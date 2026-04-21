from backend.northstar.blueprint import northstar
from backend.northstar.contracts import LISTING_ID_PATH, LISTING_UPDATE_BODY
from backend.northstar.endpoints import listing_detail as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/listings/<int:listing_id>", methods=["GET"])
def get_listing_detail_route(listing_id):
    return handle_request(
        endpoint="/listings/{listingId}",
        method="GET",
        handler=endpoint.get_listing_detail,
        path_values={"listing_id": listing_id},
        path_schema=LISTING_ID_PATH,
    )


@northstar.route("/listings/<int:listing_id>", methods=["PUT"])
def update_listing_detail_route(listing_id):
    return handle_request(
        endpoint="/listings/{listingId}",
        method="PUT",
        handler=endpoint.put_listing_detail,
        path_values={"listing_id": listing_id},
        path_schema=LISTING_ID_PATH,
        body_schema=LISTING_UPDATE_BODY,
    )


@northstar.route("/listings/<int:listing_id>", methods=["DELETE"])
def delete_listing_detail_route(listing_id):
    return handle_request(
        endpoint="/listings/{listingId}",
        method="DELETE",
        handler=endpoint.delete_listing_detail,
        path_values={"listing_id": listing_id},
        path_schema=LISTING_ID_PATH,
    )
