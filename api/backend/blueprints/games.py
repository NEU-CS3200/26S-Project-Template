from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

games = Blueprint("games", __name__)


# POST /games — add a game
@games.route("/games", methods=["POST"])
def create_game():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("POST /games")
        data = request.get_json()

        required = ["game_time", "game_date", "venue_id", "status",
                    "venue_time_slot_id", "away_team_id", "home_team_id", "league_id"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """INSERT INTO Game
                       (game_time, game_date, venue_id, status, venue_time_slot_id,
                        away_team_id, home_team_id, league_id)
                   VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"""
        cursor.execute(query, (data["game_time"], data["game_date"], data["venue_id"],
                               data["status"], data["venue_time_slot_id"],
                               data["away_team_id"], data["home_team_id"],
                               data["league_id"]))
        get_db().commit()

        return jsonify({"message": "Game created", "game_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_game: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /games/<id> — game details
@games.route("/games/<int:game_id>", methods=["GET"])
def get_game(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/{game_id}")

        query = """SELECT g.id AS game_id, g.game_time, g.game_date, g.status,
                          v.name AS venue_name, v.address AS venue_address,
                          ht.name AS home_team_name,
                          at.name AS away_team_name,
                          l.sport, l.league_name, l.season
                   FROM Game g
                   JOIN Venue v ON g.venue_id = v.id
                   JOIN Team ht ON g.home_team_id = ht.id
                   JOIN Team at ON g.away_team_id = at.id
                   JOIN League l ON g.league_id = l.id
                   WHERE g.id = %s"""
        cursor.execute(query, (game_id,))
        result = cursor.fetchone()

        if not result:
            return jsonify({"error": "Game not found"}), 404

        return jsonify(result), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_game: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /games/<id> — update game status (cancel, reschedule, completed)
@games.route("/games/<int:game_id>", methods=["PUT"])
def update_game(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /games/{game_id}")
        data = request.get_json()

        cursor.execute("SELECT id FROM Game WHERE id = %s", (game_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Game not found"}), 404

        allowed = ["game_time", "game_date", "venue_id", "status",
                   "venue_time_slot_id", "away_team_id", "home_team_id"]
        update_fields = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(game_id)
        query = f"UPDATE Game SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "Game updated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_game: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /games/<id> — delete game
@games.route("/games/<int:game_id>", methods=["DELETE"])
def delete_game(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /games/{game_id}")

        cursor.execute("SELECT id FROM Game WHERE id = %s", (game_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Game not found"}), 404

        cursor.execute("DELETE FROM Game WHERE id = %s", (game_id,))
        get_db().commit()

        return jsonify({"message": "Game deleted"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in delete_game: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /games/<id>/scores — game scores
@games.route("/games/<int:game_id>/scores", methods=["GET"])
def get_game_scores(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/{game_id}/scores")

        query = """SELECT gr.id, gr.home_score, gr.away_score, gr.is_forfeit,
                          wt.name AS winning_team_name
                   FROM Game_Result gr
                   JOIN Team wt ON gr.winning_team_id = wt.id
                   WHERE gr.game_id = %s"""
        cursor.execute(query, (game_id,))
        result = cursor.fetchone()

        if not result:
            return jsonify({"error": "No scores found for this game"}), 404

        submissions_query = """SELECT ss.id, ss.home_score, ss.away_score,
                                      ss.status, ss.submission_date,
                                      ss.dispute_reason, ss.is_disputed,
                                      p.first_name, p.last_name
                               FROM Score_Submission ss
                               JOIN Player p ON ss.player_id = p.id
                               WHERE ss.game_id = %s"""
        cursor.execute(submissions_query, (game_id,))
        result["submissions"] = cursor.fetchall()

        return jsonify(result), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_game_scores: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /games/<id>/scores — submit game scores
@games.route("/games/<int:game_id>/scores", methods=["POST"])
def submit_game_scores(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /games/{game_id}/scores")
        data = request.get_json()

        required = ["player_id", "home_score", "away_score"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """INSERT INTO Score_Submission
                       (player_id, game_id, home_score, away_score, status,
                        submission_date, dispute_reason, is_disputed)
                   VALUES (%s, %s, %s, %s, %s, NOW(), %s, %s)"""
        cursor.execute(query, (data["player_id"], game_id,
                               data["home_score"], data["away_score"],
                               data.get("status", "Pending"),
                               data.get("dispute_reason", ""),
                               data.get("is_disputed", False)))
        get_db().commit()

        return jsonify({"message": "Score submitted",
                        "submission_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in submit_game_scores: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /games/<id>/scores — update disputed scores
@games.route("/games/<int:game_id>/scores", methods=["PUT"])
def update_game_scores(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /games/{game_id}/scores")
        data = request.get_json()

        cursor.execute("SELECT id FROM Game_Result WHERE game_id = %s", (game_id,))
        existing = cursor.fetchone()

        if existing:
            allowed = ["winning_team_id", "home_score", "away_score", "is_forfeit"]
            update_fields = [f"{f} = %s" for f in allowed if f in data]
            params = [data[f] for f in allowed if f in data]

            if not update_fields:
                return jsonify({"error": "No valid fields to update"}), 400

            params.append(game_id)
            query = f"UPDATE Game_Result SET {', '.join(update_fields)} WHERE game_id = %s"
            cursor.execute(query, params)
            get_db().commit()
            return jsonify({"message": "Scores updated"}), 200
        else:
            required = ["winning_team_id", "home_score", "away_score"]
            for field in required:
                if field not in data:
                    return jsonify({"error": f"Missing required field: {field}"}), 400

            query = """INSERT INTO Game_Result (game_id, winning_team_id, home_score,
                                                 away_score, is_forfeit)
                       VALUES (%s, %s, %s, %s, %s)"""
            cursor.execute(query, (game_id, data["winning_team_id"],
                                   data["home_score"], data["away_score"],
                                   data.get("is_forfeit", False)))
            get_db().commit()
            return jsonify({"message": "Scores created"}), 201
    except Error as e:
        current_app.logger.error(f"Database error in update_game_scores: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /games/<id>/disputes — disputes for a game
@games.route("/games/<int:game_id>/disputes", methods=["GET"])
def get_game_disputes(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/{game_id}/disputes")

        query = """SELECT d.id, d.dispute_type, d.status, d.description,
                          d.resolution, d.resolution_date, d.is_resolved,
                          d.admin_notes,
                          st.name AS submitted_by_team_name
                   FROM Dispute d
                   JOIN Team st ON d.submitted_by_team_id = st.id
                   WHERE d.game_id = %s"""
        cursor.execute(query, (game_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_game_disputes: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /games/<id>/disputes — create dispute / reschedule request
@games.route("/games/<int:game_id>/disputes", methods=["POST"])
def create_game_dispute(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /games/{game_id}/disputes")
        data = request.get_json()

        required = ["submitted_by_team_id", "dispute_type", "description"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """INSERT INTO Dispute
                       (admin_notes, game_id, submitted_by_team_id, dispute_type,
                        status, description, is_resolved)
                   VALUES (%s, %s, %s, %s, %s, %s, %s)"""
        cursor.execute(query, (data.get("admin_notes"), game_id,
                               data["submitted_by_team_id"],
                               data["dispute_type"],
                               data.get("status", "Pending"),
                               data["description"],
                               False))
        get_db().commit()

        return jsonify({"message": "Dispute created",
                        "dispute_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_game_dispute: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /games/<id>/disputes/<dispute_id> — resolve dispute
@games.route("/games/<int:game_id>/disputes/<int:dispute_id>", methods=["PUT"])
def resolve_game_dispute(game_id, dispute_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /games/{game_id}/disputes/{dispute_id}")
        data = request.get_json() or {}

        cursor.execute("SELECT id FROM Dispute WHERE id = %s AND game_id = %s",
                       (dispute_id, game_id))
        if not cursor.fetchone():
            return jsonify({"error": "Dispute not found"}), 404

        status = data.get("status", "Resolved")
        resolution = data.get("resolution", "")
        is_resolved = data.get("is_resolved", True)
        admin_notes = data.get("admin_notes")

        if admin_notes is not None:
            query = """UPDATE Dispute
                       SET status = %s, resolution = %s, is_resolved = %s,
                           resolution_date = NOW(), admin_notes = %s
                       WHERE id = %s"""
            cursor.execute(query, (status, resolution, is_resolved, admin_notes, dispute_id))
        else:
            query = """UPDATE Dispute
                       SET status = %s, resolution = %s, is_resolved = %s,
                           resolution_date = NOW()
                       WHERE id = %s"""
            cursor.execute(query, (status, resolution, is_resolved, dispute_id))

        get_db().commit()

        return jsonify({"message": "Dispute updated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in resolve_game_dispute: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
