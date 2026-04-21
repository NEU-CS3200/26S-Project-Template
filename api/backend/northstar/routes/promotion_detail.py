from backend.northstar.blueprint import northstar
from backend.northstar.contracts import PROMOTION_ID_PATH, PROMOTION_UPDATE_BODY
from backend.northstar.endpoints import promotion_detail as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/promotions/<int:promotion_id>", methods=["GET"])
def get_promotion_detail_route(promotion_id):
    return handle_request(
        endpoint="/promotions/{promotionId}",
        method="GET",
        handler=endpoint.get_promotion_detail,
        path_values={"promotion_id": promotion_id},
        path_schema=PROMOTION_ID_PATH,
    )


@northstar.route("/promotions/<int:promotion_id>", methods=["PUT"])
def update_promotion_detail_route(promotion_id):
    return handle_request(
        endpoint="/promotions/{promotionId}",
        method="PUT",
        handler=endpoint.put_promotion_detail,
        path_values={"promotion_id": promotion_id},
        path_schema=PROMOTION_ID_PATH,
        body_schema=PROMOTION_UPDATE_BODY,
    )


@northstar.route("/promotions/<int:promotion_id>", methods=["DELETE"])
def delete_promotion_detail_route(promotion_id):
    return handle_request(
        endpoint="/promotions/{promotionId}",
        method="DELETE",
        handler=endpoint.delete_promotion_detail,
        path_values={"promotion_id": promotion_id},
        path_schema=PROMOTION_ID_PATH,
    )
