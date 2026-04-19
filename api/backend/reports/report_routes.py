from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

reports = Blueprint("reports", __name__)


# ---- /reports ---------------------------------------------------------------

# GET /reports — list/filter reports. Supported query params:
#   ?type=accessibility|snow_plow_request|bike_theft|plowed
#   ?status=open|resolved|in_progress
#   ?date_from=YYYY-MM-DD   ?date_to=YYYY-MM-DD
#   ?issue_type=<issue_type_name>   ?urgency=Low|Medium|High
# [Paul-2][Wilson-3][John-1][John-5] — Phase 2 SQL 1.2, 4.1, 4.5
@reports.route("", methods=["GET"])
def list_reports():
    cursor = get_db().cursor(dictionary=True)
    try:
        q_type = request.args.get("type")
        q_status = request.args.get("status")
        q_from = request.args.get("date_from")
        q_to = request.args.get("date_to")
        q_issue = request.args.get("issue_type")
        q_urgency = request.args.get("urgency")

        query = """
            SELECT r.report_id, r.report_date, r.report_type, r.report_status,
                   r.urgency, r.description, r.location_id, r.user_id,
                   l.street_name, l.neighborhood_name, l.zip_code,
                   it.issue_type_name, it.issue_category
            FROM report r
            LEFT JOIN location l ON r.location_id = l.location_id
            LEFT JOIN accessibility_report ar ON r.report_id = ar.report_id
            LEFT JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
            WHERE 1=1
        """
        params = []
        if q_type:
            query += " AND r.report_type = %s"
            params.append(q_type)
        if q_status:
            query += " AND r.report_status = %s"
            params.append(q_status)
        if q_from:
            query += " AND r.report_date >= %s"
            params.append(q_from)
        if q_to:
            query += " AND r.report_date <= %s"
            params.append(q_to)
        if q_issue:
            query += " AND it.issue_type_name = %s"
            params.append(q_issue)
        if q_urgency:
            query += " AND r.urgency = %s"
            params.append(q_urgency)
        query += " ORDER BY r.report_date DESC"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"list_reports: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /reports — create a new report. Body can include optional
