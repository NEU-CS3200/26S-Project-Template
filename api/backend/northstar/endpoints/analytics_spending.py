from backend.northstar.endpoint_utils import select_payload


def get_analytics_spending(validated):
    sql = """
        SELECT
            COUNT(DISTINCT t.trip_id) AS trip_count,
            AVG(t.total_spent) AS average_spend_per_trip,
            SUM(t.total_spent) AS total_spend,
            AVG(
                CASE
                    WHEN t.group_size > 0 THEN t.total_spent / t.group_size
                    ELSE NULL
                END
            ) AS average_spend_per_traveler
        FROM Trip t
    """
    return select_payload(sql)
