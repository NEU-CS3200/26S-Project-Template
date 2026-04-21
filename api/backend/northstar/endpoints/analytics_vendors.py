from backend.northstar.endpoint_utils import select_payload


def get_analytics_vendors(validated):
    sql = """
        SELECT
            v.vendor_id,
            v.vendor_name,
            l.service_category,
            COUNT(DISTINCT b.booking_id) AS booking_frequency,
            AVG(l.traveler_rating) AS average_traveler_rating,
            v.last_active_date
        FROM Vendor v
        LEFT JOIN Listing l ON l.vendor_id = v.vendor_id
        LEFT JOIN Booking b ON b.vendor_id = v.vendor_id
    """
    return select_payload(
        sql,
        group_by="v.vendor_id, v.vendor_name, l.service_category, v.last_active_date",
        order_by="booking_frequency DESC, average_traveler_rating DESC",
    )
