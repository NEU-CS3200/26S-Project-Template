from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_ID_PATH,
    TRIP_PREFERENCES_DELETE_BODY,
    TRIP_PREFERENCES_QUERY,
)
from backend.northstar.endpoints import trip_preferences as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/preferences", methods=["GET"])
def get_trip_preferences_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/preferences",
        method="GET",
        handler=endpoint.get_trip_preferences,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        query_schema=TRIP_PREFERENCES_QUERY,
    )


@northstar.route("/trips/<int:trip_id>/preferences", methods=["DELETE"])
def delete_trip_preferences_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/preferences",
        method="DELETE",
        handler=endpoint.delete_trip_preferences,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_PREFERENCES_DELETE_BODY,
    )
