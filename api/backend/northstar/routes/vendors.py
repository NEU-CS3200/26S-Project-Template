from backend.northstar.blueprint import northstar
from backend.northstar.contracts import VENDOR_CREATE_BODY, VENDORS_QUERY
from backend.northstar.endpoints import vendors as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/vendors", methods=["GET"])
def get_vendors_route():
    return handle_request(
        endpoint="/vendors",
        method="GET",
        handler=endpoint.get_vendors,
        query_schema=VENDORS_QUERY,
    )


@northstar.route("/vendors", methods=["POST"])
def create_vendors_route():
    return handle_request(
        endpoint="/vendors",
        method="POST",
        handler=endpoint.post_vendors,
        body_schema=VENDOR_CREATE_BODY,
    )
