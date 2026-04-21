from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

events_routes = Blueprint("events_routes", __name__)


# GET /event/events
# Return a list of all events; supports query params for category, date, and location filters
@events_routes.route("/events", methods=["GET"])
def get_events():
    cursor = get_db().cursor(dictionary=True)
    try:
        category = request.args.get("category")
        date = request.args.get("date")
        location = request.args.get("location")

        query = """
            SELECT e.EventID, e.Name, e.Date, e.Location, e.Description, e.Size, e.Category
            FROM Event e
            WHERE 1=1
        """
        params = []

        if category:
            query += " AND e.Category = %s"
            params.append(category)
        if date:
            query += " AND DATE(e.Date) = %s"
            params.append(date)
        if location:
            query += " AND e.Location LIKE %s"
            params.append(f"%{location}%")

        query += " ORDER BY e.Date ASC"
        cursor.execute(query, params)
        events = cursor.fetchall()
        return jsonify(events), 200
    except Error as e:
        current_app.logger.error(f"Database error in get_events: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /event/events
# Post a new event visible to potential attendees [Ron-2]
@events_routes.route("/events", methods=["POST"])
def post_event():
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        name = data.get("name")
        date = data.get("date")
        location = data.get("location")
        description = data.get("description")
        size = data.get("size")
        category = data.get("category")

        cursor.execute(
            """
            INSERT INTO Event (Name, Date, Location, Description, Size, Category)
            VALUES (%s, %s, %s, %s, %s, %s)
            """,
            (name, date, location, description, size, category)
        )
        get_db().commit()
        return jsonify({"message": "Event created successfully", "event_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Database error in post_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /event/events/<id>
# Return full event detail: date/time, venue, description, performer info, and size
@events_routes.route("/events/<int:event_id>", methods=["GET"])
def get_event_by_id(event_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                e.EventID, e.Name, e.Date, e.Location,
                e.Description, e.Size, e.Category,
                v.Name AS VenueName, v.Capacity,
                p.FName AS PerformerFirstName,
                p.LName AS PerformerLastName,
                p.Genre
            FROM Event e
            LEFT JOIN Hosts h ON e.EventID = h.EventID
            LEFT JOIN Venue v ON h.VenueID = v.VenueID
            LEFT JOIN PreformsAt pa ON e.EventID = pa.EventID
            LEFT JOIN Performer p ON pa.PerformerID = p.PerformerID
            WHERE e.EventID = %s
        """
        cursor.execute(query, (event_id,))
        event = cursor.fetchone()
        if not event:
            return jsonify({"error": "Event not found"}), 404
        return jsonify(event), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_event_by_id: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /event/events/<id>
# Edit an existing event's details such as title, date, and description [Ron-2]
@events_routes.route("/events/<int:event_id>", methods=["PUT"])
def update_event(event_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()

        cursor.execute("SELECT EventID FROM Event WHERE EventID = %s", (event_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Event not found"}), 404

        allowed_fields = ["Name", "Date", "Location", "Description", "Size", "Category"]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(event_id)
        query = f"UPDATE Event SET {', '.join(update_fields)} WHERE EventID = %s"
        cursor.execute(query, params)
        get_db().commit()
        return jsonify({"message": "Event updated successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in update_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /event/events/<id>
# Delete an event [Ron-1]
@events_routes.route("/events/<int:event_id>", methods=["DELETE"])
def delete_event(event_id):
    cursor = get_db().cursor()
    try:
        cursor.execute("SELECT EventID FROM Event WHERE EventID = %s", (event_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Event not found"}), 404

        cursor.execute("DELETE FROM Event WHERE EventID = %s", (event_id,))
        get_db().commit()
        return jsonify({"message": "Event deleted successfully"}), 200
    except Error as e:
        current_app.logger.error(f'Database error in delete_event: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /event/events/<id>/attendees
# Return list and count of confirmed attendees for an event [Ron-1]
@events_routes.route("/events/<int:event_id>/attendees", methods=["GET"])
def get_event_attendees(event_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT
                a.AttendeeID,
                a.FName,
                a.LName,
                a.Email,
                ae.Status
            FROM Attendee a
            JOIN Attends ae ON a.AttendeeID = ae.AttendeeID
            WHERE ae.EventID = %s
              AND ae.Status = 'Confirmed'
            ORDER BY a.LName ASC
        """
        cursor.execute(query, (event_id,))
        attendees = cursor.fetchall()
        return jsonify({"attendees": attendees, "total": len(attendees)}), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_event_attendees: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /event/events/<id>/reviews
# Return all reviews and average rating for a specific event [Sarah-4], [Sarah-6]
@events_routes.route("/events/<int:event_id>/reviews", methods=["GET"])
def get_event_reviews(event_id):
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

        cursor.execute(
            "SELECT AVG(Rating) AS AverageRating, COUNT(*) AS TotalReviews FROM Review WHERE EventID = %s",
            (event_id,)
        )
        summary = cursor.fetchone()

        return jsonify({"reviews": reviews, "summary": summary}), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_event_reviews: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /event/events/<id>/reviews
# Submit a rating and written review for an attended event [Sarah-6]
@events_routes.route("/events/<int:event_id>/reviews", methods=["POST"])
def post_event_review(event_id):
    cursor = get_db().cursor()
    try:
        data = request.get_json()
        attendee_id = data.get("attendee_id")
        rating = data.get("rating")
        comment = data.get("comment")

        cursor.execute(
            """
            INSERT INTO Review (EventID, AttendeeID, Rating, Comment, Date)
            VALUES (%s, %s, %s, %s, NOW())
            """,
            (event_id, attendee_id, rating, comment)
        )
        get_db().commit()
        return jsonify({"message": "Review submitted successfully", "review_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f'Database error in post_event_review: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /event/events/<id>/matched-users
# Return attendees whose interests match the event's category [Ron-3], [Ron-6]
@events_routes.route("/events/<int:event_id>/matched-users", methods=["GET"])
def get_event_matched_users(event_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = """
            SELECT DISTINCT
                a.AttendeeID,
                a.FName,
                a.LName,
                a.Email,
                COUNT(i.InterestID) AS MatchingInterests
            FROM Attendee a
            JOIN Interests i ON a.AttendeeID = i.AttendeeID
            JOIN Event e ON i.Interest = e.Category
            WHERE e.EventID = %s
            GROUP BY a.AttendeeID, a.FName, a.LName, a.Email
            ORDER BY MatchingInterests DESC
        """
        cursor.execute(query, (event_id,))
        matches = cursor.fetchall()
        return jsonify(matches), 200
    except Error as e:
        current_app.logger.error(f'Database error in get_event_matched_users: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
