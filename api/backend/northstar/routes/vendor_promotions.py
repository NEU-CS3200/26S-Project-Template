from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    PROMOTION_BULK_DELETE_BODY,
    PROMOTION_BULK_UPDATE_BODY,
    PROMOTION_CREATE_BODY,
    VENDOR_ID_PATH,
)
from backend.northstar.endpoints import vendor_promotions as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/vendors/<int:vendor_id>/promotions", methods=["GET"])
def get_vendor_promotions_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}/promotions",
        method="GET",
        handler=endpoint.get_vendor_promotions,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
    )


@northstar.route("/vendors/<int:vendor_id>/promotions", methods=["POST"])
def create_vendor_promotions_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}/promotions",
        method="POST",
        handler=endpoint.post_vendor_promotions,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
        body_schema=PROMOTION_CREATE_BODY,
    )


@northstar.route("/vendors/<int:vendor_id>/promotions", methods=["PUT"])
def update_vendor_promotions_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}/promotions",
        method="PUT",
        handler=endpoint.put_vendor_promotions,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
        body_schema=PROMOTION_BULK_UPDATE_BODY,
    )


@northstar.route("/vendors/<int:vendor_id>/promotions", methods=["DELETE"])
def delete_vendor_promotions_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}/promotions",
        method="DELETE",
        handler=endpoint.delete_vendor_promotions,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
        body_schema=PROMOTION_BULK_DELETE_BODY,
    )
