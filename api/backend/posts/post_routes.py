from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

posts = Blueprint('posts', __name__)


# Get a specific post [Marcus-6]
@posts.route('/<int:post_id>', methods=['GET'])
def get_post(post_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT p.postId, p.ownerId, u.username AS ownerUsername,
                   p.venueId, v.name AS venueName, p.content, p.postDate
            FROM Posts p
            JOIN Users u ON u.accountId = p.ownerId
            JOIN Venues v ON v.venueId = p.venueId
            WHERE p.postId = %s
            """,
            (post_id,)
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Post not found"}), 404
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Edit a post's content [Marcus-6]
@posts.route('/<int:post_id>', methods=['PUT'])
def update_post(post_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        content = data.get('content')
        if not content:
            return jsonify({"error": "'content' is required"}), 400
        cursor.execute(
            "UPDATE Posts SET content = %s WHERE postId = %s",
            (content, post_id)
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Post not found"}), 404
        return jsonify({"message": "Post updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Delete a post [Marcus-6]
@posts.route('/<int:post_id>', methods=['DELETE'])
def delete_post(post_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM Posts WHERE postId = %s", (post_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Post not found"}), 404
        return jsonify({"message": "Post deleted"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
