from flask import Blueprint, jsonify, request, current_app
try:
    from ..db_connection import get_db
except (ImportError, ValueError):
    try:
        from backend.db_connection import get_db
    except ImportError:
        from api.backend.db_connection import get_db
from mysql.connector import Error

vibes = Blueprint('vibes', __name__)


# GET /vibes - List all vibe tags
# [Maya-1, Josh-5]
@vibes.route('/', methods=['GET'])
def get_all_vibes():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('GET /vibes')
        cursor.execute("SELECT vibeId, name FROM Vibe ORDER BY name")
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /vibes - Add a new vibe tag
# [Josh-5]
@vibes.route('/', methods=['POST'])
def create_vibe():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('POST /vibes')
        data = request.get_json(silent=True) or {}
        name = data.get('name')
        if not name:
            return jsonify({"error": "'name' is required"}), 400
        cursor.execute("INSERT INTO Vibe (name) VALUES (%s)", (name,))
        get_db().commit()
        return jsonify({"message": "Vibe created", "vibeId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /vibes/<id> - Rename a vibe tag
# [Josh-5]
@vibes.route('/<int:vibe_id>', methods=['PUT'])
def update_vibe(vibe_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'PUT /vibes/{vibe_id}')
        data = request.get_json(silent=True) or {}
        name = data.get('name')
        if not name:
            return jsonify({"error": "'name' is required"}), 400
        cursor.execute("UPDATE Vibe SET name = %s WHERE vibeId = %s", (name, vibe_id))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Vibe not found"}), 404
        return jsonify({"message": "Vibe updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /vibes/<id> - Remove a vibe tag
# [Josh-5]
@vibes.route('/<int:vibe_id>', methods=['DELETE'])
def delete_vibe(vibe_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'DELETE /vibes/{vibe_id}')
        cursor.execute("DELETE FROM Vibe WHERE vibeId = %s", (vibe_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Vibe not found"}), 404
        return jsonify({"message": "Vibe deleted"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
