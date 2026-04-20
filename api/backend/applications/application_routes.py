from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

applications = Blueprint('applications', __name__)


# List all applications (filterable by status and ownerId) [Josh-3, Marcus-5]
@applications.route('/', methods=['GET'])
def get_all_applications():
    cursor = get_db().cursor(dictionary=True)
    try:
        status = request.args.get('status')
        owner_id = request.args.get('ownerId', type=int)
        cursor.execute(
            """
            SELECT a.applicationId, a.ownerId, u.username AS ownerUsername,
                   a.name, a.description, a.address, a.phone,
                   a.minPrice, a.maxPrice, a.status, a.createdAt
            FROM VenueApplications a
            LEFT JOIN Users u ON u.accountId = a.ownerId
            WHERE (%s IS NULL OR a.status = %s)
              AND (%s IS NULL OR a.ownerId = %s)
            ORDER BY a.createdAt DESC
            """,
            (status, status, owner_id, owner_id)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Submit a new venue application [Marcus-5]
@applications.route('/', methods=['POST'])
def create_application():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        required = ['ownerId', 'name', 'address']
        missing = [f for f in required if not data.get(f)]
        if missing:
            return jsonify({"error": f"Missing required fields: {', '.join(missing)}"}), 400
        cursor.execute(
            """
            INSERT INTO VenueApplications
                (ownerId, name, description, address, phone, minPrice, maxPrice)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
            """,
            (
                data['ownerId'],
                data['name'],
                data.get('description'),
                data['address'],
                data.get('phone'),
                data.get('minPrice'),
                data.get('maxPrice'),
            )
        )
        get_db().commit()
        return jsonify({"message": "Application submitted", "applicationId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Full details of an application [Josh-3]
@applications.route('/<int:app_id>', methods=['GET'])
def get_application(app_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT a.applicationId, a.ownerId, u.username AS ownerUsername,
                   a.name, a.description, a.address, a.phone,
                   a.minPrice, a.maxPrice, a.status, a.createdAt
            FROM VenueApplications a
            LEFT JOIN Users u ON u.accountId = a.ownerId
            WHERE a.applicationId = %s
            """,
            (app_id,)
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Application not found"}), 404
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Approve or reject an application [Josh-3]
@applications.route('/<int:app_id>', methods=['PUT'])
def update_application(app_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        status = data.get('status')
        if status not in ('APPROVED', 'REJECTED', 'PENDING'):
            return jsonify({"error": "status must be APPROVED, REJECTED, or PENDING"}), 400
        cursor.execute(
            "UPDATE VenueApplications SET status = %s WHERE applicationId = %s",
            (status, app_id)
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Application not found"}), 404
        return jsonify({"message": f"Application {status.lower()}"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
