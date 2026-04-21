from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_TRAVELER_PATH,
    TRIP_TRAVELER_PREFERENCES_BODY,
)
from backend.northstar.endpoints import trip_traveler_preferences as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route(
    "/trips/<int:trip_id>/travelers/<int:traveler_id>/preferences",
    methods=["GET"],
)
def get_trip_traveler_preferences_route(trip_id, traveler_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers/{travelerId}/preferences",
        method="GET",
        handler=endpoint.get_trip_traveler_preferences,
        path_values={"trip_id": trip_id, "traveler_id": traveler_id},
        path_schema=TRIP_TRAVELER_PATH,
    )


@northstar.route(
    "/trips/<int:trip_id>/travelers/<int:traveler_id>/preferences",
    methods=["POST"],
)
def create_trip_traveler_preferences_route(trip_id, traveler_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers/{travelerId}/preferences",
        method="POST",
        handler=endpoint.post_trip_traveler_preferences,
        path_values={"trip_id": trip_id, "traveler_id": traveler_id},
        path_schema=TRIP_TRAVELER_PATH,
        body_schema=TRIP_TRAVELER_PREFERENCES_BODY,
    )


@northstar.route(
    "/trips/<int:trip_id>/travelers/<int:traveler_id>/preferences",
    methods=["PUT"],
)
def update_trip_traveler_preferences_route(trip_id, traveler_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers/{travelerId}/preferences",
        method="PUT",
        handler=endpoint.put_trip_traveler_preferences,
        path_values={"trip_id": trip_id, "traveler_id": traveler_id},
        path_schema=TRIP_TRAVELER_PATH,
        body_schema=TRIP_TRAVELER_PREFERENCES_BODY,
    )


@northstar.route(
    "/trips/<int:trip_id>/travelers/<int:traveler_id>/preferences",
    methods=["DELETE"],
)
def delete_trip_traveler_preferences_route(trip_id, traveler_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers/{travelerId}/preferences",
        method="DELETE",
        handler=endpoint.delete_trip_traveler_preferences,
        path_values={"trip_id": trip_id, "traveler_id": traveler_id},
        path_schema=TRIP_TRAVELER_PATH,
    )
