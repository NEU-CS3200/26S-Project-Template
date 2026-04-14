from flask import Blueprint, current_app, jsonify, request
from mysql.connector import Error

from backend.db_connection import get_db

courts = Blueprint("courts", __name__)


# Get all active courts with live player counts
# Supports optional filters: ?skill_level=, ?court_type=, ?neighborhood=
# Example: /court/courts?skill_level=Intermediate
@courts.route("/courts", methods=["GET"])
def get_all_courts():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /court/courts")

        skill_level = request.args.get("skill_level")
        court_type = request.args.get("court_type")
        neighborhood = request.args.get("neighborhood")

        query = """
            SELECT c.CourtId,
                   c.CourtName,
                   c.Address,
                   n.NeighborhoodName,
                   c.Latitude,
                   c.Longitude,
                   c.SkillLevel,
                   c.CourtType,
                   c.SurfaceType,
                   c.HoopCount,
                   c.Hours,
                   COUNT(ci.CheckInId) AS ActivePlayerCount
            FROM Court c
                JOIN Neighborhood n ON n.NeighborhoodId = c.NeighborhoodId
                LEFT JOIN CheckIn ci
                    ON ci.CourtId = c.CourtId AND ci.CheckOutTime IS NULL
            WHERE c.IsActive = TRUE
              AND c.IsOpen = TRUE
        """
        params = []

        if skill_level:
            query += " AND c.SkillLevel = %s"
            params.append(skill_level)
        if court_type:
            query += " AND c.CourtType = %s"
            params.append(court_type)
        if neighborhood:
            query += " AND n.NeighborhoodName = %s"
            params.append(neighborhood)

        query += """
            GROUP BY c.CourtId, c.CourtName, c.Address, n.NeighborhoodName,
                     c.Latitude, c.Longitude, c.SkillLevel, c.CourtType,
                     c.SurfaceType, c.HoopCount, c.Hours
            ORDER BY ActivePlayerCount DESC
        """

        cursor.execute(query, params)
        courts_list = cursor.fetchall()

        current_app.logger.info(f"Retrieved {len(courts_list)} courts")
        return jsonify(courts_list), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_courts: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get full details for one court including its amenities
