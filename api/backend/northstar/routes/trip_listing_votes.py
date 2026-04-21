from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_LISTING_PATH,
    TRIP_LISTING_VOTES_QUERY,
    TRIP_LISTING_VOTE_CREATE_BODY,
    TRIP_LISTING_VOTE_DELETE_BODY,
)
from backend.northstar.endpoints import trip_listing_votes as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/listings/<int:listing_id>/votes", methods=["GET"])
def get_trip_listing_votes_route(trip_id, listing_id):
    return handle_request(
        endpoint="/trips/{tripId}/listings/{listingId}/votes",
        method="GET",
        handler=endpoint.get_trip_listing_votes,
        path_values={"trip_id": trip_id, "listing_id": listing_id},
        path_schema=TRIP_LISTING_PATH,
        query_schema=TRIP_LISTING_VOTES_QUERY,
    )


@northstar.route("/trips/<int:trip_id>/listings/<int:listing_id>/votes", methods=["POST"])
def create_trip_listing_votes_route(trip_id, listing_id):
    return handle_request(
        endpoint="/trips/{tripId}/listings/{listingId}/votes",
        method="POST",
        handler=endpoint.post_trip_listing_votes,
        path_values={"trip_id": trip_id, "listing_id": listing_id},
        path_schema=TRIP_LISTING_PATH,
        body_schema=TRIP_LISTING_VOTE_CREATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/listings/<int:listing_id>/votes", methods=["PUT"])
def update_trip_listing_votes_route(trip_id, listing_id):
    return handle_request(
        endpoint="/trips/{tripId}/listings/{listingId}/votes",
        method="PUT",
        handler=endpoint.put_trip_listing_votes,
        path_values={"trip_id": trip_id, "listing_id": listing_id},
        path_schema=TRIP_LISTING_PATH,
        body_schema=TRIP_LISTING_VOTE_CREATE_BODY,
    )


@northstar.route(
    "/trips/<int:trip_id>/listings/<int:listing_id>/votes",
    methods=["DELETE"],
)
def delete_trip_listing_votes_route(trip_id, listing_id):
    return handle_request(
        endpoint="/trips/{tripId}/listings/{listingId}/votes",
        method="DELETE",
        handler=endpoint.delete_trip_listing_votes,
        path_values={"trip_id": trip_id, "listing_id": listing_id},
        path_schema=TRIP_LISTING_PATH,
        body_schema=TRIP_LISTING_VOTE_DELETE_BODY,
    )
