from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

analytics = Blueprint('analytics', __name__)


# New user signups over time; filter by date range [Joey-1]
@analytics.route('/signups', methods=['GET'])
def get_signups():
    cursor = get_db().cursor(dictionary=True)
    try:
        start = request.args.get('start')
        end = request.args.get('end')
        cursor.execute(
            """
            SELECT DATE(createdAt) AS signupDate,
                   COUNT(accountId) AS newSignups
            FROM Users
            WHERE (%s IS NULL OR DATE(createdAt) >= %s)
              AND (%s IS NULL OR DATE(createdAt) <= %s)
            GROUP BY DATE(createdAt)
            ORDER BY signupDate
            """,
            (start, start, end, end)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Highest rated & most saved venues; filter by city/category [Joey-2]
@analytics.route('/venues/top', methods=['GET'])
def get_top_venues():
    cursor = get_db().cursor(dictionary=True)
    try:
        city = request.args.get('city')
        category_id = request.args.get('category_id', type=int)
        cursor.execute(
            """
            SELECT v.venueId, v.name, v.city,
                   ROUND(AVG(r.rating), 2)   AS avgRating,
                   COUNT(DISTINCT r.reviewId) AS totalReviews,
                   COUNT(DISTINCT sv.userId)  AS totalSaves
            FROM Venues v
            LEFT JOIN Reviews r      ON r.venueId = v.venueId
            LEFT JOIN SavedVenues sv ON sv.venueId = v.venueId
            LEFT JOIN VenueCategory vc ON vc.venueId = v.venueId
            WHERE (%s IS NULL OR v.city = %s)
              AND (%s IS NULL OR vc.categoryId = %s)
            GROUP BY v.venueId, v.name, v.city
            ORDER BY avgRating DESC, totalSaves DESC
            """,
            (city, city, category_id, category_id)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Cities with high user activity but low venue listings [Joey-3]
@analytics.route('/coverage', methods=['GET'])
def get_coverage_gaps():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT u.city,
                   COUNT(DISTINCT u.accountId)  AS totalUsers,
                   COUNT(DISTINCT v.venueId)    AS totalVenues,
                   COUNT(DISTINCT r.reviewId)   AS totalReviews
            FROM Users u
            LEFT JOIN Venues v  ON v.city = u.city
            LEFT JOIN Reviews r ON r.userId = u.accountId
            WHERE u.city IS NOT NULL
            GROUP BY u.city
            ORDER BY totalUsers DESC, totalVenues ASC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Review submission volume per venue over time; detect anomalies [Joey-4]
@analytics.route('/reviews/volume', methods=['GET'])
def get_review_volume():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT v.venueId, v.name,
                   YEAR(r.createdAt)  AS reviewYear,
                   MONTH(r.createdAt) AS reviewMonth,
                   COUNT(r.reviewId)  AS reviewCount,
                   ROUND(AVG(r.rating), 2) AS avgRating
            FROM Reviews r
            JOIN Venues v ON v.venueId = r.venueId
            GROUP BY v.venueId, v.name, YEAR(r.createdAt), MONTH(r.createdAt)
            ORDER BY reviewCount DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# User activity over time; identify inactive users [Joey-5]
@analytics.route('/retention', methods=['GET'])
def get_retention():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT u.accountId, u.username, u.city,
                   MAX(r.createdAt)  AS lastReview,
                   MAX(sv.savedAt)   AS lastSave,
                   COUNT(DISTINCT r.reviewId)  AS totalReviews,
                   COUNT(DISTINCT sv.venueId)  AS totalSaves
            FROM Users u
            LEFT JOIN Reviews r      ON r.userId = u.accountId
            LEFT JOIN SavedVenues sv ON sv.userId = u.accountId
            WHERE u.role = 'CUSTOMER'
            GROUP BY u.accountId, u.username, u.city
            ORDER BY lastReview ASC, lastSave ASC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Platform-wide stats summary [Joey-6]
@analytics.route('/summary', methods=['GET'])
def get_platform_summary():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT
                (SELECT COUNT(*) FROM Users)                                           AS totalUsers,
                (SELECT COUNT(*) FROM Venues)                                          AS totalVenues,
                (SELECT COUNT(*) FROM Reviews)                                         AS totalReviews,
                (SELECT ROUND(AVG(rating), 2) FROM Reviews)                            AS platformAvgRating,
                (SELECT COUNT(*) FROM SavedVenues)                                     AS totalSaves,
                (SELECT COUNT(*) FROM VenueApplications WHERE status = 'PENDING')      AS pendingApplications,
                (SELECT COUNT(*) FROM ReportTickets   WHERE status = 'PENDING')        AS pendingTickets,
                (SELECT COUNT(*) FROM Users WHERE role = 'CUSTOMER')                   AS totalCustomers,
                (SELECT COUNT(*) FROM Users WHERE role = 'VENUE_OWNER')                AS totalOwners
            """
        )
        return jsonify(cursor.fetchone()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