# Example: /court/courts/1
@courts.route("/courts/<int:court_id>", methods=["GET"])
def get_court(court_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /court/courts/{court_id}")

        cursor.execute(
            """
            SELECT c.CourtId, c.CourtName, c.Address, c.Latitude, c.Longitude,
                   c.SkillLevel, c.CourtType, c.SurfaceType, c.HoopCount,
                   c.Hours, c.IsOpen, c.IsActive,
                   n.NeighborhoodName
            FROM Court c
                JOIN Neighborhood n ON n.NeighborhoodId = c.NeighborhoodId
            WHERE c.CourtId = %s
            """,
            (court_id,),
        )
        court = cursor.fetchone()

        if not court:
            return jsonify({"error": "Court not found"}), 404

        # Get amenities for this court
        cursor.execute(
            """
            SELECT a.AmenityId, a.AmenityName
            FROM CourtAmenity ca
                JOIN Amenity a ON a.AmenityId = ca.AmenityId
            WHERE ca.CourtId = %s
            """,
            (court_id,),
        )
        court["amenities"] = cursor.fetchall()

        return jsonify(court), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_court: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Add a new court with optional amenities (Admin User Story 1)
# Required fields: CourtName, Address, Latitude, Longitude, SkillLevel,
#                  CourtType, SurfaceType, HoopCount, Hours, NeighborhoodId
# Optional: amenity_ids (list of ints)
# Example: POST /court/courts
@courts.route("/courts", methods=["POST"])
def create_court():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("POST /court/courts")
        data = request.get_json()

        required_fields = [
            "CourtName",
            "Address",
            "Latitude",
            "Longitude",
            "SkillLevel",
            "CourtType",
            "SurfaceType",
            "HoopCount",
            "Hours",
            "NeighborhoodId",
        ]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        cursor.execute(
            """
            INSERT INTO Court (CourtName, Address, Latitude, Longitude, SkillLevel,
                               CourtType, SurfaceType, HoopCount, Hours, IsOpen,
                               IsActive, NeighborhoodId)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, TRUE, TRUE, %s)
            """,
            (
                data["CourtName"],
                data["Address"],
                data["Latitude"],
                data["Longitude"],
                data["SkillLevel"],
                data["CourtType"],
                data["SurfaceType"],
                data["HoopCount"],
                data["Hours"],
                data["NeighborhoodId"],
            ),
        )
        new_court_id = cursor.lastrowid

        # Insert each amenity if provided
        for amenity_id in data.get("amenity_ids", []):
            cursor.execute(
                "INSERT INTO CourtAmenity (CourtId, AmenityId) VALUES (%s, %s)",
                (new_court_id, amenity_id),
            )

        get_db().commit()
        return jsonify(
            {"message": "Court created successfully", "CourtId": new_court_id}
        ), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_court: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Update court details or toggle IsActive/IsOpen (Admin User Stories 2 and 4)
# Can update any field except CourtId
# Example: PUT /court/courts/1
@courts.route("/courts/<int:court_id>", methods=["PUT"])
def update_court(court_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /court/courts/{court_id}")
        data = request.get_json()

        # Build update query dynamically based on provided fields
        allowed_fields = [
            "CourtName",
            "Address",
            "Hours",
            "SurfaceType",
            "HoopCount",
            "SkillLevel",
            "CourtType",
            "IsOpen",
            "IsActive",
            "NeighborhoodId",
        ]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(court_id)
        query = f"UPDATE Court SET {', '.join(update_fields)} WHERE CourtId = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "Court updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_court: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get all reviews for a specific court with the reviewer's username
# Optional: ?flagged_only=true to show only flagged reviews
# Example: /court/courts/1/reviews
@courts.route("/courts/<int:court_id>/reviews", methods=["GET"])
def get_court_reviews(court_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /court/courts/{court_id}/reviews")

        flagged_only = request.args.get("flagged_only", "false").lower() == "true"

        query = """
            SELECT cr.ReviewId, p.Username, cr.Rating, cr.ConditionRating,
                   cr.Comment, cr.IsFlagged, cr.ReviewDate
            FROM CourtReview cr
                JOIN Player p ON p.PlayerId = cr.PlayerId
            WHERE cr.CourtId = %s
        """
        params = [court_id]

        if flagged_only:
            query += " AND cr.IsFlagged = TRUE"

        query += " ORDER BY cr.ReviewDate DESC"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_court_reviews: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Submit a review for a court (Pickup Player User Story 5)
# Required fields: PlayerId, Rating, ConditionRating
# Optional: Comment
# Example: POST /court/courts/3/reviews
@courts.route("/courts/<int:court_id>/reviews", methods=["POST"])
def create_review(court_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /court/courts/{court_id}/reviews")
        data = request.get_json()

        required_fields = ["PlayerId", "Rating", "ConditionRating"]
        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        cursor.execute(
            """
            INSERT INTO CourtReview (Rating, ConditionRating, Comment, IsFlagged,
                                     ReviewDate, PlayerId, CourtId)
            VALUES (%s, %s, %s, FALSE, CURDATE(), %s, %s)
            """,
            (
                data["Rating"],
                data["ConditionRating"],
                data.get("Comment", ""),
                data["PlayerId"],
                court_id,
            ),
        )
        get_db().commit()

        return jsonify(
            {"message": "Review submitted successfully", "ReviewId": cursor.lastrowid}
        ), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_review: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Get all flagged reviews across every court (Admin User Story 3)
# Example: /court/reviews/flagged
@courts.route("/reviews/flagged", methods=["GET"])
def get_flagged_reviews():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /court/reviews/flagged")

        cursor.execute(
            """
            SELECT cr.ReviewId, p.Username, c.CourtName, cr.Rating,
                   cr.ConditionRating, cr.Comment, cr.ReviewDate
            FROM CourtReview cr
                JOIN Player p ON p.PlayerId = cr.PlayerId
                JOIN Court c ON c.CourtId = cr.CourtId
            WHERE cr.IsFlagged = TRUE
            ORDER BY cr.ReviewDate DESC
            """
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_flagged_reviews: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Delete a flagged review (Admin User Story 3)
# Example: DELETE /court/reviews/4
@courts.route("/reviews/<int:review_id>", methods=["DELETE"])
def delete_review(review_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /court/reviews/{review_id}")

        cursor.execute(
            "DELETE FROM CourtReview WHERE ReviewId = %s AND IsFlagged = TRUE",
            (review_id,),
        )
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Review not found or not flagged"}), 404

        return jsonify({"message": "Review deleted successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in delete_review: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
