from backend.northstar.blueprint import northstar
from backend.northstar.contracts import TRIP_ID_PATH, TRIP_UPDATE_BODY
from backend.northstar.endpoints import trip_detail as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>", methods=["GET"])
def get_trip_detail_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}",
        method="GET",
        handler=endpoint.get_trip_detail,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
    )


@northstar.route("/trips/<int:trip_id>", methods=["PUT"])
def update_trip_detail_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}",
        method="PUT",
        handler=endpoint.put_trip_detail,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=TRIP_UPDATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>", methods=["DELETE"])
def delete_trip_detail_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}",
        method="DELETE",
        handler=endpoint.delete_trip_detail,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
    )
