from flask import Blueprint, jsonify, request, current_app
from backend.db_connection import get_db
from mysql.connector import Error

users = Blueprint("users", __name__)


# ---- /users -----------------------------------------------------------------

# GET /users — list all users. Optional filters: ?role_id=, ?email=
# [Wilson-1]
@users.route("", methods=["GET"])
def list_users():
    cursor = get_db().cursor(dictionary=True)
    try:
        role_id = request.args.get("role_id")
        email = request.args.get("email")

        query = """
            SELECT u.user_id, u.first_name, u.last_name, u.user_email,
                   u.phone_number, u.preferred_language,
                   u.demographics_age, u.demographics_gender, u.demographics_ethnicity
            FROM `user` u
        """
        params = []
        clauses = []
        if role_id:
            query += " JOIN user_role ur ON u.user_id = ur.user_id"
            clauses.append("ur.role_id = %s")
            params.append(role_id)
        if email:
            clauses.append("u.user_email = %s")
            params.append(email)
        if clauses:
            query += " WHERE " + " AND ".join(clauses)
        query += " ORDER BY u.last_name, u.first_name"

        cursor.execute(query, params)
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"list_users: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /users — create a new user. [Wilson-1]
@users.route("", methods=["POST"])
def create_user():
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        required = ["first_name", "last_name", "user_email"]
        for field in required:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        cursor.execute(
            """
            INSERT INTO `user`
                (first_name, last_name, user_email, phone_number,
                 preferred_language, demographics_age,
                 demographics_gender, demographics_ethnicity)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """,
            (
                data["first_name"],
                data["last_name"],
                data["user_email"],
                data.get("phone_number"),
                data.get("preferred_language"),
                data.get("demographics_age"),
                data.get("demographics_gender"),
                data.get("demographics_ethnicity"),
            ),
        )
        get_db().commit()
        return jsonify({"message": "User created", "user_id": cursor.lastrowid}), 201
    except Error as e:
        current_app.logger.error(f"create_user: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /users/{id} ------------------------------------------------------------

# GET /users/{id} — view one user, with roles + disabilities embedded.
# [Wilson-1][Sally-5]
@users.route("/<int:user_id>", methods=["GET"])
def get_user(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM `user` WHERE user_id = %s", (user_id,))
        user = cursor.fetchone()
        if not user:
            return jsonify({"error": "User not found"}), 404

        cursor.execute(
            """
            SELECT r.role_id, r.role_name, r.role_description
            FROM role r JOIN user_role ur ON r.role_id = ur.role_id
            WHERE ur.user_id = %s
            """,
            (user_id,),
        )
        user["roles"] = cursor.fetchall()

        cursor.execute(
            """
            SELECT d.disability_id, d.disability_name
            FROM disability d JOIN user_disability ud ON d.disability_id = ud.disability_id
            WHERE ud.user_id = %s
            """,
            (user_id,),
        )
        user["disabilities"] = cursor.fetchall()

        return jsonify(user), 200
    except Error as e:
        current_app.logger.error(f"get_user: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /users/{id} — update any subset of user fields. [Wilson-1][Sally-5]
@users.route("/<int:user_id>", methods=["PUT"])
def update_user(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}

        cursor.execute("SELECT user_id FROM `user` WHERE user_id = %s", (user_id,))
        if not cursor.fetchone():
            return jsonify({"error": "User not found"}), 404

        allowed = [
            "first_name", "last_name", "user_email", "phone_number",
            "preferred_language", "demographics_age",
            "demographics_gender", "demographics_ethnicity",
        ]
        updates = [f"{f} = %s" for f in allowed if f in data]
        params = [data[f] for f in allowed if f in data]
        if not updates:
            return jsonify({"error": "No valid fields to update"}), 400

        params.append(user_id)
        cursor.execute(
            f"UPDATE `user` SET {', '.join(updates)} WHERE user_id = %s",
            params,
        )
        get_db().commit()
        return jsonify({"message": "User updated"}), 200
    except Error as e:
        current_app.logger.error(f"update_user: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /users/{id} — [Wilson-1]
@users.route("/<int:user_id>", methods=["DELETE"])
def delete_user(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute("DELETE FROM `user` WHERE user_id = %s", (user_id,))
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "User not found"}), 404
        return jsonify({"message": "User deleted"}), 200
    except Error as e:
        current_app.logger.error(f"delete_user: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /users/{id}/roles ------------------------------------------------------

# GET /users/{id}/roles — [Wilson-1]
@users.route("/<int:user_id>/roles", methods=["GET"])
def get_user_roles(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT r.role_id, r.role_name, r.role_description
            FROM role r JOIN user_role ur ON r.role_id = ur.role_id
            WHERE ur.user_id = %s
            """,
            (user_id,),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /users/{id}/roles — replace the user's role set with the given list.
# Body: {"role_ids": [1, 2, 3]}. [Wilson-1]
@users.route("/<int:user_id>/roles", methods=["PUT"])
def set_user_roles(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        role_ids = data.get("role_ids")
        if not isinstance(role_ids, list):
            return jsonify({"error": "Body must include role_ids as a list"}), 400

        cursor.execute("DELETE FROM user_role WHERE user_id = %s", (user_id,))
        for rid in role_ids:
            cursor.execute(
                "INSERT INTO user_role (user_id, role_id) VALUES (%s, %s)",
                (user_id, rid),
            )
        get_db().commit()
        return jsonify({"message": "Roles updated", "count": len(role_ids)}), 200
    except Error as e:
        get_db().rollback()
        current_app.logger.error(f"set_user_roles: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /users/{id}/disabilities ----------------------------------------------

# GET /users/{id}/disabilities — [Sally-5]
@users.route("/<int:user_id>/disabilities", methods=["GET"])
def get_user_disabilities(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            """
            SELECT d.disability_id, d.disability_name
            FROM disability d
            JOIN user_disability ud ON d.disability_id = ud.disability_id
            WHERE ud.user_id = %s
            """,
            (user_id,),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# POST /users/{id}/disabilities — add a disability to a user.
# Body: {"disability_id": 1}. [Sally-5]
@users.route("/<int:user_id>/disabilities", methods=["POST"])
def add_user_disability(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        disability_id = data.get("disability_id")
        if not disability_id:
            return jsonify({"error": "disability_id is required"}), 400

        cursor.execute(
            "INSERT IGNORE INTO user_disability (user_id, disability_id) VALUES (%s, %s)",
            (user_id, disability_id),
        )
        get_db().commit()
        return jsonify({"message": "Disability added"}), 201
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# PUT /users/{id}/disabilities — replace the user's full disability set.
# Body: {"disability_ids": [1, 2]}. [Sally-5]
@users.route("/<int:user_id>/disabilities", methods=["PUT"])
def set_user_disabilities(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        data = request.get_json() or {}
        ids = data.get("disability_ids")
        if not isinstance(ids, list):
            return jsonify({"error": "Body must include disability_ids as a list"}), 400

        cursor.execute("DELETE FROM user_disability WHERE user_id = %s", (user_id,))
        for did in ids:
            cursor.execute(
                "INSERT INTO user_disability (user_id, disability_id) VALUES (%s, %s)",
                (user_id, did),
            )
        get_db().commit()
        return jsonify({"message": "Disabilities updated", "count": len(ids)}), 200
    except Error as e:
        get_db().rollback()
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# DELETE /users/{id}/disabilities/{disability_id} — remove one disability.
# [Sally-5]
@users.route("/<int:user_id>/disabilities/<int:disability_id>", methods=["DELETE"])
def remove_user_disability(user_id, disability_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        cursor.execute(
            "DELETE FROM user_disability WHERE user_id = %s AND disability_id = %s",
            (user_id, disability_id),
        )
        get_db().commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Disability not found on this user"}), 404
        return jsonify({"message": "Disability removed"}), 200
    except Error as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()


# ---- /users/{id}/actions ----------------------------------------------------

# GET /users/{id}/actions — view a user's action log. [Wilson-2]
# NOTE: depends on `action_log` table (log_id, user_id, action_type,
# log_description, timestamp) which is in Wilson's persona ER diagram but not
# yet in the committed DDL. Flagged in docs/rest-api-matrix.md.
@users.route("/<int:user_id>/actions", methods=["GET"])
def get_user_actions(user_id):
    cursor = get_db().cursor(dictionary=True)
    try:
        limit = request.args.get("limit", default=50, type=int)
        cursor.execute(
            """
            SELECT log_id, user_id, action_type, log_description, timestamp
            FROM action_log
            WHERE user_id = %s
            ORDER BY timestamp DESC
            LIMIT %s
            """,
            (user_id, limit),
        )
        return jsonify(cursor.fetchall()), 200
    except Error as e:
        current_app.logger.error(f"get_user_actions: {e}")
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
