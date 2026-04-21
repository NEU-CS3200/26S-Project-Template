from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    VENDOR_ID_PATH,
    VENDOR_LISTING_CREATE_BODY,
    VENDOR_LISTINGS_QUERY,
)
from backend.northstar.endpoints import vendor_listings as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/vendors/<int:vendor_id>/listings", methods=["GET"])
def get_vendor_listings_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}/listings",
        method="GET",
        handler=endpoint.get_vendor_listings,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
        query_schema=VENDOR_LISTINGS_QUERY,
    )


@northstar.route("/vendors/<int:vendor_id>/listings", methods=["POST"])
def create_vendor_listings_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}/listings",
        method="POST",
        handler=endpoint.post_vendor_listings,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
        body_schema=VENDOR_LISTING_CREATE_BODY,
    )
