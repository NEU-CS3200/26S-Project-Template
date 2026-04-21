from backend.northstar.blueprint import northstar
from backend.northstar.endpoints import analytics_vendors as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/analytics/vendors", methods=["GET"])
def get_analytics_vendors_route():
    return handle_request(
        endpoint="/analytics/vendors",
        method="GET",
        handler=endpoint.get_analytics_vendors,
    )
