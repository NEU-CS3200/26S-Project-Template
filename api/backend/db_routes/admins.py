from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

admins = Blueprint("admins", __name__)


#get all reports and add new report
@admins.route("/reports", methods=["GET", "POST"])
def get_all_reports():
    cursor = get_db().cursor(dictionary=True)
    try:
        if request.method == "GET":
            current_app.logger.info('GET /admins/reports')
            cursor.execute("SELECT * FROM Report")
            return jsonify(cursor.fetchall()), 200
        
        #post request to add new report
        elif request.method == "POST":
            data = request.get_json()
            required = ["ReportId", "Title", "Format", "StartDate", "EndDate" ]
            for field in required:
                if field not in data:
                    return jsonify({"error": f"Missing required field: {field}"}), 400
            if data["Format"] not in ["PDF", "Excel", "CSV"]:
                return jsonify({"error": "Invalid format. Must be PDF, Excel, or CSV"}), 400
            cursor.execute("INSERT INTO Report (ReportId, Title, Format, StartDate, EndDate) VALUES (%s, %s, %s, %s, %s)", 
                           (data["ReportId"], data["Title"], data["Format"], data["StartDate"], data["EndDate"]))
            get_db().commit()
            return jsonify({"message": "Report created.","report_id": data["ReportId"] }), 201
    except Error as e:
        current_app.logger.error(f'Database error in get_all_reports: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET    /admins/reports/{reportid} — get a specific report
# DELETE /admins/reports/{reportid} — delete a report
@admins.route("/reports/<int:report_id>", methods=["GET", "DELETE"])
def report(report_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM Report WHERE ReportId = %s", (report_id,))
        existing = cursor.fetchone()
        if not existing:
            return jsonify({"error": "Report not found"}), 404
 
        if request.method == "GET":
            return jsonify(existing), 200
 
        # DELETE
        cursor.execute("DELETE FROM Report WHERE ReportId = %s", (report_id,))
        get_db().commit()
        return jsonify({"message": "Report deleted"}), 200
 
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
 
 
# GET /admins/feedback — return all student feedback
#
# Schema: StudentFeedback(FeedbackSubmissionId, DietaryRestriction, HallId, Content,
#                          SubmittedDate, Status, CuisinePref, StudentId)
# Filterable by Status (enum: positive/negative/neutral) and HallId.
@admins.route("/feedback", methods=["GET"])
def get_feedback():
    cursor = get_db().cursor(dictionary=True)
    try:
        status = request.args.get("status")
        hall_id = request.args.get("hall_id")
 
        query = "SELECT * FROM StudentFeedback WHERE 1=1"
        params = []
 
        if status:
            if status not in ("positive", "negative", "neutral"):
                return jsonify({"error": "Status must be: positive, negative, or neutral"}), 400
            query += " AND Status = %s"
            params.append(status)
        if hall_id:
            query += " AND HallId = %s"
            params.append(hall_id)
 
        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
 
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
 
 
# PUT    /admins/feedback/{feedbackid} — update status or content of a submission
# DELETE /admins/feedback/{feedbackid} — delete a feedback submission
#
# FeedbackSubmissionId is the PK (not FeedbackId).
@admins.route("/feedback/<int:feedback_id>", methods=["PUT", "DELETE"])
def feedback(feedback_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            "SELECT FeedbackSubmissionId FROM StudentFeedback WHERE FeedbackSubmissionId = %s",
            (feedback_id,),
        )
        if not cursor.fetchone():
            return jsonify({"error": "Feedback not found"}), 404
 
        if request.method == "DELETE":
            cursor.execute(
                "DELETE FROM StudentFeedback WHERE FeedbackSubmissionId = %s", (feedback_id,)
            )
            get_db().commit()
            return jsonify({"message": "Feedback deleted"}), 200
 
        # PUT
        data = request.get_json()
 
        # Validate Status enum if provided
        if "Status" in data and data["Status"] not in ("positive", "negative", "neutral"):
            return jsonify({"error": "Status must be: positive, negative, or neutral"}), 400
 
        allowed = ["Status", "Content", "DietaryRestriction", "CuisinePref"]
        update_fields = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]
 
        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400
 
        params.append(feedback_id)
        cursor.execute(
            f"UPDATE StudentFeedback SET {', '.join(update_fields)} WHERE FeedbackSubmissionId = %s",
            params,
        )
        get_db().commit()
        return jsonify({"message": "Feedback updated"}), 200
 
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()