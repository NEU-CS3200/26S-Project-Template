from backend.northstar.endpoint_utils import make_query, multi_query, select_payload, update_payload


def get_trip_budget(validated):
    trip_id = validated["path"]["trip_id"]
    queries = [
        select_payload(
            """
            SELECT
                t.trip_id,
                COALESCE(SUM(l.price), 0) AS estimated_total,
                COALESCE(SUM(CASE WHEN b.booking_status = 'Confirmed' THEN l.price ELSE 0 END), 0) AS confirmed_total,
                t.total_spent AS actual_spent
            FROM Trip t
            LEFT JOIN Booking b ON b.trip_id = t.trip_id
            LEFT JOIN Listing l ON l.listing_id = b.listing_id
            """,
            filters=(["t.trip_id = %s"], [trip_id]),
            group_by="t.trip_id, t.total_spent",
            name="budget_summary",
        )
    ]

    if validated["query"].get("include_breakdown"):
        queries.append(
            select_payload(
                """
                SELECT
                    b.booking_id,
                    b.booking_status,
                    l.service_category,
                    l.description,
                    l.price
                FROM Booking b
                JOIN Listing l ON l.listing_id = b.listing_id
                """,
                filters=(["b.trip_id = %s"], [trip_id]),
                order_by="b.booking_id",
                name="booking_breakdown",
            )
        )

    return multi_query(queries)


def put_trip_budget(validated):
    trip_id = validated["path"]["trip_id"]
    body = validated["body"]
    queries = []

    if "actual_spent" in body:
        queries.append(
            update_payload(
                "Trip",
                {"total_spent": body["actual_spent"]},
                where_clause="trip_id = %s",
                where_params=[trip_id],
            )
        )

    if "estimated_total" in body:
        queries.append(
            make_query(
                """
                /* TODO: add durable storage for estimated trip totals. */
                SELECT %s AS estimated_total_placeholder, %s AS trip_id
                """,
                [body["estimated_total"], trip_id],
                name="estimated_total_placeholder",
            )
        )

    if "confirmed_total" in body:
        queries.append(
            make_query(
                """
                /* TODO: add durable storage for confirmed trip totals. */
                SELECT %s AS confirmed_total_placeholder, %s AS trip_id
                """,
                [body["confirmed_total"], trip_id],
                name="confirmed_total_placeholder",
            )
        )

    return multi_query(
        queries,
        notes=[
            "The current Trip table persists only total_spent; estimated and confirmed totals remain scaffold placeholders.",
        ],
    )
