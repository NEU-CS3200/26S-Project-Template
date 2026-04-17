from flask import Blueprint, current_app, jsonify, request
from mysql.connector import Error

from backend.db_connection import get_db

tournaments_bp = Blueprint("tournaments", __name__)


# Get all tournaments with court name and registered player count
# Optional: ?status=Upcoming|Ongoing|Completed
# Example: /tournament/tournaments
@tournaments_bp.route("/tournaments", methods=["GET"])
def get_all_tournaments():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /tournament/tournaments")

        status = request.args.get("status")

        query = """
            SELECT t.TournamentId,
                   t.TournamentName,
                   t.StartDate,
                   t.EndDate,
                   t.Status,
                   c.CourtName,
                   COUNT(tr.PlayerId) AS RegisteredPlayers
            FROM Tournament t
                LEFT JOIN Court c ON c.CourtId = t.CourtId
                LEFT JOIN TournamentRegistration tr
                    ON tr.TournamentId = t.TournamentId
            WHERE 1=1
        """
        params = []

        if status:
            query += " AND t.Status = %s"
            params.append(status)

        query += """
            GROUP BY t.TournamentId, t.TournamentName, t.StartDate, t.EndDate,
                     t.Status, c.CourtName
            ORDER BY t.StartDate
        """

        cursor.execute(query, params)
        tournament_list = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(tournament_list)} tournaments")
        return jsonify(tournament_list), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_tournaments: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get a specific tournament with registered players and bracket (Competitive Player User Story 6)
