from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_ID_PATH,
    TRIP_TRAVELERS_CREATE_BODY,
    TRIP_TRAVELERS_DELETE_BODY,
    TRIP_TRAVELERS_UPDATE_BODY,
)
from backend.northstar.endpoints import trip_travelers as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/travelers", methods=["GET"])
def get_trip_travelers_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers",
        method="GET",
        handler=endpoint.get_trip_travelers,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
    )


@northstar.route("/trips/<int:trip_id>/travelers", methods=["POST"])
def create_trip_travelers_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers",
        method="POST",
        handler=endpoint.post_trip_travelers,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_TRAVELERS_CREATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/travelers", methods=["PUT"])
def update_trip_travelers_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers",
        method="PUT",
        handler=endpoint.put_trip_travelers,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_TRAVELERS_UPDATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/travelers", methods=["DELETE"])
def delete_trip_travelers_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers",
        method="DELETE",
        handler=endpoint.delete_trip_travelers,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_TRAVELERS_DELETE_BODY,
    )
