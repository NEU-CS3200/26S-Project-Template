from flask import Blueprint, jsonify, current_app, request
from backend.db_connection import get_db
from mysql.connector import Error

players = Blueprint("players", __name__)


## Get unread notifications for a specific player
@players.route("/players/<int:player_id>/notifications", methods=["GET"])
def get_unread_player_notifications(player_id):
    cursor = get_db().cursor(dictionary=True)
    unread_only = request.args.get("unread_only", "false").lower() == "true"
    query = "SELECT * FROM Notifications WHERE player_id = %s"

    if unread_only:
        query += " AND NOT is_read"

    try:
        current_app.logger.info(
            f"GET /players/{player_id}/notifications?unread_only={unread_only}"
        )
        cursor.execute(query, (player_id,))
        results = cursor.fetchall()

        current_app.logger.info(
            f"Retrieved {len(results)} data results for notifications"
        )
        return jsonify(results), 200

    except Error as e:
        current_app.logger.error(
            f"Database error in get_unread_player_notifications: {e}"
        )
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
