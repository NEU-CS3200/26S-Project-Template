=from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

restaurants = Blueprint('restaurants', __name__)

# retrieve the /restaurant/{restaurant_id}/waittime route
# required field: restaurant_id
# user stories: [Ryan-5] [Alex-5]
@restaurants.route("/restaurant/<int:restaurant_id>/waittime", methods=["GET"])
def get_restaurant_waittime(restaurant_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT R.Name,
                   W.EstimatedMin
            FROM Restaurant R
            JOIN WaitTime W ON R.RestaurantId = W.RestaurantId
            WHERE W.RestaurantId = %s
            """,
            (restaurant_id,)
        )

        wait_time = cursor.fetchall()
        return jsonify(wait_time), 200

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


# create new restaurant wait time estimate
# required fields: EstimatedMin, TimeStamp
# user stories: [Ryan-5]
@restaurants.route("/restaurant/<int:restaurant_id>/waittime", methods=["POST"])
def create_restaurant_waittime(restaurant_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()

        required_fields = ["EstimatedMin", "TimeStamp"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """
            INSERT INTO WaitTime (EstimatedMin, RestaurantId, TimeStamp)
            VALUES (%s, %s, %s)
        """

        cursor.execute(query, (
            data["EstimatedMin"],
            restaurant_id,
            data["TimeStamp"]
        ))

        get_db().commit()

        return jsonify({"message": "Wait time created successfully"}), 201

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()