from backend.northstar.endpoint_utils import (
    collect_fields,
    deactivate_payload,
    select_payload,
    update_payload,
)


LISTING_UPDATE_FIELDS = [
    "availability",
    "operating_hours",
    "price",
    "service_category",
    "description",
    "promotional_notes",
    "listing_status",
    "traveler_rating",
    "is_active",
]


def get_listing_detail(validated):
    listing_id = validated["path"]["listing_id"]
    sql = """
        SELECT
            l.listing_id,
            l.vendor_id,
            v.vendor_name,
            l.price,
            l.traveler_rating,
            l.listing_status,
            l.service_category,
            l.availability,
            l.operating_hours,
            l.description,
            l.promotional_notes,
            l.is_active
        FROM Listing l
        JOIN Vendor v ON v.vendor_id = l.vendor_id
    """
    return select_payload(sql, filters=(["l.listing_id = %s"], [listing_id]))


def put_listing_detail(validated):
    listing_id = validated["path"]["listing_id"]
    values = collect_fields(validated["body"], LISTING_UPDATE_FIELDS)
    return update_payload(
        "Listing",
        values,
        where_clause="listing_id = %s",
        where_params=[listing_id],
    )


def delete_listing_detail(validated):
    listing_id = validated["path"]["listing_id"]
    return deactivate_payload(
        "Listing",
        where_clause="listing_id = %s",
        where_params=[listing_id],
    )
