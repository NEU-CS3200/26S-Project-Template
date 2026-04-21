from backend.northstar.endpoint_utils import select_payload


def get_analytics_destinations(validated):
    sql = """
        SELECT
            t.destination,
            t.trip_type,
            COUNT(DISTINCT t.trip_id) AS trip_count,
            COUNT(DISTINCT b.booking_id) AS booking_volume,
            COALESCE(SUM(l.price), 0) AS estimated_revenue_total
        FROM Trip t
        LEFT JOIN Booking b ON b.trip_id = t.trip_id
        LEFT JOIN Listing l ON l.listing_id = b.listing_id
    """
    return select_payload(
        sql,
        group_by="t.destination, t.trip_type",
        order_by="trip_count DESC, estimated_revenue_total DESC",
    )
