from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

reviews = Blueprint('reviews', __name__)


# Get a specific review [Maya-4]
@reviews.route('/<int:review_id>', methods=['GET'])
def get_review(review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.reviewId, r.userId, u.username, r.venueId,
                   v.name AS venueName, r.rating, r.comment,
                   r.isFlagged, r.createdAt
            FROM Reviews r
            JOIN Users u ON u.accountId = r.userId
            JOIN Venues v ON v.venueId = r.venueId
            WHERE r.reviewId = %s
            """,
            (review_id,)
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Review not found"}), 404
        return jsonify(row), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Edit own review [Maya-3]
@reviews.route('/<int:review_id>', methods=['PUT'])
def update_review(review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json(silent=True) or {}
        rating = data.get('rating')
        comment = data.get('comment')
        cursor.execute(
            """
            UPDATE Reviews
            SET rating  = COALESCE(%s, rating),
                comment = COALESCE(%s, comment)
            WHERE reviewId = %s
            """,
            (rating, comment, review_id)
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Review not found"}), 404
        return jsonify({"message": "Review updated"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Delete own review [Maya-3]
@reviews.route('/<int:review_id>', methods=['DELETE'])
def delete_review(review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM Reviews WHERE reviewId = %s", (review_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Review not found"}), 404
        return jsonify({"message": "Review deleted"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Flag a review as inappropriate [Marcus-3, Josh-1]
@reviews.route('/<int:review_id>/flag', methods=['POST'])
def flag_review(review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            "UPDATE Reviews SET isFlagged = TRUE WHERE reviewId = %s",
            (review_id,)
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Review not found"}), 404
        return jsonify({"message": "Review flagged"}), 200
    except Error as e:
        current_app.logger.error(f'Error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
