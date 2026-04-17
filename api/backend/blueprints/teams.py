from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

teams = Blueprint("teams", __name__)


# GET /teams — teams available to join
@teams.route("/teams", methods=["GET"])
def get_all_teams():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /teams")

        league_id = request.args.get("league_id")
        status = request.args.get("status", "Active")

        query = """SELECT t.id, t.name, t.status, t.league_id,
                          l.sport, l.league_name,
                          l.roster_limit,
                          (SELECT COUNT(*) FROM Team_Membership tm
                           WHERE tm.team_id = t.id AND tm.status = 'Active') AS current_roster
                   FROM Team t
                   JOIN League l ON t.league_id = l.id
                   WHERE t.status = %s"""
        params = [status]

        if league_id:
            query += " AND t.league_id = %s"
            params.append(league_id)

        cursor.execute(query, params)
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_teams: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /teams — create team
@teams.route("/teams", methods=["POST"])
def create_team():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("POST /teams")
        data = request.get_json()

        required = ["name", "captain_id", "league_id"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """INSERT INTO Team (name, status, captain_id, league_id)
                   VALUES (%s, %s, %s, %s)"""
        cursor.execute(query, (data["name"], data.get("status", "Active"),
                               data["captain_id"], data["league_id"]))
        get_db().commit()

        return jsonify({"message": "Team created", "team_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_team: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /teams/<id> — team details with standings and head-to-head
@teams.route("/teams/<int:team_id>", methods=["GET"])
def get_team(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /teams/{team_id}")

        team_query = """SELECT t.id, t.name, t.status, t.league_id,
                               p.first_name AS captain_first_name,
                               p.last_name AS captain_last_name,
                               l.league_name, l.sport
                        FROM Team t
                        JOIN Player p ON t.captain_id = p.id
                        JOIN League l ON t.league_id = l.id
                        WHERE t.id = %s"""
        cursor.execute(team_query, (team_id,))
        team = cursor.fetchone()

        if not team:
            return jsonify({"error": "Team not found"}), 404

        standings_query = """SELECT t.id AS team_id, t.name AS team_name,
                                    SUM(CASE WHEN gr.winning_team_id = t.id THEN 1 ELSE 0 END) AS wins,
                                    SUM(CASE WHEN gr.winning_team_id != t.id THEN 1 ELSE 0 END) AS losses
                             FROM Team t
                             JOIN Game g ON (g.home_team_id = t.id OR g.away_team_id = t.id)
                             JOIN Game_Result gr ON gr.game_id = g.id
                             WHERE g.league_id = %s
                             GROUP BY t.id, t.name
                             ORDER BY wins DESC, losses ASC"""
        cursor.execute(standings_query, (team["league_id"],))
        standings = cursor.fetchall()

        team_position = None
        for idx, row in enumerate(standings):
            if row["team_id"] == team_id:
                team_position = idx + 1
                break

        h2h_query = """SELECT opp.id AS opponent_id, opp.name AS opponent_name,
                              SUM(CASE WHEN gr.winning_team_id = %s THEN 1 ELSE 0 END) AS wins,
                              SUM(CASE WHEN gr.winning_team_id = opp.id THEN 1 ELSE 0 END) AS losses
                       FROM Game g
                       JOIN Game_Result gr ON gr.game_id = g.id
                       JOIN Team opp ON (opp.id = g.home_team_id OR opp.id = g.away_team_id)
                       WHERE (g.home_team_id = %s OR g.away_team_id = %s)
                         AND opp.id != %s
                       GROUP BY opp.id, opp.name"""
        cursor.execute(h2h_query, (team_id, team_id, team_id, team_id))
        h2h = cursor.fetchall()

        team["standings"] = {"position": team_position, "full_standings": standings}
        team["head_to_head"] = h2h

        return jsonify(team), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_team: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /teams/<id> — update team (e.g. deactivate)
@teams.route("/teams/<int:team_id>", methods=["PUT"])
def update_team(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /teams/{team_id}")
        data = request.get_json()

        cursor.execute("SELECT id FROM Team WHERE id = %s", (team_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Team not found"}), 404

        allowed = ["name", "status", "captain_id", "league_id"]
        update_fields = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(team_id)
        query = f"UPDATE Team SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "Team updated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_team: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /teams/<id> — remove team
@teams.route("/teams/<int:team_id>", methods=["DELETE"])
def delete_team(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /teams/{team_id}")

        cursor.execute("SELECT id FROM Team WHERE id = %s", (team_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Team not found"}), 404

        cursor.execute("DELETE FROM Team WHERE id = %s", (team_id,))
        get_db().commit()

        return jsonify({"message": "Team deleted"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in delete_team: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /teams/<id>/schedule — team's games
@teams.route("/teams/<int:team_id>/schedule", methods=["GET"])
def get_team_schedule(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /teams/{team_id}/schedule")
        status = request.args.get("status")

        query = """SELECT g.id AS game_id, g.game_time, g.game_date, g.status,
                          v.name AS venue_name,
                          ht.name AS home_team_name,
                          at.name AS away_team_name,
                          l.sport, l.league_name
                   FROM Game g
                   JOIN Venue v ON g.venue_id = v.id
                   JOIN Team ht ON g.home_team_id = ht.id
                   JOIN Team at ON g.away_team_id = at.id
                   JOIN League l ON g.league_id = l.id
                   WHERE (g.home_team_id = %s OR g.away_team_id = %s)"""
        params = [team_id, team_id]

        if status:
            query += " AND g.status = %s"
            params.append(status)

        query += " ORDER BY g.game_date, g.game_time"

        cursor.execute(query, params)
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_team_schedule: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /teams/<id>/messages — team messages
@teams.route("/teams/<int:team_id>/messages", methods=["GET"])
def get_team_messages(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /teams/{team_id}/messages")

        query = """SELECT tm.id, tm.sent_at, tm.message,
                          p.id AS player_id, p.first_name, p.last_name
                   FROM Team_Message tm
                   JOIN Player p ON tm.player_id = p.id
                   WHERE tm.team_id = %s
                   ORDER BY tm.sent_at DESC"""
        cursor.execute(query, (team_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_team_messages: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /teams/<id>/messages — send team message
@teams.route("/teams/<int:team_id>/messages", methods=["POST"])
def send_team_message(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /teams/{team_id}/messages")
        data = request.get_json()

        required = ["player_id", "message"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """INSERT INTO Team_Message (team_id, sent_at, player_id, message)
                   VALUES (%s, NOW(), %s, %s)"""
        cursor.execute(query, (team_id, data["player_id"], data["message"]))
        get_db().commit()

        return jsonify({"message": "Message sent", "message_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in send_team_message: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
