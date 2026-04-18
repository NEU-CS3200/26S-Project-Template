from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

restaurants = Blueprint('restaurants', __name__)


# Get all restaurants with optional filters for cuisine, price range,
# distance, and allergen. Covers the broad discovery use cases.
# User stories: Alex-2, Ryan-2, Ryan-6
@restaurants.route('/', methods=['GET'])
def get_restaurants():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /restaurants/')

        cuisine  = request.args.get('cuisine')
        price    = request.args.get('price')
        max_dist = request.args.get('maxDist', type=float)

        query  = "SELECT RestaurantId, Name, Address, PriceRange, Cuisine, DistFromCampus FROM Restaurant WHERE 1=1"
        params = []

        if cuisine:
            query += " AND Cuisine = %s"
            params.append(cuisine)
        if price:
            query += " AND PriceRange = %s"
            params.append(price)
        if max_dist is not None:
            query += " AND DistFromCampus <= %s"
            params.append(max_dist)

        query += " ORDER BY DistFromCampus ASC"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'GET restaurants error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get all restaurants within a specific distance (miles) from campus.
# note: Flask cannot distinguish /restaurants/<distance> from
# /restaurants/<restaurant_id> since both are dynamic segments
# /restaurants/within/<distance> avoids that conflict
# User stories: Alex-2
@restaurants.route('/within/<float:distance>', methods=['GET'])
def get_restaurants_by_distance(distance):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'GET /restaurants/within/{distance}')

        cursor.execute('''
            SELECT RestaurantId, Name, Address, PriceRange, Cuisine, DistFromCampus
            FROM   Restaurant
            WHERE  DistFromCampus <= %s
            ORDER  BY DistFromCampus ASC
        ''', (distance,))

        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'GET restaurants by distance error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get full detail for a single restaurant including average rating
# and most recent wait time.
# User stories: Ryan-1
@restaurants.route('/<int:restaurant_id>', methods=['GET'])
def get_restaurant(restaurant_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'GET /restaurants/{restaurant_id}')

        cursor.execute('''
            SELECT  r.RestaurantId,
                    r.Name,
                    r.Address,
                    r.PriceRange,
                    r.Cuisine,
                    r.DistFromCampus,
                    ROUND(AVG(rv.Rating), 1)  AS AvgRating,
                    COUNT(rv.ReviewId)         AS NumReviews
            FROM    Restaurant   r
            LEFT JOIN Review     rv ON rv.RestaurantId = r.RestaurantId
            WHERE   r.RestaurantId = %s
            GROUP   BY r.RestaurantId, r.Name, r.Address,
                       r.PriceRange, r.Cuisine, r.DistFromCampus
        ''', (restaurant_id,))

        restaurant = cursor.fetchone()
        if not restaurant:
            return jsonify({"error": "Restaurant not found"}), 404
        return jsonify(restaurant), 200
    except Error as e:
        current_app.logger.error(f'GET restaurant error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Save a restaurant as a saved spot for a student.
# User stories: Alex-3
@restaurants.route('/<int:restaurant_id>', methods=['POST'])
def save_restaurant(restaurant_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'POST /restaurants/{restaurant_id}')

        data = request.get_json()
        if not data:
            return jsonify({"error": "Request body required"}), 400

        if "studentId" not in data:
            return jsonify({"error": "Missing required field: studentId"}), 400

        cursor.execute('''
            INSERT INTO SavedSpot (StudentId, RestaurantId, HallId, TagId, DateAdded, Notes)
            VALUES (%s, %s, NULL, %s, CURRENT_DATE(), %s)
        ''', (
            data["studentId"],
            restaurant_id,
            data.get("tagId"),
            data.get("notes"),
        ))

        get_db().commit()
        return jsonify({"message": "Restaurant saved successfully", "savedId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'POST save restaurant error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get all reviews for a restaurant.
# Supports optional ?allergenFlag= filter to show only reviews
# from students with a specific allergen concern
# User stories: Alex-4, Ryan-1, Ryan-2
@restaurants.route('/<int:restaurant_id>/reviews', methods=['GET'])
def get_restaurant_reviews(restaurant_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'GET /restaurants/{restaurant_id}/reviews')

        allergen = request.args.get('allergenFlag')
        query = '''
            SELECT  rv.ReviewId,
                    rv.Rating,
                    rv.Comment,
                    rv.AllergenFlag,
                    rv.PriceRating,
                    rv.ReviewDate,
                    s.FirstName,
                    s.LastName,
                    s.University
            FROM    Review    rv
            LEFT JOIN Student  s  ON s.StudentId = rv.StudentId
            WHERE   rv.RestaurantId = %s
        '''
        params = [restaurant_id]

        if allergen:
            query += " AND rv.AllergenFlag = %s"
            params.append(allergen)

        query += " ORDER BY rv.ReviewDate DESC"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'GET restaurant reviews error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Submit a new student review for a restaurant
# User stories: Ryan-4
@restaurants.route('/<int:restaurant_id>/reviews', methods=['POST'])
def add_restaurant_review(restaurant_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'POST /restaurants/{restaurant_id}/reviews')

        data = request.get_json()
        if not data:
            return jsonify({"error": "Request body required"}), 400

        required_fields = ["studentId", "rating"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        if data["rating"] not in (1, 2, 3, 4, 5):
            return jsonify({"error": "Rating must be an integer 1-5"}), 400

        cursor.execute('''
            INSERT INTO Review
                (StudentId, RestaurantId, Rating, Comment,
                 AllergenFlag, PriceRating, ReviewDate)
            VALUES (%s, %s, %s, %s, %s, %s, CURRENT_DATE())
        ''', (
            data["studentId"],
            restaurant_id,
            data["rating"],
            data.get("comment"),
            data.get("allergenFlag"),
            data.get("priceRating"),
        ))

        get_db().commit()
        return jsonify({"message": "Review submitted successfully", "reviewId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'POST restaurant review error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
