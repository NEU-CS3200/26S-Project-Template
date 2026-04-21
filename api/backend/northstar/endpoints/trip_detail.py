from backend.northstar.endpoint_utils import (
    collect_fields,
    deactivate_payload,
    select_payload,
    update_payload,
)


TRIP_UPDATE_FIELDS = [
    "trip_name",
    "destination",
    "city",
    "country",
    "region",
    "start_date",
    "end_date",
    "trip_type",
    "group_size",
    "trip_status",
    "date_booked",
    "is_active",
]


def get_trip_detail(validated):
    trip_id = validated["path"]["trip_id"]
    sql = """
        SELECT
            t.trip_id,
            t.planner_id,
            p.name AS planner_name,
            t.trip_name,
            t.date_booked,
            t.trip_status,
            t.destination,
            t.city,
            t.country,
            t.region,
            t.trip_type,
            t.start_date,
            t.end_date,
            t.is_active,
            t.total_spent,
            t.group_size
        FROM Trip t
        JOIN Planner p ON p.planner_id = t.planner_id
    """
    return select_payload(
        sql,
        filters=(["t.trip_id = %s"], [trip_id]),
    )


def put_trip_detail(validated):
    trip_id = validated["path"]["trip_id"]
    values = collect_fields(validated["body"], TRIP_UPDATE_FIELDS)
    return update_payload(
        "Trip",
        values,
        where_clause="trip_id = %s",
        where_params=[trip_id],
    )


def delete_trip_detail(validated):
    trip_id = validated["path"]["trip_id"]
    return deactivate_payload("Trip", where_clause="trip_id = %s", where_params=[trip_id])
