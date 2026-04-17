from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

venues = Blueprint("venues", __name__)


# GET /venues — all venues
@venues.route("/venues", methods=["GET"])
def get_all_venues():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("GET /venues")

        sport_type = request.args.get("sport_type")

        query = "SELECT * FROM Venue WHERE 1=1"
        params = []

        if sport_type:
            query += " AND sport_type = %s"
            params.append(sport_type)

        cursor.execute(query, params)
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_venues: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /venues — add venue
@venues.route("/venues", methods=["POST"])
def create_venue():
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info("POST /venues")
        data = request.get_json()

        required = ["address", "sport_type", "capacity", "name"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """INSERT INTO Venue (address, sport_type, capacity, name)
                   VALUES (%s, %s, %s, %s)"""
        cursor.execute(query, (data["address"], data["sport_type"],
                               data["capacity"], data["name"]))
        get_db().commit()

        return jsonify({"message": "Venue created", "venue_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_venue: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /venues/<id> — update venue details
@venues.route("/venues/<int:venue_id>", methods=["PUT"])
def update_venue(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /venues/{venue_id}")
        data = request.get_json()

        cursor.execute("SELECT id FROM Venue WHERE id = %s", (venue_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Venue not found"}), 404

        allowed = ["address", "sport_type", "capacity", "name"]
        update_fields = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(venue_id)
        query = f"UPDATE Venue SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "Venue updated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_venue: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /venues/<id> — delete venue
@venues.route("/venues/<int:venue_id>", methods=["DELETE"])
def delete_venue(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"DELETE /venues/{venue_id}")

        cursor.execute("SELECT id FROM Venue WHERE id = %s", (venue_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Venue not found"}), 404

        cursor.execute("DELETE FROM Venue WHERE id = %s", (venue_id,))
        get_db().commit()

        return jsonify({"message": "Venue deleted"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in delete_venue: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venues/<id>/reviews — venue reviews
@venues.route("/venues/<int:venue_id>/reviews", methods=["GET"])
def get_venue_reviews(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /venues/{venue_id}/reviews")

        query = """SELECT vr.id, vr.field_quality_rating, vr.lighting_rating,
                          vr.parking_rating, vr.overall_rating, vr.text,
                          vr.last_reviewed_date, vr.game_id,
                          p.first_name, p.last_name
                   FROM Venue_Review vr
                   LEFT JOIN Player p ON vr.player_id = p.id
                   WHERE vr.venue_id = %s
                   ORDER BY vr.last_reviewed_date DESC"""
        cursor.execute(query, (venue_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_venue_reviews: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /venues/<id>/reviews — create venue review
@venues.route("/venues/<int:venue_id>/reviews", methods=["POST"])
def create_venue_review(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"POST /venues/{venue_id}/reviews")
        data = request.get_json()

        if "overall_rating" not in data:
            return jsonify({"error": "Missing required field: overall_rating"}), 400

        query = """INSERT INTO Venue_Review
                       (field_quality_rating, venue_id, player_id, game_id,
                        lighting_rating, text, parking_rating, overall_rating,
                        last_reviewed_date)
                   VALUES (%s, %s, %s, %s, %s, %s, %s, %s, NOW())"""
        cursor.execute(query, (data.get("field_quality_rating"), venue_id,
                               data.get("player_id"), data.get("game_id"),
                               data.get("lighting_rating"), data.get("text"),
                               data.get("parking_rating"), data["overall_rating"]))
        get_db().commit()

        return jsonify({"message": "Review created",
                        "review_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_venue_review: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venues/<id>/timeslots — helper for venue schedule page
@venues.route("/venues/<int:venue_id>/timeslots", methods=["GET"])
def get_venue_timeslots(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /venues/{venue_id}/timeslots")

        query = """SELECT vts.id, vts.slot_date, vts.slot_start_time,
                          vts.slot_end_time, vts.is_available,
                          vts.league_id, l.league_name, l.sport
                   FROM Venue_Time_Slot vts
                   JOIN League l ON vts.league_id = l.id
                   WHERE vts.venue_id = %s
                   ORDER BY vts.slot_date, vts.slot_start_time"""
        cursor.execute(query, (venue_id,))
        results = cursor.fetchall()

        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_venue_timeslots: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venue-slots/<slot_id> — slot availability
@venues.route("/venue-slots/<int:slot_id>", methods=["GET"])
def get_venue_slot(slot_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"GET /venue-slots/{slot_id}")

        query = """SELECT vts.id, vts.venue_id, vts.league_id,
                          vts.slot_date, vts.slot_start_time, vts.slot_end_time,
                          vts.is_available,
                          v.name AS venue_name,
                          l.league_name, l.sport
                   FROM Venue_Time_Slot vts
                   JOIN Venue v ON vts.venue_id = v.id
                   JOIN League l ON vts.league_id = l.id
                   WHERE vts.id = %s"""
        cursor.execute(query, (slot_id,))
        result = cursor.fetchone()

        if not result:
            return jsonify({"error": "Slot not found"}), 404

        return jsonify(result), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_venue_slot: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /venue-slots/<slot_id> — assign venue/league to time slot
@venues.route("/venue-slots/<int:slot_id>", methods=["PUT"])
def update_venue_slot(slot_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f"PUT /venue-slots/{slot_id}")
        data = request.get_json()

        cursor.execute("SELECT id FROM Venue_Time_Slot WHERE id = %s", (slot_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Slot not found"}), 404

        allowed = ["venue_id", "league_id", "slot_date", "slot_start_time",
                   "slot_end_time", "is_available"]
        update_fields = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(slot_id)
        query = f"UPDATE Venue_Time_Slot SET {', '.join(update_fields)} WHERE id = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "Slot updated"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_venue_slot: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
