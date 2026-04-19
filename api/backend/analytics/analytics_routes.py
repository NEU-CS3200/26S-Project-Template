from flask import Blueprint, jsonify
from backend.db_connection import get_db

analytics = Blueprint('analytics', __name__)

@analytics.route('/analytics/test', methods=['GET'])
def test():
    return jsonify({"message": "analytics working"})

@analytics.route('/analytics/placement-rate', methods=['GET'])
def placement_rate():
    query = """
        SELECT
            COUNT(DISTINCT s.StudentID) AS total_students,
            COUNT(DISTINCT CASE
                WHEN jo.OfferAccepted = TRUE
                 AND ja.IsArchived = FALSE
                THEN s.StudentID
            END) AS students_placed,
            ROUND(
                COUNT(DISTINCT CASE
                    WHEN jo.OfferAccepted = TRUE
                     AND ja.IsArchived = FALSE
                    THEN s.StudentID
                END) * 100.0
                / NULLIF(COUNT(DISTINCT s.StudentID), 0),
                2
            ) AS placement_rate
        FROM Student s
        LEFT JOIN Job_Application ja
            ON s.StudentID = ja.StudentID
        LEFT JOIN Job_Offer jo
            ON ja.ApplicationID = jo.ApplicationID;
    """

    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(query)
    row = cursor.fetchone()
    cursor.close()

    return jsonify({
        "total_students": int(row[0] or 0),
        "students_placed": int(row[1] or 0),
        "placement_rate": float(row[2] or 0)
    })

@analytics.route('/analytics/conversion-funnel', methods=['GET'])
def conversion_funnel():
    query = """
        SELECT
            COUNT(DISTINCT ja.ApplicationID) AS total_applications,
            COUNT(DISTINCT i.InterviewID) AS total_interviews,
            COUNT(DISTINCT jo.OfferID) AS total_offers,
            ROUND(
                COUNT(DISTINCT i.InterviewID) * 100.0
                / NULLIF(COUNT(DISTINCT ja.ApplicationID), 0),
                2
            ) AS application_to_interview_rate,
            ROUND(
                COUNT(DISTINCT jo.OfferID) * 100.0
                / NULLIF(COUNT(DISTINCT i.InterviewID), 0),
                2
            ) AS interview_to_offer_rate
        FROM Job_Application ja
        LEFT JOIN Interview i
            ON ja.ApplicationID = i.ApplicationID
        LEFT JOIN Job_Offer jo
            ON ja.ApplicationID = jo.ApplicationID
        WHERE ja.IsArchived = FALSE;
    """

    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(query)
    row = cursor.fetchone()
    cursor.close()

    return jsonify({
        "total_applications": int(row[0] or 0),
        "total_interviews": int(row[1] or 0),
        "total_offers": int(row[2] or 0),
        "application_to_interview_rate": float(row[3] or 0),
        "interview_to_offer_rate": float(row[4] or 0)
    })

@analytics.route('/analytics/average-salary', methods=['GET'])
def average_salary():
    query = """
        SELECT AVG(Salary)
        FROM Job_Offer
        WHERE OfferAccepted = TRUE;
    """

    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(query)
    row = cursor.fetchone()
    cursor.close()

    return jsonify({
        "average_salary": float(row[0] or 0)
    })

@analytics.route('/analytics/time-to-offer', methods=['GET'])
def time_to_offer():
    query = """
        SELECT
            ROUND(AVG(TIMESTAMPDIFF(DAY, ja.Application_Date, jo.DateExtended)), 2) AS avg_days_to_offer,
            ROUND(AVG(TIMESTAMPDIFF(WEEK, ja.Application_Date, jo.DateExtended)), 2) AS avg_weeks_to_offer
        FROM Job_Application ja
        JOIN Job_Offer jo
            ON ja.ApplicationID = jo.ApplicationID
        WHERE jo.DateExtended IS NOT NULL
          AND ja.IsArchived = FALSE;
    """

    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(query)
    row = cursor.fetchone()
    cursor.close()

    return jsonify({
        "avg_days_to_offer": float(row[0] or 0),
        "avg_weeks_to_offer": float(row[1] or 0)
    })


@analytics.route('/analytics/trends', methods=['GET'])
def trends():
    query = """
        SELECT
            DATE_FORMAT(ja.Application_Date, '%Y-%m') AS month_bucket,
            COUNT(DISTINCT ja.ApplicationID) AS applications,
            COUNT(DISTINCT i.InterviewID) AS interviews,
            COUNT(DISTINCT jo.OfferID) AS offers
        FROM Job_Application ja
        LEFT JOIN Interview i
            ON ja.ApplicationID = i.ApplicationID
        LEFT JOIN Job_Offer jo
            ON ja.ApplicationID = jo.ApplicationID
        WHERE ja.IsArchived = FALSE
        GROUP BY DATE_FORMAT(ja.Application_Date, '%Y-%m')
        ORDER BY month_bucket;
    """

    conn = get_db()
    cursor = conn.cursor()
    cursor.execute(query)
    rows = cursor.fetchall()
    cursor.close()

    return jsonify([
        {
            "month_bucket": row[0],
            "applications": int(row[1] or 0),
            "interviews": int(row[2] or 0),
            "offers": int(row[3] or 0)
        }
        for row in rows
    ])
