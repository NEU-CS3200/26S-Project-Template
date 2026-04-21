from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_ID_PATH,
    TRIP_VOTES_BULK_DELETE_BODY,
    TRIP_VOTES_BULK_UPDATE_BODY,
    TRIP_VOTES_CREATE_BODY,
)
from backend.northstar.endpoints import trip_votes as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/votes", methods=["GET"])
def get_trip_votes_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/votes",
        method="GET",
        handler=endpoint.get_trip_votes,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
    )


@northstar.route("/trips/<int:trip_id>/votes", methods=["POST"])
def create_trip_votes_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/votes",
        method="POST",
        handler=endpoint.post_trip_votes,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_VOTES_CREATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/votes", methods=["PUT"])
def update_trip_votes_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/votes",
        method="PUT",
        handler=endpoint.put_trip_votes,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_VOTES_BULK_UPDATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/votes", methods=["DELETE"])
def delete_trip_votes_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/votes",
        method="DELETE",
        handler=endpoint.delete_trip_votes,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_VOTES_BULK_DELETE_BODY,
    )
