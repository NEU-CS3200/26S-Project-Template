from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

notifications = Blueprint("notifications", __name__)


## Get league wide notification
@notifications.route("/notification/<int:league_id>", methods=["GET"])
def get_league_wide_notifications(league_id: int):
    
    cursor = get_db().cursor(dictionary=True)
    query = f"SELECT * FROM Notifications WHERE league_id = {league_id}"

    try:
        current_app.logger.info("GET /notification")
        cursor.execute(query, (league_id,))
        results = cursor.fetchall()

        current_app.logger.info(
            f"Retrieved {len(results)} data results for notifications"
        )
        return jsonify(results), 200

    except Error as e:
        current_app.logger.error(
            f"Database error in get_league_wide_notifications: {e}"
        )
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

