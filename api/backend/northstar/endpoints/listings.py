from backend.northstar.endpoint_utils import (
    build_where,
    collect_fields,
    insert_payload,
    select_payload,
)


LISTING_CREATE_FIELDS = [
    "vendor_id",
    "service_category",
    "price",
    "availability",
    "operating_hours",
    "description",
    "promotional_notes",
    "listing_status",
    "traveler_rating",
    "is_active",
]


def get_listings(validated):
    filters = build_where(
        validated["query"],
        equals={
            "service_category": "l.service_category",
            "vendor_id": "l.vendor_id",
            "availability": "l.availability",
            "listing_status": "l.listing_status",
            "is_active": "l.is_active",
        },
        comparisons={
            "min_price": ("l.price", ">="),
            "max_price": ("l.price", "<="),
            "min_rating": ("l.traveler_rating", ">="),
        },
    )
    sql = """
        SELECT
            l.listing_id,
            l.vendor_id,
            v.vendor_name,
            l.service_category,
            l.price,
            l.traveler_rating,
            l.listing_status,
            l.availability,
            l.operating_hours,
            l.description,
            l.promotional_notes,
            l.is_active
        FROM Listing l
        JOIN Vendor v ON v.vendor_id = l.vendor_id
    """
    return select_payload(sql, filters=filters, order_by="l.service_category, l.listing_id")


def post_listings(validated):
    values = collect_fields(validated["body"], LISTING_CREATE_FIELDS)
    values.setdefault("is_active", True)
    return insert_payload("Listing", values)
