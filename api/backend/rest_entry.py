import logging
import os

from dotenv import load_dotenv
from flask import Flask

from backend.db_connection import init_app as init_db
from backend.courts.court_routes import courts
from backend.players.player_routes import players
from backend.tournaments.tournament_routes import tournaments_bp
from backend.analytics.analytics_routes import analytics


def create_app():
    app = Flask(__name__)

    app.logger.setLevel(logging.DEBUG)
    app.logger.info("API startup")

    # Load environment variables from the .env file so they are
    # accessible via os.getenv() below.
    load_dotenv()

    # Secret key used by Flask for securely signing session cookies.
    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

    # Database connection settings — values come from the .env file.
    app.config["MYSQL_DATABASE_USER"] = os.getenv("DB_USER").strip()
    app.config["MYSQL_DATABASE_PASSWORD"] = os.getenv("MYSQL_ROOT_PASSWORD").strip()
    app.config["MYSQL_DATABASE_HOST"] = os.getenv("DB_HOST").strip()
    app.config["MYSQL_DATABASE_PORT"] = int(os.getenv("DB_PORT").strip())
    app.config["MYSQL_DATABASE_DB"] = os.getenv("DB_NAME").strip()

    # Register the cleanup hook for the database connection.
    app.logger.info("create_app(): initializing database connection")
    init_db(app)

    # Register the routes from each Blueprint with the app object
    # and give a url prefix to each.
    app.logger.info("create_app(): registering blueprints")
    app.register_blueprint(courts,         url_prefix="/court")
    app.register_blueprint(players,        url_prefix="/player")
    app.register_blueprint(tournaments_bp, url_prefix="/tournament")
    app.register_blueprint(analytics,      url_prefix="/analytics")

    return app
