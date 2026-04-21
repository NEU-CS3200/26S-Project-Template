from backend.northstar.endpoint_utils import make_query, multi_query, select_payload


def get_trip_listing_votes(validated):
    trip_id = validated["path"]["trip_id"]
    listing_id = validated["path"]["listing_id"]
    queries = [
        select_payload(
            """
            SELECT
                tv.trip_id,
                tv.listing_id,
                COUNT(*) AS vote_count,
                COALESCE(SUM(tv.vote_value), 0) AS vote_score
            FROM Traveler_Vote tv
            """,
            filters=(
                ["tv.trip_id = %s", "tv.listing_id = %s"],
                [trip_id, listing_id],
            ),
            group_by="tv.trip_id, tv.listing_id",
            name="listing_vote_aggregate",
        )
    ]

    if "traveler_id" in validated["query"]:
        queries.append(
            select_payload(
                """
                SELECT
                    traveler_id,
                    listing_id,
                    vote_value
                FROM Traveler_Vote
                """,
                filters=(
                    ["trip_id = %s", "listing_id = %s", "traveler_id = %s"],
                    [trip_id, listing_id, validated["query"]["traveler_id"]],
                ),
                name="traveler_vote_state",
            )
        )

    return multi_query(queries)


def post_trip_listing_votes(validated):
    trip_id = validated["path"]["trip_id"]
    listing_id = validated["path"]["listing_id"]
    body = validated["body"]
    return make_query(
        """
        INSERT INTO Traveler_Vote (traveler_id, listing_id, vote_value, trip_id)
        VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            vote_value = VALUES(vote_value),
            trip_id = VALUES(trip_id)
        """,
        [body["traveler_id"], listing_id, body["vote_value"], trip_id],
        name="upsert_listing_vote",
    )


def put_trip_listing_votes(validated):
    trip_id = validated["path"]["trip_id"]
    listing_id = validated["path"]["listing_id"]
    body = validated["body"]
    return make_query(
        """
        UPDATE Traveler_Vote
        SET vote_value = %s, trip_id = %s
        WHERE traveler_id = %s AND listing_id = %s
        """,
        [body["vote_value"], trip_id, body["traveler_id"], listing_id],
        name="update_listing_vote",
    )


def delete_trip_listing_votes(validated):
    listing_id = validated["path"]["listing_id"]
    traveler_id = validated["body"]["traveler_id"]
    return make_query(
        "DELETE FROM Traveler_Vote WHERE traveler_id = %s AND listing_id = %s",
        [traveler_id, listing_id],
        name="delete_listing_vote",
    )
