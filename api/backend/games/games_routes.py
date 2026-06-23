from flask import Blueprint, make_response, jsonify, request
from mysql.connector import Error
from backend.db_connection import get_db

games_routes = Blueprint("games_routes", __name__)

# cursor = get_db().cursor(dictionary = TRUE)

def _request_data():
    return request.get_json(silent=True) or {}

def _missing_fields(data, required_fields):
    return [field for field in required_fields if field not in data]

@games_routes.route("/games", methods=["GET"])
def get_all_games():
	cursor = get_db().cursor(dictionary = True)
	the_query = """
	SELECT g.*, s.studio_name AS published_by_studio_name
    FROM games AS g
    LEFT JOIN studios AS s ON g.published_by_studio_id = s.studio_id
    ORDER BY g.title, g.platform
	"""
	cursor.execute(the_query)
	the_data = cursor.fetchall()
	the_response = make_response(the_data)
	return the_response

@games_routes.route("/games", methods=["POST"])
def create_game():
    data = _request_data()
    required_fields = ("title", "description", "genre", "platform", "release_year")
    missing_fields = _missing_fields(data, required_fields)
    if missing_fields:
        return jsonify({"error": f"Missing required fields: {', '.join(missing_fields)}"}), 400

    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute(
            """INSERT INTO games
               (title, description, genre, platform, release_year,
                average_rating, lifecycle_status, published_by_studio_id)
               VALUES (%s, %s, %s, %s, %s, %s, %s, %s)""",
            (
                data["title"],
                data["description"],
                data["genre"],
                data["platform"],
                data["release_year"],
                data.get("average_rating", 0.00),
                data.get("lifecycle_status", "active"),
                data.get("published_by_studio_id"),
            ),
        )
        db.commit()
        return jsonify({"game_id": cursor.lastrowid}), 201
    except Error as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 400
    finally:
        cursor.close()

@games_routes.route("/games/<id>", methods=["GET"])
def get_game(id):
	cursor = get_db().cursor(dictionary = True)
	cursor.execute('SELECT * FROM games WHERE game_id = {0}'.format(id))
	the_data = cursor.fetchall()
	the_response = make_response(the_data)
	return the_response

@games_routes.route("/games/<int:game_id>", methods=["PUT"])
def update_game(game_id):
    data = _request_data()
    db = get_db()
    cursor = db.cursor()

    allowed_fields = (
        "title",
        "description",
        "genre",
        "platform",
        "release_year",
        "average_rating",
        "lifecycle_status",
        "published_by_studio_id",
    )

    try:
        fields = []
        values = []
        for column in allowed_fields:
            if column in data:
                fields.append(f"{column} = %s")
                values.append(data[column])

        if not fields:
            return jsonify({"error": "No fields to update"}), 400

        values.append(game_id)
        cursor.execute(
            """UPDATE games SET {', '.join(fields)} WHERE game_id = %s""",
            values,
        )
        db.commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Game not found"}), 404
        return jsonify({"message": "Game updated"}), 200
    except Error as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 400
    finally:
        cursor.close()

@games_routes.route("/games/<id>", methods=["DELETE"])
def delete_game(id):
    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute("DELETE FROM games WHERE = {0}".format(id))
        db.commit()
        if cursor.rowcount == 0:
            return jsonify({"error": "Game not found"}), 404
        return jsonify({"message": "Game deleted"}), 200
    finally:
        cursor.close()

@games_routes.route("/games/<id>/tags", methods=["GET"])
def get_tags_by_game(id):
	cursor = get_db().cursor(dictionary = True)
	cursor.execute('SELECT tag_name FROM tags WHERE tag_id IN (SELECT tag_id FROM game_tags WHERE game_id = {0})'.format(id))
	the_data = cursor.fetchall()
	the_response = make_response(the_data)
	return the_response

@games_routes.route("/games/<id>/tags", methods=["POST"])
def add_tag_to_game(id):
    data = _request_data()
    required_fields = ("tag_id")
    missing_fields = _missing_fields(data, required_fields)
    if missing_fields:
        return jsonify({"error": f"Missing required fields: {', '.join(missing_fields)}"}), 400

    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute(
            """INSERT INTO game_tags
               (game_id, tag_id)
               VALUES (%s, %s)""",
            (
                data[id],
                data["tag_id"]
            ),
        )
        db.commit()
        return jsonify({"message": "Tag added"}), 200
    except Error as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 400
    finally:
        cursor.close()

