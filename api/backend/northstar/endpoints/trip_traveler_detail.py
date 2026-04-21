from backend.northstar.endpoint_utils import delete_payload, make_query, multi_query, select_payload, update_payload


def get_trip_traveler_detail(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    sql = """
        SELECT
            tt.trip_id,
            tt.traveler_id,
            tt.start_date,
            tt.end_date,
            tr.first_name,
            tr.last_name,
            tr.phone,
            tr.email,
            tr.availability,
            tr.traveler_status,
            tr.is_active
        FROM Trip_Traveler tt
        JOIN Traveler tr ON tr.traveler_id = tt.traveler_id
    """
    return select_payload(
        sql,
        filters=(
            ["tt.trip_id = %s", "tt.traveler_id = %s"],
            [trip_id, traveler_id],
        ),
    )


def put_trip_traveler_detail(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    body = validated["body"]
    queries = []

    trip_values = {}
    if "start_date" in body:
        trip_values["start_date"] = body["start_date"]
    if "end_date" in body:
        trip_values["end_date"] = body["end_date"]

    if trip_values:
        queries.append(
            update_payload(
                "Trip_Traveler",
                trip_values,
                where_clause="trip_id = %s AND traveler_id = %s",
                where_params=[trip_id, traveler_id],
            )
        )

    if "availability" in body:
        queries.append(
            update_payload(
                "Traveler",
                {"availability": body["availability"]},
                where_clause="traveler_id = %s",
                where_params=[traveler_id],
            )
        )

    if "participation_status" in body:
        queries.append(
            make_query(
                """
                /* TODO: persist trip-specific traveler participation status in a future schema update. */
                SELECT %s AS participation_status_placeholder, %s AS traveler_id, %s AS trip_id
                """,
                [body["participation_status"], traveler_id, trip_id],
                name="participation_status_placeholder",
            )
        )

    return multi_query(
        queries,
        notes=[
            "The current DDL does not include a trip-specific participation_status column.",
        ],
    )


def delete_trip_traveler_detail(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    return delete_payload(
        "Trip_Traveler",
        where_clause="trip_id = %s AND traveler_id = %s",
        where_params=[trip_id, traveler_id],
    )
