from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

# Create a Blueprint for Dining Halls routes
dining_halls = Blueprint("dining_halls", __name__)

# Update an existing dining menu item
# Can update any field except menu item id
@dining_halls.route('/dininghalls/menuitems/<menu_item_id>', methods=["PUT"])
def update_menu_item(menu_item_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()

        cursor.execute("SELECT ItemId FROM MenuItem WHERE ItemId = %s", (menu_item_id,))
        if not cursor.fetchone():
            return jsonify({"error": "MenuItem not found"}), 404
        
        # Build update query dynamically based on provided fields
        allowed_fields = ["HallId", "ItemName", "Description", "Category", "IsAvailable"]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400
        
        params.append(menu_item_id)
        query = f"UPDATE MenuItem SET {', '.join(update_fields)} WHERE ItemId = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "MenuItem updated successfully"}), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Get info on what cuisines students prefer
@dining_halls.route("/dininghalls/<hall_id>/studentfeedback", methods=["GET"])
def get_cuisine_prefs(hall_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute('''SELECT dh.Name AS DiningHall, sf.CuisinePref, COUNT(*) AS Responses
                        FROM   StudentFeedback  sf
                        JOIN   DiningHall       dh  ON  dh.HallId = sf.HallId
                        WHERE dh.HallId = %s
                        GROUP  BY dh.HallId, dh.Name, sf.CuisinePref
                        ORDER  BY dh.Name, Responses DESC;''', (hall_id,))
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Update operating hours for a dining hall
@dining_halls.route("/dininghalls/<hall_id>/operatinghours/<day_of_week>", methods=["PUT"])
def update_dh_hours(hall_id, day_of_week):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()

        cursor.execute("SELECT HallId, DayOfWeek FROM OperatingHours WHERE HallId = %s and DayOfWeek = %s", (hall_id, day_of_week,))
        if not cursor.fetchone():
            return jsonify({"error": "OperatingHours entry not found"}), 404
        
        # Build update query dynamically based on provided fields
        allowed_fields = ["OpenTime", "CloseTime", "Note"]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400
        
        params.extend([hall_id, day_of_week])
        query = f"UPDATE OperatingHours SET {', '.join(update_fields)} WHERE HallId = %s AND DayOfWeek = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({"message": "OperatingHours updated successfully"}), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()