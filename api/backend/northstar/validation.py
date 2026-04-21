from __future__ import annotations

from datetime import date
from decimal import Decimal, InvalidOperation


class ValidationError(Exception):
    def __init__(self, errors):
        super().__init__("Validation failed.")
        self.errors = errors


def schema(required=None, optional=None, at_least_one=None, rules=None):
    return {
        "required": required or {},
        "optional": optional or {},
        "at_least_one": at_least_one or [],
        "rules": rules or [],
    }


def string_field(*, allow_blank=False):
    return {"type": "string", "allow_blank": allow_blank}


def int_field(*, min_value=None, max_value=None):
    return {"type": "int", "min_value": min_value, "max_value": max_value}


def bool_field():
    return {"type": "bool"}


def decimal_field(*, min_value=None, max_value=None):
    return {"type": "decimal", "min_value": min_value, "max_value": max_value}


def date_field():
    return {"type": "date"}


def enum_field(*choices):
    return {"type": "enum", "choices": set(choices)}


def list_field(item_spec, *, min_items=1):
    return {"type": "list", "items": item_spec, "min_items": min_items}


def object_field(object_schema):
    return {"type": "object", "schema": object_schema}


EMPTY_SCHEMA = schema()


def date_order_rule(start_field, end_field):
    def _rule(values, prefix):
        if start_field in values and end_field in values:
            if values[start_field] > values[end_field]:
                return {
                    _join_path(prefix, end_field): (
                        f"'{end_field}' must be on or after '{start_field}'."
                    )
                }
        return {}

    return _rule


def must_be_true_rule(field_name):
    def _rule(values, prefix):
        if field_name in values and values[field_name] is not True:
            return {
                _join_path(prefix, field_name): f"'{field_name}' must be true."
            }
        return {}

    return _rule


def validate_mapping(data, object_schema, prefix=""):
    if not isinstance(data, dict):
        label = prefix or "payload"
        raise ValidationError({label: "Expected a JSON object."})

    required_fields = object_schema.get("required", {})
    optional_fields = object_schema.get("optional", {})
    allowed_fields = set(required_fields) | set(optional_fields)
    errors = {}
    validated = {}

    for key in data:
        if key not in allowed_fields:
            errors[_join_path(prefix, key)] = "Unknown field."

    for key, spec in required_fields.items():
        value = data.get(key)
        if value is None or (isinstance(value, str) and not value.strip()):
            errors[_join_path(prefix, key)] = "Field is required."

    combined_fields = {**required_fields, **optional_fields}
    for key, spec in combined_fields.items():
        if key not in data:
            continue
        try:
            validated[key] = _validate_value(
                data[key],
                spec,
                _join_path(prefix, key),
            )
        except ValidationError as exc:
            errors.update(exc.errors)

    if object_schema.get("at_least_one"):
        present_fields = [key for key in object_schema["at_least_one"] if key in data]
        if not present_fields:
            key = prefix or "body"
            errors[key] = (
                "At least one of the following fields is required: "
                + ", ".join(object_schema["at_least_one"])
            )

    for rule in object_schema.get("rules", []):
        errors.update(rule(validated, prefix))

    if errors:
        raise ValidationError(errors)

    return validated


def validate_json_body(request, object_schema):
    raw_body = request.get_data(cache=True)
    if not raw_body or not raw_body.strip():
        raise ValidationError({"body": "A JSON object body is required."})

    data = request.get_json(silent=True)
    if data is None:
        raise ValidationError({"body": "Request body must contain valid JSON."})
    if not isinstance(data, dict):
        raise ValidationError({"body": "Request body must be a JSON object."})

    return validate_mapping(data, object_schema)


def ensure_no_body(request):
    raw_body = request.get_data(cache=True)
    if raw_body and raw_body.strip():
        raise ValidationError({"body": "This endpoint does not accept a request body."})


def _validate_value(value, spec, key):
    field_type = spec["type"]

    if field_type == "string":
        if not isinstance(value, str):
            raise ValidationError({key: "Expected a string."})
        cleaned = value.strip()
        if not spec.get("allow_blank") and not cleaned:
            raise ValidationError({key: "Value cannot be blank."})
        return cleaned

    if field_type == "int":
        parsed = _coerce_int(value, key)
        min_value = spec.get("min_value")
        max_value = spec.get("max_value")
        if min_value is not None and parsed < min_value:
            raise ValidationError({key: f"Value must be at least {min_value}."})
        if max_value is not None and parsed > max_value:
            raise ValidationError({key: f"Value must be at most {max_value}."})
        return parsed

    if field_type == "bool":
        return _coerce_bool(value, key)

    if field_type == "decimal":
        parsed = _coerce_decimal(value, key)
        min_value = spec.get("min_value")
        max_value = spec.get("max_value")
        if min_value is not None and parsed < Decimal(str(min_value)):
            raise ValidationError({key: f"Value must be at least {min_value}."})
        if max_value is not None and parsed > Decimal(str(max_value)):
            raise ValidationError({key: f"Value must be at most {max_value}."})
        return parsed

    if field_type == "date":
        if not isinstance(value, str):
            raise ValidationError({key: "Expected an ISO date string."})
        try:
            return date.fromisoformat(value)
        except ValueError as exc:
            raise ValidationError({key: "Expected a date in YYYY-MM-DD format."}) from exc

    if field_type == "enum":
        if not isinstance(value, str):
            raise ValidationError({key: "Expected a string value."})
        cleaned = value.strip()
        if cleaned not in spec["choices"]:
            choices = ", ".join(sorted(spec["choices"]))
            raise ValidationError({key: f"Expected one of: {choices}."})
        return cleaned

    if field_type == "list":
        if not isinstance(value, list):
            raise ValidationError({key: "Expected an array."})
        min_items = spec.get("min_items", 0)
        if len(value) < min_items:
            raise ValidationError(
                {key: f"Expected at least {min_items} item(s)."}
            )
        return [
            _validate_value(item, spec["items"], f"{key}[{index}]")
            for index, item in enumerate(value)
        ]

    if field_type == "object":
        if not isinstance(value, dict):
            raise ValidationError({key: "Expected an object."})
        return validate_mapping(value, spec["schema"], prefix=key)

    raise ValidationError({key: f"Unsupported field type '{field_type}'."})


def _coerce_int(value, key):
    if isinstance(value, bool):
        raise ValidationError({key: "Expected an integer."})
    if isinstance(value, int):
        return value
    if isinstance(value, str):
        cleaned = value.strip()
        if cleaned.lstrip("-").isdigit():
            return int(cleaned)
    raise ValidationError({key: "Expected an integer."})


def _coerce_bool(value, key):
    if isinstance(value, bool):
        return value
    if isinstance(value, str):
        cleaned = value.strip().lower()
        if cleaned in {"true", "1", "yes"}:
            return True
        if cleaned in {"false", "0", "no"}:
            return False
    raise ValidationError({key: "Expected a boolean value."})


def _coerce_decimal(value, key):
    if isinstance(value, bool):
        raise ValidationError({key: "Expected a decimal value."})
    try:
        return Decimal(str(value))
    except (InvalidOperation, ValueError, TypeError) as exc:
        raise ValidationError({key: "Expected a decimal value."}) from exc


def _join_path(prefix, field):
    if not prefix:
        return field
    if field.startswith("["):
        return f"{prefix}{field}"
    return f"{prefix}.{field}"
