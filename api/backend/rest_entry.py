from flask import Flask
from flask.json.provider import DefaultJSONProvider
from dotenv import load_dotenv
from datetime import timedelta
import os
import logging

from backend.db_connection import init_app as init_db
from backend.users.user_routes import users
from backend.reports.report_routes import reports
from backend.locations_tickets.routes import locations_tickets
from backend.analytics.analytics_routes import analytics


# MySQL TIME columns arrive as Python timedelta, which Flask's default
# JSON encoder can't serialize. Render them as HH:MM:SS strings.
class BostonabilityJSONProvider(DefaultJSONProvider):
    def default(self, obj):
        if isinstance(obj, timedelta):
            total = int(obj.total_seconds())
            h, rem = divmod(total, 3600)
            m, s = divmod(rem, 60)
            return f"{h:02d}:{m:02d}:{s:02d}"
        return super().default(obj)


def create_app():
    app = Flask(__name__)
    app.json = BostonabilityJSONProvider(app)

    app.logger.setLevel(logging.DEBUG)
    app.logger.info('API startup')

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
    app.register_blueprint(users, url_prefix="/users")
    app.register_blueprint(reports, url_prefix="/reports")
    app.register_blueprint(locations_tickets)
    app.register_blueprint(analytics, url_prefix="/analytics")

    return app
