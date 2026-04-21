from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRAVELER_ID_PATH,
    TRAVELER_NOTIFICATIONS_DELETE_BODY,
    TRAVELER_NOTIFICATIONS_QUERY,
    TRAVELER_NOTIFICATIONS_UPDATE_BODY,
    TRAVELER_NOTIFICATION_CREATE_BODY,
)
from backend.northstar.endpoints import traveler_notifications as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/travelers/<int:traveler_id>/notifications", methods=["GET"])
def get_traveler_notifications_route(traveler_id):
    return handle_request(
        endpoint="/travelers/{travelerId}/notifications",
        method="GET",
        handler=endpoint.get_traveler_notifications,
        path_values={"traveler_id": traveler_id},
        path_schema=TRAVELER_ID_PATH,
        query_schema=TRAVELER_NOTIFICATIONS_QUERY,
    )


@northstar.route("/travelers/<int:traveler_id>/notifications", methods=["POST"])
def create_traveler_notifications_route(traveler_id):
    return handle_request(
        endpoint="/travelers/{travelerId}/notifications",
        method="POST",
        handler=endpoint.post_traveler_notifications,
        path_values={"traveler_id": traveler_id},
        path_schema=TRAVELER_ID_PATH,
        body_schema=TRAVELER_NOTIFICATION_CREATE_BODY,
    )


@northstar.route("/travelers/<int:traveler_id>/notifications", methods=["PUT"])
def update_traveler_notifications_route(traveler_id):
    return handle_request(
        endpoint="/travelers/{travelerId}/notifications",
        method="PUT",
        handler=endpoint.put_traveler_notifications,
        path_values={"traveler_id": traveler_id},
        path_schema=TRAVELER_ID_PATH,
        body_schema=TRAVELER_NOTIFICATIONS_UPDATE_BODY,
    )


@northstar.route("/travelers/<int:traveler_id>/notifications", methods=["DELETE"])
def delete_traveler_notifications_route(traveler_id):
    return handle_request(
        endpoint="/travelers/{travelerId}/notifications",
        method="DELETE",
        handler=endpoint.delete_traveler_notifications,
        path_values={"traveler_id": traveler_id},
        path_schema=TRAVELER_ID_PATH,
        body_schema=TRAVELER_NOTIFICATIONS_DELETE_BODY,
    )
