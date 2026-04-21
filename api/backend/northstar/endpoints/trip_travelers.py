from backend.northstar.endpoint_utils import (
    delete_payload,
    make_query,
    multi_query,
    placeholder_list,
    select_payload,
    update_payload,
)


def get_trip_travelers(validated):
    trip_id = validated["path"]["trip_id"]
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
        filters=(["tt.trip_id = %s"], [trip_id]),
        order_by="tr.last_name, tr.first_name",
    )


def post_trip_travelers(validated):
    trip_id = validated["path"]["trip_id"]
    queries = []
    for index, item in enumerate(validated["body"]["items"], start=1):
        queries.extend(_build_trip_traveler_queries(trip_id, item, "insert", index))
    return multi_query(
        queries,
        notes=[
            "Trip-specific participation_status is not represented in the current DDL and remains a placeholder query.",
        ],
    )


def put_trip_travelers(validated):
    trip_id = validated["path"]["trip_id"]
    queries = []
    for index, item in enumerate(validated["body"]["items"], start=1):
        queries.extend(_build_trip_traveler_queries(trip_id, item, "update", index))
    return multi_query(
        queries,
        notes=[
            "Trip-specific participation_status is not represented in the current DDL and remains a placeholder query.",
        ],
    )


def delete_trip_travelers(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_ids = validated["body"]["traveler_ids"]
    placeholders = placeholder_list(len(traveler_ids))
    return delete_payload(
        "Trip_Traveler",
        where_clause=f"trip_id = %s AND traveler_id IN ({placeholders})",
        where_params=[trip_id, *traveler_ids],
    )


def _build_trip_traveler_queries(trip_id, item, mode, index):
    traveler_id = item["traveler_id"]
    queries = []

    if mode == "insert":
        queries.append(
            make_query(
                """
                INSERT INTO Trip_Traveler (trip_id, traveler_id, start_date, end_date)
                VALUES (%s, %s, %s, %s)
                """,
                [trip_id, traveler_id, item.get("start_date"), item.get("end_date")],
                name=f"trip_traveler_insert_{index}",
            )
        )
    else:
        date_values = {}
        if "start_date" in item:
            date_values["start_date"] = item["start_date"]
        if "end_date" in item:
            date_values["end_date"] = item["end_date"]
        if date_values:
            queries.append(
                update_payload(
                    "Trip_Traveler",
                    date_values,
                    where_clause="trip_id = %s AND traveler_id = %s",
                    where_params=[trip_id, traveler_id],
                    notes=[f"Trip traveler update item {index}."],
                )
            )

    if "availability" in item:
        queries.append(
            update_payload(
                "Traveler",
                {"availability": item["availability"]},
                where_clause="traveler_id = %s",
                where_params=[traveler_id],
            )
        )

    if "participation_status" in item:
        queries.append(
            make_query(
                """
                /* TODO: persist trip-specific traveler participation status in a future schema update. */
                SELECT %s AS participation_status_placeholder, %s AS traveler_id, %s AS trip_id
                """,
                [item["participation_status"], traveler_id, trip_id],
                name=f"participation_status_{index}",
            )
        )

    return queries
