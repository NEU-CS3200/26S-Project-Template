from backend.northstar.endpoint_utils import select_payload


def get_analytics_data_quality_trips(validated):
    sql = """
        SELECT
            t.trip_id,
            t.trip_name,
            t.planner_id,
            t.destination,
            t.trip_status,
            t.start_date,
            t.end_date,
            t.group_size,
            CASE
                WHEN t.destination IS NULL OR t.destination = '' THEN 'missing_destination'
                WHEN t.start_date IS NULL OR t.end_date IS NULL THEN 'missing_dates'
                WHEN t.start_date > t.end_date THEN 'invalid_date_range'
                WHEN t.is_active = FALSE AND EXISTS (
                    SELECT 1
                    FROM Booking b
                    WHERE b.trip_id = t.trip_id AND b.is_active = TRUE
                ) THEN 'inactive_trip_with_active_bookings'
                ELSE 'review_required'
            END AS data_quality_issue
        FROM Trip t
        WHERE
            t.destination IS NULL
            OR t.destination = ''
            OR t.start_date IS NULL
            OR t.end_date IS NULL
            OR t.start_date > t.end_date
            OR (
                t.is_active = FALSE AND EXISTS (
                    SELECT 1
                    FROM Booking b
                    WHERE b.trip_id = t.trip_id AND b.is_active = TRUE
                )
            )
    """
    return select_payload(sql, order_by="t.trip_id")
