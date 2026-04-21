from backend.northstar.endpoint_utils import delete_payload, make_query, multi_query, select_payload


PREFERENCE_CATEGORIES = {
    "food_preferences": "food",
    "lodging_preferences": "lodging",
    "activity_preferences": "activity",
}


def get_trip_traveler_preferences(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    sql = """
        SELECT
            traveler_id,
            trip_id,
            preference
        FROM Traveler_Preference
    """
    return select_payload(
        sql,
        filters=(
            ["trip_id = %s", "traveler_id = %s"],
            [trip_id, traveler_id],
        ),
        order_by="preference",
        notes=[
            "Current schema stores trip preferences as flattened strings in Traveler_Preference.preference.",
        ],
    )


def post_trip_traveler_preferences(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    queries = _preference_insert_queries(trip_id, traveler_id, validated["body"])
    return multi_query(
        queries,
        notes=[
            "Category-specific preferences are flattened into a single string column until the schema is expanded.",
        ],
    )


def put_trip_traveler_preferences(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    queries = [
        delete_payload(
            "Traveler_Preference",
            where_clause="trip_id = %s AND traveler_id = %s",
            where_params=[trip_id, traveler_id],
            notes=["Replace the traveler's existing trip preferences with the supplied payload."],
        )
    ]
    queries.extend(_preference_insert_queries(trip_id, traveler_id, validated["body"]))
    return multi_query(
        queries,
        notes=[
            "Category-specific preferences are flattened into a single string column until the schema is expanded.",
        ],
    )


def delete_trip_traveler_preferences(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    return delete_payload(
        "Traveler_Preference",
        where_clause="trip_id = %s AND traveler_id = %s",
        where_params=[trip_id, traveler_id],
    )


def _preference_insert_queries(trip_id, traveler_id, body):
    queries = []
    for key, category in PREFERENCE_CATEGORIES.items():
        for index, preference in enumerate(body.get(key, []), start=1):
            flattened_preference = f"{category}:{preference}"
            queries.append(
                make_query(
                    """
                    INSERT INTO Traveler_Preference (traveler_id, preference, trip_id)
                    VALUES (%s, %s, %s)
                    """,
                    [traveler_id, flattened_preference, trip_id],
                    name=f"{category}_preference_{index}",
                )
            )
    return queries
