from backend.northstar.blueprint import northstar
from backend.northstar.endpoints import analytics_booking_trends as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/analytics/bookings/trends", methods=["GET"])
def get_analytics_booking_trends_route():
    return handle_request(
        endpoint="/analytics/bookings/trends",
        method="GET",
        handler=endpoint.get_analytics_booking_trends,
    )
