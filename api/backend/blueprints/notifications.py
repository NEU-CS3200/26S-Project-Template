from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

notifications = Blueprint("notifications", __name__)


# GET /notifications/<league_id> — system/league notifications
@notifications.route("/notifications/<int:league_id>", methods=["GET"])
def get_league_notifications(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /notifications/{league_id}")

        query = "SELECT * FROM Notification WHERE league_id = %s ORDER BY sent_at DESC"
        cursor.execute(query, (league_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_league_notifications: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /notifications/<league_id> — send league-wide notification
@notifications.route("/notifications/<int:league_id>", methods=["POST"])
def send_league_notification(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /notifications/{league_id}")
        data = request.get_json()

        if "message" not in data:
            return jsonify({"error": "Missing required field: message"}), 400

        notification_type = data.get("notification_type", "Banner")
        message = data["message"]
        game_id = data.get("game_id")

        cursor.execute(
            """SELECT DISTINCT tm.player_id
                          FROM Team t
                          JOIN Team_Membership tm ON tm.team_id = t.id
                          WHERE t.league_id = %s AND tm.status = 'Active'""",
            (league_id,),
        )
        player_ids = [row["player_id"] for row in cursor.fetchall()]

        if not player_ids:
            return jsonify({"message": "No recipients found", "count": 0}), 200

        insert_query = """INSERT INTO Notification
                              (is_read, sent_at, message, game_id, player_id,
                               league_id, notification_type)
                          VALUES (FALSE, NOW(), %s, %s, %s, %s, %s)"""
        for player_id in player_ids:
            cursor.execute(
                insert_query,
                (message, game_id, player_id, league_id, notification_type),
            )
        get_db().commit()

        return jsonify({"message": "Notifications sent", "count": len(player_ids)}), 201
    except Error as e:
        current_app.logger.error(f"Database error in send_league_notification: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
