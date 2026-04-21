from __future__ import annotations

from flask import current_app, g, request
from mysql.connector import Error as MySQLError

from backend.db_connection import db
from backend.northstar.responses import (
    database_error,
    internal_error,
    success,
    validation_error,
)
from backend.northstar.validation import (
    EMPTY_SCHEMA,
    ValidationError,
    ensure_no_body,
    validate_json_body,
    validate_mapping,
)


NO_BODY = object()


class QueryPayloadError(Exception):
    pass


def handle_request(
    *,
    endpoint,
    method,
    handler,
    path_values=None,
    path_schema=None,
    query_schema=None,
    body_schema=NO_BODY,
):
    try:
        validated = {}

        if path_schema is not None:
            validated["path"] = validate_mapping(path_values or {}, path_schema)

        active_query_schema = query_schema or EMPTY_SCHEMA
        validated["query"] = validate_mapping(
            request.args.to_dict(flat=True),
            active_query_schema,
        )

        if body_schema is NO_BODY:
            ensure_no_body(request)
        else:
            validated["body"] = validate_json_body(request, body_schema)

        query_payload = handler(validated)
        response_payload, should_commit = execute_query_payload(query_payload)
        if should_commit:
            db.commit()
        return success(response_payload, status=_success_status(method))
    except ValidationError as exc:
        return validation_error(exc.errors)
    except QueryPayloadError as exc:
        _rollback_db()
        return internal_error(str(exc), endpoint=endpoint, method=method)
    except MySQLError as exc:
        _rollback_db()
        current_app.logger.exception(
            "Database execution failed for %s %s",
            method,
            endpoint,
        )
        return database_error(exc, endpoint=endpoint, method=method)


def execute_query_payload(query_payload):
    if not isinstance(query_payload, dict):
        raise QueryPayloadError("Endpoint handler returned an invalid query payload.")

    if "queries" in query_payload:
        queries = query_payload["queries"]
        if not isinstance(queries, (list, tuple)):
            raise QueryPayloadError("Multi-query payloads must include a query list.")

        results = []
        should_commit = False
        for query in queries:
            result, query_should_commit = _execute_query(query)
            results.append(result)
            should_commit = should_commit or query_should_commit
        return {"results": results}, should_commit

    result, should_commit = _execute_query(query_payload)
    return _single_query_response(result), should_commit


def _execute_query(query):
    query = _validate_query(query)
    cursor = db.cursor(dictionary=True)
    try:
        cursor.execute(query["sql"], query["params"])

        if cursor.description is not None:
            rows = cursor.fetchall()
            result = {
                "rows": rows,
                "row_count": len(rows),
            }
            if query.get("name"):
                result["name"] = query["name"]
            return result, False

        result = {
            "affected_rows": cursor.rowcount,
        }
        if query.get("name"):
            result["name"] = query["name"]
        if cursor.lastrowid:
            result["last_insert_id"] = cursor.lastrowid
        return result, True
    finally:
        cursor.close()


def _validate_query(query):
    if not isinstance(query, dict):
        raise QueryPayloadError("Each query payload must be an object.")

    sql = query.get("sql")
    if not isinstance(sql, str) or not sql.strip():
        raise QueryPayloadError("Each query payload must include a non-empty SQL string.")

    params = query.get("params", [])
    if params is None:
        params = []
    if not isinstance(params, (list, tuple)):
        raise QueryPayloadError("Query params must be a list or tuple.")

    return {
        "sql": sql.strip(),
        "params": list(params),
        "name": query.get("name"),
    }


def _single_query_response(result):
    if "rows" in result:
        return result["rows"]
    return result


def _success_status(method):
    if method.upper() == "POST":
        return 201
    return 200


def _rollback_db():
    connection = g.get("db")
    if connection is None:
        return

    try:
        connection.rollback()
    except Exception:
        current_app.logger.exception("Database rollback failed.")
