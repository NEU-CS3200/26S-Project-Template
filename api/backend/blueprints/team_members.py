from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

team_members = Blueprint("team_members", __name__)


# GET /teams/<id>/members — team roster
@team_members.route("/teams/<int:team_id>/members", methods=["GET"])
def get_team_members(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /teams/{team_id}/members")

        query = """SELECT tm.id, tm.date_joined, tm.designation, tm.status,
                          tm.role, tm.join_method,
                          p.id AS player_id, p.first_name, p.last_name, p.email
                   FROM Team_Membership tm
                   JOIN Player p ON tm.player_id = p.id
                   WHERE tm.team_id = %s"""
        cursor.execute(query, (team_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_team_members: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /teams/<id>/members — add player to team
@team_members.route("/teams/<int:team_id>/members", methods=["POST"])
def add_team_member(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /teams/{team_id}/members")
        data = request.get_json()

        if "player_id" not in data:
            return jsonify({"error": "Missing required field: player_id"}), 400

        query = """INSERT INTO Team_Membership
                       (team_id, player_id, role, join_method, status, date_joined, designation)
                   VALUES (%s, %s, %s, %s, %s, NOW(), %s)"""
        cursor.execute(query, (team_id, data["player_id"],
                               data.get("role", "Player"),
                               data.get("join_method", "Invite"),
                               data.get("status", "Active"),
                               data.get("designation", "Starter")))
        get_db().commit()

        return jsonify({"message": "Member added", "member_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in add_team_member: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /teams/<id>/members/<member_id> — designate role (starter/sub) or update status
@team_members.route("/teams/<int:team_id>/members/<int:member_id>", methods=["PUT"])
def update_team_member(team_id, member_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /teams/{team_id}/members/{member_id}")
        data = request.get_json()

        cursor.execute("SELECT id FROM Team_Membership WHERE id = %s AND team_id = %s",
                       (member_id, team_id))
        if not cursor.fetchone():
            return jsonify({"error": "Member not found"}), 404

        allowed = ["status", "role", "designation"]
        update_fields = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(member_id)
        query = f"UPDATE Team_Membership SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "Member updated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_team_member: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /teams/<id>/members/<member_id> — remove player
@team_members.route("/teams/<int:team_id>/members/<int:member_id>", methods=["DELETE"])
def remove_team_member(team_id, member_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /teams/{team_id}/members/{member_id}")

        cursor.execute("SELECT id FROM Team_Membership WHERE id = %s AND team_id = %s",
                       (member_id, team_id))
        if not cursor.fetchone():
            return jsonify({"error": "Member not found"}), 404

        cursor.execute("DELETE FROM Team_Membership WHERE id = %s", (member_id,))
        get_db().commit()

        return jsonify({"message": "Member removed"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in remove_team_member: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
