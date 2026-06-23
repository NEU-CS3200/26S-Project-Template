import logging
import os

from dotenv import load_dotenv
from flask import Flask

from backend.db_connection import init_app as init_db
from backend.system.system_routes import system_routes
from backend.studio_developer.studio_developer_routes import studio_developer_routes
from backend.users.users_routes import users_routes
from backend.games.games_routes import games_routes


def create_app():
    app = Flask(__name__)

    app.logger.setLevel(logging.DEBUG)
    app.logger.info("API startup")

    load_dotenv()

    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

    app.config["MYSQL_DATABASE_USER"] = os.getenv("DB_USER").strip()
    app.config["MYSQL_DATABASE_PASSWORD"] = os.getenv("MYSQL_ROOT_PASSWORD").strip()
    app.config["MYSQL_DATABASE_HOST"] = os.getenv("DB_HOST").strip()
    app.config["MYSQL_DATABASE_PORT"] = int(os.getenv("DB_PORT").strip())
    app.config["MYSQL_DATABASE_DB"] = os.getenv("DB_NAME").strip()

    app.logger.info("create_app(): initializing database connection")
    init_db(app)

    app.logger.info("create_app(): registering blueprints")
    app.register_blueprint(system_routes)
    app.register_blueprint(studio_developer_routes)
    app.register_blueprint(users_routes)
    app.register_blueprint(games_routes)

    return app
