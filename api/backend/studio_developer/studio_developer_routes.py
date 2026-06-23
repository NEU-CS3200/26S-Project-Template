from flask import Blueprint, request, jsonify
from backend.db_connection import get_db

studio_developer_routes = Blueprint("studio_developer_routes", __name__)

# /studios/<id>

@studio_developer_routes.route("/studios/<int:studio_id>", methods=["GET"])
def get_studio(studio_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        query = """
            SELECT
                studio_id,
                studio_name,
                headquarters_region,
                created_at
            FROM studios
            WHERE studio_id = %s
        """
        cursor.execute(query, (studio_id,))
        studio = cursor.fetchone()

        if not studio:
            return jsonify({"error": "Studio not found"}), 404

        return jsonify(studio), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


@studio_developer_routes.route("/studios/<int:studio_id>", methods=["PUT"])
def update_studio(studio_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        data = request.get_json()

        if not data:
            return jsonify({"error": "Request body is required"}), 400

        studio_name = data.get("studio_name")
        headquarters_region = data.get("headquarters_region")

        if studio_name is None and headquarters_region is None:
            return jsonify({
                "error": "At least one of studio_name or headquarters_region must be provided"
            }), 400

        # keep existing values if one field is omitted
        select_query = """
            SELECT studio_name, headquarters_region
            FROM studios
            WHERE studio_id = %s
        """
        cursor.execute(select_query, (studio_id,))
        existing = cursor.fetchone()

        if not existing:
            return jsonify({"error": "Studio not found"}), 404

        new_name = studio_name if studio_name is not None else existing["studio_name"]
        new_region = (
            headquarters_region
            if headquarters_region is not None
            else existing["headquarters_region"]
        )

        update_query = """
            UPDATE studios
            SET
                studio_name = %s,
                headquarters_region = %s
            WHERE studio_id = %s
        """
        cursor.execute(update_query, (new_name, new_region, studio_id))
        get_db().commit()

        return jsonify({"message": "Studio updated successfully"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


@studio_developer_routes.route("/studios/<int:studio_id>", methods=["DELETE"])
def delete_studio(studio_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        query = """
            DELETE FROM studios
            WHERE studio_id = %s
        """
        cursor.execute(query, (studio_id,))
        get_db().commit()

        if cursor.rowcount == 0:
            return jsonify({"error": "Studio not found"}), 404

        return jsonify({"message": "Studio deleted successfully"}), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


# /studios/<id>/games

@studio_developer_routes.route("/studios/<int:studio_id>/games", methods=["GET"])
def get_studio_games(studio_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        # optional: verify studio exists first
        studio_query = """
            SELECT studio_id
            FROM studios
            WHERE studio_id = %s
        """
        cursor.execute(studio_query, (studio_id,))
        studio = cursor.fetchone()

        if not studio:
            return jsonify({"error": "Studio not found"}), 404

        games_query = """
            SELECT
                game_id,
                title,
                description,
                genre,
                platform,
                release_year,
                average_rating,
                lifecycle_status,
                published_by_studio_id,
                created_at,
                updated_at
            FROM games
            WHERE published_by_studio_id = %s
            ORDER BY title
        """
        cursor.execute(games_query, (studio_id,))
        games = cursor.fetchall()

        return jsonify(games), 200

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()


@studio_developer_routes.route("/studios/<int:studio_id>/games", methods=["POST"])
def create_studio_game(studio_id):
    cursor = get_db().cursor(dictionary=True)

    try:
        data = request.get_json()

        if not data:
            return jsonify({"error": "Request body is required"}), 400

        required_fields = [
            "title",
            "description",
            "genre",
            "platform",
            "release_year"
        ]

        for field in required_fields:
            if field not in data:
                return jsonify({"error": f"Missing required field: {field}"}), 400

        # optional: verify studio exists first
        studio_query = """
            SELECT studio_id
            FROM studios
            WHERE studio_id = %s
        """
        cursor.execute(studio_query, (studio_id,))
        studio = cursor.fetchone()

        if not studio:
            return jsonify({"error": "Studio not found"}), 404

        insert_query = """
            INSERT INTO games (
                title,
                description,
                genre,
                platform,
                release_year,
                average_rating,
                lifecycle_status,
                published_by_studio_id
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """
        cursor.execute(
            insert_query,
            (
                data["title"],
                data["description"],
                data["genre"],
                data["platform"],
                data["release_year"],
                data.get("average_rating", 0.00),
                data.get("lifecycle_status", "active"),
                studio_id
            )
        )
        get_db().commit()

        return jsonify({
            "message": "Game created successfully",
            "game_id": cursor.lastrowid
        }), 201

    except Exception as e:
        return jsonify({"error": str(e)}), 500

    finally:
        cursor.close()