from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

admin = Blueprint("admin", __name__)

# Returns teh platforms health data including the active users count
# This incldes API response time, error count in last 24 hours, uptime, and the status of each service component
@admin.route("/health", methods=["GET"])
def get_health():
    cursor = get_db().cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT COUNT(*) AS ActiveUsers
            FROM `User`
            WHERE Account_Status = 'Active';
        """)
        active_users = cursor.fetchone()

        cursor.execute("""
            SELECT Metric_Value AS APIResponse
            FROM Health_Metric
            WHERE Metric_Name = 'Response Time'
            ORDER BY Recorded_At DESC LIMIT 1;
        """)
        api_response = cursor.fetchone()

        cursor.execute("""
            SELECT COUNT(*) AS ErrorsLast24h
            FROM Error_Log
            WHERE Occurred_At >= NOW() - INTERVAL 24 HOUR;
        """)
        errors = cursor.fetchone()

        cursor.execute("""
            SELECT Metric_Value AS Uptime
            FROM Health_Metric
            WHERE Metric_Name = 'Uptime'
            ORDER BY Recorded_At DESC 
            LIMIT 1;
        """)
        uptime = cursor.fetchone()

        cursor.execute("""
            SELECT Component_Name, Current_Status
            FROM Service_Component;
        """)
        components = cursor.fetchall()

        return jsonify({
            "active_users":  active_users["ActiveUsers"],
            "api_response":  api_response["APIResponse"],
            "errors_24h":    errors["ErrorsLast24h"],
            "uptime":        uptime["Uptime"] if uptime else None,
            "components":    components
        }), 200

    except Error as e:
        current_app.logger.error(f'get_health error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Returns a list of all the users with their name, email, role, institution, and account status
# Optionally, it also lets you filter for role, institution, and status through paramertes
@admin.route("/users", methods=["GET"])
def get_users():
    cursor = get_db().cursor(dictionary=True)

    try:
        status = request.args.get("status")
        institution = request.args.get("institution")
        role = request.args.get("role")

        query = """
            SELECT u.UserID,
                   CONCAT(u.FirstName, ' ', u.LastName) AS FullName,
                   u.Email,
                   r.RoleName,
                   i.InstitutionName,
                   u.Account_Status
            FROM `User` u
                JOIN Role r ON u.RoleID = r.RoleID
                JOIN Institution i ON u.InstitutionID = i.InstitutionID
            WHERE 1 = 1
        """

        values = []

        if role:
            query += " AND r.RoleName = %s"
            values.append(role)
        if institution:
            query += " AND i.InstitutionName = %s"
            values.append(institution)
        if status:
            query += " AND u.Account_Status = %s"
            values.append(status)

        query += " ORDER BY u.Created_At DESC"

        cursor.execute(query, values)
        results = cursor.fetchall()
        return jsonify(results), 200

    except Error as e:
        current_app.logger.error(f'get_users error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# Returns a list of error logs with the component name, error type, severity, status, and when it occured.
# Optionally, filters for status and severity through parmaeters
@admin.route("/errors", methods=["GET"])
def get_errors():
    cursor = get_db().cursor(dictionary=True)

    try:
        status = request.args.get("status")
        severity = request.args.get("severity")

        query = """
            SELECT el.ErrorID,
                   sc.Component_Name,
                   el.Error_Type,
                   el.Severity,
                   el.Status,
                   el.Occurred_At,
                   el.Message
            FROM Error_Log el
                JOIN Service_Component sc ON el.ComponentID = sc.ComponentID
            WHERE 1=1
        """

        values = []
        if status:
            query += " AND el.Status = %s"
            values.append(status)
        if severity:
            query += " AND el.Severity = %s"
            values.append(severity)

        query += " ORDER BY el.Occurred_At DESC"

        cursor.execute(query, values)
        results = cursor.fetchall()
        return jsonify(results), 200

    except Error as e:
        current_app.logger.error(f'get_error error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Return a list of the outdated/archived job applications that are flagged for cleanup
# Shows the student name, position, employer, date, and status
@admin.route("/data-cleanup", methods=["GET"])
def get_outdated_records():
    cursor = get_db().cursor(dictionary=True)

    try:
        cursor.execute("""
            SELECT ja.ApplicationID,
                   CONCAT(u.FirstName, ' ', u.LastName) AS StudentName,
                   p.Title AS PositionTitle,
                   e.Name AS EmployerName,
                   ja.Application_Date,
                   ja.Status,
                   ja.IsArchived
            FROM Job_Application ja
                JOIN Student s ON ja.StudentID = s.StudentID
                JOIN `User` u ON s.UserID = u.UserID
                JOIN `Position` p ON ja.PositionID = p.PositionID
                JOIN Employer e ON p.EmployerID = e.EmployerID
            WHERE ja.IsArchived = TRUE
            ORDER BY ja.Application_Date;
        """)

        results = cursor.fetchall()
        return jsonify(results), 200

    except Error as e:
        current_app.logger.error(f'get_outdated_records error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Creates a new user account witht eh provided first name, last name, email, role, and institutuion. Sets it to active automatically
@admin.route("/users", methods=["POST"])
def create_user():
    cursor = get_db().cursor(dictionary=True)

    try:
        data = request.get_json()

        needed = ["FirstName", "LastName", "Email", "RoleID", "InstitutionID"]
        
        for field in needed:
            if field not in data:
                return jsonify({"error": f"Missing needed field: {field}"}), 400

        cursor.execute("""
            INSERT INTO `User`(FirstName, LastName, Email, RoleID, InstitutionID, Account_Status)
                VALUES (%s, %s, %s, %s, %s, 'Active');
        """, (
            data["FirstName"],
            data["LastName"],
            data["Email"],
            data["RoleID"],
            data["InstitutionID"]
        ))

        get_db().commit()

        return jsonify({
            "message": "User created successfully",
            "user_id": cursor.lastrowid
        }), 201

    except Error as e:
        current_app.logger.error(f'create_users error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Updates a existing users role or institution based on teh provided user id. 
@admin.route("/users/<int:user_id>", methods=["PUT"])
def update_user(user_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        data = request.get_json()

        cursor.execute("""
                SELECT UserID 
                FROM `User` 
                WHERE UserID = %s;
            """, (user_id,))

        if not cursor.fetchone():
            return jsonify({"error": "User wasn't found"}), 404

        allowed = ["RoleID", "InstitutionID"]
        updates = []
        params  = []

        for f in allowed:
            if f in data:
                updates.append(f"{f} = %s")
                params.append(data[f])

        if not updates:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(user_id)
        
        cursor.execute(f"""
            UPDATE `User` 
            SET {', '.join(updates)} 
            WHERE UserID = %s;
            """,
            params
        )

        get_db().commit()

        return jsonify({
            "message": "User updated successfully"
            }), 200

    except Error as e:
        current_app.logger.error(f'update_user error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Reactivates a users account that is currently deactivated
@admin.route("/users/<int:user_id>/reactivate", methods=["PUT"])
def reactivate_user(user_id):
    cursor = get_db().cursor(dictionary=True)
    
    try:
        cursor.execute("""
                SELECT UserID 
                FROM `User` 
                WHERE UserID = %s;
            """, (user_id,))

        if not cursor.fetchone():
            return jsonify({"error": "User not found"}), 404

        cursor.execute("""
                UPDATE `User`
                SET Account_Status = 'Active', Deactivated_At = NULL
                WHERE UserID = %s
            """, (user_id,))

        get_db().commit()

        return jsonify({"message": "User reactivated successfully"}), 200

    except Error as e:
        current_app.logger.error(f'reactivate_user error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Soft deletes an account. Basically it deactivates the account and make it inactive
@admin.route("/users/<int:user_id>", methods=["DELETE"])
def deactivate_user(user_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        cursor.execute("""
                SELECT UserID 
                FROM `User` 
                WHERE UserID = %s;
            """, (user_id,))

        if not cursor.fetchone():
            return jsonify({"error": "User wasn't found"}), 404

        cursor.execute("""
            UPDATE `User`
            SET Account_Status = 'Inactive', Deactivated_At = NOW()
            WHERE  UserID = %s;
        """, (user_id,))
        
        get_db().commit()

        return jsonify({
            "message": "User deactivated successfully"
            }), 200

    except Error as e:
        current_app.logger.error(f'deactivate_user error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()

# Permanently deletes all archived job applications older than 2 years from the database.
# This action cannot be undone@admin.route("/data-cleanup", methods=["DELETE"])
def delete_outdated_records():
    cursor = get_db().cursor(dictionary=True)

    try:
        cursor.execute("""
            DELETE FROM Job_Application
            WHERE IsArchived = TRUE
            AND Application_Date < DATE_SUB(NOW(), INTERVAL 2 YEAR);
        """)
        
        get_db().commit()

        return jsonify({
            "message": f"Deleted {cursor.rowcount} outdated record(s)",
            "num_rows_deleted": cursor.rowcount
        }), 200

    except Error as e:
        current_app.logger.error(f'delete_outdated_records error: {e}')
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()