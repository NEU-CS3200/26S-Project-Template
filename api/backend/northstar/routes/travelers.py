from backend.northstar.blueprint import northstar
from backend.northstar.contracts import TRAVELER_CREATE_BODY, TRAVELERS_QUERY
from backend.northstar.endpoints import travelers as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/travelers", methods=["GET"])
def get_travelers_route():
    return handle_request(
        endpoint="/travelers",
        method="GET",
        handler=endpoint.get_travelers,
        query_schema=TRAVELERS_QUERY,
    )


@northstar.route("/travelers", methods=["POST"])
def create_travelers_route():
    return handle_request(
        endpoint="/travelers",
        method="POST",
        handler=endpoint.post_travelers,
        body_schema=TRAVELER_CREATE_BODY,
    )
