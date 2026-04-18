from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

dining_halls = Blueprint("dining_halls", __name__)


# GET /dining-halls/<hall_id>/menuitems/<item_id>/allergens/<allergen_id>
@dining_halls.route("/<int:hall_id>/menuitems/<int:item_id>/allergens/<int:allergen_id>", methods=["GET"])
def get_menu_item_allergen(hall_id, item_id, allergen_id):
    """Returns allergen info for a specific menu item in a dining hall."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'GET allergen {allergen_id} for item {item_id} in hall {hall_id}')

        # make sure the item actually belongs to this hall
        cursor.execute(
            "SELECT ItemId FROM MenuItem WHERE ItemId = %s AND HallId = %s",
            (item_id, hall_id)
        )
        if not cursor.fetchone():
            return jsonify({"error": "That menu item doesn't exist in this dining hall"}), 404

        cursor.execute("""
            SELECT mi.ItemId, mi.ItemName, mi.Description, mi.Category, mi.IsAvailable,
                   a.AllergenId, a.AllergyName, a.Severity
            FROM MenuItem mi
            JOIN MenuItemAllergen mia ON mi.ItemId = mia.ItemId
            JOIN Allergen a ON mia.AllergenId = a.AllergenId
            WHERE mi.HallId = %s AND mi.ItemId = %s AND a.AllergenId = %s
        """, (hall_id, item_id, allergen_id))

        result = cursor.fetchall()
        current_app.logger.info(f'found {len(result)} allergen record(s)')
        return jsonify(result), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error fetching allergen info: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /dining-halls/<hall_id>/menuitems/<item_id>/allergens/<allergen_id>
@dining_halls.route("/<int:hall_id>/menuitems/<int:item_id>/allergens/<int:allergen_id>", methods=["POST"])
def tag_menu_item_allergen(hall_id, item_id, allergen_id):
    """Tags a menu item with an allergen."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'tagging allergen {allergen_id} onto item {item_id} in hall {hall_id}')

        cursor.execute(
            "SELECT ItemId FROM MenuItem WHERE ItemId = %s AND HallId = %s",
            (item_id, hall_id)
        )
        if not cursor.fetchone():
            return jsonify({"error": "That menu item doesn't exist in this dining hall"}), 404

        cursor.execute("SELECT AllergenId FROM Allergen WHERE AllergenId = %s", (allergen_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Allergen not found"}), 404

        # don't allow duplicates
        cursor.execute(
            "SELECT 1 FROM MenuItemAllergen WHERE ItemId = %s AND AllergenId = %s",
            (item_id, allergen_id)
        )
        if cursor.fetchone():
            return jsonify({"error": "This allergen is already tagged on that item"}), 409

        cursor.execute(
            "INSERT INTO MenuItemAllergen (ItemId, AllergenId) VALUES (%s, %s)",
            (item_id, allergen_id)
        )
        get_db().commit()
        return jsonify({"message": "Allergen tagged successfully"}), 201

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error tagging allergen: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /dining-halls/<hall_id>/stations/<station_id>/menuitems
@dining_halls.route("/<int:hall_id>/stations/<int:station_id>/menuitems", methods=["GET"])
def get_station_menu_items(hall_id, station_id):
    """Returns all menu items currently being served at a station."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'fetching menu items for station {station_id} in hall {hall_id}')

        cursor.execute(
            "SELECT StationId FROM DiningStation WHERE StationId = %s AND HallId = %s",
            (station_id, hall_id)
        )
        if not cursor.fetchone():
            return jsonify({"error": "That station doesn't exist in this dining hall"}), 404

        cursor.execute("""
            SELECT mi.ItemId, mi.ItemName, mi.Description, mi.Category, mi.IsAvailable,
                   ds.Name AS StationName, ds.WaitMinutes, ds.UpdatedAt
            FROM DiningStation ds
            JOIN MenuItem mi ON ds.ItemId = mi.ItemId
            WHERE ds.StationId = %s AND ds.HallId = %s
        """, (station_id, hall_id))

        items = cursor.fetchall()
        current_app.logger.info(f'found {len(items)} item(s) at station {station_id}')
        return jsonify(items), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error fetching station menu items: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /dining-halls/studentfeedback/<hall_id>
@dining_halls.route("/studentfeedback/<int:hall_id>", methods=["GET"])
def get_student_feedback(hall_id):
    """Pulls all student feedback submitted for a dining hall."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'fetching student feedback for hall {hall_id}')

        cursor.execute("SELECT HallId FROM DiningHall WHERE HallId = %s", (hall_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Dining hall not found"}), 404

        cursor.execute("SELECT * FROM StudentFeedback WHERE HallId = %s", (hall_id,))
        feedback = cursor.fetchall()

        current_app.logger.info(f'found {len(feedback)} feedback entry/entries for hall {hall_id}')
        return jsonify(feedback), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error fetching student feedback: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /dining-halls/<hall_id>/usagestats
@dining_halls.route("/<int:hall_id>/usagestats", methods=["GET"])
def get_usage_stats(hall_id):
    """Returns visitor counts and peak hours for a dining hall."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'fetching usage stats for hall {hall_id}')

        cursor.execute("SELECT HallId FROM DiningHall WHERE HallId = %s", (hall_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Dining hall not found"}), 404

        cursor.execute(
    "SELECT HallId, TimeStamp, VisitorCount, CAST(PeakHour AS CHAR) AS PeakHour, DayOfWeek FROM UsageStats WHERE HallId = %s",
    (hall_id,)
)
        stats = cursor.fetchall()

        current_app.logger.info(f'found {len(stats)} usage stat(s) for hall {hall_id}')
        return jsonify(stats), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error fetching usage stats: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /dining-halls/menuitems
# required: HallId, ItemName, Category, IsAvailable - Description is optional
@dining_halls.route("/menuitems", methods=["POST"])
def create_menu_item():
    """Adds a new menu item to a dining hall."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('creating a new menu item')
        data = request.get_json()

        if not data:
            return jsonify({"error": "No request body found"}), 400

        for field in ["HallId", "ItemName", "Category", "IsAvailable"]:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        cursor.execute("SELECT HallId FROM DiningHall WHERE HallId = %s", (data["HallId"],))
        if not cursor.fetchone():
            return jsonify({"error": "Dining hall not found"}), 404

        cursor.execute("""
            INSERT INTO MenuItem (HallId, ItemName, Description, Category, IsAvailable)
            VALUES (%s, %s, %s, %s, %s)
        """, (
            data["HallId"],
            data["ItemName"],
            data.get("Description"),
            data["Category"],
            data["IsAvailable"],
        ))
        get_db().commit()
        return jsonify({"message": "Menu item created successfully"}), 201

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error creating menu item: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /dining-halls/menuitems/<menu_item_id>
# any field except ItemId can be updated
@dining_halls.route("/menuitems/<int:menu_item_id>", methods=["PUT"])
def update_menu_item(menu_item_id):
    """Updates a menu item."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'updating menu item {menu_item_id}')
        data = request.get_json()

        if not data:
            return jsonify({"error": "No request body found"}), 400

        if "HallId" in data:
            cursor.execute("SELECT HallId FROM DiningHall WHERE HallId = %s", (data["HallId"],))
            if not cursor.fetchone():
                return jsonify({"error": "Dining hall not found"}), 404

        cursor.execute("SELECT ItemId FROM MenuItem WHERE ItemId = %s", (menu_item_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Menu item not found"}), 404

        allowed_fields = ["HallId", "ItemName", "Description", "Category", "IsAvailable"]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(menu_item_id)
        cursor.execute(
            f"UPDATE MenuItem SET {', '.join(update_fields)} WHERE ItemId = %s",
            params
        )
        get_db().commit()
        return jsonify({"message": "Menu item updated successfully"}), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error updating menu item: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /dining-halls/studentfeedback
@dining_halls.route("/studentfeedback", methods=["GET"])
def get_cuisine_preferences():
    """Returns cuisine preferences aggregated across all student feedback."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('fetching cuisine preferences from student feedback')

        cursor.execute("""
            SELECT CuisinePref, COUNT(*) AS RequestCount
            FROM StudentFeedback
            WHERE CuisinePref IS NOT NULL
            GROUP BY CuisinePref
            ORDER BY RequestCount DESC
        """)
        preferences = cursor.fetchall()

        current_app.logger.info(f'found {len(preferences)} cuisine preference(s)')
        return jsonify(preferences), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error fetching cuisine preferences: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# GET /dining-halls/studentfeedback
@dining_halls.route("/studentfeedback", methods=["GET"])
def get_cuisine_preferences():
    """Returns cuisine preferences aggregated across all student feedback."""
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info('fetching cuisine preferences from student feedback')

        cursor.execute("""
            SELECT CuisinePref, COUNT(*) AS RequestCount
            FROM StudentFeedback
            WHERE CuisinePref IS NOT NULL
            GROUP BY CuisinePref
            ORDER BY RequestCount DESC
        """)
        preferences = cursor.fetchall()

        current_app.logger.info(f'found {len(preferences)} cuisine preference(s)')
        return jsonify(preferences), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error fetching cuisine preferences: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# PUT /dining-halls/<hall_id>/operatinghours/<day_of_week>
@dining_halls.route("/<int:hall_id>/operatinghours/<string:day_of_week>", methods=["PUT"])
def update_operating_hours(hall_id, day_of_week):
    """Updates open/close time (and optionally a note) for a given day."""
    day_of_week = day_of_week.capitalize()  # accept monday or Monday
    cursor = get_db().cursor(dictionary=True)
    try:
        current_app.logger.info(f'updating {day_of_week} hours for hall {hall_id}')
        data = request.get_json()

        if not data:
            return jsonify({"error": "No request body found"}), 400

        cursor.execute("SELECT HallId FROM DiningHall WHERE HallId = %s", (hall_id,))
        if not cursor.fetchone():
            return jsonify({"error": "Dining hall not found"}), 404

        cursor.execute(
            "SELECT HallId FROM OperatingHours WHERE HallId = %s AND DayOfWeek = %s",
            (hall_id, day_of_week)
        )
        if not cursor.fetchone():
            return jsonify({"error": f"No operating hours found for {day_of_week}"}), 404

        allowed_fields = ["OpenTime", "CloseTime", "Note"]
        update_fields = [f"{f} = %s" for f in allowed_fields if f in data]
        params = [data[f] for f in allowed_fields if f in data]

        if not update_fields:
            return jsonify({"error": "Nothing to update - send OpenTime, CloseTime, and/or Note"}), 400

        params.extend([hall_id, day_of_week])
        cursor.execute(
            f"UPDATE OperatingHours SET {', '.join(update_fields)} WHERE HallId = %s AND DayOfWeek = %s",
            params
        )
        get_db().commit()
        return jsonify({"message": "Operating hours updated successfully"}), 200

    except Error as e:
        get_db().rollback()
        current_app.logger.error(f'error updating operating hours: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()