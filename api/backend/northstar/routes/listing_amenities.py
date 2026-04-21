from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    LISTING_AMENITIES_ADD_BODY,
    LISTING_AMENITIES_DELETE_BODY,
    LISTING_ID_PATH,
)
from backend.northstar.endpoints import listing_amenities as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/listings/<int:listing_id>/amenities", methods=["GET"])
def get_listing_amenities_route(listing_id):
    return handle_request(
        endpoint="/listings/{listingId}/amenities",
        method="GET",
        handler=endpoint.get_listing_amenities,
        path_values={"listing_id": listing_id},
        path_schema=LISTING_ID_PATH,
    )


@northstar.route("/listings/<int:listing_id>/amenities", methods=["POST"])
def create_listing_amenities_route(listing_id):
    return handle_request(
        endpoint="/listings/{listingId}/amenities",
        method="POST",
        handler=endpoint.post_listing_amenities,
        path_values={"listing_id": listing_id},
        path_schema=LISTING_ID_PATH,
        body_schema=LISTING_AMENITIES_ADD_BODY,
    )


@northstar.route("/listings/<int:listing_id>/amenities", methods=["PUT"])
def update_listing_amenities_route(listing_id):
    return handle_request(
        endpoint="/listings/{listingId}/amenities",
        method="PUT",
        handler=endpoint.put_listing_amenities,
        path_values={"listing_id": listing_id},
        path_schema=LISTING_ID_PATH,
        body_schema=LISTING_AMENITIES_ADD_BODY,
    )


@northstar.route("/listings/<int:listing_id>/amenities", methods=["DELETE"])
def delete_listing_amenities_route(listing_id):
    return handle_request(
        endpoint="/listings/{listingId}/amenities",
        method="DELETE",
        handler=endpoint.delete_listing_amenities,
        path_values={"listing_id": listing_id},
        path_schema=LISTING_ID_PATH,
        body_schema=LISTING_AMENITIES_DELETE_BODY,
    )
