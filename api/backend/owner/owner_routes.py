from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

# Create a Blueprint for Owner routes
owner_routes = Blueprint("owner_routes", __name__)

# GET /owner/owners
# Returns all owners for the login selector
@owner_routes.route("/owners", methods=["GET"])
def get_all_owners():
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("SELECT OwnerID, FName, LName FROM Owner ORDER BY FName, LName")
        owners = cursor.fetchall()
        return jsonify(owners), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_all_owners: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Returns a list of all event requests with details so the owner can make informed decisions [Jason-1]
@owner_routes.route("/owners/<int:owner_id>/requests", methods=["GET"])
def get_owner_requests(owner_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT 
                r.RequestID, 
                r.RequestName, 
                r.Status, 
                e.Date, 
                e.Size, 
                o.FName AS OrganizerFirstName, 
                o.LName AS OrganizerLastName
            FROM Requests r
            JOIN Organizer o ON r.OrganizerID = o.OrganizerID
            LEFT JOIN Event e ON r.RequestName LIKE CONCAT('%%', e.Name, '%%')
            JOIN Venue v ON r.VenueID = v.VenueID
            WHERE v.OwnerID = %s
        """
        cursor.execute(query, (owner_id,))
        requests = cursor.fetchall()
        return jsonify(requests), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_owner_requests: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /owners/<id>/calendar
# Returns a calendar view of bookings to avoid conflicts [Jason-2]
@owner_routes.route("/owners/<int:owner_id>/calendar", methods=["GET"])
def get_owner_calendar(owner_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT 
                e.EventID, 
                e.Name, 
                e.Date, 
                v.Name AS VenueName
            FROM Hosts h
            JOIN Event e ON h.EventID = e.EventID
            JOIN Venue v ON h.VenueID = v.VenueID
            WHERE v.OwnerID = %s
            ORDER BY e.Date ASC
        """
        cursor.execute(query, (owner_id,))
        calendar_events = cursor.fetchall()
        return jsonify(calendar_events), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_owner_calendar: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /venues/<id>/recommendations
# Returns event recommendations that fit venue size and type to increase bookings [Jason-3]
@owner_routes.route("/venues/<int:venue_id>/recommendations", methods=["GET"])
def get_venue_recommendations(venue_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT 
                e.EventID, 
                e.Name, 
                e.Size, 
                e.Category, 
                v.Capacity
            FROM Event e
            JOIN Venue v ON v.VenueID = %s
            WHERE e.Size <= v.Capacity
            ORDER BY e.Size DESC
        """
        cursor.execute(query, (venue_id,))
        recommendations = cursor.fetchall()
        return jsonify(recommendations), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_venue_recommendations: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /owners/organizers/profiles
# Allows venue owners to review organizer profiles to ensure reliability [Jason-4]
@owner_routes.route("/owners/organizers/profiles", methods=["GET"])
def get_organizer_profiles():
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT 
                o.OrganizerID, 
                o.FName, 
                o.LName, 
                o.Email, 
                o.Location,
                COUNT(r.RequestID) AS TotalRequests,
                SUM(CASE WHEN r.Status = 'Approved' THEN 1 ELSE 0 END) AS ApprovedRequests
            FROM Organizer o
            LEFT JOIN Requests r ON o.OrganizerID = r.OrganizerID
            GROUP BY o.OrganizerID
        """
        cursor.execute(query)
        profiles = cursor.fetchall()
        return jsonify(profiles), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_organizer_profiles: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# PUT /requests/<id>/status
# Easy approval/rejection system for booking requests [Jason-5]
@owner_routes.route("/requests/<int:request_id>/status", methods=["PUT"])
def update_request_status(request_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        status = data.get("status")

        if not status:
            return jsonify({"error": "Status is required"}), 400

        cursor.execute("UPDATE Requests SET Status = %s WHERE RequestID = %s", (status, request_id))
        get_db().commit()
        return jsonify({"message": "Request status updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in update_request_status: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# GET /owners/<id>/revenue
# Tracks weekly earnings and revenue trends to understand business performance [Jason-6]
@owner_routes.route("/owners/<int:owner_id>/revenue", methods=["GET"])
def get_owner_revenue(owner_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT 
                YEAR(rb.RequestDate) AS Year,
                WEEK(rb.RequestDate) AS Week,
                SUM(rb.Compensation) AS WeeklyRevenue
            FROM RecievedBooking rb
            JOIN Venue v ON v.OwnerID = %s
            GROUP BY Year, Week
            ORDER BY Year, Week
        """
        cursor.execute(query, (owner_id,))
        revenue = cursor.fetchall()
        return jsonify(revenue), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_owner_revenue: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()