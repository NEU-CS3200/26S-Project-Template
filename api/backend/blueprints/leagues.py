from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

leagues = Blueprint("leagues", __name__)


# GET /leagues — filtered leagues
@leagues.route("/leagues", methods=["GET"])
def get_all_leagues():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /leagues")

        sport = request.args.get("sport")
        skill_level = request.args.get("skill_level")
        season = request.args.get("season")
        status = request.args.get("status")
        search = request.args.get("search")

        query = "SELECT * FROM League WHERE 1=1"
        params = []

        if sport:
            query += " AND sport = %s"
            params.append(sport)
        if skill_level:
            query += " AND skill_level = %s"
            params.append(skill_level)
        if season:
            query += " AND season = %s"
            params.append(season)
        if status:
            query += " AND status = %s"
            params.append(status)
        if search:
            query += " AND (sport LIKE %s OR league_name LIKE %s)"
            params.extend([f"%{search}%", f"%{search}%"])

        cursor.execute(query, params)
        results = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(results)} leagues")
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_leagues: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /leagues — create a new league
@leagues.route("/leagues", methods=["POST"])
def create_league():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("POST /leagues")
        data = request.get_json()

        required = ["season", "skill_level", "registration_start", "registration_end",
                    "rules", "status", "schedule_type", "roster_limit",
                    "division_tier", "sport", "league_name"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """INSERT INTO League
                       (season, skill_level, registration_start, registration_end,
                        rules, status, schedule_type, roster_limit, division_tier,
                        sport, league_name)
                   VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"""
        cursor.execute(query, (data["season"], data["skill_level"],
                               data["registration_start"], data["registration_end"],
                               data["rules"], data["status"], data["schedule_type"],
                               data["roster_limit"], data["division_tier"],
                               data["sport"], data["league_name"]))
        get_db().commit()

        current_app.logger.info(f"Created league with id {cursor.lastrowid}")
        return jsonify({"message": "League created", "league_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_league: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /leagues/<id> — single league (helper for pages)
@leagues.route("/leagues/<int:league_id>", methods=["GET"])
def get_league(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /leagues/{league_id}")
        cursor.execute("SELECT * FROM League WHERE id = %s", (league_id,))
        result = cursor.fetchone()

        if not result:
            return jsonify({"error": "League not found"}), 404

        return jsonify(result), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_league: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /leagues/<id> — update league config
@leagues.route("/leagues/<int:league_id>", methods=["PUT"])
def update_league(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /leagues/{league_id}")
        data = request.get_json()

        cursor.execute("SELECT id FROM League WHERE id = %s", (league_id,))
        if not cursor.fetchone():
            return jsonify({"error": "League not found"}), 404

        allowed = ["league_name", "sport", "roster_limit", "skill_level",
                   "registration_start", "registration_end", "rules",
                   "status", "schedule_type", "division_tier", "season"]
        update_fields = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(league_id)
        query = f"UPDATE League SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "League updated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_league: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /leagues/<id>/free-agents — list free agent requests for a league
@leagues.route("/leagues/<int:league_id>/free-agents", methods=["GET"])
def get_free_agents(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /leagues/{league_id}/free-agents")

        query = """SELECT far.id, far.status, far.request_date,
                          p.id AS player_id, p.first_name, p.last_name, p.email
                   FROM Free_Agent_Request far
                   JOIN Player p ON far.player_id = p.id
                   WHERE far.league_id = %s"""
        cursor.execute(query, (league_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_free_agents: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /leagues/<id>/free-agents — register as free agent
@leagues.route("/leagues/<int:league_id>/free-agents", methods=["POST"])
def create_free_agent_request(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /leagues/{league_id}/free-agents")
        data = request.get_json()

        if "player_id" not in data:
            return jsonify({"error": "Missing required field: player_id"}), 400

        query = """INSERT INTO Free_Agent_Request (status, player_id, league_id, request_date)
                   VALUES (%s, %s, %s, NOW())"""
        cursor.execute(query, ("Pending", data["player_id"], league_id))
        get_db().commit()

        return jsonify({"message": "Free agent request created",
                        "request_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_free_agent_request: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /leagues/<id>/free-agents/<req_id> — accept free agent request
@leagues.route("/leagues/<int:league_id>/free-agents/<int:req_id>", methods=["PUT"])
def update_free_agent_request(league_id, req_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /leagues/{league_id}/free-agents/{req_id}")
        data = request.get_json() or {}
        new_status = data.get("status", "Accepted")

        cursor.execute("SELECT id FROM Free_Agent_Request WHERE id = %s AND league_id = %s",
                       (req_id, league_id))
        if not cursor.fetchone():
            return jsonify({"error": "Request not found"}), 404

        cursor.execute("UPDATE Free_Agent_Request SET status = %s WHERE id = %s",
                       (new_status, req_id))
        get_db().commit()

        return jsonify({"message": f"Request {new_status.lower()}"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_free_agent_request: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /leagues/<id>/free-agents/<req_id> — reject/revoke request
@leagues.route("/leagues/<int:league_id>/free-agents/<int:req_id>", methods=["DELETE"])
def reject_free_agent_request(league_id, req_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /leagues/{league_id}/free-agents/{req_id}")

        cursor.execute("SELECT id FROM Free_Agent_Request WHERE id = %s AND league_id = %s",
                       (req_id, league_id))
        if not cursor.fetchone():
            return jsonify({"error": "Request not found"}), 404

        cursor.execute("UPDATE Free_Agent_Request SET status = 'Rejected' WHERE id = %s",
                       (req_id,))
        get_db().commit()

        return jsonify({"message": "Request rejected"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in reject_free_agent_request: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /leagues/<id>/teams — helper for league admin page
@leagues.route("/leagues/<int:league_id>/teams", methods=["GET"])
def get_league_teams(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /leagues/{league_id}/teams")

        query = """SELECT t.id, t.name, t.status,
                          p.first_name AS captain_first_name,
                          p.last_name AS captain_last_name
                   FROM Team t
                   JOIN Player p ON t.captain_id = p.id
                   WHERE t.league_id = %s"""
        cursor.execute(query, (league_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_league_teams: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /leagues/<id>/disputes — helper for league admin disputes page
@leagues.route("/leagues/<int:league_id>/disputes", methods=["GET"])
def get_league_disputes(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /leagues/{league_id}/disputes")

        query = """SELECT d.id, d.dispute_type, d.status, d.description,
                          d.resolution, d.is_resolved, d.game_id,
                          ht.name AS home_team_name,
                          awt.name AS away_team_name,
                          st.name AS submitted_by_team_name,
                          gr.home_score, gr.away_score
                   FROM Dispute d
                   JOIN Game g ON d.game_id = g.id
                   JOIN Team ht ON g.home_team_id = ht.id
                   JOIN Team awt ON g.away_team_id = awt.id
                   JOIN Team st ON d.submitted_by_team_id = st.id
                   LEFT JOIN Game_Result gr ON g.id = gr.game_id
                   WHERE g.league_id = %s"""
        cursor.execute(query, (league_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_league_disputes: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
