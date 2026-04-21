from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_ID_PATH,
    TRIP_NOTIFICATIONS_CREATE_BODY,
    TRIP_NOTIFICATIONS_DELETE_BODY,
    TRIP_NOTIFICATIONS_QUERY,
    TRIP_NOTIFICATIONS_UPDATE_BODY,
)
from backend.northstar.endpoints import trip_notifications as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/notifications", methods=["GET"])
def get_trip_notifications_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/notifications",
        method="GET",
        handler=endpoint.get_trip_notifications,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        query_schema=TRIP_NOTIFICATIONS_QUERY,
    )


@northstar.route("/trips/<int:trip_id>/notifications", methods=["POST"])
def create_trip_notifications_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/notifications",
        method="POST",
        handler=endpoint.post_trip_notifications,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_NOTIFICATIONS_CREATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/notifications", methods=["PUT"])
def update_trip_notifications_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/notifications",
        method="PUT",
        handler=endpoint.put_trip_notifications,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_NOTIFICATIONS_UPDATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/notifications", methods=["DELETE"])
def delete_trip_notifications_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/notifications",
        method="DELETE",
        handler=endpoint.delete_trip_notifications,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_NOTIFICATIONS_DELETE_BODY,
    )
