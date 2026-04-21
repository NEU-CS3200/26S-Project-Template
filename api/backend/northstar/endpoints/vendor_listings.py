from backend.northstar.endpoint_utils import collect_fields, insert_payload, select_payload


VENDOR_LISTING_FIELDS = [
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


def get_vendor_listings(validated):
    vendor_id = validated["path"]["vendor_id"]
    query = validated["query"]
    columns = [
        "l.listing_id",
        "l.vendor_id",
        "l.service_category",
        "l.price",
        "l.traveler_rating",
        "l.listing_status",
        "l.availability",
        "l.operating_hours",
        "l.description",
        "l.promotional_notes",
        "l.is_active",
    ]
    joins = []
    group_by = None

    if query.get("include_booking_totals") or query.get("include_status_counts"):
        joins.append("LEFT JOIN Booking b ON b.listing_id = l.listing_id")
        columns.append("COUNT(DISTINCT b.booking_id) AS booking_total")
        if query.get("include_status_counts"):
            columns.append(
                "SUM(CASE WHEN b.booking_status = 'Pending' THEN 1 ELSE 0 END) AS pending_count"
            )
            columns.append(
                "SUM(CASE WHEN b.booking_status = 'Confirmed' THEN 1 ELSE 0 END) AS confirmed_count"
            )
        group_by = (
            "l.listing_id, l.vendor_id, l.service_category, l.price, l.traveler_rating, "
            "l.listing_status, l.availability, l.operating_hours, l.description, "
            "l.promotional_notes, l.is_active"
        )

    if query.get("include_interest_metrics"):
        joins.append("LEFT JOIN Traveler_Vote tv ON tv.listing_id = l.listing_id")
        columns.append("COUNT(DISTINCT tv.traveler_id) AS interested_traveler_count")
        columns.append("COALESCE(SUM(tv.vote_value), 0) AS interest_score")
        group_by = (
            "l.listing_id, l.vendor_id, l.service_category, l.price, l.traveler_rating, "
            "l.listing_status, l.availability, l.operating_hours, l.description, "
            "l.promotional_notes, l.is_active"
        )

    sql = "SELECT\n            " + ",\n            ".join(columns) + "\n        FROM Listing l"
    if joins:
        sql += "\n        " + "\n        ".join(joins)

    return select_payload(
        sql,
        filters=(["l.vendor_id = %s"], [vendor_id]),
        group_by=group_by,
        order_by="l.listing_id",
    )


def post_vendor_listings(validated):
    vendor_id = validated["path"]["vendor_id"]
    values = collect_fields(validated["body"], VENDOR_LISTING_FIELDS)
    values["vendor_id"] = vendor_id
    values.setdefault("is_active", True)
    return insert_payload("Listing", values)
