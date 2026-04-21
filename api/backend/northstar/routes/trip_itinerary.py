from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_ID_PATH,
    TRIP_ITINERARY_QUERY,
    TRIP_ITINERARY_UPDATE_BODY,
)
from backend.northstar.endpoints import trip_itinerary as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/itinerary", methods=["GET"])
def get_trip_itinerary_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/itinerary",
        method="GET",
        handler=endpoint.get_trip_itinerary,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        query_schema=TRIP_ITINERARY_QUERY,
    )


@northstar.route("/trips/<int:trip_id>/itinerary", methods=["PUT"])
def update_trip_itinerary_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/itinerary",
        method="PUT",
        handler=endpoint.put_trip_itinerary,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_ITINERARY_UPDATE_BODY,
    )
