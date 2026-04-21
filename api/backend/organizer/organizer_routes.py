from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

organizer_routes = Blueprint("organizer_routes", __name__)

# GET /organizer/organizers
# Returns all organizers for the login selector
@organizer_routes.route("/organizers", methods=["GET"])
def get_all_organizers():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("SELECT OrganizerID, FName, LName FROM Organizer ORDER BY FName, LName")
        organizers = cursor.fetchall()
        return jsonify(organizers), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_all_organizers: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /organizer/organizers/<id>
# Return organizer profile with reliability stats
@organizer_routes.route("/organizers/<int:organizer_id>", methods=["GET"])
def get_organizer_by_id(organizer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT COUNT(r.RequestID) AS TotalRequests,
                   SUM(CASE WHEN r.Status = 'Approved' THEN 1 ELSE 0 END) AS ApprovedCount,
                   o.OrganizerID, o.FName, o.LName, o.Email, o.Location
            FROM Organizer o
            LEFT JOIN Requests r ON o.OrganizerID = r.OrganizerID
            WHERE o.OrganizerID = %s
            GROUP BY o.OrganizerID, o.FName, o.LName, o.Email, o.Location
        '''
        cursor.execute(query, (organizer_id,))
        organizer = cursor.fetchall()
        return jsonify(organizer), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_organizer_by_id: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /organizer/organizers/<id>/events
# Return all events linked to this organizer via venue requests, with attendee count [Ron-1]
@organizer_routes.route("/organizers/<int:organizer_id>/events", methods=["GET"])
def get_organizer_events(organizer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                e.EventID,
                e.Name,
                e.Date,
                e.Location,
                e.Category,
                e.Size,
                COUNT(a.AttendeeID) AS ConfirmedAttendees
            FROM Event e
            JOIN Hosts h ON e.EventID = h.EventID
            JOIN Requests r ON h.VenueID = r.VenueID
            LEFT JOIN Attends a ON e.EventID = a.EventID AND a.Status = 'Confirmed'
            WHERE r.OrganizerID = %s
            GROUP BY e.EventID, e.Name, e.Date, e.Location, e.Category, e.Size
            ORDER BY e.Date ASC
        """
        cursor.execute(query, (organizer_id,))
        events = cursor.fetchall()
        return jsonify(events), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_organizer_events: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /organizer/organizers/<id>/events
# Create a new event for this organizer [Ron-2]
@organizer_routes.route("/organizers/<int:organizer_id>/events", methods=["POST"])
def create_organizer_event(organizer_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        required = ["name", "date", "location", "description", "size", "category"]
        if not all(k in data for k in required):
            return jsonify({"error": f"Missing required fields: {required}"}), 400

        query = """
            INSERT INTO Event (Name, Date, Location, Description, Size, Category)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (
            data["name"], data["date"], data["location"],
            data["description"], data["size"], data["category"]
        ))
        get_db().commit()
        return jsonify({"message": "Event created", "event_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Database error in create_organizer_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /organizer/organizers/<id>/venue-requests
# Return all venue booking requests submitted by this organizer [Ron-4]
@organizer_routes.route("/organizers/<int:organizer_id>/venue-requests", methods=["GET"])
def get_organizer_venue_requests(organizer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                r.RequestID,
                r.RequestName,
                r.Status,
                v.VenueID,
                v.Name AS VenueName,
                v.Location AS VenueLocation,
                v.Capacity
            FROM Requests r
            JOIN Venue v ON r.VenueID = v.VenueID
            WHERE r.OrganizerID = %s
            ORDER BY r.RequestID DESC
        """
        cursor.execute(query, (organizer_id,))
        requests = cursor.fetchall()
        return jsonify(requests), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_organizer_venue_requests: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /organizer/organizers/<id>/venue-requests
# Submit a new venue booking request [Ron-4]
@organizer_routes.route("/organizers/<int:organizer_id>/venue-requests", methods=["POST"])
def create_venue_request(organizer_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        required = ["request_name", "venue_id"]
        if not all(k in data for k in required):
            return jsonify({"error": f"Missing required fields: {required}"}), 400

        query = """
            INSERT INTO Requests (RequestName, Status, OrganizerID, VenueID)
            VALUES (%s, 'Pending', %s, %s)
        """
        cursor.execute(query, (data["request_name"], organizer_id, data["venue_id"]))
        get_db().commit()
        return jsonify({"message": "Venue request submitted", "request_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Database error in create_venue_request: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /organizer/organizers/<id>/performer-bookings
# Return all performer bookings sent by this organizer [Ron-5]
@organizer_routes.route("/organizers/<int:organizer_id>/performer-bookings", methods=["GET"])
def get_organizer_performer_bookings(organizer_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                rb.BookingID,
                rb.Compensation,
                rb.Status,
                rb.RequestDate,
                p.PerformerID,
                p.FName AS PerformerFirstName,
                p.LName AS PerformerLastName,
                p.Genre
            FROM RecievedBooking rb
            JOIN Performer p ON rb.PerformerID = p.PerformerID
            WHERE rb.OrganizerID = %s
            ORDER BY rb.RequestDate DESC
        """
        cursor.execute(query, (organizer_id,))
        bookings = cursor.fetchall()
        return jsonify(bookings), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_organizer_performer_bookings: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /organizer/organizers/<id>/performer-bookings
# Send a booking offer to a performer [Ron-5]
@organizer_routes.route("/organizers/<int:organizer_id>/performer-bookings", methods=["POST"])
def create_performer_booking(organizer_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        required = ["performer_id", "compensation"]
        if not all(k in data for k in required):
            return jsonify({"error": f"Missing required fields: {required}"}), 400

        query = """
            INSERT INTO RecievedBooking (Compensation, Status, RequestDate, OrganizerID, PerformerID)
            VALUES (%s, 'Pending', CURDATE(), %s, %s)
        """
        cursor.execute(query, (data["compensation"], organizer_id, data["performer_id"]))
        get_db().commit()
        return jsonify({"message": "Booking offer sent", "booking_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Database error in create_performer_booking: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()