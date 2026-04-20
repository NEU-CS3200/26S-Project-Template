from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

admin_log = Blueprint('admin_log', __name__)


# GET /log - Most recent admin actions across platform [Josh-6]
@admin_log.route('/', methods=['GET'])
def get_log_entries():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /log')
        cursor.execute(
            """
            SELECT al.logId, al.adminId,
                   u.firstName AS adminName,
                   al.action, al.targetTable, al.targetId,
                   al.performedAt, al.notes,
                   al.appId, al.reportId
            FROM AdminLog al
            JOIN Users u ON u.accountId = al.adminId
            ORDER BY al.performedAt DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /log/<id> - Detail view of a specific log entry [Josh-6]
@admin_log.route('/<int:log_id>', methods=['GET'])
def get_log_entry(log_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'GET /log/{log_id}')
        cursor.execute(
            """
            SELECT al.logId, al.adminId,
                   u.firstName AS adminName,
                   al.action, al.targetTable, al.targetId,
                   al.performedAt, al.notes,
                   al.appId, al.reportId
            FROM AdminLog al
            JOIN Users u ON u.accountId = al.adminId
            WHERE al.logId = %s
            """,
            (log_id,)
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Log entry not found"}), 404
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /log - Record an admin action [Josh-6]
@admin_log.route('/', methods=['POST'])
def create_log_entry():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        admin_id = data.get('adminId')
        action = data.get('action')
        if not admin_id or not action:
            return jsonify({"error": "'adminId' and 'action' are required"}), 400
        cursor.execute(
            """
            INSERT INTO AdminLog (adminId, appId, reportId, action, targetTable, targetId, notes)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            """,
            (
                admin_id,
                data.get('appId'),
                data.get('reportId'),
                action,
                data.get('targetTable'),
                data.get('targetId'),
                data.get('notes'),
            )
        )
        get_db().commit()
        return jsonify({"message": "Log entry created", "logId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
