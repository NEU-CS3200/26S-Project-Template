from backend.northstar.blueprint import northstar
from backend.northstar.contracts import NOTIFICATION_ID_PATH, NOTIFICATION_UPDATE_BODY
from backend.northstar.endpoints import notification_detail as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/notifications/<int:notification_id>", methods=["GET"])
def get_notification_detail_route(notification_id):
    return handle_request(
        endpoint="/notifications/{notificationId}",
        method="GET",
        handler=endpoint.get_notification_detail,
        path_values={"notification_id": notification_id},
        path_schema=NOTIFICATION_ID_PATH,
    )


@northstar.route("/notifications/<int:notification_id>", methods=["PUT"])
def update_notification_detail_route(notification_id):
    return handle_request(
        endpoint="/notifications/{notificationId}",
        method="PUT",
        handler=endpoint.put_notification_detail,
        path_values={"notification_id": notification_id},
        path_schema=NOTIFICATION_ID_PATH,
        body_schema=NOTIFICATION_UPDATE_BODY,
    )


@northstar.route("/notifications/<int:notification_id>", methods=["DELETE"])
def delete_notification_detail_route(notification_id):
    return handle_request(
        endpoint="/notifications/{notificationId}",
        method="DELETE",
        handler=endpoint.delete_notification_detail,
        path_values={"notification_id": notification_id},
        path_schema=NOTIFICATION_ID_PATH,
    )