@games_routes.route("/games/<game_id>/tags", methods=["DELETE"])
def delete_tag_from_game(game_id):
    data = _request_data()
    required_fields = ("tag_id")
    missing_fields = _missing_fields(data, required_fields)
    if missing_fields:
        return jsonify({"error": f"Missing required fields: {', '.join(missing_fields)}"}), 400
    db = get_db()
    cursor = get_db().cursor(dictionary = True)
    delete_query = """
            DELETE FROM game_tags
            WHERE game_id = %s AND tag_id = %s
        """
    try:
         cursor.execute(delete_query, (game_id, data["tag_id"]))
         db.commit()
         the_response = jsonify({"message": "Tag deleted from Game"}), 200
         return the_response
    except Error as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 400
    finally:
        cursor.close()
         

@games_routes.route("/games/<id>/comments", methods=["GET"])
def get_comments_from_game(id):
	cursor = get_db().cursor(dictionary = True)
	cursor.execute('SELECT * FROM comments WHERE game_id = {0})'.format(id))
	the_data = cursor.fetchall()
	the_response = make_response(the_data)
	return the_response

@games_routes.route("/games/<id>/comments", methods=["POST"])
def add_comment_to_game(id):
    data = _request_data()
    required_fields = ("created_by_user_id", "comment_text", "rating")
    missing_fields = _missing_fields(data, required_fields)
    if missing_fields:
        return jsonify({"error": f"Missing required fields: {', '.join(missing_fields)}"}), 400

    db = get_db()
    cursor = db.cursor()
    try:
        cursor.execute(
            """INSERT INTO comments
               (game_id, created_by_user_id, comment_text, rating)
               VALUES (%s, %s, %s, %s)""", 
            (
                data[id],
                data["created_by_user_id"],
                data["comment_text"],
                data["rating"]
            ),
        )
        db.commit()
        return jsonify({"message": "Tag added"}), 200
    except Error as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 400
    finally:
        cursor.close()

@games_routes.route("/games/<id>/comments", methods=["DELETE"])
def delete_all_comments_from_game(id):
	cursor = get_db().cursor
	cursor.execute('DELETE FROM comments WHERE game_id = {0})'.format(id))
	the_response = jsonify({"message": "All Comments deleted from Game"}), 200
	return the_response

# TODO: Should we change the comments tables to a weak entity?
@games_routes.route("/comments/<id>", methods=["GET"])
def get_comment(id):
	cursor = get_db().cursor(dictionary = True)
	cursor.execute('SELECT * FROM comments WHERE comment_id = {0})'.format(id))
	the_data = cursor.fetchall()
	the_response = make_response(the_data)
	return the_response 

@games_routes.route("/comments/<id>/rating", methods=["GET"])
def get_comment_rating(id):
	cursor = get_db().cursor(dictionary = True)
	cursor.execute('SELECT rating FROM comments WHERE comment_id = {0})'.format(id))
	the_data = cursor.fetchall()
	the_response = make_response(the_data)
	return the_response 

@games_routes.route("/comments/<id>", methods=["PUT"])
def update_comment(id):
    data = _request_data()
    db = get_db()
    cursor = db.cursor()

    allowed_fields = (
        "comment_text",
        "rating"
    )
    
    try: 
         fields = []
         values = []
         for column in allowed_fields:
              if column in data:
                   fields.append(f"{column} = %s")
                   values.append(data[column])
         if not fields: return jsonify({"error": "No fields to update"}), 400
         values.append(id)
         cursor.execute(
            """UPDATE comments SET {', '.join(fields)} WHERE comment_id = %s""",
            values,
        )
         db.commit()
         return jsonify({"message": "Rating Updated"}), 200
    except Error as exc:
        db.rollback()
        return jsonify({"error": str(exc)}), 400
    finally:
        cursor.close()
    

@games_routes.route("/comments/<id>", methods=["DELETE"])
def delete_comment(id):
	cursor = get_db().cursor
	cursor.execute('DELETE FROM comments WHERE comment_id = {0})'.format(id))
	the_response = jsonify({"message": "Comment deleted"}), 200
	return the_response 





