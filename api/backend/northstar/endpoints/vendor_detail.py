from backend.northstar.endpoint_utils import (
    collect_fields,
    deactivate_payload,
    select_payload,
    update_payload,
)


VENDOR_UPDATE_FIELDS = ["vendor_name", "last_active_date", "is_active"]


def get_vendor_detail(validated):
    vendor_id = validated["path"]["vendor_id"]
    sql = """
        SELECT
            v.vendor_id,
            v.vendor_name,
            v.last_active_date,
            v.is_active,
            COUNT(DISTINCT l.listing_id) AS listing_count,
            COUNT(DISTINCT b.booking_id) AS booking_count
        FROM Vendor v
        LEFT JOIN Listing l ON l.vendor_id = v.vendor_id
        LEFT JOIN Booking b ON b.vendor_id = v.vendor_id
    """
    return select_payload(
        sql,
        filters=(["v.vendor_id = %s"], [vendor_id]),
        group_by="v.vendor_id, v.vendor_name, v.last_active_date, v.is_active",
    )


def put_vendor_detail(validated):
    vendor_id = validated["path"]["vendor_id"]
    values = collect_fields(validated["body"], VENDOR_UPDATE_FIELDS)
    return update_payload(
        "Vendor",
        values,
        where_clause="vendor_id = %s",
        where_params=[vendor_id],
    )


def delete_vendor_detail(validated):
    vendor_id = validated["path"]["vendor_id"]
    return deactivate_payload(
        "Vendor",
        where_clause="vendor_id = %s",
        where_params=[vendor_id],
    )
