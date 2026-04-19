from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

locations_tickets = Blueprint("locations_tickets", __name__)


# ============================================================================
# TICKETS — accessibility_ticket table
# ============================================================================

# GET /tickets — list tickets. Optional filters: ?status=, ?user_id=
# [Paul-3][Wilson-5] — Phase 2 SQL 1.3, 2.2
@locations_tickets.route("/tickets", methods=["GET"])
def list_tickets():
    cursor = get_db().cursor(dictionary=True)
    try:
        status = request.args.get("status")
        user_id = request.args.get("user_id")

        query = """
            SELECT at.ticket_id, at.ticket_status, at.ticket_date, at.ticket_time,
                   at.report_id, at.issue_type_id,
                   it.issue_type_name, it.issue_category,
                   r.report_status, r.urgency,
                   u.first_name, u.last_name
            FROM accessibility_ticket at
            LEFT JOIN issue_type it ON at.issue_type_id = it.issue_type_id
            LEFT JOIN report r ON at.report_id = r.report_id
            LEFT JOIN `user` u ON r.user_id = u.user_id
            WHERE 1=1
        """
        params = []
        if status:
            query += " AND at.ticket_status = %s"
            params.append(status)
        if user_id:
            query += " AND r.user_id = %s"
            params.append(user_id)
        query += " ORDER BY at.ticket_date DESC, at.ticket_time DESC"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"list_tickets: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /tickets — open a new ticket against an existing report. [Wilson-4]
