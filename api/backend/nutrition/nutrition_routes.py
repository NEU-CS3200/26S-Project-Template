from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

nutrition = Blueprint('nutrition', __name__)


@nutrition.route('/daily/<int:user_id>', methods=['GET'])
def get_daily_nutrition(user_id):
    log_date = request.args.get('date', '2025-04-04')
    cursor = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT n.name AS nutrient, n.unit,
                   ROUND(SUM(min_t.amount * mli.servings), 2) AS total_intake,
                   ng.min_value, ng.max_value
            FROM meal_logs ml
            JOIN meal_log_items mli        ON ml.log_id         = mli.log_id
            JOIN menu_item_nutrients min_t ON mli.item_id       = min_t.item_id
            JOIN nutrients n               ON min_t.nutrient_id = n.nutrient_id
            LEFT JOIN nutrition_goals ng   ON ng.user_id        = ml.user_id
              AND ng.nutrient_id = n.nutrient_id
              AND ml.log_date BETWEEN ng.effective_from
                  AND COALESCE(ng.effective_to, '9999-12-31')
            WHERE ml.user_id  = %s
              AND ml.log_date = %s
            GROUP BY n.nutrient_id, n.name, n.unit, ng.min_value, ng.max_value
        '''
        cursor.execute(query, (user_id, log_date))
        results = cursor.fetchall()
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/daily/{user_id} error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/menu', methods=['GET'])
def get_menu_nutrition():
    available_date = request.args.get('date', '2025-04-04')
    cursor = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT mi.name AS menu_item, mi.description, dh.name AS dining_hall,
                   n.name AS nutrient, n.unit, min_t.amount
            FROM menu_items mi
            JOIN dining_halls dh           ON mi.hall_id        = dh.hall_id
            JOIN menu_item_nutrients min_t ON mi.item_id        = min_t.item_id
            JOIN nutrients n               ON min_t.nutrient_id = n.nutrient_id
            WHERE mi.available_date = %s
              AND mi.is_active = TRUE
            ORDER BY dh.name, mi.name, n.name
        '''
        cursor.execute(query, (available_date,))
        results = cursor.fetchall()
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/menu error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/log', methods=['POST'])
def log_meal():
    cursor = get_db().cursor(dictionary=True)
    try:
        data        = request.get_json()
        user_id     = data.get('user_id')
        log_date    = data.get('log_date')
        meal_period = data.get('meal_period')
        items       = data.get('items', [])

        if not all([user_id, log_date, meal_period]):
            return jsonify({'error': 'user_id, log_date, and meal_period are required'}), 400

        cursor.execute(
            'INSERT INTO meal_logs (user_id, log_date, meal_period) VALUES (%s, %s, %s)',
            (user_id, log_date, meal_period)
        )
        new_log_id = cursor.lastrowid
        for item in items:
            cursor.execute(
                'INSERT INTO meal_log_items (log_id, item_id, servings) VALUES (%s, %s, %s)',
                (new_log_id, item['item_id'], item['servings'])
            )
        get_db().commit()
        return jsonify({'message': 'Meal logged successfully', 'log_id': new_log_id}), 201
    except Error as e:
        current_app.logger.error(f'POST /nutrition/log error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/history/<int:user_id>', methods=['GET'])
