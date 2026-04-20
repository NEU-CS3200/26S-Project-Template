from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error
import json

analytics = Blueprint('analytics', __name__)

#comments placed to learn, inspired format from Jasmine
# Process: look how Jasmine approached for consistency, fill in own templates. Paste SQL from google doc for query

# Immanuel story 3.1: filter nutrition data by hall, date range, student type
@analytics.route('/filter', methods=['GET'])
def filter_nutrition_data():
    # read query params — hall and student_type are optional
    hall_name = request.args.get('hall')
    start_date = request.args.get('start', '2025-03-29')
    end_date = request.args.get('end', '2025-04-04')
    student_type = request.args.get('student_type')

    cursor = get_db().cursor(dictionary=True)
    try:
        # base query: total nutrient consumption per day in a date range
        query = '''
            SELECT dh.name AS dining_hall, d.student_type, d.college_year,
                   n.name AS nutrient, n.unit,
                   ROUND(AVG(min_t.amount * mli.servings), 2) AS avg_intake,
                   COUNT(DISTINCT ml.user_id) AS num_users
            FROM meal_logs ml
            JOIN meal_log_items mli ON ml.log_id = mli.log_id
            JOIN menu_items mi ON mli.item_id = mi.item_id
            JOIN dining_halls dh ON mi.hall_id = dh.hall_id
            JOIN menu_item_nutrients min_t ON mi.item_id = min_t.item_id
            JOIN nutrients n ON min_t.nutrient_id = n.nutrient_id
            JOIN users u ON ml.user_id = u.user_id
            JOIN demographics d ON u.demographic_id = d.demographic_id
            WHERE ml.log_date BETWEEN %s AND %s
        '''
        params = [start_date, end_date]

        # add on optional filters only if user passed them
        if hall_name:
            query += ' AND dh.name = %s'
            params.append(hall_name)
        if student_type:
            query += ' AND d.student_type = %s'
            params.append(student_type)

        query += '''
            GROUP BY dh.name, d.student_type, d.college_year, n.name, n.unit
            ORDER BY n.name, d.college_year
        '''

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200

    except Error as e:
        # logs for debugging, return 500 so frontend sees it - stole from jasmine
        current_app.logger.error(f'/analytics/filter failed: {e}')
        return jsonify({'error': str(e)}), 500
    
# Immanuel story 3.3: nutrient totals per day over a date range
@analytics.route('/trends', methods=['GET'])
def trends():
    # grab params, nutrient filter optional
    start_date = request.args.get('start', '2025-03-29')
    end_date = request.args.get('end', '2025-04-04')
    nutrient = request.args.get('nutrient')  # None means "all nutrients"

    cursor = get_db().cursor(dictionary=True)
    try:
        # base query: average intake per nutrient and then grouped by hall + demographic
        query = '''
            SELECT ml.log_date, n.name as nutrient, n.unit,
                round(sum(min_t.amount * mli.servings), 2) as total_consumed,
                count(distinct ml.user_id) as users_tracked
            FROM meal_logs ml
            JOIN meal_log_items mli on ml.log_id = mli.log_id
            JOIN menu_items mi on mli.item_id = mi.item_id
            JOIN menu_item_nutrients min_t on mi.item_id = min_t.item_id
            JOIN nutrients n on min_t.nutrient_id = n.nutrient_id
            WHERE ml.log_date BETWEEN %s AND %s
        '''
        params = [start_date, end_date]

        # add on optional filters only if user passed them
        if nutrient:
            query += ' AND n.name = %s'
            params.append(nutrient)

        query += '''
            GROUP BY ml.log_date, n.name, n.unit
            ORDER BY ml.log_date, n.name
        '''

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200

    except Error as e:
        # logs for debugging, return 500 so frontend sees it - stole from jasmine
        current_app.logger.error(f'/analytics/trends failed: {e}')
        return jsonify({'error': str(e)}), 500
    
