from backend.northstar.blueprint import northstar
from backend.northstar.contracts import TRIP_TRAVELER_PATH, TRIP_TRAVELER_UPDATE_BODY
from backend.northstar.endpoints import trip_traveler_detail as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/travelers/<int:traveler_id>", methods=["GET"])
def get_trip_traveler_detail_route(trip_id, traveler_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers/{travelerId}",
        method="GET",
        handler=endpoint.get_trip_traveler_detail,
        path_values={"trip_id": trip_id, "traveler_id": traveler_id},
        path_schema=TRIP_TRAVELER_PATH,
    )


@northstar.route("/trips/<int:trip_id>/travelers/<int:traveler_id>", methods=["PUT"])
def update_trip_traveler_detail_route(trip_id, traveler_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers/{travelerId}",
        method="PUT",
        handler=endpoint.put_trip_traveler_detail,
        path_values={"trip_id": trip_id, "traveler_id": traveler_id},
        path_schema=TRIP_TRAVELER_PATH,
        body_schema=TRIP_TRAVELER_UPDATE_BODY,
    )


@northstar.route(
    "/trips/<int:trip_id>/travelers/<int:traveler_id>",
    methods=["DELETE"],
)
def delete_trip_traveler_detail_route(trip_id, traveler_id):
    return handle_request(
        endpoint="/trips/{tripId}/travelers/{travelerId}",
        method="DELETE",
        handler=endpoint.delete_trip_traveler_detail,
        path_values={"trip_id": trip_id, "traveler_id": traveler_id},
        path_schema=TRIP_TRAVELER_PATH,
    )
