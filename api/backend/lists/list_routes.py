from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

lists = Blueprint('lists', __name__)


# All list IDs [Maya-2]
@lists.route('/', methods=['GET'])
def get_all_lists():
    cursor = get_db().cursor(dictionary=True)
    try:
        # TODO: complete query
        cursor.execute("SELECT 1")
        return jsonify({"message": "TODO"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Create a new empty list [Maya-2]
@lists.route('/', methods=['POST'])
def create_list():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()
        # TODO: complete query
        get_db().commit()
        return jsonify({"message": "TODO"}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Venues in a specific list [Maya-2]
@lists.route('/<int:list_id>', methods=['GET'])
def get_list(list_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        # TODO: complete query
        cursor.execute("SELECT 1")
        return jsonify({"message": "TODO"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Add or remove venues from list [Maya-2]
@lists.route('/<int:list_id>', methods=['PUT'])
def update_list(list_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()
        # TODO: complete query
        get_db().commit()
        return jsonify({"message": "TODO"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Delete a list [Maya-2]
@lists.route('/<int:list_id>', methods=['DELETE'])
def delete_list(list_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        # TODO: complete query
        get_db().commit()
        return jsonify({"message": "TODO"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
