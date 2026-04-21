from backend.northstar.blueprint import northstar
from backend.northstar.contracts import TRIP_CREATE_BODY, TRIPS_QUERY
from backend.northstar.endpoints import trips as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips", methods=["GET"])
def get_trips_route():
    return handle_request(
        endpoint="/trips",
        method="GET",
        handler=endpoint.get_trips,
        query_schema=TRIPS_QUERY,
    )


@northstar.route("/trips", methods=["POST"])
def create_trip_route():
    return handle_request(
        endpoint="/trips",
        method="POST",
        handler=endpoint.post_trips,
        body_schema=TRIP_CREATE_BODY,
    )
