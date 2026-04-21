from backend.northstar.blueprint import northstar
from backend.northstar.endpoints import analytics_spending as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/analytics/spending", methods=["GET"])
def get_analytics_spending_route():
    return handle_request(
        endpoint="/analytics/spending",
        method="GET",
        handler=endpoint.get_analytics_spending,
    )
