from flask import Blueprint, current_app, jsonify, request
from mysql.connector import Error

from backend.db_connection import get_db

players = Blueprint("players", __name__)


# Get all players, ordered by registration date
# Optional: ?flagged=true to show only flagged accounts (Admin User Story 5)
# Example: /player/players
@players.route("/players", methods=["GET"])
def get_all_players():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /player/players")

        flagged = request.args.get("flagged", "false").lower() == "true"

        # WHERE 1=1 lets us append AND clauses without special-casing the first filter
        query = """
            SELECT PlayerId, Username, Email, SkillRating, Position, Height,
                   PreferredCourtType, ZipCode, RegistrationDate, IsActive, IsFlagged
            FROM Player
            WHERE 1=1
        """
        params = []

        if flagged:
            query += " AND IsFlagged = TRUE"

        query += " ORDER BY RegistrationDate DESC, Username"

        cursor.execute(query, params)
        player_list = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(player_list)} players")
        return jsonify(player_list), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_players: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get a single player's profile with game stats and skill rank (Pickup Player User Story 4)
# Example: /player/players/1
@players.route("/players/<int:player_id>", methods=["GET"])
def get_player(player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /player/players/{player_id}")

        cursor.execute(
            """
            SELECT p.PlayerId,
                   p.Username,
                   p.Email,
                   p.SkillRating,
                   p.Position,
                   p.Height,
                   p.PreferredCourtType,
                   p.ZipCode,
                   p.RegistrationDate,
                   COUNT(gp.GameId)                                    AS GamesPlayed,
                   SUM(CASE WHEN gp.Result = 'Win' THEN 1 ELSE 0 END) AS Wins,
                   (SELECT COUNT(*) + 1
                    FROM Player p2
                    WHERE p2.SkillRating > p.SkillRating
                      AND p2.IsActive = TRUE)                          AS SkillRank
            FROM Player p
                LEFT JOIN GameParticipation gp ON gp.PlayerId = p.PlayerId
            WHERE p.PlayerId = %s
            GROUP BY p.PlayerId, p.Username, p.Email, p.SkillRating,
                     p.Position, p.Height, p.PreferredCourtType,
                     p.ZipCode, p.RegistrationDate
            """,
            (player_id,),
        )
        player = cursor.fetchone()

        if not player:
            return jsonify({"error": "Player not found"}), 404

        return jsonify(player), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_player: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Update player profile information (Competitive Player User Story 5)
# Can update any field except PlayerId
# Example: PUT /player/players/2
@players.route("/players/<int:player_id>", methods=["PUT"])
def update_player(player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /player/players/{player_id}")
        data = request.get_json()

        # Build update query dynamically based on provided fields
        allowed_fields = [
            "Username",
            "Email",
            "Position",
            "Height",
            "PreferredCourtType",
            "SkillRating",
            "ZipCode",
            "IsActive",
            "IsFlagged",
        ]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(player_id)
        query = f"UPDATE Player SET {', '.join(update_fields)} WHERE PlayerId = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "Player updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_player: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Deactivate a violating player account (Admin User Story 5)
# Sets IsActive = FALSE (soft delete, does not remove the row)
# Example: DELETE /player/players/5
@players.route("/players/<int:player_id>", methods=["DELETE"])
def deactivate_player(player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /player/players/{player_id}")

        cursor.execute(
            "UPDATE Player SET IsActive = FALSE WHERE PlayerId = %s",
            (player_id,),
        )
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Player not found"}), 404

        return jsonify({"message": "Player account deactivated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in deactivate_player: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get the public leaderboard ranked by skill rating (Competitive Player User Story 1)
# Example: /player/leaderboard
@players.route("/leaderboard", methods=["GET"])
def get_leaderboard():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /player/leaderboard")

        cursor.execute(
            """
            SELECT PlayerId,
                   Username,
                   SkillRating,
                   Position
            FROM Player
            WHERE IsActive = TRUE
            ORDER BY SkillRating DESC, Username
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_leaderboard: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get the player's most recent games with court + result info (Pickup Player Profile)
# Optional: ?limit=10 to cap results (defaults to 10)
# Example: /player/players/1/recent-games
@players.route("/players/<int:player_id>/recent-games", methods=["GET"])
def get_recent_games(player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /player/players/{player_id}/recent-games")

        limit = request.args.get("limit", default=10, type=int)
        limit = max(1, min(limit, 50))

        cursor.execute(
            """
            SELECT g.GameId,
                   g.GameDate,
                   g.GameType,
                   c.CourtId,
                   c.CourtName,
                   gp.Result,
                   gp.Score
            FROM GameParticipation gp
                JOIN Game g  ON g.GameId  = gp.GameId
                JOIN Court c ON c.CourtId = g.CourtId
            WHERE gp.PlayerId = %s
            ORDER BY g.GameDate DESC
            LIMIT %s
            """,
            (player_id, limit),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_recent_games: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Derive a skill-score trend from a player's game history (Pickup Player Profile)
# The schema stores a single current SkillRating per player, so we synthesize a
# trajectory by walking their games in chronological order and applying a small
# delta per win/loss that ends on the player's current rating * 1000 (display).
# Example: /player/players/1/skill-history
@players.route("/players/<int:player_id>/skill-history", methods=["GET"])
def get_skill_history(player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /player/players/{player_id}/skill-history")

        cursor.execute(
            "SELECT SkillRating FROM Player WHERE PlayerId = %s",
            (player_id,),
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Player not found"}), 404
        current_rating = float(row["SkillRating"] or 0)

        cursor.execute(
            """
            SELECT g.GameDate, gp.Result
            FROM GameParticipation gp
                JOIN Game g ON g.GameId = gp.GameId
            WHERE gp.PlayerId = %s
            ORDER BY g.GameDate ASC
            """,
            (player_id,),
        )
        games = cursor.fetchall()

        # Display skill score = rating * 1000 (e.g. 4.5 -> 4500; demo rank ~1240)
        win_delta = 18
        loss_delta = 12
        net_delta = sum(
            win_delta if (g["Result"] or "").lower() == "win" else -loss_delta
            for g in games
        )
        start_score = round(current_rating * 1000) - net_delta

        history = []
        running = start_score
        for g in games:
            running += (
                win_delta if (g["Result"] or "").lower() == "win" else -loss_delta
            )
            history.append(
                {
                    "GameDate": g["GameDate"].isoformat() if g["GameDate"] else None,
                    "SkillScore": running,
                }
            )

        return jsonify(history), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_skill_history: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Check in at a court (Pickup Player User Story 2)
# Required fields: PlayerId, CourtId
# Example: POST /player/checkins
@players.route("/checkins", methods=["POST"])
def checkin():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("POST /player/checkins")
        data = request.get_json()

        required_fields = ["PlayerId", "CourtId"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        cursor.execute(
            """
            INSERT INTO CheckIn (CheckInTime, CheckOutTime, PlayerId, CourtId)
            VALUES (NOW(), NULL, %s, %s)
            """,
            (data["PlayerId"], data["CourtId"]),
        )
        get_db().commit()

        return jsonify(
            {"message": "Checked in successfully", "CheckInId": cursor.lastrowid}
        ), 201
    except Error as e:
        current_app.logger.error(f"Database error in checkin: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Check out of a court when leaving (Pickup Player User Story 6)
# Example: PUT /player/checkins/6/checkout
@players.route("/checkins/<int:checkin_id>/checkout", methods=["PUT"])
def checkout(checkin_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /player/checkins/{checkin_id}/checkout")

        cursor.execute(
            "UPDATE CheckIn SET CheckOutTime = NOW() WHERE CheckInId = %s",
            (checkin_id,),
        )
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Check-in record not found"}), 404

        return jsonify({"message": "Checked out successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in checkout: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
