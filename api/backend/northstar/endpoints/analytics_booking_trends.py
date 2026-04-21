from backend.northstar.endpoint_utils import select_payload


def get_analytics_booking_trends(validated):
    sql = """
        SELECT
            DATE_FORMAT(b.booking_date, '%Y-%m') AS booking_month,
            b.booking_status,
            COUNT(*) AS booking_count
        FROM Booking b
    """
    return select_payload(
        sql,
        group_by="DATE_FORMAT(b.booking_date, '%Y-%m'), b.booking_status",
        order_by="booking_month DESC, b.booking_status",
    )