@locations_tickets.route("/tickets", methods=["POST"])
def create_ticket():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        required = ["ticket_status", "ticket_date"]
        for f in required:
            if f not in data:
                return jsonify({"error": f"Missing required field: {f}"}), 400

        cursor.execute(
            """
            INSERT INTO accessibility_ticket
                (ticket_status, ticket_date, ticket_time, report_id, issue_type_id)
            VALUES (%s, %s, %s, %s, %s)
            """,
            (
                data["ticket_status"],
                data["ticket_date"],
                data.get("ticket_time"),
                data.get("report_id"),
                data.get("issue_type_id"),
            ),
        )
        get_db().commit()
        return jsonify({"message": "Ticket created", "ticket_id": cursor.lastrowid}), 201
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /tickets/{id} — [Paul-3][Wilson-5]
@locations_tickets.route("/tickets/<int:ticket_id>", methods=["GET"])
def get_ticket(ticket_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT at.*, it.issue_type_name, it.issue_category,
                   r.report_status, r.urgency, r.description,
                   l.street_name, l.neighborhood_name
            FROM accessibility_ticket at
            LEFT JOIN issue_type it ON at.issue_type_id = it.issue_type_id
            LEFT JOIN report r ON at.report_id = r.report_id
            LEFT JOIN location l ON r.location_id = l.location_id
            WHERE at.ticket_id = %s
            """,
            (ticket_id,),
        )
        row = cursor.fetchone()
        if not row:
            return jsonify({"error": "Ticket not found"}), 404
        return jsonify(row), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /tickets/{id} — update ticket status/date/time or priority via status.
# [Paul-3][Paul-6]
@locations_tickets.route("/tickets/<int:ticket_id>", methods=["PUT"])
def update_ticket(ticket_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}

        cursor.execute(
            "SELECT ticket_id FROM accessibility_ticket WHERE ticket_id = %s",
            (ticket_id,),
        )
        if not cursor.fetchone():
            return jsonify({"error": "Ticket not found"}), 404

        allowed = ["ticket_status", "ticket_date", "ticket_time",
                   "report_id", "issue_type_id"]
        updates = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]
        if not updates:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(ticket_id)
        cursor.execute(
            f"UPDATE accessibility_ticket SET {', '.join(updates)} "
            f"WHERE ticket_id = %s",
            params,
        )
        get_db().commit()
        return jsonify({"message": "Ticket updated"}), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /tickets/{id} — [Wilson-4]
@locations_tickets.route("/tickets/<int:ticket_id>", methods=["DELETE"])
def delete_ticket(ticket_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM accessibility_ticket WHERE ticket_id = %s",
                       (ticket_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Ticket not found"}), 404
        return jsonify({"message": "Ticket deleted"}), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ============================================================================
# LOCATIONS — location table
# ============================================================================

# GET /locations — list all locations. Optional ?neighborhood= or ?zip_code=
# or ?street_name_like= (supports partial match for John-6 SQL 4.6).
# [Sally-1][John-6]
@locations_tickets.route("/locations", methods=["GET"])
def list_locations():
    cursor = get_db().cursor(dictionary=True)
    try:
        neighborhood = request.args.get("neighborhood")
        zip_code = request.args.get("zip_code")
        street_like = request.args.get("street_name_like")

        query = "SELECT * FROM location WHERE 1=1"
        params = []
        if neighborhood:
            query += " AND neighborhood_name = %s"
            params.append(neighborhood)
        if zip_code:
            query += " AND zip_code = %s"
            params.append(zip_code)
        if street_like:
            query += " AND street_name LIKE %s"
            params.append(f"%{street_like}%")
        query += " ORDER BY neighborhood_name, street_name"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /locations — create a new location. Body: {street_name, neighborhood_name, zip_code}
@locations_tickets.route("/locations", methods=["POST"])
def create_location():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        if not data.get("street_name"):
            return jsonify({"error": "street_name is required"}), 400
        cursor.execute(
            "INSERT INTO location (street_name, neighborhood_name, zip_code) VALUES (%s, %s, %s)",
            (data["street_name"], data.get("neighborhood_name"), data.get("zip_code")),
        )
        db.commit()
        return jsonify({"location_id": cursor.lastrowid}), 201
    except Error as e:
        db.rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /locations/{id} — view a single location with its obstructions.
# [Sally-2][John-6]
@locations_tickets.route("/locations/<int:location_id>", methods=["GET"])
def get_location(location_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM location WHERE location_id = %s",
                       (location_id,))
        loc = cursor.fetchone()
        if not loc:
            return jsonify({"error": "Location not found"}), 404

        cursor.execute(
            """
            SELECT o.obstruction_id, o.obstruction_name,
                   o.obstruction_desc, o.severity_level
            FROM obstructions o
            JOIN location_obstruction lo ON o.obstruction_id = lo.obstruction_id
            WHERE lo.location_id = %s
            ORDER BY o.severity_level DESC
            """,
            (location_id,),
        )
        loc["obstructions"] = cursor.fetchall()
        return jsonify(loc), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ============================================================================
# OBSTRUCTIONS AT A LOCATION — location_obstruction junction + obstructions
# ============================================================================

# GET /locations/{id}/obstructions — list obstructions at a location.
# Optional ?name= filters by exact obstruction_name (supports Sally-1..6
# queries from Phase 2 SQL 3.1–3.6 which filter by obstruction_name).
# [Sally-1..6]
@locations_tickets.route("/locations/<int:location_id>/obstructions",
                         methods=["GET"])
def list_location_obstructions(location_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        name = request.args.get("name")

        query = """
            SELECT o.obstruction_id, o.obstruction_name,
                   o.obstruction_desc, o.severity_level,
                   l.street_name, l.neighborhood_name
            FROM obstructions o
            JOIN location_obstruction lo ON o.obstruction_id = lo.obstruction_id
            JOIN location l ON lo.location_id = l.location_id
            WHERE lo.location_id = %s
        """
        params = [location_id]
        if name:
            query += " AND o.obstruction_name = %s"
            params.append(name)
        query += " ORDER BY o.severity_level DESC"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /locations/{id}/obstructions — attach an obstruction to a location.
# Body: {"obstruction_id": 5}. [Wilson-4]
@locations_tickets.route("/locations/<int:location_id>/obstructions",
                         methods=["POST"])
def add_location_obstruction(location_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        obstruction_id = data.get("obstruction_id")
        if not obstruction_id:
            return jsonify({"error": "obstruction_id is required"}), 400

        cursor.execute(
            "INSERT IGNORE INTO location_obstruction "
            "(location_id, obstruction_id) VALUES (%s, %s)",
            (location_id, obstruction_id),
        )
        get_db().commit()
        return jsonify({"message": "Obstruction linked to location"}), 201
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /locations/{id}/obstructions/{obstruction_id} — detach an
# obstruction from a location. [Wilson-4]
@locations_tickets.route(
    "/locations/<int:location_id>/obstructions/<int:obstruction_id>",
    methods=["DELETE"],
)
def remove_location_obstruction(location_id, obstruction_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            "DELETE FROM location_obstruction "
            "WHERE location_id = %s AND obstruction_id = %s",
            (location_id, obstruction_id),
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Link not found"}), 404
        return jsonify({"message": "Obstruction unlinked from location"}), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
