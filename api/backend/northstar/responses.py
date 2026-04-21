from __future__ import annotations

from datetime import date, datetime
from decimal import Decimal

from flask import jsonify


def _make_json_safe(value):
    if isinstance(value, dict):
        return {key: _make_json_safe(item) for key, item in value.items()}
    if isinstance(value, list):
        return [_make_json_safe(item) for item in value]
    if isinstance(value, tuple):
        return [_make_json_safe(item) for item in value]
    if isinstance(value, (date, datetime)):
        return value.isoformat()
    if isinstance(value, Decimal):
        return str(value)
    return value


def validation_error(errors):
    payload = {
        "error": "validation_failed",
        "details": _make_json_safe(errors),
    }
    return jsonify(payload), 400


def success(payload, status=200):
    return jsonify(_make_json_safe(payload)), status


def database_error(error, *, endpoint=None, method=None):
    payload = {
        "error": "database_error",
        "message": str(error),
    }
    if endpoint:
        payload["endpoint"] = endpoint
    if method:
        payload["method"] = method
    return jsonify(_make_json_safe(payload)), 500


def internal_error(message, *, endpoint=None, method=None):
    payload = {
        "error": "internal_error",
        "message": message,
    }
    if endpoint:
        payload["endpoint"] = endpoint
    if method:
        payload["method"] = method
    return jsonify(payload), 500


def not_implemented(endpoint, method, validated_input, query_payload):
    payload = {
        "error": "not_implemented",
        "message": "Request validation passed, but database execution is not implemented yet.",
        "endpoint": endpoint,
        "method": method,
        "validated_input": _make_json_safe(validated_input),
    }
    payload.update(_make_json_safe(query_payload or {}))
    return jsonify(payload), 501