def get_weekly_history(user_id):
    start  = request.args.get('start', '2025-03-29')
    end    = request.args.get('end',   '2025-04-04')
    cursor = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT ml.log_date, ml.meal_period,
                   n.name AS nutrient, n.unit,
                   ROUND(SUM(min_t.amount * mli.servings), 2) AS total
            FROM meal_logs ml
            JOIN meal_log_items mli        ON ml.log_id         = mli.log_id
            JOIN menu_item_nutrients min_t ON mli.item_id       = min_t.item_id
            JOIN nutrients n               ON min_t.nutrient_id = n.nutrient_id
            WHERE ml.user_id  = %s
              AND ml.log_date BETWEEN %s AND %s
            GROUP BY ml.log_date, ml.meal_period, n.name, n.unit
            ORDER BY ml.log_date, ml.meal_period
        '''
        cursor.execute(query, (user_id, start, end))
        results = cursor.fetchall()
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/history/{user_id} error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/goals/<int:user_id>', methods=['GET'])
def get_goal_status(user_id):
    log_date = request.args.get('date', '2025-04-04')
    cursor   = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT n.name AS nutrient, n.unit,
                   ROUND(SUM(min_t.amount * mli.servings), 2) AS daily_total,
                   ng.min_value AS goal_min, ng.max_value AS goal_max,
                   CASE
                     WHEN SUM(min_t.amount * mli.servings) < ng.min_value THEN 'BELOW'
                     WHEN ng.max_value IS NOT NULL
                          AND SUM(min_t.amount * mli.servings) > ng.max_value THEN 'ABOVE'
                     ELSE 'ON TRACK'
                   END AS status
            FROM meal_logs ml
            JOIN meal_log_items mli        ON ml.log_id         = mli.log_id
            JOIN menu_item_nutrients min_t ON mli.item_id       = min_t.item_id
            JOIN nutrients n               ON min_t.nutrient_id = n.nutrient_id
            JOIN nutrition_goals ng        ON ng.user_id        = ml.user_id
              AND ng.nutrient_id = n.nutrient_id
              AND ml.log_date BETWEEN ng.effective_from
                  AND COALESCE(ng.effective_to, '9999-12-31')
            WHERE ml.user_id  = %s
              AND ml.log_date = %s
            GROUP BY n.nutrient_id, n.name, n.unit, ng.min_value, ng.max_value
        '''
        cursor.execute(query, (user_id, log_date))
        results = cursor.fetchall()
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/goals/{user_id} error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/alerts/<int:user_id>', methods=['GET'])
def get_alerts(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT alert_id, alert_type, message, triggered_at, is_read
            FROM alerts
            WHERE user_id = %s
              AND is_read = FALSE
            ORDER BY triggered_at DESC
        '''
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()
        return jsonify(results), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/alerts/{user_id} error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/log/<int:log_id>', methods=['PUT'])
def update_meal_log(log_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data        = request.get_json()
        meal_period = data.get('meal_period')
        log_date    = data.get('log_date')

        if not meal_period and not log_date:
            return jsonify({'error': 'Provide at least meal_period or log_date to update'}), 400

        if meal_period and log_date:
            cursor.execute(
                'UPDATE meal_logs SET meal_period=%s, log_date=%s WHERE log_id=%s',
                (meal_period, log_date, log_id)
            )
        elif meal_period:
            cursor.execute(
                'UPDATE meal_logs SET meal_period=%s WHERE log_id=%s',
                (meal_period, log_id)
            )
        else:
            cursor.execute(
                'UPDATE meal_logs SET log_date=%s WHERE log_id=%s',
                (log_date, log_id)
            )
        get_db().commit()
        return jsonify({'message': f'Meal log {log_id} updated'}), 200
    except Error as e:
        current_app.logger.error(f'PUT /nutrition/log/{log_id} error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/goal/<int:goal_id>', methods=['PUT'])
def update_nutrition_goal(goal_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data      = request.get_json()
        min_value = data.get('min_value')
        max_value = data.get('max_value')
        cursor.execute(
            'UPDATE nutrition_goals SET min_value=%s, max_value=%s WHERE goal_id=%s',
            (min_value, max_value, goal_id)
        )
        get_db().commit()
        return jsonify({'message': f'Goal {goal_id} updated'}), 200
    except Error as e:
        current_app.logger.error(f'PUT /nutrition/goal/{goal_id} error: {e}')
        return jsonify({'error': str(e)}), 500


@nutrition.route('/log/<int:log_id>', methods=['DELETE'])
def delete_meal_log(log_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute('DELETE FROM meal_logs WHERE log_id = %s', (log_id,))
        get_db().commit()
        return jsonify({'message': f'Meal log {log_id} deleted'}), 200
    except Error as e:
        current_app.logger.error(f'DELETE /nutrition/log/{log_id} error: {e}')
        return jsonify({'error': str(e)}), 500


# Jordan Carter (Artist and Performer) Dining Hall Routes

@nutrition.route('/dining-halls', methods=['GET'])
def get_dining_halls():
    cursor = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT hall_id, name, location, building_code, latitude, longitude, operating_hours
            FROM dining_halls
            WHERE is_active = TRUE
            ORDER BY name
        '''
        cursor.execute(query)
        results = cursor.fetchall()
        return jsonify({
            'status': 'success',
            'data': results,
            'count': len(results)
        }), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/dining-halls error: {e}')
        return jsonify({'status': 'error', 'message': str(e)}), 500


@nutrition.route('/menu-browse', methods=['GET'])
def browse_menu():
    hall_id = request.args.get('hall_id', type=int)
    meal_period = request.args.get('meal_period')
    dietary_label = request.args.get('dietary_label')
    search = request.args.get('search', '')
    available_date = request.args.get('date', '2025-04-04')

    cursor = get_db().cursor(dictionary=True)

    try:
        query = '''
            SELECT mi.item_id, mi.name, mi.description, mi.meal_period,
                dh.hall_id, dh.name AS dining_hall,
                ROUND(SUM(CASE WHEN n.nutrient_id = 1 THEN min_t.amount ELSE 0 END), 0) AS calories,
                ROUND(SUM(CASE WHEN n.nutrient_id = 10 THEN min_t.amount ELSE 0 END), 1) AS protein,
                d.dietary_label
            FROM menu_items mi
            JOIN dining_halls dh ON mi.hall_id = dh.hall_id
            LEFT JOIN menu_item_nutrients min_t ON mi.item_id = min_t.item_id
            LEFT JOIN nutrients n ON min_t.nutrient_id = n.nutrient_id
            LEFT JOIN demographics d ON d.dietary_label IS NOT NULL
            WHERE mi.available_date = %s
            AND mi.is_active = TRUE
            AND dh.is_active = TRUE
        '''

        params = [available_date]
        
        if hall_id:
            query += ' AND dh.hall_id = %s'
            params.append(hall_id)
        if meal_period:
            query += ' AND mi.meal_period IN (%s, "all_day")'
            params.append(meal_period)
        if search:
            query += ' AND mi.name LIKE %s'
            params.append(f'%{search}%')
        query += '''
            GROUP BY mi.item_id, mi.name, mi.description, mi.meal_period, dh.hall_id, dh.name
            ORDER BY dh.name, mi.name
        '''
        
        cursor.execute(query, params)
        results = cursor.fetchall()
        return jsonify({
            'status': 'success',
            'data': results,
            'filters': {
                'hall_id': hall_id,
                'meal_period': meal_period,
                'dietary_label': dietary_label,
                'search': search,
                'date': available_date
            },
            'count': len(results)
        }), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/menu-browse error: {e}')
        return jsonify({'status': 'error', 'message': str(e)}), 500


@nutrition.route('/wait-times', methods=['GET'])
def get_wait_times():
    hall_id = request.args.get('hall_id', type=int)
    
    wait_time_data = {
        1: {'hall_id': 1, 'name': 'Stetson East', 'wait_minutes': 8, 'peak_hours': ['11:30-13:00', '17:30-19:00']},
        2: {'hall_id': 2, 'name': 'Stetson West', 'wait_minutes': 12, 'peak_hours': ['12:00-13:30', '18:00-19:30']},
        3: {'hall_id': 3, 'name': 'International Village', 'wait_minutes': 15, 'peak_hours': ['12:30-14:00', '18:30-20:00']},
        4: {'hall_id': 4, 'name': 'Levine Marketplace', 'wait_minutes': 5, 'peak_hours': ['10:30-11:30', '14:00-15:00']},
        5: {'hall_id': 5, 'name': 'Outtakes Express', 'wait_minutes': 3, 'peak_hours': ['10:00-11:00', '13:00-14:30']}
    }
    
    try:
        if hall_id:
            if hall_id not in wait_time_data:
                return jsonify({'status': 'error', 'message': f'Hall {hall_id} not found'}), 404
            return jsonify({
                'status': 'success',
                'data': wait_time_data[hall_id],
                'source': 'demo_estimate'
            }), 200
        else:
            return jsonify({
                'status': 'success',
                'data': list(wait_time_data.values()),
                'source': 'demo_estimate',
                'count': len(wait_time_data)
            }), 200
    except Exception as e:
        current_app.logger.error(f'GET /nutrition/wait-times error: {e}')
        return jsonify({'status': 'error', 'message': str(e)}), 500


@nutrition.route('/saved-meals', methods=['POST'])
def create_saved_meal():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()
        user_id = data.get('user_id')
        name = data.get('name')
        description = data.get('description', '')
        items = data.get('items', [])
        if not all([user_id, name]):
            return jsonify({'status': 'error', 'message': 'user_id and name are required'}), 400
        if not items:
            return jsonify({'status': 'error', 'message': 'At least one item must be included'}), 400
        cursor.execute(
            'INSERT INTO saved_meals (user_id, name, description) VALUES (%s, %s, %s)',
            (user_id, name, description)
        )
        saved_meal_id = cursor.lastrowid
        for item in items:
            cursor.execute(
                'INSERT INTO saved_meal_items (saved_meal_id, item_id, servings) VALUES (%s, %s, %s)',
                (saved_meal_id, item['item_id'], item.get('servings', 1.0))
            )
        get_db().commit()
        return jsonify({
            'status': 'success',
            'message': 'Saved meal created',
            'saved_meal_id': saved_meal_id,
            'item_count': len(items)
        }), 201
    except Error as e:
        current_app.logger.error(f'POST /nutrition/saved-meals error: {e}')
        get_db().rollback()
        return jsonify({'status': 'error', 'message': str(e)}), 500


@nutrition.route('/saved-meals/<int:user_id>', methods=['GET'])
def list_saved_meals(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        query = '''
            SELECT sm.saved_meal_id, sm.name, sm.description, sm.created_at, sm.updated_at,
                COUNT(smi.saved_item_id) AS item_count,
                   ROUND(SUM(CASE WHEN n.nutrient_id = 1 THEN min_t.amount * smi.servings ELSE 0 END), 0) AS total_calories,
                   ROUND(SUM(CASE WHEN n.nutrient_id = 10 THEN min_t.amount * smi.servings ELSE 0 END), 1) AS total_protein
            FROM saved_meals sm
            LEFT JOIN saved_meal_items smi ON sm.saved_meal_id = smi.saved_meal_id
            LEFT JOIN menu_items mi ON smi.item_id = mi.item_id
            LEFT JOIN menu_item_nutrients min_t ON mi.item_id = min_t.item_id
            LEFT JOIN nutrients n ON min_t.nutrient_id = n.nutrient_id
            WHERE sm.user_id = %s
            GROUP BY sm.saved_meal_id, sm.name, sm.description, sm.created_at, sm.updated_at
            ORDER BY sm.updated_at DESC
        '''
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()
        return jsonify({
            'status': 'success',
            'data': results,
            'count': len(results)
        }), 200
    except Error as e:
        current_app.logger.error(f'GET /nutrition/saved-meals/{user_id} error: {e}')
        return jsonify({'status': 'error', 'message': str(e)}), 500


@nutrition.route('/saved-meals/<int:saved_meal_id>', methods=['DELETE'])
def delete_saved_meal(saved_meal_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        cursor.execute('SELECT user_id FROM saved_meals WHERE saved_meal_id = %s', (saved_meal_id,))
        meal = cursor.fetchone()
        if not meal:
            return jsonify({'status': 'error', 'message': f'Saved meal {saved_meal_id} not found'}), 404
        cursor.execute('DELETE FROM saved_meals WHERE saved_meal_id = %s', (saved_meal_id,))
        get_db().commit()
        return jsonify({
            'status': 'success',
            'message': f'Saved meal {saved_meal_id} deleted'
        }), 200
    except Error as e:
        current_app.logger.error(f'DELETE /nutrition/saved-meals/{saved_meal_id} error: {e}')
        return jsonify({'status': 'error', 'message': str(e)}), 500
