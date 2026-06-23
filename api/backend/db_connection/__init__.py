import mysql.connector
from flask import current_app, g


def get_db():
    """
    Get a database connection for the current application.
    If it doesn't exist yet, create a new one and store it in application context.

    Returns:
        A MySQL database connection object.
    """
    if "db" not in g:
        g.db = mysql.connector.connect(
            host=current_app.config["MYSQL_DATABASE_HOST"],
            user=current_app.config["MYSQL_DATABASE_USER"],
            password=current_app.config["MYSQL_DATABASE_PASSWORD"],
            database=current_app.config["MYSQL_DATABASE_DB"],
            port=current_app.config["MYSQL_DATABASE_PORT"],
        )
    return g.db


def close_db(e=None):
    db = g.pop("db", None)
    if db is not None:
        db.close()


def init_app(app):
    app.teardown_appcontext(close_db)
