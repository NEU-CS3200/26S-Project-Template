from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

analytics = Blueprint("analytics", __name__)

# 1. participation trends
@analytics.route("/analytics/participation", methods=["GET"])
def get_participation_trends():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /analytics/participation')

        query = """SELECT l.sport, l.season, COUNT(tm.player_id) AS total_players
			FROM League l
			JOIN Team t ON l.id = t.league_id
			JOIN Team_Membership tm ON t.id = tm.team_id
			GROUP BY l.sport, l.season"""

        cursor.execute(query)
        results = cursor.fetchall()

        current_app.logger.info(f'Retrieved {len(results)} data results for participation')
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_participation_trends: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
    
    
        
# 2. venue utilization
@analytics.route("/analytics/venues", methods=["GET"])
def get_venue_utilization_trends():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /analytics/venues')

        query = """SELECT v.name,
					COUNT(vts.id) AS total_slots,
					SUM(vts.is_available = 0) AS used_slots
				FROM Venue v
				JOIN Venue_Time_Slot vts ON v.id = vts.venue_id
				GROUP BY v.name"""

        cursor.execute(query)
        results = cursor.fetchall()

        current_app.logger.info(f'Retrieved {len(results)} data results for venue utilization')
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venue_utilization_trends: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        
# 3. No show rates by sport or game time
@analytics.route("/analytics/forfeits", methods=["GET"])
def get_no_show_rates():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /analytics/forfeits')
        filter = request.args.get("filter")
        
        if filter == "sport":
            query = """SELECT l.sport, SUM(gr.is_forfeit = 1) / COUNT(DISTINCT gr.game_id) AS forfeit_rate
				FROM Game g
				JOIN Game_Result gr ON g.id = gr.game_id
				JOIN League l ON g.league_id = l.id
				GROUP BY l.sport"""
        elif filter == "game_time":
            query = """SELECT g.game_time, SUM(gr.is_forfeit = 1) / COUNT(DISTINCT gr.game_id) AS forfeit_rate
					FROM Game g
					JOIN Game_Result gr ON g.id = gr.game_id
					GROUP BY g.game_time"""
        else:
            current_app.logger.error('Error in get_no_show_rates: Invalid filter (must filter by sport or game_time in request args)')
            return jsonify({"error": "invalid filter in get_no_show_rates"}), 400

        cursor.execute(query)
        results = cursor.fetchall()

        current_app.logger.info(f'Retrieved {len(results)} data results for venue utilization on filter {filter}')
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_no_show_rates: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# 4. avg pts scored by month
@analytics.route("/analytics/<int:teamId>/pts-scored", methods=["GET"])
def get_avg_points_scored(teamId):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'GET /analytics/{teamId}/pts-scored')

        query = """SELECT YEAR(g.game_date), MONTH(g.game_date), AVG(IF(g.home_team_id = %s, gr.home_score, gr.away_score))
                FROM Game_Result gr
                JOIN Game g ON gr.game_id = g.id
                JOIN League l ON g.league_id = l.id
                WHERE g.home_team_id = %s OR g.away_team_id = %s
                GROUP BY YEAR(g.game_date), MONTH(g.game_date)"""

        cursor.execute(query, (teamId, teamId, teamId))
        results = cursor.fetchall()

        current_app.logger.info(f'Retrieved {len(results)} data results for avg points scored')
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_avg_points_scored: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# 5. avg pts opponent scored by month
@analytics.route("/analytics/<int:teamId>/pts-allowed", methods=["GET"])
def get_avg_points_allowed(teamId):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'GET /analytics/{teamId}/pts-allowed')

        query = """SELECT YEAR(g.game_date), MONTH(g.game_date), AVG(IF(g.home_team_id = %s, gr.away_score, gr.home_score))
                FROM Game_Result gr
                JOIN Game g ON gr.game_id = g.id
                JOIN League l ON g.league_id = l.id
                WHERE g.home_team_id = %s OR g.away_team_id = %s
                GROUP BY YEAR(g.game_date), MONTH(g.game_date)"""

        cursor.execute(query, (teamId, teamId, teamId))
        results = cursor.fetchall()

        current_app.logger.info(f'Retrieved {len(results)} data results for avg points scored')
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_avg_points_scored: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# 6. registration demand
@analytics.route("/analytics/demand", methods=["GET"])
def get_registration_demand():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /analytics/demand')

        query = """SELECT l.sport, l.season, l.division_tier, COUNT(DISTINCT far.id) AS total_agent_requests
                FROM League l
                JOIN Free_Agent_Request far ON l.id = far.league_id
                GROUP BY l.sport, l.season, l.division_tier"""

        cursor.execute(query)
        results = cursor.fetchall()

        current_app.logger.info(f'Retrieved {len(results)} data results for registration demand')
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_registration_demand: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# 7. end-of-season reports
@analytics.route("/analytics/reports", methods=["GET"])
def get_analytics_report():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /analytics/reports')

        season = request.args.get("season")

        query = "SELECT * FROM Analytics_Report WHERE 1=1"
        params = []

        if season:
            query += " AND season = %s"
            params.append(season)

        cursor.execute(query, params)
        results = cursor.fetchall()

        current_app.logger.info(f'Retrieved {len(results)} data results for reports')
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_analytics_report: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()