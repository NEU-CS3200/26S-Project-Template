from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

venue_routes = Blueprint("venue_routes", __name__)


# GET /venue/venues
# List all venues with optional filters for capacity and location [Ron-4]
@venue_routes.route("/venues", methods=["GET"])
def get_venues():
    cursor = get_db().cursor(dictionary=True)
    try:
        location = request.args.get("location")
        min_capacity = request.args.get("min_capacity")

        query = """
            SELECT
                v.VenueID,
                v.Name,
                v.Capacity,
                v.Location,
                o.FName AS OwnerFirstName,
                o.LName AS OwnerLastName
            FROM Venue v
            JOIN Owner o ON v.OwnerID = o.OwnerID
            WHERE 1=1
        """
        params = []

        if location:
            query += " AND v.Location LIKE %s"
            params.append(f"%{location}%")
        if min_capacity:
            query += " AND v.Capacity >= %s"
            params.append(int(min_capacity))

        query += " ORDER BY v.Capacity DESC"
        cursor.execute(query, params)
        venues = cursor.fetchall()
        return jsonify(venues), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venues: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venue/venues/<id>
# Return full details for a single venue
@venue_routes.route("/venues/<int:venue_id>", methods=["GET"])
def get_venue_by_id(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                v.VenueID,
                v.Name,
                v.Capacity,
                v.Location,
                o.OwnerID,
                o.FName AS OwnerFirstName,
                o.LName AS OwnerLastName,
                o.Email AS OwnerEmail
            FROM Venue v
            JOIN Owner o ON v.OwnerID = o.OwnerID
            WHERE v.VenueID = %s
        """
        cursor.execute(query, (venue_id,))
        venue = cursor.fetchone()
        if not venue:
            return jsonify({"error": "Venue not found"}), 404
        return jsonify(venue), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venue_by_id: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venue/venues/<id>/requests
# Return all booking requests submitted for this venue [Jason-1]
@venue_routes.route("/venues/<int:venue_id>/requests", methods=["GET"])
def get_venue_requests(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                r.RequestID,
                r.RequestName,
                r.Status,
                o.OrganizerID,
                o.FName AS OrganizerFirstName,
                o.LName AS OrganizerLastName,
                o.Email AS OrganizerEmail,
                o.Location AS OrganizerLocation
            FROM Requests r
            JOIN Organizer o ON r.OrganizerID = o.OrganizerID
            WHERE r.VenueID = %s
            ORDER BY r.RequestID DESC
        """
        cursor.execute(query, (venue_id,))
        requests = cursor.fetchall()
        return jsonify(requests), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venue_requests: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /venue/venues/<id>/requests/<req_id>
# Approve or reject a booking request [Jason-5]
@venue_routes.route("/venues/<int:venue_id>/requests/<int:request_id>", methods=["PUT"])
def update_venue_request_status(venue_id, request_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        status = data.get("status")

        if not status or status not in ("Approved", "Rejected", "Pending"):
            return jsonify({"error": "status must be Approved, Rejected, or Pending"}), 400

        cursor.execute(
            "SELECT RequestID FROM Requests WHERE RequestID = %s AND VenueID = %s",
            (request_id, venue_id)
        )
        if not cursor.fetchone():
            return jsonify({"error": "Request not found for this venue"}), 404

        cursor.execute(
            "UPDATE Requests SET Status = %s WHERE RequestID = %s",
            (status, request_id)
        )
        get_db().commit()
        return jsonify({"message": f"Request {request_id} marked as {status}"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in update_venue_request_status: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venue/venues/<id>/calendar
# Return a chronological schedule of all events booked at this venue [Jason-2]
@venue_routes.route("/venues/<int:venue_id>/calendar", methods=["GET"])
def get_venue_calendar(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                e.EventID,
                e.Name,
                e.Date,
                e.Size,
                e.Category,
                e.Location
            FROM Hosts h
            JOIN Event e ON h.EventID = e.EventID
            WHERE h.VenueID = %s
            ORDER BY e.Date ASC
        """
        cursor.execute(query, (venue_id,))
        calendar = cursor.fetchall()
        return jsonify(calendar), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venue_calendar: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venue/venues/<id>/revenue
# Return weekly revenue trends for this venue based on approved performer bookings [Jason-6]
@venue_routes.route("/venues/<int:venue_id>/revenue", methods=["GET"])
def get_venue_revenue(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                YEAR(rb.RequestDate) AS Year,
                WEEK(rb.RequestDate) AS Week,
                SUM(rb.Compensation) AS WeeklyRevenue
            FROM RecievedBooking rb
            JOIN Requests r ON rb.OrganizerID = r.OrganizerID
            WHERE r.VenueID = %s
              AND r.Status = 'Approved'
            GROUP BY YEAR(rb.RequestDate), WEEK(rb.RequestDate)
            ORDER BY Year ASC, Week ASC
        """
        cursor.execute(query, (venue_id,))
        revenue = cursor.fetchall()
        return jsonify(revenue), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venue_revenue: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /venue/venues/<id>/recommended-events
# Return events that fit this venue's capacity and are not yet booked here [Jason-3]
@venue_routes.route("/venues/<int:venue_id>/recommended-events", methods=["GET"])
def get_venue_recommended_events(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                e.EventID,
                e.Name,
                e.Date,
                e.Location,
                e.Size,
                e.Category,
                v.Capacity
            FROM Event e
            JOIN Venue v ON v.VenueID = %s
            WHERE e.Size <= v.Capacity
              AND e.EventID NOT IN (
                  SELECT EventID FROM Hosts WHERE VenueID = %s
              )
            ORDER BY e.Date ASC
        """
        cursor.execute(query, (venue_id, venue_id))
        events = cursor.fetchall()
        return jsonify(events), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venue_recommended_events: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
