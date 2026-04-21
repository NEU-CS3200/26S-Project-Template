from backend.northstar.blueprint import northstar
from backend.northstar.contracts import (
    BOOKING_BULK_DELETE_BODY,
    BOOKING_BULK_UPDATE_BODY,
    BOOKING_CREATE_BODY,
    TRIP_ID_PATH,
)
from backend.northstar.endpoints import trip_bookings as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/bookings", methods=["GET"])
def get_trip_bookings_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/bookings",
        method="GET",
        handler=endpoint.get_trip_bookings,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
    )


@northstar.route("/trips/<int:trip_id>/bookings", methods=["POST"])
def create_trip_bookings_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/bookings",
        method="POST",
        handler=endpoint.post_trip_bookings,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=BOOKING_CREATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/bookings", methods=["PUT"])
def update_trip_bookings_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/bookings",
        method="PUT",
        handler=endpoint.put_trip_bookings,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=BOOKING_BULK_UPDATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/bookings", methods=["DELETE"])
def delete_trip_bookings_route(trip_id):
    return handle_request(
        endpoint="/trips/{tripId}/bookings",
        method="DELETE",
        handler=endpoint.delete_trip_bookings,
        path_values={"trip_id": trip_id},
        path_schema=TRIP_ID_PATH,
        body_schema=BOOKING_BULK_DELETE_BODY,
    )
