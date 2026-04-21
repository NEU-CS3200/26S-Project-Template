from backend.northstar.endpoint_utils import (
    collect_fields,
    deactivate_payload,
    select_payload,
    update_payload,
)


TRAVELER_UPDATE_FIELDS = [
    "first_name",
    "last_name",
    "phone",
    "email",
    "availability",
    "traveler_status",
    "is_active",
]


def get_traveler_detail(validated):
    traveler_id = validated["path"]["traveler_id"]
    sql = """
        SELECT
            traveler_id,
            first_name,
            last_name,
            phone,
            email,
            availability,
            traveler_status,
            is_active
        FROM Traveler
    """
    return select_payload(sql, filters=(["traveler_id = %s"], [traveler_id]))


def put_traveler_detail(validated):
    traveler_id = validated["path"]["traveler_id"]
    values = collect_fields(validated["body"], TRAVELER_UPDATE_FIELDS)
    return update_payload(
        "Traveler",
        values,
        where_clause="traveler_id = %s",
        where_params=[traveler_id],
    )


def delete_traveler_detail(validated):
    traveler_id = validated["path"]["traveler_id"]
    return deactivate_payload(
        "Traveler",
        where_clause="traveler_id = %s",
        where_params=[traveler_id],
    )
