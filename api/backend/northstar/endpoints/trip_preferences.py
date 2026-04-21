from backend.northstar.endpoint_utils import delete_payload, multi_query, select_payload


def get_trip_preferences(validated):
    trip_id = validated["path"]["trip_id"]
    group_by = validated["query"].get("group_by", "traveler")

    raw_query = select_payload(
        """
        SELECT
            traveler_id,
            trip_id,
            preference
        FROM Traveler_Preference
        """,
        filters=(["trip_id = %s"], [trip_id]),
        order_by="traveler_id, preference",
        name="preferences_by_traveler",
    )
    category_query = select_payload(
        """
        SELECT
            SUBSTRING_INDEX(preference, ':', 1) AS preference_category,
            COUNT(*) AS preference_count
        FROM Traveler_Preference
        """,
        filters=(["trip_id = %s"], [trip_id]),
        group_by="SUBSTRING_INDEX(preference, ':', 1)",
        order_by="preference_category",
        name="preferences_by_category",
    )

    if group_by == "category":
        return category_query
    if group_by == "both":
        return multi_query(
            [raw_query, category_query],
            notes=[
                "Preference categories are inferred from the flattened string prefix in the current DDL.",
            ],
        )
    return raw_query


def delete_trip_preferences(validated):
    trip_id = validated["path"]["trip_id"]
    return delete_payload(
        "Traveler_Preference",
        where_clause="trip_id = %s",
        where_params=[trip_id],
    )
