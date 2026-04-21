from backend.northstar.endpoint_utils import (
    build_where,
    collect_fields,
    insert_payload,
    select_payload,
)


VENDOR_CREATE_FIELDS = ["vendor_name", "last_active_date", "is_active"]


def get_vendors(validated):
    filters = build_where(
        validated["query"],
        equals={"is_active": "v.is_active"},
        comparisons={"last_active_since": ("v.last_active_date", ">=")},
    )
    sql = """
        SELECT
            v.vendor_id,
            v.vendor_name,
            v.last_active_date,
            v.is_active
        FROM Vendor v
    """
    return select_payload(sql, filters=filters, order_by="v.vendor_name")


def post_vendors(validated):
    values = collect_fields(validated["body"], VENDOR_CREATE_FIELDS)
    values.setdefault("is_active", True)
    return insert_payload("Vendor", values)
