from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    TRIP_BUDGET_QUERY,
    TRIP_BUDGET_UPDATE_BODY,
    TRIP_ID_PATH,
)
from backend.northstar.endpoints import trip_budget as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/budget", methods=["GET"])
def get_trip_budget_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/budget",
        method="GET",
        handler=endpoint.get_trip_budget,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        query_schema=TRIP_BUDGET_QUERY,
    )


@northstar.route("/trips/<int:trip_id>/budget", methods=["PUT"])
def update_trip_budget_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/budget",
        method="PUT",
        handler=endpoint.put_trip_budget,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_BUDGET_UPDATE_BODY,
    )
