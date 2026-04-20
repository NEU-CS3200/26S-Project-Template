from flask import Flask
from dotenv import load_dotenv
import os
import logging

from backend.db_connection import init_app as init_db
from backend.venues.venue_routes import venues
from backend.categories.category_routes import categories
from backend.vibes.vibe_routes import vibes
from backend.reviews.review_routes import reviews
from backend.users.user_routes import users
from backend.lists.list_routes import lists
from backend.posts.post_routes import posts
from backend.applications.application_routes import applications
from backend.tickets.ticket_routes import tickets
from backend.admin_log.log_routes import admin_log
from backend.analytics.analytics_routes import analytics


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
    app.register_blueprint(venues,       url_prefix='/venues')
    app.register_blueprint(categories,   url_prefix='/categories')
    app.register_blueprint(vibes,        url_prefix='/vibes')
    app.register_blueprint(reviews,      url_prefix='/reviews')
    app.register_blueprint(users,        url_prefix='/users')
    app.register_blueprint(lists,        url_prefix='/lists')
    app.register_blueprint(posts,        url_prefix='/posts')
    app.register_blueprint(applications, url_prefix='/applications')
    app.register_blueprint(tickets,      url_prefix='/tickets')
    app.register_blueprint(admin_log,    url_prefix='/log')
    app.register_blueprint(analytics,    url_prefix='/analytics')

    return app
