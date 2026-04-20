from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

tickets = Blueprint('tickets', __name__)


# List all report tickets, filterable by status [Josh-1]
@tickets.route('/', methods=['GET'])
def get_all_tickets():
    cursor = get_db().cursor(dictionary=True)
    try:
        status = request.args.get('status')
        cursor.execute(
            """
            SELECT rt.reportId, rt.reporterId,
                   u.username AS reporterUsername,
                   rt.reviewId, rt.reason, rt.description,
                   rt.status, rt.createdAt
            FROM ReportTickets rt
            LEFT JOIN Users u ON u.accountId = rt.reporterId
            WHERE (%s IS NULL OR rt.status = %s)
            ORDER BY rt.createdAt DESC
            """,
            (status, status)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Submit a new report ticket [Marcus-3]
@tickets.route('/', methods=['POST'])
def create_ticket():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        reporter_id = data.get('reporterId')
        reason = data.get('reason')
        if not reporter_id or not reason:
            return jsonify({"error": "'reporterId' and 'reason' are required"}), 400
        cursor.execute(
            """
            INSERT INTO ReportTickets (reporterId, reviewId, reason, description)
            VALUES (%s, %s, %s, %s)
            """,
            (reporter_id, data.get('reviewId'), reason, data.get('description'))
        )
        get_db().commit()
        return jsonify({"message": "Ticket submitted", "reportId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Detail view of a specific ticket [Josh-1]
@tickets.route('/<int:ticket_id>', methods=['GET'])
def get_ticket(ticket_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT rt.reportId, rt.reporterId,
                   u.username AS reporterUsername,
                   rt.reviewId, r.comment AS reviewComment,
                   rt.reason, rt.description, rt.status, rt.createdAt
            FROM ReportTickets rt
            LEFT JOIN Users u   ON u.accountId  = rt.reporterId
            LEFT JOIN Reviews r ON r.reviewId   = rt.reviewId
            WHERE rt.reportId = %s
            """,
            (ticket_id,)
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Ticket not found"}), 404
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Resolve, dismiss, or escalate a ticket [Josh-1]
@tickets.route('/<int:ticket_id>', methods=['PUT'])
def update_ticket(ticket_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        status = data.get('status')
        valid = ('PENDING', 'UNDER REVIEW', 'RESOLVED', 'DISMISSED')
        if status not in valid:
            return jsonify({"error": f"status must be one of {valid}"}), 400
        cursor.execute(
            "UPDATE ReportTickets SET status = %s WHERE reportId = %s",
            (status, ticket_id)
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Ticket not found"}), 404
        return jsonify({"message": f"Ticket updated to {status}"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
