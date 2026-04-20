from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

categories = Blueprint('categories', __name__)


# List all categories [Maya-1, Josh-5]
@categories.route('/', methods=['GET'])
def get_all_categories():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("SELECT categoryId, name FROM Category ORDER BY name")
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Add a new category [Josh-5]
@categories.route('/', methods=['POST'])
def create_category():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        name = data.get('name')
        if not name:
            return jsonify({"error": "'name' is required"}), 400
        cursor.execute("INSERT INTO Category (name) VALUES (%s)", (name,))
        get_db().commit()
        return jsonify({"message": "Category created", "categoryId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Rename a category [Josh-5]
@categories.route('/<int:cat_id>', methods=['PUT'])
def update_category(cat_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        name = data.get('name')
        if not name:
            return jsonify({"error": "'name' is required"}), 400
        cursor.execute("UPDATE Category SET name = %s WHERE categoryId = %s", (name, cat_id))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Category not found"}), 404
        return jsonify({"message": "Category updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Remove a category [Josh-5]
@categories.route('/<int:cat_id>', methods=['DELETE'])
def delete_category(cat_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM Category WHERE categoryId = %s", (cat_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Category not found"}), 404
        return jsonify({"message": "Category deleted"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
