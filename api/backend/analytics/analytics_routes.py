from flask import Blueprint, jsonify, request, current_app, Response
from backend.db_connection import get_db
from mysql.connector import Error
import csv
import io
import json

analytics = Blueprint("analytics", __name__)


# GET /analytics/issues-by-neighborhood — report counts per neighborhood
# grouped by issue type. [Paul-1][Wilson-5] — Phase 2 SQL 1.1
@analytics.route("/issues-by-neighborhood", methods=["GET"])
def issues_by_neighborhood():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT l.neighborhood_name,
                   it.issue_type_name,
                   COUNT(ar.report_id) AS report_count
            FROM accessibility_report ar
            JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
            JOIN report r ON ar.report_id = r.report_id
            JOIN location l ON r.location_id = l.location_id
            GROUP BY l.neighborhood_name, it.issue_type_name
            ORDER BY report_count DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"issues_by_neighborhood: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /analytics/trends — monthly trend of new reports per issue type.
# Optional ?from=YYYY-MM-DD&to=YYYY-MM-DD. [Paul-5] — Phase 2 SQL 1.5
# (MySQL-adapted: DATE_FORMAT instead of DATE_TRUNC)
@analytics.route("/trends", methods=["GET"])
def trends():
    cursor = get_db().cursor(dictionary=True)
    try:
        date_from = request.args.get("from")
        date_to = request.args.get("to")

        query = """
            SELECT DATE_FORMAT(ar.report_date, '%%Y-%%m') AS report_month,
                   it.issue_type_name,
                   COUNT(ar.report_id) AS new_reports
            FROM accessibility_report ar
            JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
            WHERE 1=1
        """
        params = []
        if date_from:
            query += " AND ar.report_date >= %s"
            params.append(date_from)
        if date_to:
            query += " AND ar.report_date <= %s"
            params.append(date_to)
        query += " GROUP BY report_month, it.issue_type_name ORDER BY report_month ASC"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"trends: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /analytics/resolution-summary — resolved vs unresolved ticket counts,
# with optional neighborhood + issue_type breakdown via ?groupby=.
# [Paul-3][Wilson-5] — Phase 2 SQL 1.3, 1.4
@analytics.route("/resolution-summary", methods=["GET"])
def resolution_summary():
    cursor = get_db().cursor(dictionary=True)
    try:
        groupby = request.args.get("groupby")  # 'neighborhood' | 'issue_type' | None

        if groupby == "neighborhood":
            cursor.execute(
                """
                SELECT l.neighborhood_name,
                       COUNT(ar.report_id) AS total_reports,
                       SUM(CASE WHEN at.ticket_status = 'resolved'
                                THEN 1 ELSE 0 END) AS resolved_count
                FROM accessibility_report ar
                JOIN report r ON ar.report_id = r.report_id
                JOIN location l ON r.location_id = l.location_id
                LEFT JOIN accessibility_ticket at ON ar.report_id = at.report_id
                GROUP BY l.neighborhood_name
                ORDER BY total_reports DESC
                """
            )
        elif groupby == "issue_type":
            cursor.execute(
                """
                SELECT it.issue_type_name,
                       COUNT(ar.report_id) AS total_reports,
                       SUM(CASE WHEN at.ticket_status = 'resolved'
                                THEN 1 ELSE 0 END) AS resolved_count
                FROM accessibility_report ar
                JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
                LEFT JOIN accessibility_ticket at ON ar.report_id = at.report_id
                GROUP BY it.issue_type_name
                ORDER BY total_reports DESC
                """
            )
        else:
            cursor.execute(
                """
                SELECT ticket_status, COUNT(ticket_id) AS ticket_count
                FROM accessibility_ticket
                GROUP BY ticket_status
                """
            )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"resolution_summary: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /analytics/high-priority — high-priority reports summary for the
# policy dashboard. [Paul-6] — Phase 2 SQL 1.6 (summary shape)
@analytics.route("/high-priority", methods=["GET"])
def high_priority_summary():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT l.neighborhood_name,
                   it.issue_type_name,
                   COUNT(ar.report_id) AS high_priority_count
            FROM accessibility_report ar
            JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
            JOIN report r ON ar.report_id = r.report_id
            JOIN location l ON r.location_id = l.location_id
            JOIN accessibility_ticket at ON ar.report_id = at.report_id
            WHERE at.ticket_status = 'high_priority'
            GROUP BY l.neighborhood_name, it.issue_type_name
            ORDER BY high_priority_count DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"high_priority_summary: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /analytics/export — export aggregated report+ticket data as CSV or
# JSON. Optional ?format=csv|json (default csv), ?from=, ?to=.
# [Paul-4][Wilson-6]
@analytics.route("/export", methods=["GET"])
def export_data():
    cursor = get_db().cursor(dictionary=True)
    try:
        fmt = (request.args.get("format") or "csv").lower()
        date_from = request.args.get("from")
        date_to = request.args.get("to")

        query = """
            SELECT r.report_id, r.report_date, r.report_type, r.report_status,
                   r.urgency, r.description,
                   l.neighborhood_name, l.street_name,
                   it.issue_type_name, it.issue_category,
                   at.ticket_id, at.ticket_status
            FROM report r
            LEFT JOIN location l ON r.location_id = l.location_id
            LEFT JOIN accessibility_report ar ON r.report_id = ar.report_id
            LEFT JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
            LEFT JOIN accessibility_ticket at ON r.report_id = at.report_id
            WHERE 1=1
        """
        params = []
        if date_from:
            query += " AND r.report_date >= %s"
            params.append(date_from)
        if date_to:
            query += " AND r.report_date <= %s"
            params.append(date_to)
        query += " ORDER BY r.report_date DESC"

        cursor.execute(query, params)
        rows = cursor.fetchall()

        if fmt == "json":
            return Response(
                json.dumps(rows, default=str),
                mimetype="application/json",
                headers={"Content-Disposition":
                         "attachment; filename=bostonability_export.json"},
            )

        buf = io.StringIO()
        if rows:
            writer = csv.DictWriter(buf, fieldnames=rows[0].keys())
            writer.writeheader()
            writer.writerows(rows)
        return Response(
            buf.getvalue(),
            mimetype="text/csv",
            headers={"Content-Disposition":
                     "attachment; filename=bostonability_export.csv"},
        )
    except Error as e:
        current_app.logger.error(f"export_data: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
