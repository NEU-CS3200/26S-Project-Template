from flask import Blueprint, jsonify, request, current_app
from hmac import compare_digest
from backend.db_connection import get_db
from mysql.connector import Error

users = Blueprint('users', __name__)


# Authenticate a user by username and stored hash [App login]
@users.route('/login', methods=['POST'])
def login_user():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        username = (data.get('username') or '').strip()
        password_hash = (data.get('pwdHash') or data.get('password') or '').strip()

        if not username or not password_hash:
            return jsonify({"error": "'username' and 'pwdHash' are required"}), 400

        cursor.execute(
            """
            SELECT accountId, email, firstName, lastName, username, phoneNum, city, role, pwdHash
            FROM Users
            WHERE username = %s
            LIMIT 1
            """,
            (username,)
        )
        row = cursor.fetchone()
        if not row or not compare_digest(str(row['pwdHash']), password_hash):
            return jsonify({"error": "Invalid username or password"}), 401

        row.pop('pwdHash', None)
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# List users with info [Josh-2]
@users.route('/', methods=['GET'])
def get_all_users():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT accountId, email, firstName, lastName, username, phoneNum, city, role, createdAt
            FROM Users
            ORDER BY createdAt DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Register a new user [Maya]
@users.route('/', methods=['POST'])
def create_user():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        required = ['email', 'pwdHash', 'firstName', 'lastName', 'username']
        missing = [field for field in required if not data.get(field)]
        if missing:
            return jsonify({"error": f"Missing required fields: {', '.join(missing)}"}), 400

        cursor.execute(
            """
            INSERT INTO Users (email, pwdHash, firstName, lastName, username, phoneNum, city, role)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (
                data['email'],
                data['pwdHash'],
                data['firstName'],
                data['lastName'],
                data['username'],
                data.get('phoneNum'),
                data.get('city'),
                data.get('role', 'CUSTOMER')
            )
        )
        get_db().commit()
        return jsonify({"message": "User created", "accountId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get user profile [Maya]
@users.route('/<int:user_id>', methods=['GET'])
def get_user(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT accountId, email, firstName, lastName, username, phoneNum, city, role, createdAt
            FROM Users
            WHERE accountId = %s
            """,
            (user_id,)
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "User not found"}), 404
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Update user info [Maya]
@users.route('/<int:user_id>', methods=['PUT'])
def update_user(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        cursor.execute(
            """
            UPDATE Users
            SET firstName = COALESCE(%s, firstName),
                lastName = COALESCE(%s, lastName),
                username = COALESCE(%s, username),
                phoneNum = COALESCE(%s, phoneNum),
                city = COALESCE(%s, city),
                email = COALESCE(%s, email)
            WHERE accountId = %s
            """,
            (
                data.get('firstName'),
                data.get('lastName'),
                data.get('username'),
                data.get('phoneNum'),
                data.get('city'),
                data.get('email'),
                user_id
            )
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "User not found"}), 404
        return jsonify({"message": "User updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Ban / delete a user account [Josh-2]
@users.route('/<int:user_id>', methods=['DELETE'])
def delete_user(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM Users WHERE accountId = %s", (user_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "User not found"}), 404
        return jsonify({"message": "User deleted"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# All venues owned by a user [Marcus-1]
@users.route('/<int:user_id>/venues', methods=['GET'])
def get_owner_venues(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT venueId, name, description, address, city, phoneNum,
                   rating, minPrice, maxPrice
            FROM Venues
            WHERE ownerId = %s
            ORDER BY name
            """,
            (user_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# All reviews written by a user [Maya-3, Marcus-4]
@users.route('/<int:user_id>/reviews', methods=['GET'])
def get_user_reviews(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.reviewId, r.venueId, v.name AS venueName, r.rating, r.comment,
                   r.isFlagged, r.createdAt
            FROM Reviews r
            JOIN Venues v ON v.venueId = r.venueId
            WHERE r.userId = %s
            ORDER BY r.createdAt DESC
            """,
            (user_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# All flagged reviews by a specific user [Josh-2]
@users.route('/<int:user_id>/flagged-reviews', methods=['GET'])
def get_user_flagged_reviews(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.reviewId, r.venueId, v.name AS venueName, r.rating, r.comment, r.createdAt
            FROM Reviews r
            JOIN Venues v ON v.venueId = r.venueId
            WHERE r.userId = %s AND r.isFlagged = TRUE
            ORDER BY r.createdAt DESC
            """,
            (user_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# All lists created by a user [Maya-2]
@users.route('/<int:user_id>/lists', methods=['GET'])
def get_user_lists(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            "SELECT listId, userId, name FROM Lists WHERE userId = %s ORDER BY listId",
            (user_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Create a new named list for user [Maya-2]
@users.route('/<int:user_id>/lists', methods=['POST'])
def create_user_list(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        name = data.get('name')
        if not name:
            return jsonify({"error": "'name' is required"}), 400

        cursor.execute(
            "INSERT INTO Lists (userId, name) VALUES (%s, %s)",
            (user_id, name)
        )
        get_db().commit()
        return jsonify({"message": "List created", "listId": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# User's saved venues with save date [Maya-5]
@users.route('/<int:user_id>/saved', methods=['GET'])
def get_saved_venues(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT v.venueId, v.name, v.city, v.address, v.rating, sv.savedAt
            FROM SavedVenues sv
            JOIN Venues v ON v.venueId = sv.venueId
            WHERE sv.userId = %s
            ORDER BY sv.savedAt DESC
            """,
            (user_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Save a venue to user's saved list [Maya-5]
@users.route('/<int:user_id>/saved', methods=['POST'])
def save_venue(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        venue_id = data.get('venueId')
        if not venue_id:
            return jsonify({"error": "'venueId' is required"}), 400

        cursor.execute(
            "INSERT INTO SavedVenues (userId, venueId) VALUES (%s, %s)",
            (user_id, venue_id)
        )
        get_db().commit()
        return jsonify({"message": "Venue saved"}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Remove a venue from saved list [Maya-5]
@users.route('/<int:user_id>/saved', methods=['DELETE'])
def unsave_venue(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        venue_id = data.get('venueId')
        if not venue_id:
            return jsonify({"error": "'venueId' is required"}), 400

        cursor.execute(
            "DELETE FROM SavedVenues WHERE userId = %s AND venueId = %s",
            (user_id, venue_id)
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Saved venue not found"}), 404
        return jsonify({"message": "Venue removed from saved list"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# All venues the user has marked visited [Maya-5]
@users.route('/<int:user_id>/visited', methods=['GET'])
def get_visited_venues(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT v.venueId, v.name, v.city, v.address, v.rating
            FROM ListVenue lv
            JOIN Lists l ON l.listId = lv.listId
            JOIN Venues v ON v.venueId = lv.venueId
            WHERE l.userId = %s AND l.name = 'Visited'
            ORDER BY v.name
            """,
            (user_id,)
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Mark a venue as visited [Maya-5]
@users.route('/<int:user_id>/visited', methods=['POST'])
def mark_visited(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        venue_id = data.get('venueId')
        if not venue_id:
            return jsonify({"error": "'venueId' is required"}), 400

        cursor.execute(
            "SELECT listId FROM Lists WHERE userId = %s AND name = 'Visited'",
            (user_id,)
        )
        row = cursor.fetchone()
        if row:
            list_id = row['listId']
        else:
            cursor.execute(
                "INSERT INTO Lists (userId, name) VALUES (%s, 'Visited')",
                (user_id,)
            )
            list_id = cursor.lastrowid

        cursor.execute(
            "INSERT IGNORE INTO ListVenue (listId, venueId) VALUES (%s, %s)",
            (list_id, venue_id)
        )
        get_db().commit()
        return jsonify({"message": "Venue marked as visited"}), 201
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Unmark a venue as visited [Maya-5]
@users.route('/<int:user_id>/visited', methods=['DELETE'])
def unmark_visited(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        venue_id = data.get('venueId')
        if not venue_id:
            return jsonify({"error": "'venueId' is required"}), 400

        cursor.execute(
            """
            DELETE lv FROM ListVenue lv
            JOIN Lists l ON l.listId = lv.listId
            WHERE l.userId = %s AND l.name = 'Visited' AND lv.venueId = %s
            """,
            (user_id, venue_id)
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Visited venue not found"}), 404
        return jsonify({"message": "Venue unmarked as visited"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