# accessibility extras (issue_type_id, photo_url) which create a matching
# accessibility_report row. [John-2] — Phase 2 SQL 4.2
@reports.route("", methods=["POST"])
def create_report():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        required = ["report_date", "report_type", "report_status", "user_id"]
        for f in required:
            if f not in data:
                return jsonify({"error": f"Missing required field: {f}"}), 400

        cursor.execute(
            """
            INSERT INTO report
                (report_date, report_type, report_status, urgency,
                 description, location_id, user_id)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            """,
            (
                data["report_date"],
                data["report_type"],
                data["report_status"],
                data.get("urgency"),
                data.get("description"),
                data.get("location_id"),
                data["user_id"],
            ),
        )
        new_report_id = cursor.lastrowid

        if data.get("issue_type_id"):
            cursor.execute(
                """
                INSERT INTO accessibility_report
                    (report_id, issue_type_id, report_date,
                     report_status, photo_url, user_id)
                VALUES (%s, %s, %s, %s, %s, %s)
                """,
                (
                    new_report_id,
                    data["issue_type_id"],
                    data["report_date"],
                    data["report_status"],
                    data.get("photo_url"),
                    data["user_id"],
                ),
            )

        db.commit()
        return jsonify({"message": "Report created", "report_id": new_report_id}), 201
    except Error as e:
        db.rollback()
        current_app.logger.error(f"create_report: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /reports/{id} ----------------------------------------------------------

# GET /reports/{id} — view one report with location, issue type, user,
# and any linked tickets. [Wilson-4][John-3] — Phase 2 SQL 2.6
@reports.route("/<int:report_id>", methods=["GET"])
def get_report(report_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.*,
                   l.street_name, l.neighborhood_name, l.zip_code,
                   u.first_name, u.last_name, u.user_email,
                   ar.issue_type_id, ar.photo_url,
                   it.issue_type_name, it.issue_category
            FROM report r
            LEFT JOIN location l ON r.location_id = l.location_id
            LEFT JOIN `user` u ON r.user_id = u.user_id
            LEFT JOIN accessibility_report ar ON r.report_id = ar.report_id
            LEFT JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
            WHERE r.report_id = %s
            """,
            (report_id,),
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Report not found"}), 404

        cursor.execute(
            "SELECT ticket_id, ticket_status, ticket_date, ticket_time "
            "FROM accessibility_ticket WHERE report_id = %s",
            (report_id,),
        )
        row["tickets"] = cursor.fetchall()
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f"get_report: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /reports/{id} — update any subset of report fields.
# [Wilson-4][John-3] — Phase 2 SQL 2.4, 4.3
# NOTE: Phase 2 SQL 4.3 also updates `past_report_status`; that column is
# not yet in the committed DDL (see docs/rest-api-matrix.md open items).
# Once added, include it in the allowed list below.
@reports.route("/<int:report_id>", methods=["PUT"])
def update_report(report_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}

        cursor.execute("SELECT report_id FROM report WHERE report_id = %s", (report_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Report not found"}), 404

        allowed = [
            "report_date", "report_type", "report_status",
            "urgency", "description", "location_id",
        ]
        updates = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]
        if not updates:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(report_id)
        cursor.execute(
            f"UPDATE report SET {', '.join(updates)} WHERE report_id = %s",
            params,
        )
        get_db().commit()
        return jsonify({"message": "Report updated"}), 200
    except Error as e:
        current_app.logger.error(f"update_report: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /reports/{id} — [Wilson-4][John-4] — Phase 2 SQL 4.4
@reports.route("/<int:report_id>", methods=["DELETE"])
def delete_report(report_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM report WHERE report_id = %s", (report_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Report not found"}), 404
        return jsonify({"message": "Report deleted"}), 200
    except Error as e:
        current_app.logger.error(f"delete_report: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /reports/mine/{user_id} ------------------------------------------------

# GET /reports/mine/{user_id} — view a user's own submitted reports.
# [John-3][John-4]
@reports.route("/mine/<int:user_id>", methods=["GET"])
def get_my_reports(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.report_id, r.report_date, r.report_type, r.report_status,
                   r.urgency, r.description,
                   l.street_name, l.neighborhood_name
            FROM report r
            LEFT JOIN location l ON r.location_id = l.location_id
            WHERE r.user_id = %s
            ORDER BY r.report_date DESC
            """,
            (user_id,),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /reports/high-priority -------------------------------------------------

# GET /reports/high-priority — reports whose linked ticket is flagged
# high_priority. [Paul-6] — Phase 2 SQL 1.6
@reports.route("/high-priority", methods=["GET"])
def high_priority_reports():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT ar.report_id, ar.report_date, ar.report_status,
                   it.issue_type_name, l.neighborhood_name,
                   at.ticket_status, at.ticket_id
            FROM accessibility_report ar
            JOIN issue_type it ON ar.issue_type_id = it.issue_type_id
            JOIN report r ON ar.report_id = r.report_id
            JOIN location l ON r.location_id = l.location_id
            JOIN accessibility_ticket at ON ar.report_id = at.report_id
            WHERE at.ticket_status = 'high_priority'
            ORDER BY ar.report_date DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"high_priority_reports: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /reports/invalid -------------------------------------------------------

# GET /reports/invalid — reports with missing required fields, for admin
# review. [Wilson-3] — Phase 2 SQL 2.3
@reports.route("/invalid", methods=["GET"])
def invalid_reports():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.report_id, r.report_date, r.report_status, r.report_type,
                   r.description, u.first_name, u.last_name, u.user_email
            FROM report r
            JOIN `user` u ON r.user_id = u.user_id
            WHERE r.description   IS NULL
               OR r.report_type   IS NULL
               OR r.report_status IS NULL
               OR r.location_id   IS NULL
            ORDER BY r.report_date DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"invalid_reports: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
