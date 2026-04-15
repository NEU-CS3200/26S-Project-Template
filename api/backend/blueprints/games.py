from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

games = Blueprint("games", __name__)


# 1. All games with details
@games.route("/games", methods=["GET"])
def get_all_games():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /games")

        status = request.args.get("status")
        league_id = request.args.get("league_id")

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
                   WHERE 1=1"""
        params = []

        if status:
            query += " AND g.status = %s"
            params.append(status)
        if league_id:
            query += " AND g.league_id = %s"
            params.append(league_id)

        query += " ORDER BY g.game_date, g.game_time"

        cursor.execute(query, params)
        results = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(results)} games")
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_games: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 2. Single game with full details
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

        current_app.logger.info(f"Retrieved game {game_id}")
        return jsonify(result), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_game: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 3. Result for a specific game
@games.route("/games/<int:game_id>/result", methods=["GET"])
def get_game_result(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/{game_id}/result")

        query = """SELECT gr.home_score, gr.away_score, gr.is_forfeit,
                          wt.name AS winning_team_name
                   FROM Game_Result gr
                   JOIN Team wt ON gr.winning_team_id = wt.id
                   WHERE gr.game_id = %s"""

        cursor.execute(query, (game_id,))
        result = cursor.fetchone()

        if not result:
            return jsonify({"error": "No result found for this game"}), 404

        current_app.logger.info(f"Retrieved result for game {game_id}")
        return jsonify(result), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_game_result: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 4. All games for a team
@games.route("/games/team/<int:team_id>", methods=["GET"])
def get_games_by_team(team_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/team/{team_id}")

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

        current_app.logger.info(f"Retrieved {len(results)} games for team {team_id}")
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_games_by_team: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 5. All games for a player (through team membership)
@games.route("/games/player/<int:player_id>", methods=["GET"])
def get_games_by_player(player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/player/{player_id}")

        query = """SELECT DISTINCT g.id AS game_id, g.game_time, g.game_date, g.status,
                          v.name AS venue_name,
                          ht.name AS home_team_name,
                          at.name AS away_team_name,
                          l.sport, l.league_name
                   FROM Game g
                   JOIN Venue v ON g.venue_id = v.id
                   JOIN Team ht ON g.home_team_id = ht.id
                   JOIN Team at ON g.away_team_id = at.id
                   JOIN League l ON g.league_id = l.id
                   JOIN Team_Membership tm ON (tm.team_id = g.home_team_id
                                               OR tm.team_id = g.away_team_id)
                   WHERE tm.player_id = %s
                   ORDER BY g.game_date, g.game_time"""

        cursor.execute(query, (player_id,))
        results = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(results)} games for player {player_id}")
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_games_by_player: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 6. All games in a league
@games.route("/games/league/<int:league_id>", methods=["GET"])
def get_games_by_league(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/league/{league_id}")

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
                   WHERE g.league_id = %s
                   ORDER BY g.game_date, g.game_time"""

        cursor.execute(query, (league_id,))
        results = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(results)} games for league {league_id}")
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_games_by_league: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 7. Player stats for a game
@games.route("/games/<int:game_id>/stats", methods=["GET"])
def get_game_stats(game_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/{game_id}/stats")

        query = """SELECT p.first_name, p.last_name,
                          pgs.points, pgs.goals_scored, pgs.assists,
                          pgs.attended, pgs.wins
                   FROM Player_Game_Stats pgs
                   JOIN Player p ON pgs.player_id = p.id
                   WHERE pgs.game_id = %s"""

        cursor.execute(query, (game_id,))
        results = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(results)} player stats for game {game_id}")
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_game_stats: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 8. League standings (wins/losses per team)
@games.route("/games/league/<int:league_id>/standings", methods=["GET"])
def get_league_standings(league_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/league/{league_id}/standings")

        query = """SELECT t.id AS team_id, t.name AS team_name,
                          SUM(CASE WHEN gr.winning_team_id = t.id THEN 1 ELSE 0 END) AS wins,
                          SUM(CASE WHEN gr.winning_team_id != t.id THEN 1 ELSE 0 END) AS losses
                   FROM Team t
                   JOIN Game g ON (g.home_team_id = t.id OR g.away_team_id = t.id)
                   JOIN Game_Result gr ON gr.game_id = g.id
                   WHERE g.league_id = %s
                   GROUP BY t.id, t.name
                   ORDER BY wins DESC, losses ASC"""

        cursor.execute(query, (league_id,))
        results = cursor.fetchall()

        current_app.logger.info(f"Retrieved standings for {len(results)} teams in league {league_id}")
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_league_standings: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 9. Head-to-head results between two teams
@games.route("/games/team/<int:team_id>/head-to-head/<int:opponent_id>", methods=["GET"])
def get_head_to_head(team_id, opponent_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/team/{team_id}/head-to-head/{opponent_id}")

        query = """SELECT g.id AS game_id, g.game_date,
                          gr.home_score, gr.away_score, gr.is_forfeit,
                          wt.name AS winning_team_name
                   FROM Game g
                   JOIN Game_Result gr ON gr.game_id = g.id
                   JOIN Team wt ON gr.winning_team_id = wt.id
                   WHERE ((g.home_team_id = %s AND g.away_team_id = %s)
                       OR (g.home_team_id = %s AND g.away_team_id = %s))
                   ORDER BY g.game_date DESC"""

        cursor.execute(query, (team_id, opponent_id, opponent_id, team_id))
        game_results = cursor.fetchall()

        cursor.execute("SELECT name FROM Team WHERE id = %s", (team_id,))
        team_row = cursor.fetchone()
        cursor.execute("SELECT name FROM Team WHERE id = %s", (opponent_id,))
        opponent_row = cursor.fetchone()

        team_name = team_row["name"] if team_row else "Unknown"
        opponent_name = opponent_row["name"] if opponent_row else "Unknown"

        team_wins = sum(1 for g in game_results if g["winning_team_name"] == team_name)
        opponent_wins = sum(1 for g in game_results if g["winning_team_name"] == opponent_name)

        response = {
            "team_name": team_name,
            "opponent_name": opponent_name,
            "team_wins": team_wins,
            "opponent_wins": opponent_wins,
            "games": game_results
        }

        current_app.logger.info(f"Retrieved {len(game_results)} head-to-head games")
        return jsonify(response), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_head_to_head: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# 10. Aggregated player stats across games
@games.route("/games/player/<int:player_id>/stats", methods=["GET"])
def get_player_stats(player_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /games/player/{player_id}/stats")

        season = request.args.get("season")

        query = """SELECT COUNT(pgs.game_id) AS games_played,
                          SUM(pgs.points) AS total_points,
                          SUM(pgs.goals_scored) AS total_goals,
                          SUM(pgs.assists) AS total_assists,
                          SUM(pgs.wins) AS total_wins,
                          SUM(pgs.attended) AS games_attended
                   FROM Player_Game_Stats pgs
                   JOIN Game g ON pgs.game_id = g.id
                   JOIN League l ON g.league_id = l.id
                   WHERE pgs.player_id = %s"""
        params = [player_id]

        if season:
            query += " AND l.season = %s"
            params.append(season)

        cursor.execute(query, params)
        result = cursor.fetchone()

        current_app.logger.info(f"Retrieved aggregated stats for player {player_id}")
        return jsonify(result), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_player_stats: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
