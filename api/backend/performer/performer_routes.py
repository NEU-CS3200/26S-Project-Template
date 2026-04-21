from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

#Create a Blueprint for Performer routes
performer_routes = Blueprint('performer_routes', __name__)

#GET /performers
#Returns a list of performers, optionally, filtered by genre and/or availability [Ron-5],[Caleb-1]
@performer_routes.route("/performers", methods=["GET"])
def get_all_performers():
    cursor = get_db().cursor(dictionary=True)
    try:
        genre = request.args.get("genre")
        availability = request.args.get("availability")

        query = """
            SELECT PerformerID, FName, LName, Genre, Bio,
                MediaLinks, Availability, Views, Ranking
            FROM Performer
            WHERE 1=1 
        """
        params = []
        if genre: 
            query += " AND Genre = %s"
            params.append(genre)
        if availability: 
            query += " AND Availability LIKE %s"
            params.append(f"%{availability}%")

        query += " ORDER BY Ranking DESC"

        cursor.execute (query, params)
        performers = cursor.fetchall()
        return jsonify(performers), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_all_performers: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# POST /performers
# Create a new performer profile [Caleb-1]
@performer_routes.route("/performers", methods=["POST"])
def create_performer():
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        fname        = data.get("FName")
        lname        = data.get("LName")
        genre        = data.get("Genre")
        bio          = data.get("Bio")
        media_links  = data.get("MediaLinks")
        availability = data.get("Availability")
 
        cursor.execute(
            """
            INSERT INTO Performer (FName, LName, Genre, Bio, MediaLinks, Availability, Views, Ranking)
            VALUES (%s, %s, %s, %s, %s, %s, 0, 0.00)
            """,
            (fname, lname, genre, bio, media_links, availability)
        )
        get_db().commit()
        return jsonify({"message": "Performer profile created successfully"}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_performer: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /performers/<performer_id>
# Return full profile details for a specific performer [Ron-5], [Caleb-1]
@performer_routes.route("/performers/<int:performer_id>", methods=["GET"])
def get_performer(performer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT PerformerID, FName, LName, Genre, Bio,
                   MediaLinks, Availability, Views, Ranking
            FROM Performer
            WHERE PerformerID = %s
            """,
            (performer_id,)
        )
        performer = cursor.fetchone()
        if not performer:
            return jsonify({"error": "Performer not found"}), 404
        return jsonify(performer), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_performer: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# PUT /performers/<performer_id>
# Update a performer's profile info such as bio, genre, media links, and availability [Caleb-1], [Caleb-6]
@performer_routes.route("/performers/<int:performer_id>", methods=["PUT"])
def update_performer(performer_id):
    cursor = get_db().cursor()
    try:
        data         = request.get_json()
        genre        = data.get("Genre")
        bio          = data.get("Bio")
        media_links  = data.get("MediaLinks")
        availability = data.get("Availability")
 
        cursor.execute(
            """
            UPDATE Performer
            SET Genre = %s,
                Bio = %s,
                MediaLinks = %s,
                Availability = %s,
                Views = Views + 1
            WHERE PerformerID = %s
            """,
            (genre, bio, media_links, availability, performer_id)
        )
        get_db().commit()
        return jsonify({"message": "Performer profile updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_performer: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# DELETE /performers/<performer_id>
# Delete a performer profile [Caleb-1]
@performer_routes.route("/performers/<int:performer_id>", methods=["DELETE"])
def delete_performer(performer_id):
    cursor = get_db().cursor()
    try:
        cursor.execute("DELETE FROM Performer WHERE PerformerID = %s", (performer_id,))
        get_db().commit()
        return jsonify({"message": "Performer profile deleted successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in delete_performer: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
 

 # GET /performers/<performer_id>/matches
# Return events matched to the performer's style and availability [Caleb-2]
@performer_routes.route("/performers/<int:performer_id>/matches", methods=["GET"])
def get_performer_matches(performer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT e.EventID, e.Name, e.Date, e.Location,
                   e.Category, mw.MatchScore, mw.Relevance
            FROM MatchedWith mw
            JOIN Event e ON mw.EventID = e.EventID
            WHERE mw.PerformerID = %s
              AND e.Date >= NOW()
            ORDER BY mw.MatchScore DESC
            """,
            (performer_id,)
        )
        matches = cursor.fetchall()
        return jsonify(matches), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_performer_matches: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /performers/<performer_id>/bookings
# Return all incoming booking requests for a performer [Caleb-3]
@performer_routes.route("/performers/<int:performer_id>/bookings", methods=["GET"])
def get_performer_bookings(performer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT rb.BookingID, rb.Compensation, rb.Status,
                   rb.RequestDate,
                   o.FName AS OrganizerFirstName,
                   o.LName AS OrganizerLastName,
                   o.Email AS OrganizerEmail
            FROM RecievedBooking rb
            JOIN Organizer o ON rb.OrganizerID = o.OrganizerID
            WHERE rb.PerformerID = %s
            ORDER BY rb.RequestDate DESC
            """,
            (performer_id,)
        )
        bookings = cursor.fetchall()
        return jsonify(bookings), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_performer_bookings: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /performers/<performer_id>/bookings
# Organizer sends a booking request to a performer [Ron-5]
@performer_routes.route("/performers/<int:performer_id>/bookings", methods=["POST"])
def create_booking(performer_id):
    cursor = get_db().cursor()
    try:
        data         = request.get_json()
        organizer_id = data.get("OrganizerID")
        compensation = data.get("Compensation")
        request_date = data.get("RequestDate")
 
        cursor.execute(
            """
            INSERT INTO RecievedBooking (Compensation, Status, RequestDate, OrganizerID, PerformerID)
            VALUES (%s, 'Pending', %s, %s, %s)
            """,
            (compensation, request_date, organizer_id, performer_id)
        )
        get_db().commit()
        return jsonify({"message": "Booking request sent successfully"}), 201
    except Error as e:
        current_app.logger.error(f"Database error in create_booking: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /performers/<performer_id>/bookings/<booking_id>
# Accept or decline a booking request [Caleb-3]
@performer_routes.route("/performers/<int:performer_id>/bookings/<int:booking_id>", methods=["PUT"])
def update_booking_status(performer_id, booking_id):
    cursor = get_db().cursor()
    try:
        data   = request.get_json()
        status = data.get("Status")  # 'Confirmed' or 'Declined'
 
        cursor.execute(
            """
            UPDATE RecievedBooking
            SET Status = %s
            WHERE BookingID = %s AND PerformerID = %s
            """,
            (status, booking_id, performer_id)
        )
        get_db().commit()
        return jsonify({"message": f"Booking {status} successfully"}), 200
    except Error as e:
        current_app.logger.error(f"Database error in update_booking_status: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /performers/<performer_id>/performances
# Return all upcoming confirmed performances for the performer [Caleb-5]
@performer_routes.route("/performers/<int:performer_id>/performances", methods=["GET"])
def get_performer_performances(performer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT e.EventID, e.Name, e.Date, e.Location,
                   v.Name AS VenueName, pa.Status
            FROM PreformsAt pa
            JOIN Event e ON pa.EventID = e.EventID
            JOIN Hosts h ON e.EventID = h.EventID
            JOIN Venue v ON h.VenueID = v.VenueID
            WHERE pa.PerformerID = %s
              AND e.Date >= NOW()
            ORDER BY e.Date ASC
            """,
            (performer_id,)
        )
        performances = cursor.fetchall()
        return jsonify(performances), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_performer_performances: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()