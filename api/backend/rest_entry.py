from flask import Flask
from dotenv import load_dotenv
import os
import logging

from backend.db_connection import init_app as init_db
from backend.analytics.analytics_routes import analytics
from backend.simple.simple_routes import simple_routes
from backend.recruiters.recruiter_routes import recruiters
from backend.admin.admin_routes import admin
from backend.alex.alex_routes import alex

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
    
    app.register_blueprint(analytics)
    app.register_blueprint(simple_routes)
    app.register_blueprint(recruiters, url_prefix="/rec")
    app.register_blueprint(admin, url_prefix="/admin")
    app.register_blueprint(alex, url_prefix="/alex")

    return app