# Immanuel story 3.4: compare avg nutrient intake between athletes vs non-athletes
@analytics.route('/compare', methods=['GET'])
def compare():
    # grab params, nutrient filter optional
    start_date = request.args.get('start', '2025-03-29')
    end_date = request.args.get('end', '2025-04-04')
    nutrient = request.args.get('nutrient')  # None means "all nutrients"

    cursor = get_db().cursor(dictionary=True)
    try:
        # base query: avg intake per nutrient, grouped by athlete vs non-athlete
        query = '''
            SELECT case when d.athletic_team is not null then 'Athlete'
                else 'Non-Athlete' end as student_group,
                n.name as nutrient, n.unit,
                round(avg(min_t.amount * mli.servings), 2) as avg_intake_per_log,
                count(distinct ml.user_id) as num_students
            FROM meal_logs ml
            JOIN meal_log_items mli on ml.log_id = mli.log_id
            JOIN menu_items mi on mli.item_id = mi.item_id
            JOIN menu_item_nutrients min_t on mi.item_id = min_t.item_id
            JOIN nutrients n on min_t.nutrient_id = n.nutrient_id
            JOIN users u on ml.user_id = u.user_id
            JOIN demographics d on u.demographic_id = d.demographic_id
            WHERE ml.log_date BETWEEN %s AND %s
        '''
        params = [start_date, end_date]

        # add on optional filters only if user passed them
        if nutrient:
            query += ' AND n.name = %s'
            params.append(nutrient)

        query += '''
            GROUP BY student_group, n.name, n.unit
            ORDER BY n.name, student_group;
        '''

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200

    except Error as e:
        # logs for debugging, return 500 so frontend sees it - stole from jasmine
        current_app.logger.error(f'/analytics/compare failed: {e}')
        return jsonify({'error': str(e)}), 500
    
# Immanuel 3.5: POST to queue an auto-generated summary report
@analytics.route('/reports', methods=['POST'])
def create_report():
    cursor = get_db().cursor(dictionary=True)
    try:
        # pull fields out of the request body
        data = request.get_json()
        created_by = data.get('created_by')
        title = data.get('title')
        report_type = data.get('report_type')
        filter_params = data.get('filter_params', {})  # default to empty dict

        # end early if required fields are missing
        if not all([created_by, title, report_type]):
            return jsonify({'error': 'created_by, title, and report_type are required'}), 400

        # filter_params is a JSON column, so serialize the dict to a string
        cursor.execute(
            '''INSERT INTO reports
               (created_by, title, report_type, filter_params, status)
               VALUES (%s, %s, %s, %s, %s)''',
            (created_by, title, report_type, json.dumps(filter_params), 'pending')
        )
        get_db().commit()

        return jsonify({
            'message': 'Report queued',
            'report_id': cursor.lastrowid
        }), 201

    except Error as e:
        current_app.logger.error(f'/analytics/reports failed: {e}')
        return jsonify({'error': str(e)}), 500
    
