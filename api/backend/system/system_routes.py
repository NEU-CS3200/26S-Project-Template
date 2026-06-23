from flask import Blueprint, current_app, jsonify

from backend.db_connection import get_db

system_routes = Blueprint("system_routes", __name__)

@system_routes.route("/", methods=["GET"])
def welcome():
    current_app.logger.info("GET /")
    return jsonify({
        "service": "GameGoats API",
        "status": "ok",
        "docs": "/api/scope",
    }), 200


@system_routes.route("/health", methods=["GET"])
def health():
    return jsonify({"status": "healthy"}), 200


@system_routes.route("/health/db", methods=["GET"])
def health_db():
    cursor = get_db().cursor()
    try:
        cursor.execute("SELECT 1")
        value = cursor.fetchone()[0]
        return jsonify({"database": "connected", "ping": value}), 200
    finally:
        cursor.close()


@system_routes.route("/api/scope", methods=["GET"])
def api_scope():
    return jsonify({
        "phase": 1,
        "status": "scope-locked",
        "resources": [
            "games",
            "comments",
            "favorites",
            "recommendations",
            "reports",
            "servers",
            "alerts",
        ],
    }), 200
