from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

# Create a Blueprint for Attendee routes
attendee_routes = Blueprint("attendee_routes", __name__)

# GET /attendee/attendees
# Returns all attendees for the login selector
@attendee_routes.route("/attendees", methods=["GET"])
def get_all_attendees():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("SELECT AttendeeID, FName, LName FROM Attendee ORDER BY FName, LName")
        attendees = cursor.fetchall()
        return jsonify(attendees), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_all_attendees: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /attendee/attendees/<id>/feed
# Returns personalized event feed based on attendee's interests + location [Sarah-1]
@attendee_routes.route("/attendees/<int:attendee_id>/feed", methods=["GET"])
def get_attendee_feed(attendee_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT e.EventID, e.Name, e.Description, e.Date, e.Location
            FROM Event e
            JOIN Interests ai ON e.Category = ai.Interest
            JOIN Attendee a ON ai.AttendeeID = a.AttendeeID
            WHERE a.AttendeeID = %s AND e.Location = a.Location
            ORDER BY e.Date ASC
        """
        cursor.execute(query, (attendee_id,))
        events = cursor.fetchall()
        return jsonify(events), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_attendee_feed: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /attendee/attendees/<id>/rsvps
# Returns all events the attendee has RSVPed to [Sarah-2]
@attendee_routes.route("/attendees/<int:attendee_id>/rsvps", methods=["GET"])
def get_attendee_rsvps(attendee_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT e.EventID, e.Name, e.Description, e.Date, e.Location, a.Status
            FROM Event e
            JOIN Attends a ON e.EventID = a.EventID
            WHERE a.AttendeeID = %s
            ORDER BY e.Date ASC
        """
        cursor.execute(query, (attendee_id,))
        events = cursor.fetchall()
        return jsonify(events), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_attendee_rsvps: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

#Post /attendee/attendees/<id>/rsvps
# Allows an attendee to RSVP to an event [Sarah-3]
@attendee_routes.route("/attendees/<int:attendee_id>/rsvps", methods=["POST"])
def rsvp_to_event(attendee_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        event_id = data.get("event_id")
        status = data.get("status", "Going")  # Default to "Going" if not provided

        # Check if the RSVP already exists
        cursor.execute("SELECT * FROM Attends WHERE AttendeeID = %s AND EventID = %s", (attendee_id, event_id))
        existing_rsvp = cursor.fetchone()

        if existing_rsvp:
            # Update existing RSVP
            cursor.execute("UPDATE Attends SET Status = %s WHERE AttendeeID = %s AND EventID = %s", (status, attendee_id, event_id))
        else:
            # Insert new RSVP
            cursor.execute("INSERT INTO Attends (AttendeeID, EventID, Status) VALUES (%s, %s, %s)", (attendee_id, event_id, status))

        get_db().commit()
        return jsonify({"message": "RSVP updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in rsvp_to_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

#Delete /attendee/attendees/<id>/rsvps/<event_id>
# Allows an attendee to cancel their RSVP to an event [Sarah-4]
@attendee_routes.route("/attendees/<int:attendee_id>/rsvps/<int:event_id>", methods=["DELETE"])
def cancel_rsvp(attendee_id, event_id):
    cursor = get_db().cursor()
    try:
        cursor.execute("DELETE FROM Attends WHERE AttendeeID = %s AND EventID = %s", (attendee_id, event_id))
        get_db().commit()
        return jsonify({"message": "RSVP cancelled successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in cancel_rsvp: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

#get /attendee/attendees/<id>/favorites
# Returns all events the attendee has favorited [Sarah-5]
@attendee_routes.route("/attendees/<int:attendee_id>/favorites", methods=["GET"])
def get_attendee_favorites(attendee_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT e.EventID, e.Name, e.Description, e.Date, e.Location
            FROM Event e
            JOIN Favorites f ON e.EventID = f.EventID
            WHERE f.AttendeeID = %s
            ORDER BY e.Date ASC
        """
        cursor.execute(query, (attendee_id,))
        events = cursor.fetchall()
        return jsonify(events), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_attendee_favorites: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

#Post /attendee/attendees/<id>/favorites
# Allows an attendee to favorite an event [Sarah-6]
@attendee_routes.route("/attendees/<int:attendee_id>/favorites", methods=["POST"])
def favorite_event(attendee_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        event_id = data.get("event_id")

        # Check if the favorite already exists
        cursor.execute("SELECT * FROM Favorites WHERE AttendeeID = %s AND EventID = %s", (attendee_id, event_id))
        existing_favorite = cursor.fetchone()

        if existing_favorite:
            return jsonify({"message": "Event already favorited"}), 400

        # Insert new favorite
        cursor.execute("INSERT INTO Favorites (AttendeeID, EventID) VALUES (%s, %s)", (attendee_id, event_id))
        get_db().commit()
        return jsonify({"message": "Event favorited successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in favorite_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

#Delete /attendee/attendees/<id>/favorites/<event_id>
# Allows an attendee to unfavorite an event [Sarah-7]
@attendee_routes.route("/attendees/<int:attendee_id>/favorites/<int:event_id>", methods=["DELETE"])
def unfavorite_event(attendee_id, event_id):
    cursor = get_db().cursor()
    try:
        cursor.execute("DELETE FROM Favorites WHERE AttendeeID = %s AND EventID = %s", (attendee_id, event_id))
        get_db().commit()
        return jsonify({"message": "Event unfavorited successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in unfavorite_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