# Immanuel 3.2: PUT to update an existing export config
@analytics.route('/exports/<int:config_id>', methods=['PUT'])
def update_export_config(config_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json()

        # build UPDATE dynamically ... only touch fields the analyst actually sent
        updates = []
        params = []

        if data.get('name') is not None:
            updates.append('name = %s')
            params.append(data.get('name'))

        if data.get('format') is not None:
            updates.append('format = %s')
            params.append(data.get('format'))

        if data.get('field_selections') is not None:
            updates.append('field_selections = %s')
            params.append(json.dumps(data.get('field_selections')))

        if data.get('filter_params') is not None:
            updates.append('filter_params = %s')
            params.append(json.dumps(data.get('filter_params')))

        if data.get('is_scheduled') is not None:
            updates.append('is_scheduled = %s')
            params.append(data.get('is_scheduled'))

        if data.get('cron_expression') is not None:
            updates.append('cron_expression = %s')
            params.append(data.get('cron_expression'))

        # nothing to update? end early
        if not updates:
            return jsonify({'error': 'At least one field required to update'}), 400

        # put config_id onto the end of params for the WHERE clause
        params.append(config_id)

        query = f"UPDATE export_configs SET {', '.join(updates)} WHERE config_id = %s"
        cursor.execute(query, params)
        get_db().commit()

        return jsonify({'message': f'Export config {config_id} updated'}), 200

    except Error as e:
        current_app.logger.error(f'/analytics/exports/{config_id} PUT failed: {e}')
        return jsonify({'error': str(e)}), 500
    
# Immanuel 3.2: DELETE an export config by id
@analytics.route('/exports/<int:config_id>', methods=['DELETE'])
def delete_export_config(config_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        # %s is a parameterized placeholder. the driver safely substitutes config_id to prevent SQL injection (so somebody cant delete my whole row)
        cursor.execute('DELETE FROM export_configs WHERE config_id = %s', (config_id,))
        get_db().commit()
        return jsonify({'message': f'Export config {config_id} deleted'}), 200

    except Error as e:
        current_app.logger.error(f'/analytics/exports/{config_id} DELETE failed: {e}')
        return jsonify({'error': str(e)}), 500

# Immanuel 3.6: flag users eating way more or less than avg for a nutrient
@analytics.route('/outliers', methods=['GET'])
def outliers():
    # grab params, nutrient filter optional
    start_date = request.args.get('start', '2025-03-29')
    end_date = request.args.get('end', '2025-04-04')
    nutrient = request.args.get('nutrient')

    cursor = get_db().cursor(dictionary=True)
    try:
        # inner subquery gets population avg + stddev per nutrient
        # outer query flags anyone 2+ std devs above or below
        query = '''
            SELECT u.first_name, u.last_name, ml.log_date,
                   n.name as nutrient, n.unit,
                   round(sum(min_t.amount * mli.servings), 2) as daily_total,
                   round(stats.avg_val, 2) as population_avg,
                   round(stats.std_val, 2) as population_stddev,
                   case
                     when sum(min_t.amount * mli.servings) > stats.avg_val + 2 * stats.std_val then 'HIGH OUTLIER'
                     when sum(min_t.amount * mli.servings) < stats.avg_val - 2 * stats.std_val then 'LOW OUTLIER'
                   end as outlier_flag
            FROM meal_logs ml
            JOIN meal_log_items mli on ml.log_id = mli.log_id
            JOIN menu_items mi on mli.item_id = mi.item_id
            JOIN menu_item_nutrients min_t on mi.item_id = min_t.item_id
            JOIN nutrients n on min_t.nutrient_id = n.nutrient_id
            JOIN users u on ml.user_id = u.user_id
            JOIN (
                SELECT n2.nutrient_id,
                       avg(sub.daily_total) as avg_val,
                       stddev(sub.daily_total) as std_val
                FROM (
                    SELECT ml2.user_id, ml2.log_date, min2.nutrient_id,
                           sum(min2.amount * mli2.servings) as daily_total
                    FROM meal_logs ml2
                    JOIN meal_log_items mli2 on ml2.log_id = mli2.log_id
                    JOIN menu_items mi2 on mli2.item_id = mi2.item_id
                    JOIN menu_item_nutrients min2 on mi2.item_id = min2.item_id
                    GROUP BY ml2.user_id, ml2.log_date, min2.nutrient_id
                ) sub
                JOIN nutrients n2 on sub.nutrient_id = n2.nutrient_id
                GROUP BY n2.nutrient_id
            ) stats on n.nutrient_id = stats.nutrient_id
            WHERE ml.log_date BETWEEN %s AND %s
        '''
        params = [start_date, end_date]

        # tack on nutrient filter if the analyst sent one
        if nutrient:
            query += ' AND n.name = %s'
            params.append(nutrient)

        query += '''
            GROUP BY u.user_id, u.first_name, u.last_name, ml.log_date,
                     n.nutrient_id, n.name, n.unit, stats.avg_val, stats.std_val
            HAVING sum(min_t.amount * mli.servings) > stats.avg_val + 2 * stats.std_val
                OR sum(min_t.amount * mli.servings) < stats.avg_val - 2 * stats.std_val
            ORDER BY outlier_flag desc, ml.log_date
        '''

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200

    except Error as e:
        current_app.logger.error(f'/analytics/outliers failed: {e}')
        return jsonify({'error': str(e)}), 500
    
# Immanuel 3.2: GET all export configs for a user... optional, added for nicer page
@analytics.route('/exports/user/<int:user_id>', methods=['GET'])
def get_export_configs(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute('SELECT * FROM export_configs WHERE user_id = %s', (user_id,))
        return jsonify(cursor.fetchall()), 200

    except Error as e:
        current_app.logger.error(f'/analytics/exports/user/{user_id} failed: {e}')
        return jsonify({'error': str(e)}), 500