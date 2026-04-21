from backend.northstar.blueprint import northstar
from backend.northstar.contracts import VENDOR_ID_PATH, VENDOR_UPDATE_BODY
from backend.northstar.endpoints import vendor_detail as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/vendors/<int:vendor_id>", methods=["GET"])
def get_vendor_detail_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}",
        method="GET",
        handler=endpoint.get_vendor_detail,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
    )


@northstar.route("/vendors/<int:vendor_id>", methods=["PUT"])
def update_vendor_detail_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}",
        method="PUT",
        handler=endpoint.put_vendor_detail,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
        body_schema=VENDOR_UPDATE_BODY,
    )


@northstar.route("/vendors/<int:vendor_id>", methods=["DELETE"])
def delete_vendor_detail_route(vendor_id):
    return handle_request(
        endpoint="/vendors/{vendorId}",
        method="DELETE",
        handler=endpoint.delete_vendor_detail,
        path_values={"vendor_id": vendor_id},
        path_schema=VENDOR_ID_PATH,
    )
