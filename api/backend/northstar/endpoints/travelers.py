from backend.northstar.endpoint_utils import (
    build_where,
    collect_fields,
    insert_payload,
    select_payload,
)


TRAVELER_CREATE_FIELDS = [
    "first_name",
    "last_name",
    "phone",
    "email",
    "availability",
    "traveler_status",
    "is_active",
]


def get_travelers(validated):
    filters = build_where(
        validated["query"],
        equals={
            "is_active": "t.is_active",
            "availability": "t.availability",
            "traveler_status": "t.traveler_status",
        },
    )
    sql = """
        SELECT
            t.traveler_id,
            t.first_name,
            t.last_name,
            t.phone,
            t.email,
            t.availability,
            t.traveler_status,
            t.is_active
        FROM Traveler t
    """
    return select_payload(sql, filters=filters, order_by="t.last_name, t.first_name")


def post_travelers(validated):
    values = collect_fields(validated["body"], TRAVELER_CREATE_FIELDS)
    values.setdefault("is_active", True)
    return insert_payload("Traveler", values)