# Optional: ?player_id= to filter bracket to one player's matches
# Example: /tournament/tournaments/2
@tournaments_bp.route("/tournaments/<int:tournament_id>", methods=["GET"])
def get_tournament(tournament_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /tournament/tournaments/{tournament_id}")

        cursor.execute(
            """
            SELECT t.TournamentId, t.TournamentName, t.StartDate, t.EndDate,
                   t.Status, t.Winner, c.CourtName
            FROM Tournament t
                LEFT JOIN Court c ON c.CourtId = t.CourtId
            WHERE t.TournamentId = %s
            """,
            (tournament_id,),
        )
        tournament = cursor.fetchone()

        if not tournament:
            return jsonify({"error": "Tournament not found"}), 404

        # Get all registered players
        cursor.execute(
            """
            SELECT p.PlayerId, p.Username, p.SkillRating, tr.RegistrationDate
            FROM TournamentRegistration tr
                JOIN Player p ON p.PlayerId = tr.PlayerId
            WHERE tr.TournamentId = %s
            ORDER BY p.SkillRating DESC
            """,
            (tournament_id,),
        )
        tournament["registrations"] = cursor.fetchall()

        # Get bracket matches, optionally filtered to one player
        player_id = request.args.get("player_id")

        bracket_query = """
            SELECT t.TournamentName,
                   tm.MatchId,
                   tm.RoundNumber,
                   tm.MatchOrder,
                   tm.MatchStatus,
                   p1.Username AS PlayerName,
                   p2.Username AS OpponentName,
                   mp1.IsWinner
            FROM Tournament t
                JOIN TournamentMatch tm ON tm.TournamentId = t.TournamentId
                JOIN MatchParticipation mp1 ON mp1.MatchId = tm.MatchId
                JOIN Player p1 ON p1.PlayerId = mp1.PlayerId
                LEFT JOIN MatchParticipation mp2
                    ON mp2.MatchId = tm.MatchId AND mp2.PlayerId <> mp1.PlayerId
                LEFT JOIN Player p2 ON p2.PlayerId = mp2.PlayerId
            WHERE t.TournamentId = %s
        """
        bracket_params = [tournament_id]

        if player_id:
            bracket_query += " AND p1.PlayerId = %s"
            bracket_params.append(player_id)

        bracket_query += " ORDER BY tm.RoundNumber, tm.MatchOrder"

        cursor.execute(bracket_query, bracket_params)
        tournament["bracket"] = cursor.fetchall()

        return jsonify(tournament), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_tournament: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Register a player for a tournament (Competitive Player User Story 3)
# Required fields: PlayerId
# Example: POST /tournament/tournaments/1/register
@tournaments_bp.route("/tournaments/<int:tournament_id>/register", methods=["POST"])
def register_player(tournament_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(
            f"POST /tournament/tournaments/{tournament_id}/register"
        )
        data = request.get_json()

        if "PlayerId" not in data:
            return jsonify({"error": "Missing required field: PlayerId"}), 400

        cursor.execute(
            """
            INSERT INTO TournamentRegistration (PlayerId, TournamentId, RegistrationDate)
            VALUES (%s, %s, CURDATE())
            """,
            (data["PlayerId"], tournament_id),
        )
        get_db().commit()

        return jsonify({"message": "Registered for tournament successfully"}), 201
    except Error as e:
        current_app.logger.error(f"Database error in register_player: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get live bracket standings for a tournament (Competitive Player User Story 6)
# Example: /tournament/tournaments/2/brackets
@tournaments_bp.route("/tournaments/<int:tournament_id>/brackets", methods=["GET"])
def get_tournament_brackets(tournament_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(
            f"GET /tournament/tournaments/{tournament_id}/brackets"
        )

        cursor.execute(
            """
            SELECT tm.MatchId,
                   tm.RoundNumber,
                   tm.MatchOrder,
                   tm.MatchStatus,
                   p1.PlayerId    AS PlayerId,
                   p1.Username    AS PlayerName,
                   p2.PlayerId    AS OpponentId,
                   p2.Username    AS OpponentName,
                   mp1.IsWinner
            FROM TournamentMatch tm
                JOIN MatchParticipation mp1 ON mp1.MatchId = tm.MatchId
                JOIN Player p1 ON p1.PlayerId = mp1.PlayerId
                LEFT JOIN MatchParticipation mp2
                    ON mp2.MatchId = tm.MatchId AND mp2.PlayerId <> mp1.PlayerId
                LEFT JOIN Player p2 ON p2.PlayerId = mp2.PlayerId
            WHERE tm.TournamentId = %s
            ORDER BY tm.RoundNumber, tm.MatchOrder
            """,
            (tournament_id,),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_tournament_brackets: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Remove an invalid tournament listing with full cascade delete (Admin User Story 6)
# Deletes in order: MatchParticipation -> TournamentMatch -> TournamentRegistration -> Tournament
# Example: DELETE /tournament/tournaments/16
@tournaments_bp.route("/tournaments/<int:tournament_id>", methods=["DELETE"])
def delete_tournament(tournament_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /tournament/tournaments/{tournament_id}")

        # Must delete child rows first to avoid foreign key constraint errors
        cursor.execute(
            """
            DELETE mp FROM MatchParticipation mp
                JOIN TournamentMatch tm ON tm.MatchId = mp.MatchId
            WHERE tm.TournamentId = %s
            """,
            (tournament_id,),
        )
        cursor.execute(
            "DELETE FROM TournamentMatch WHERE TournamentId = %s",
            (tournament_id,),
        )
        cursor.execute(
            "DELETE FROM TournamentRegistration WHERE TournamentId = %s",
            (tournament_id,),
        )
        cursor.execute(
            "DELETE FROM Tournament WHERE TournamentId = %s",
            (tournament_id,),
        )
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Tournament not found"}), 404

        return jsonify({"message": "Tournament deleted successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in delete_tournament: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Log a new game and record participation results (Competitive Player User Story 2)
# Required fields: CourtId, GameDate, players (list of {PlayerId, Result, Score})
# Optional fields: GameType, MinSkillRating
# Example: POST /tournament/games
@tournaments_bp.route("/games", methods=["POST"])
def create_game():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("POST /tournament/games")
        data = request.get_json()

        required_fields = ["CourtId", "GameDate", "players"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        cursor.execute(
            """
            INSERT INTO Game (CourtId, GameDate, GameType, MinSkillRating)
            VALUES (%s, %s, %s, %s)
            """,
            (
                data["CourtId"],
                data["GameDate"],
                data.get("GameType", "Pickup"),
                data.get("MinSkillRating", 0),
            ),
        )
        game_id = cursor.lastrowid

        # Insert a participation record for each player in the game
        for p in data["players"]:
            cursor.execute(
                """
                INSERT INTO GameParticipation (GameId, PlayerId, Result, Score)
                VALUES (%s, %s, %s, %s)
                """,
                (game_id, p["PlayerId"], p["Result"], p.get("Score", 0)),
            )

        get_db().commit()
        return jsonify({"message": "Game logged successfully", "GameId": game_id}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_game: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get games filtered by minimum skill rating or court (Competitive Player User Story 4)
# Optional: ?min_skill_rating=4.0, ?court_id=1
# Example: /tournament/games?min_skill_rating=4.0
@tournaments_bp.route("/games", methods=["GET"])
def get_games():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /tournament/games")

        min_skill = request.args.get("min_skill_rating")
        court_id = request.args.get("court_id")

        query = """
            SELECT c.CourtId, c.CourtName, c.Address,
                   g.GameId, g.GameDate, g.GameType, g.MinSkillRating
            FROM Court c
                JOIN Game g ON g.CourtId = c.CourtId
            WHERE c.IsActive = TRUE
        """
        params = []

        if min_skill:
            query += " AND g.MinSkillRating >= %s"
            params.append(float(min_skill))
        if court_id:
            query += " AND g.CourtId = %s"
            params.append(int(court_id))

        query += " ORDER BY g.MinSkillRating DESC, g.GameDate"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_games: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Log a game result for a player in an existing game (Competitive Player User Story 2)
# Required fields: PlayerId, Result, Score
# Example: POST /tournament/games/1/participants
@tournaments_bp.route("/games/<int:game_id>/participants", methods=["POST"])
def add_game_participant(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /tournament/games/{game_id}/participants")
        data = request.get_json()

        required_fields = ["PlayerId", "Result", "Score"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        cursor.execute(
            """
            INSERT INTO GameParticipation (GameId, PlayerId, Result, Score)
            VALUES (%s, %s, %s, %s)
            """,
            (game_id, data["PlayerId"], data["Result"], data["Score"]),
        )
        get_db().commit()

        return jsonify({"message": "Game result logged successfully"}), 201
    except Error as e:
        current_app.logger.error(f"Database error in add_game_participant: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Update a game participation result and optionally update a player's skill rating
# (Competitive Player User Story 2)
# Required fields: Result, Score
# Optional: SkillRating (updates the player's overall rating)
# Example: PUT /tournament/games/1/players/2
@tournaments_bp.route("/games/<int:game_id>/players/<int:player_id>", methods=["PUT"])
def update_game_result(game_id, player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /tournament/games/{game_id}/players/{player_id}")
        data = request.get_json()

        cursor.execute(
            """
            UPDATE GameParticipation
            SET Result = %s, Score = %s
            WHERE GameId = %s AND PlayerId = %s
            """,
            (data["Result"], data.get("Score", 0), game_id, player_id),
        )

        # If a new skill rating is provided, update the player's overall rating too
        if "SkillRating" in data:
            cursor.execute(
                "UPDATE Player SET SkillRating = %s WHERE PlayerId = %s",
                (data["SkillRating"], player_id),
            )

        get_db().commit()
        return jsonify({"message": "Game result updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_game_result: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
