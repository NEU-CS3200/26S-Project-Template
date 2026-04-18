from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

# Create a Blueprint for student routes
students = Blueprint("students", __name__)

# retrieve the students/{id}/allergen-profile route
# required field: id
# user stories: [Alex-4] [Alex-1]
@students.route("/student/<int:id>/allergen-profile", methods=["GET"])
def get_allergen_profile(id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT s.StudentId,
                   a.AllergyName,
                   a.Severity
            FROM Student s
            JOIN StudentAllergen sa ON s.StudentId = sa.StudentId
            JOIN Allergen a ON sa.AllergenId = a.AllergenId
            WHERE sa.StudentId = %s
            """,
            (id,)
        )
        allergen_profile = cursor.fetchall()
        return jsonify(allergen_profile), 200

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


# create new student review
# required fields: studentId
# user stories: [Ryan-4]
@students.route("/student/<int:id>/review", methods=["POST"])
def create_student_review(id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "Request body must be JSON"}), 400

        required_fields = ["Rating", "Comment", "AllergenFlag", "PriceRating", "ReviewDate"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        hall_id = data.get("HallId")
        restaurant_id = data.get("RestaurantId")

        if (hall_id is None and restaurant_id is None) or (hall_id is not None and restaurant_id is not None):
            return jsonify({"error": "Provide exactly one of HallId or RestaurantId"}), 400

        query = """
            INSERT INTO Review (StudentId, HallId, RestaurantId, Rating, Comment, AllergenFlag, PriceRating, ReviewDate)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """

        cursor.execute(query, (
            id,
            hall_id,
            restaurant_id,
            data["Rating"],
            data["Comment"],
            data["AllergenFlag"],
            data["PriceRating"],
            data["ReviewDate"]
        ))

        get_db().commit()

        return jsonify({"message": "Review created successfully", "ReviewId": cursor.lastrowid}), 201

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


# update student's allergen profile
# required fields: student id
# user stories: [Alex-1]
@students.route("/student/<int:id>/allergen-profile", methods=["PUT"])
def update_allergen_profile(id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()
        if not data:
            return jsonify({"error": "Request body must be JSON"}), 400

        allergen_ids = data.get("AllergenIds")

        if allergen_ids is None:
            return jsonify({"error": "Missing required field: AllergenIds"}), 400

        cursor.execute(
            "DELETE FROM StudentAllergen WHERE StudentId = %s",
            (id,)
        )

        for allergen_id in allergen_ids:
            cursor.execute(
                "INSERT INTO StudentAllergen (StudentId, AllergenId) VALUES (%s, %s)",
                (id, allergen_id)
            )

        get_db().commit()
        return jsonify({"message": "Allergen profile updated successfully"}), 200

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


# delete review written by student
# required field is student id and review id
# user stories: [Ryan-4]
@students.route("/student/<int:student_id>/reviews/<int:review_id>", methods=["DELETE"])
def delete_review(student_id, review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            "SELECT ReviewId FROM Review WHERE ReviewId = %s AND StudentId = %s",
            (review_id, student_id)
        )

        if not cursor.fetchone():
            return jsonify({"error": "Review not found"}), 404

        cursor.execute(
            "DELETE FROM Review WHERE StudentId = %s AND ReviewId = %s",
            (student_id, review_id)
        )
        get_db().commit()

        return jsonify({"message": "Review deleted successfully"}), 200

    except Error as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()