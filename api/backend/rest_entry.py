from flask import Flask
from dotenv import load_dotenv
import os
import logging

from backend.review.review_routes import review_routes
from backend.db_connection import init_app as init_db
from backend.attendee.attendee_routes import attendee_routes
from backend.event.events_routes import events_routes
from backend.organizer.organizer_routes import organizer_routes
from backend.owner.owner_routes import owner_routes
from backend.performer.performer_routes import performer_routes
from backend.venue.venue_routes import venue_routes


def create_app():
    app = Flask(__name__)

    app.logger.setLevel(logging.DEBUG)
    app.logger.info('API startup')

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
    app.register_blueprint(attendee_routes, url_prefix="/attendee")
    app.register_blueprint(events_routes, url_prefix="/event")
    app.register_blueprint(organizer_routes, url_prefix="/organizer")
    app.register_blueprint(owner_routes, url_prefix="/owner")
    app.register_blueprint(performer_routes, url_prefix="/performer")
    app.register_blueprint(review_routes, url_prefix="/review")
    app.register_blueprint(venue_routes, url_prefix="/venue")
    

    return app
