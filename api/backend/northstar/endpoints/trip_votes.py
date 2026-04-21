from backend.northstar.endpoint_utils import make_query, multi_query, select_payload


def get_trip_votes(validated):
    trip_id = validated["path"]["trip_id"]
    sql = """
        SELECT
            tv.trip_id,
            tv.traveler_id,
            CONCAT(tr.first_name, ' ', tr.last_name) AS traveler_name,
            tv.listing_id,
            l.description,
            l.service_category,
            tv.vote_value
        FROM Traveler_Vote tv
        JOIN Traveler tr ON tr.traveler_id = tv.traveler_id
        JOIN Listing l ON l.listing_id = tv.listing_id
    """
    return select_payload(
        sql,
        filters=(["tv.trip_id = %s"], [trip_id]),
        order_by="tv.listing_id, tv.traveler_id",
    )


def post_trip_votes(validated):
    trip_id = validated["path"]["trip_id"]
    body = validated["body"]
    return make_query(
        """
        INSERT INTO Traveler_Vote (traveler_id, listing_id, vote_value, trip_id)
        VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            vote_value = VALUES(vote_value),
            trip_id = VALUES(trip_id)
        """,
        [body["traveler_id"], body["listing_id"], body["vote_value"], trip_id],
        name="upsert_trip_vote",
    )


def put_trip_votes(validated):
    trip_id = validated["path"]["trip_id"]
    queries = []
    for index, item in enumerate(validated["body"]["items"], start=1):
        queries.append(
            make_query(
                """
                UPDATE Traveler_Vote
                SET vote_value = %s, trip_id = %s
                WHERE traveler_id = %s AND listing_id = %s
                """,
                [item["vote_value"], trip_id, item["traveler_id"], item["listing_id"]],
                name=f"trip_vote_update_{index}",
            )
        )
    return multi_query(queries)


def delete_trip_votes(validated):
    queries = []
    for index, item in enumerate(validated["body"]["items"], start=1):
        queries.append(
            make_query(
                "DELETE FROM Traveler_Vote WHERE traveler_id = %s AND listing_id = %s",
                [item["traveler_id"], item["listing_id"]],
                name=f"trip_vote_delete_{index}",
            )
        )
    return multi_query(queries)
