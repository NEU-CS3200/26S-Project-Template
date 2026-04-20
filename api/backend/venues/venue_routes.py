from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

venues = Blueprint('venues', __name__)


# Detect duplicate venue names [Josh-4]
@venues.route('/duplicates', methods=['GET'])
def get_duplicate_venues():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT v.venueId, v.name, v.city, v.address, v.rating, v.ownerId
            FROM Venues v
            WHERE v.name IN (
                SELECT name FROM Venues GROUP BY name HAVING COUNT(*) > 1
            )
            ORDER BY v.name, v.city
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# List all venues by name & location [Maya-1, Josh-4]
@venues.route('/', methods=['GET'])
def get_all_venues():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT venueId, name, city, address, rating, minPrice, maxPrice
            FROM Venues
            ORDER BY name
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Filter venues by category, vibe, price, rating, and distance [Maya-1, Maya-4, Maya-6]
@venues.route('/search', methods=['GET'])
def search_venues():
    cursor = get_db().cursor(dictionary=True)
    try:
        q = request.args.get('q', type=str)
        q = f"%{q.strip()}%" if q and q.strip() else None
        city = request.args.get('city', type=str)
        city = city.strip() if city else None
        if city == '':
            city = None
        category_id = request.args.get('category_id', type=int)
        vibe_id = request.args.get('vibe_id', type=int)
        min_price = request.args.get('min_price', type=float)
        max_price = request.args.get('max_price', type=float)
        min_rating = request.args.get('min_rating', type=float)

        cursor.execute(
            """
            SELECT DISTINCT v.venueId, v.name, v.description, v.city, v.address,
                            v.rating, v.minPrice, v.maxPrice,
                            GROUP_CONCAT(DISTINCT c.name  ORDER BY c.name  SEPARATOR ', ') AS categories,
                            GROUP_CONCAT(DISTINCT b.name  ORDER BY b.name  SEPARATOR ', ') AS vibes
            FROM Venues v
            LEFT JOIN VenueCategory vc ON vc.venueId = v.venueId
            LEFT JOIN Category c       ON c.categoryId = vc.categoryId
            LEFT JOIN VenueVibe vv     ON vv.venueId = v.venueId
            LEFT JOIN Vibe b           ON b.vibeId = vv.vibeId
            WHERE (%s IS NULL OR v.name LIKE %s OR v.description LIKE %s)
              AND (%s IS NULL OR LOWER(TRIM(v.city)) = LOWER(TRIM(%s)))
              AND (%s IS NULL OR vc.categoryId = %s)
              AND (%s IS NULL OR vv.vibeId = %s)
              AND (%s IS NULL OR v.minPrice >= %s)
              AND (%s IS NULL OR v.maxPrice <= %s)
              AND (%s IS NULL OR v.rating >= %s)
            GROUP BY v.venueId
            ORDER BY v.rating DESC, v.name
            """,
            (
                q, q, q,
                city, city,
                category_id, category_id,
                vibe_id, vibe_id,
                min_price, min_price,
                max_price, max_price,
                min_rating, min_rating
            )
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Full venue details incl. vibes, category, avg rating [Maya-1, Maya-4, Josh-4]
@venues.route('/<int:venue_id>', methods=['GET'])
def get_venue(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT v.venueId, v.ownerId, v.name, v.description, v.address, v.city,
                   v.phoneNum, v.rating, v.minPrice, v.maxPrice,
                   ROUND(AVG(r.rating), 2) AS avgReviewRating,
                   GROUP_CONCAT(DISTINCT c.name ORDER BY c.name SEPARATOR ', ') AS categories,
                   GROUP_CONCAT(DISTINCT b.name ORDER BY b.name SEPARATOR ', ') AS vibes
            FROM Venues v
            LEFT JOIN Reviews r ON r.venueId = v.venueId
            LEFT JOIN VenueCategory vc ON vc.venueId = v.venueId
            LEFT JOIN Category c ON c.categoryId = vc.categoryId
            LEFT JOIN VenueVibe vv ON vv.venueId = v.venueId
            LEFT JOIN Vibe b ON b.vibeId = vv.vibeId
            WHERE v.venueId = %s
            GROUP BY v.venueId
            """,
            (venue_id,)
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Venue not found"}), 404
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Create listing after application approved [Josh-3]
@venues.route('/<int:venue_id>', methods=['POST'])
def create_venue_from_application(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        city = data.get('city')
        if not city:
            return jsonify({"error": "'city' is required to create venue"}), 400

        cursor.execute(
            """
            SELECT ownerId, name, description, address, phone, minPrice, maxPrice, status
            FROM VenueApplications
            WHERE applicationId = %s
            """,
            (venue_id,)
        )
        app_row = cursor.fetchone()
        if not app_row:
            return jsonify({"error": "Application not found"}), 404
        if app_row['status'] != 'APPROVED':
            return jsonify({"error": "Application must be APPROVED first"}), 400

        cursor.execute(
            """
            INSERT INTO Venues (ownerId, name, description, address, city, phoneNum, minPrice, maxPrice)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (
                app_row['ownerId'],
                app_row['name'],
                app_row['description'],
                app_row['address'],
                city,
                app_row['phone'],
                app_row['minPrice'],
                app_row['maxPrice']
            )
        )
        get_db().commit()
        return jsonify({"message": "Venue created", "venueId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Update venue info (hours, phone, description) [Marcus-1]
@venues.route('/<int:venue_id>', methods=['PUT'])
def update_venue(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        cursor.execute(
            """
            UPDATE Venues
            SET name = COALESCE(%s, name),
                description = COALESCE(%s, description),
                address = COALESCE(%s, address),
                city = COALESCE(%s, city),
                phoneNum = COALESCE(%s, phoneNum),
                minPrice = COALESCE(%s, minPrice),
                maxPrice = COALESCE(%s, maxPrice)
            WHERE venueId = %s
            """,
            (
                data.get('name'),
                data.get('description'),
                data.get('address'),
                data.get('city'),
                data.get('phoneNum'),
                data.get('minPrice'),
                data.get('maxPrice'),
                venue_id
            )
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Venue not found"}), 404
        return jsonify({"message": "Venue updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Delete a venue (admin use — remove duplicates) [Josh-4]
@venues.route('/<int:venue_id>', methods=['DELETE'])
def delete_venue(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM Venues WHERE venueId = %s", (venue_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Venue not found"}), 404
        return jsonify({"message": "Venue deleted"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Return venues sharing category with saved spots [Maya-6]
@venues.route('/<int:venue_id>/similar', methods=['GET'])
def get_similar_venues(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT DISTINCT v.venueId, v.name, v.city, v.address, v.rating
            FROM Venues v
            JOIN VenueCategory vc ON vc.venueId = v.venueId
            WHERE vc.categoryId IN (
                SELECT categoryId FROM VenueCategory WHERE venueId = %s
            )
              AND v.venueId <> %s
            ORDER BY v.rating DESC, v.name
            """,
            (venue_id, venue_id)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get categories for a venue [Marcus-2]
@venues.route('/<int:venue_id>/categories', methods=['GET'])
def get_venue_categories(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT c.categoryId, c.name
            FROM VenueCategory vc
            JOIN Category c ON c.categoryId = vc.categoryId
            WHERE vc.venueId = %s
            ORDER BY c.name
            """,
            (venue_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Update venue's assigned categories [Marcus-2]
@venues.route('/<int:venue_id>/categories', methods=['PUT'])
def update_venue_categories(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        category_ids = data.get('categoryIds')
        if not isinstance(category_ids, list):
            return jsonify({"error": "'categoryIds' must be a list"}), 400

        cursor.execute("DELETE FROM VenueCategory WHERE venueId = %s", (venue_id,))
        if category_ids:
            cursor.executemany(
                "INSERT INTO VenueCategory (venueId, categoryId) VALUES (%s, %s)",
                [(venue_id, category_id) for category_id in category_ids]
            )
        get_db().commit()
        return jsonify({"message": "Venue categories updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get vibes for a venue [Marcus-2]
@venues.route('/<int:venue_id>/vibes', methods=['GET'])
def get_venue_vibes(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT b.vibeId, b.name
            FROM VenueVibe vv
            JOIN Vibe b ON b.vibeId = vv.vibeId
            WHERE vv.venueId = %s
            ORDER BY b.name
            """,
            (venue_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Update venue's assigned vibes [Marcus-2]
@venues.route('/<int:venue_id>/vibes', methods=['PUT'])
def update_venue_vibes(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        vibe_ids = data.get('vibeIds')
        if not isinstance(vibe_ids, list):
            return jsonify({"error": "'vibeIds' must be a list"}), 400

        cursor.execute("DELETE FROM VenueVibe WHERE venueId = %s", (venue_id,))
        if vibe_ids:
            cursor.executemany(
                "INSERT INTO VenueVibe (venueId, vibeId) VALUES (%s, %s)",
                [(venue_id, vibe_id) for vibe_id in vibe_ids]
            )
        get_db().commit()
        return jsonify({"message": "Venue vibes updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# All reviews for a venue, ordered by date [Maya-4, Marcus-4]
@venues.route('/<int:venue_id>/reviews', methods=['GET'])
def get_venue_reviews(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.reviewId, r.userId, u.username, r.rating, r.comment,
                   r.isFlagged, r.createdAt
            FROM Reviews r
            JOIN Users u ON u.accountId = r.userId
            WHERE r.venueId = %s
            ORDER BY r.createdAt DESC
            """,
            (venue_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Submit a review for a venue [Maya-3]
@venues.route('/<int:venue_id>/reviews', methods=['POST'])
def create_venue_review(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        user_id = data.get('userId')
        rating = data.get('rating')
        comment = data.get('comment')
        if not user_id or rating is None:
            return jsonify({"error": "'userId' and 'rating' are required"}), 400

        cursor.execute(
            """
            INSERT INTO Reviews (userId, venueId, comment, rating)
            VALUES (%s, %s, %s, %s)
            """,
            (user_id, venue_id, comment, rating)
        )
        get_db().commit()
        return jsonify({"message": "Review created", "reviewId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Count of users who saved a venue [Marcus-1]
@venues.route('/<int:venue_id>/saves', methods=['GET'])
def get_venue_saves_count(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            "SELECT COUNT(*) AS count FROM SavedVenues WHERE venueId = %s",
            (venue_id,)
        )
        return jsonify(cursor.fetchone()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# All posts/events for a venue [Marcus-6, Maya-4]
@venues.route('/<int:venue_id>/posts', methods=['GET'])
def get_venue_posts(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT p.postId, p.ownerId, u.username AS ownerUsername, p.content, p.postDate
            FROM Posts p
            JOIN Users u ON u.accountId = p.ownerId
            WHERE p.venueId = %s
            ORDER BY p.postDate DESC
            """,
            (venue_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Create a new post or event [Marcus-6]
@venues.route('/<int:venue_id>/posts', methods=['POST'])
def create_venue_post(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        owner_id = data.get('ownerId')
        content = data.get('content')
        if not owner_id or not content:
            return jsonify({"error": "'ownerId' and 'content' are required"}), 400

        cursor.execute(
            "INSERT INTO Posts (ownerId, venueId, content) VALUES (%s, %s, %s)",
            (owner_id, venue_id, content)
        )
        get_db().commit()
        return jsonify({"message": "Post created", "postId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
