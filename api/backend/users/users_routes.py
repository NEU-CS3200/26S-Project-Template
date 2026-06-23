from flask import Blueprint, request, jsonify
from backend.db_connection import get_db

users_routes = Blueprint("users_routes", __name__)

# get all fav from user
@users_routes.route("/users/<int:user_id>/favorites", methods=["GET"])
def get_user_favorites(user_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        query = """
            SELECT
                f.favorite_id,
                f.player_user_id,
                f.game_id,
                f.priority,
                f.added_at,
                g.title,
                g.genre,
                g.platform,
                g.release_year,
                g.average_rating
            FROM favorites f
            JOIN games g ON f.game_id = g.game_id
            WHERE f.player_user_id = %s
            ORDER BY f.priority ASC, f.added_at DESC
        """
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()

        return jsonify(results), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()

# add game to fav
@users_routes.route("/users/<int:user_id>/favorites", methods=["POST"])
def add_user_favorite(user_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        data = request.get_json()

        if not data or "game_id" not in data:
            return jsonify({"error": "Missing required field: game_id"}), 400

        priority = data.get("priority", 3)

        query = """
            INSERT INTO favorites (player_user_id, game_id, priority)
            VALUES (%s, %s, %s)
        """
        cursor.execute(query, (user_id, data["game_id"], priority))
        get_db().commit()

        return jsonify({
            "message": "Favorite added",
            "favorite_id": cursor.lastrowid
        }), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()

# remove game from fav
@users_routes.route("/users/<int:user_id>/favorites/<int:game_id>", methods=["DELETE"])
def delete_user_favorite(user_id, game_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        query = """
            DELETE FROM favorites
            WHERE player_user_id = %s AND game_id = %s
        """
        cursor.execute(query, (user_id, game_id))
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Favorite not found"}), 404

        return jsonify({"message": "Favorite removed"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()

# get rec
@users_routes.route("/users/<int:user_id>/recommendations", methods=["GET"])
def get_user_recommendations(user_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        query = """
            SELECT
                r.recommendation_id,
                r.player_user_id,
                r.game_id,
                r.recommendation_reason,
                r.match_score,
                r.is_saved,
                r.recommendation_status,
                r.generated_at,
                g.title,
                g.genre,
                g.average_rating
            FROM recommendations r
            JOIN games g ON r.game_id = g.game_id
            WHERE r.player_user_id = %s
            ORDER BY r.generated_at DESC
        """
        cursor.execute(query, (user_id,))
        results = cursor.fetchall()

        return jsonify(results), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()

# create rec
@users_routes.route("/users/<int:user_id>/recommendations", methods=["POST"])
def create_recommendation(user_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        data = request.get_json()

        required_fields = ["game_id", "recommendation_reason", "match_score"]
        for field in required_fields:
            if not data or field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        query = """
            INSERT INTO recommendations (
                player_user_id,
                game_id,
                recommendation_reason,
                match_score,
                is_saved,
                recommendation_status
            )
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        cursor.execute(query, (
            user_id,
            data["game_id"],
            data["recommendation_reason"],
            data["match_score"],
            data.get("is_saved", False),
            data.get("recommendation_status", "new")
        ))
        get_db().commit()

        return jsonify({
            "message": "Recommendation created",
            "recommendation_id": cursor.lastrowid
        }), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()

# update rec
@users_routes.route("/users/<int:user_id>/recommendations/<int:rec_id>", methods=["PUT"])
def update_recommendation(user_id, rec_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        data = request.get_json()

        if not data:
            return jsonify({"error": "Request body required"}), 400

        query = """
            UPDATE recommendations
            SET
                recommendation_reason = %s,
                match_score = %s,
                is_saved = %s,
                recommendation_status = %s,
                refreshed_at = NOW()
            WHERE recommendation_id = %s
              AND player_user_id = %s
        """
        cursor.execute(query, (
            data.get("recommendation_reason"),
            data.get("match_score"),
            data.get("is_saved"),
            data.get("recommendation_status"),
            rec_id,
            user_id
        ))
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Recommendation not found"}), 404

        return jsonify({"message": "Recommendation updated"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()

# delete rec
@users_routes.route("/users/<int:user_id>/recommendations/<int:rec_id>", methods=["DELETE"])
def delete_recommendation(user_id, rec_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        query = """
            DELETE FROM recommendations
            WHERE recommendation_id = %s
              AND player_user_id = %s
        """
        cursor.execute(query, (rec_id, user_id))
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Recommendation not found"}), 404

        return jsonify({"message": "Recommendation deleted"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()