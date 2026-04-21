from flask import Blueprint, current_app, jsonify, request
from mysql.connector import Error

from backend.db_connection import get_db

analytics = Blueprint("analytics", __name__)


# Get total check-ins per court for a given date range (Data Analyst User Story 1)
# Required: ?start=YYYY-MM-DD&end=YYYY-MM-DD
# Example: /analytics/checkins?start=2026-03-01&end=2026-03-31
@analytics.route("/checkins", methods=["GET"])
def checkin_counts():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /analytics/checkins")

        start = request.args.get("start", "2026-03-01")
        end = request.args.get("end", "2026-03-31")

        cursor.execute(
            """
            SELECT c.CourtId,
                   c.CourtName,
                   COUNT(ci.CheckInId) AS TotalCheckIns
            FROM Court c
                LEFT JOIN CheckIn ci
                    ON ci.CourtId = c.CourtId
                    AND ci.CheckInTime >= %s
                    AND ci.CheckInTime <= CONCAT(%s, ' 23:59:59')
            GROUP BY c.CourtId, c.CourtName
            ORDER BY TotalCheckIns DESC, c.CourtName
            """,
            (start, end),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in checkin_counts: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get check-in activity by neighborhood with coordinates for a heat map
# (Data Analyst User Story 2)
# Required: ?start=YYYY-MM-DD&end=YYYY-MM-DD
# Example: /analytics/heatmap?start=2026-03-01&end=2026-03-31
@analytics.route("/heatmap", methods=["GET"])
def heatmap():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /analytics/heatmap")

        start = request.args.get("start", "2026-03-01")
        end = request.args.get("end", "2026-03-31")

        cursor.execute(
            """
            SELECT n.NeighborhoodName,
                   c.CourtId,
                   c.CourtName,
                   c.Latitude,
                   c.Longitude,
                   COUNT(ci.CheckInId) AS ActivityCount
            FROM Court c
                JOIN Neighborhood n ON n.NeighborhoodId = c.NeighborhoodId
                LEFT JOIN CheckIn ci
                    ON ci.CourtId = c.CourtId
                    AND ci.CheckInTime >= %s
                    AND ci.CheckInTime <= CONCAT(%s, ' 23:59:59')
            GROUP BY n.NeighborhoodName, c.CourtId, c.CourtName,
                     c.Latitude, c.Longitude
            ORDER BY ActivityCount DESC, n.NeighborhoodName, c.CourtName
            """,
            (start, end),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in heatmap: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get peak usage hours per court grouped by day of week (Data Analyst User Story 3)
# Optional: ?start=, ?end=, ?court_name=
# Example: /analytics/peak-hours?start=2026-03-01&end=2026-03-31
@analytics.route("/peak-hours", methods=["GET"])
def peak_hours():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /analytics/peak-hours")

        start = request.args.get("start", "2026-03-01")
        end = request.args.get("end", "2026-03-31")
        court_name = request.args.get("court_name")

        query = """
            SELECT c.CourtName,
                   DAYNAME(ci.CheckInTime) AS DayOfWeek,
                   HOUR(ci.CheckInTime)    AS HourOfDay,
                   COUNT(*)                AS CheckInCount
            FROM CheckIn ci
                JOIN Court c ON c.CourtId = ci.CourtId
            WHERE ci.CheckInTime >= %s
              AND ci.CheckInTime <= CONCAT(%s, ' 23:59:59')
        """
        params = [start, end]

        if court_name:
            query += " AND c.CourtName = %s"
            params.append(court_name)

        query += """
            GROUP BY c.CourtName, DAYNAME(ci.CheckInTime), HOUR(ci.CheckInTime)
            ORDER BY c.CourtName, CheckInCount DESC
        """

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in peak_hours: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get average condition ratings with check-in totals per court (Data Analyst User Story 4)
# Optional: ?start=, ?end=
# Example: /analytics/court-conditions?start=2026-03-01&end=2026-03-31
@analytics.route("/court-conditions", methods=["GET"])
def court_conditions():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /analytics/court-conditions")

        start = request.args.get("start", "2026-03-01")
        end = request.args.get("end", "2026-03-31")

        cursor.execute(
            """
            SELECT c.CourtId,
                   c.CourtName,
                   ROUND(AVG(cr.ConditionRating), 2)               AS AvgConditionRating,
                   COUNT(cr.ReviewId)                              AS ReviewCount,
                   (SELECT COUNT(*)
                    FROM CheckIn ci
                    WHERE ci.CourtId = c.CourtId
                      AND ci.CheckInTime >= %s
                      AND ci.CheckInTime <= CONCAT(%s, ' 23:59:59')) AS CheckInCount
            FROM Court c
                LEFT JOIN CourtReview cr ON cr.CourtId = c.CourtId
            WHERE cr.ReviewDate >= %s
               OR cr.ReviewDate IS NULL
            GROUP BY c.CourtId, c.CourtName
            ORDER BY CheckInCount DESC, AvgConditionRating ASC
            """,
            (start, end, start),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in court_conditions: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Export check-in data with duration for a date range (Data Analyst User Story 5)
# Optional: ?neighborhood= to filter by neighborhood
# Example: /analytics/checkins/export?start=2026-03-01&end=2026-03-31&neighborhood=Mission Hill
@analytics.route("/checkins/export", methods=["GET"])
def export_checkins():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /analytics/checkins/export")

        start = request.args.get("start", "2026-03-01")
        end = request.args.get("end", "2026-03-31")
        neighborhood = request.args.get("neighborhood")

        query = """
            SELECT ci.CheckInId,
                   ci.CheckInTime,
                   ci.CheckOutTime,
                   TIMESTAMPDIFF(MINUTE, ci.CheckInTime, ci.CheckOutTime) AS DurationMinutes,
                   p.PlayerId,
                   p.Username,
                   c.CourtId,
                   c.CourtName,
                   n.NeighborhoodName
            FROM CheckIn ci
                JOIN Player p ON p.PlayerId = ci.PlayerId
                JOIN Court c ON c.CourtId = ci.CourtId
                JOIN Neighborhood n ON n.NeighborhoodId = c.NeighborhoodId
            WHERE ci.CheckInTime >= %s
              AND ci.CheckInTime <= CONCAT(%s, ' 23:59:59')
        """
        params = [start, end]

        if neighborhood:
            query += " AND n.NeighborhoodName = %s"
            params.append(neighborhood)

        query += " ORDER BY ci.CheckInTime"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in export_checkins: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get active user count and average skill rating grouped by ZIP code (Data Analyst User Story 6)
# Example: /analytics/users-by-zip
@analytics.route("/users-by-zip", methods=["GET"])
def users_by_zipcode():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /analytics/users/zipcode")

        cursor.execute(
            """
            SELECT ZipCode,
                   COUNT(*)                   AS ActiveUserCount,
                   ROUND(AVG(SkillRating), 2) AS AvgSkillRating
            FROM Player
            WHERE IsActive = TRUE
            GROUP BY ZipCode
            ORDER BY ActiveUserCount DESC, ZipCode
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in users_by_zipcode: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
