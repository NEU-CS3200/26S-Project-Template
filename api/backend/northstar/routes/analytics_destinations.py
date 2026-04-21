from backend.northstar.blueprint import northstar
from backend.northstar.endpoints import analytics_destinations as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/analytics/destinations", methods=["GET"])
def get_analytics_destinations_route():
    return handle_request(
        endpoint="/analytics/destinations",
        method="GET",
        handler=endpoint.get_analytics_destinations,
    )
