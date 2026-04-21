from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

review_routes = Blueprint("review_routes", __name__)


# GET /review/reviews/<id>
# Return a single review with attendee and event info
@review_routes.route("/reviews/<int:review_id>", methods=["GET"])
def get_review(review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                r.ReviewID,
                r.Rating,
                r.Comment,
                r.Date,
                a.AttendeeID,
                a.FName AS AttendeeFirstName,
                a.LName AS AttendeeLastName,
                e.EventID,
                e.Name AS EventName
            FROM Review r
            JOIN Attendee a ON r.AttendeeID = a.AttendeeID
            JOIN Event e ON r.EventID = e.EventID
            WHERE r.ReviewID = %s
        """
        cursor.execute(query, (review_id,))
        review = cursor.fetchone()
        if not review:
            return jsonify({"error": "Review not found"}), 404
        return jsonify(review), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_review: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /review/reviews/event/<id>
# Return all reviews for a specific event plus the average rating
@review_routes.route("/reviews/event/<int:event_id>", methods=["GET"])
def get_reviews_for_event(event_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                r.ReviewID,
                r.Rating,
                r.Comment,
                r.Date,
                a.FName AS AttendeeFirstName,
                a.LName AS AttendeeLastName
            FROM Review r
            JOIN Attendee a ON r.AttendeeID = a.AttendeeID
            WHERE r.EventID = %s
            ORDER BY r.Date DESC
        """
        cursor.execute(query, (event_id,))
        reviews = cursor.fetchall()

        avg_query = """
            SELECT AVG(Rating) AS AverageRating, COUNT(*) AS TotalReviews
            FROM Review
            WHERE EventID = %s
        """
        cursor.execute(avg_query, (event_id,))
        summary = cursor.fetchone()

        return jsonify({"reviews": reviews, "summary": summary}), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_reviews_for_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /review/reviews
# Create a new review for an event [Sarah-6]
@review_routes.route("/reviews", methods=["POST"])
def create_review():
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        required = ["rating", "comment", "event_id", "attendee_id"]
        if not all(k in data for k in required):
            return jsonify({"error": f"Missing required fields: {required}"}), 400

        query = """
            INSERT INTO Review (Rating, Comment, Date, EventID, AttendeeID)
            VALUES (%s, %s, NOW(), %s, %s)
        """
        cursor.execute(query, (
            data["rating"], data["comment"],
            data["event_id"], data["attendee_id"]
        ))
        get_db().commit()
        return jsonify({"message": "Review submitted", "review_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Database error in create_review: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /review/reviews/<id>
# Edit an existing review's rating or comment [Sarah-6]
@review_routes.route("/reviews/<int:review_id>", methods=["PUT"])
def update_review(review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()

        cursor.execute("SELECT ReviewID FROM Review WHERE ReviewID = %s", (review_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Review not found"}), 404

        allowed_fields = ["Rating", "Comment"]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(review_id)
        query = f"UPDATE Review SET {', '.join(update_fields)} WHERE ReviewID = %s"
        cursor.execute(query, params)
        get_db().commit()
        return jsonify({"message": "Review updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in update_review: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /review/reviews/<id>
# Delete a review the attendee submitted [Sarah-6]
@review_routes.route("/reviews/<int:review_id>", methods=["DELETE"])
def delete_review(review_id):
    cursor = get_db().cursor()
    try:
        cursor.execute("SELECT ReviewID FROM Review WHERE ReviewID = %s", (review_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Review not found"}), 404

        cursor.execute("DELETE FROM Review WHERE ReviewID = %s", (review_id,))
        get_db().commit()
        return jsonify({"message": "Review deleted successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in delete_review: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
