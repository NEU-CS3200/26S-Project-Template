from backend.northstar.endpoint_utils import make_query, multi_query, select_payload


def get_trip_itinerary(validated):
    trip_id = validated["path"]["trip_id"]
    include_inactive = validated["query"].get("include_inactive", False)
    clauses = ["b.trip_id = %s"]
    params = [trip_id]
    if not include_inactive:
        clauses.append("b.is_active = %s")
        params.append(True)

    sql = """
        SELECT
            b.booking_id,
            b.booking_date,
            b.booking_status,
            b.is_active,
            l.listing_id,
            l.service_category,
            l.description,
            l.price,
            v.vendor_id,
            v.vendor_name,
            p.promotion_id,
            p.title AS promotion_title,
            p.discount_value
        FROM Booking b
        JOIN Listing l ON l.listing_id = b.listing_id
        JOIN Vendor v ON v.vendor_id = b.vendor_id
        LEFT JOIN Promotion p ON p.promotion_id = b.promotion_id
    """
    return select_payload(sql, filters=(clauses, params), order_by="b.booking_date, b.booking_id")


def put_trip_itinerary(validated):
    trip_id = validated["path"]["trip_id"]
    queries = []
    for index, item in enumerate(validated["body"]["items"], start=1):
        queries.append(
            make_query(
                """
                /* TODO: add explicit itinerary sequencing support to the schema. */
                UPDATE Booking
                SET booking_date = booking_date
                WHERE trip_id = %s AND booking_id = %s
                """,
                [trip_id, item["booking_id"]],
                name=f"itinerary_item_{index}",
            )
        )
    return multi_query(
        queries,
        notes=[
            "The current DDL does not model itinerary sequence explicitly, so this is a placeholder reorder scaffold.",
        ],
    )
