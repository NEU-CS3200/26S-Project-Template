from backend.northstar.endpoint_utils import make_query, select_payload


def get_trip_traveler_votes(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    sql = """
        SELECT
            tv.trip_id,
            tv.traveler_id,
            tv.listing_id,
            l.description,
            l.service_category,
            tv.vote_value
        FROM Traveler_Vote tv
        JOIN Listing l ON l.listing_id = tv.listing_id
    """
    return select_payload(
        sql,
        filters=(
            ["tv.trip_id = %s", "tv.traveler_id = %s"],
            [trip_id, traveler_id],
        ),
        order_by="tv.listing_id",
    )


def post_trip_traveler_votes(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    body = validated["body"]
    return make_query(
        """
        INSERT INTO Traveler_Vote (traveler_id, listing_id, vote_value, trip_id)
        VALUES (%s, %s, %s, %s)
        ON DUPLICATE KEY UPDATE
            vote_value = VALUES(vote_value),
            trip_id = VALUES(trip_id)
        """,
        [traveler_id, body["listing_id"], body["vote_value"], trip_id],
        name="upsert_trip_traveler_vote",
    )


def put_trip_traveler_votes(validated):
    trip_id = validated["path"]["trip_id"]
    traveler_id = validated["path"]["traveler_id"]
    body = validated["body"]
    return make_query(
        """
        UPDATE Traveler_Vote
        SET vote_value = %s, trip_id = %s
        WHERE traveler_id = %s AND listing_id = %s
        """,
        [body["vote_value"], trip_id, traveler_id, body["listing_id"]],
        name="update_trip_traveler_vote",
    )


def delete_trip_traveler_votes(validated):
    traveler_id = validated["path"]["traveler_id"]
    listing_id = validated["body"]["listing_id"]
    return make_query(
        "DELETE FROM Traveler_Vote WHERE traveler_id = %s AND listing_id = %s",
        [traveler_id, listing_id],
        name="delete_trip_traveler_vote",
    )
