from backend.northstar.blueprint import northstar
from backend.northstar.contracts import BOOKING_UPDATE_BODY, TRIP_BOOKING_PATH
from backend.northstar.endpoints import trip_booking_detail as endpoint
from backend.northstar.route_utils import handle_request


@northstar.route("/trips/<int:trip_id>/bookings/<int:booking_id>", methods=["GET"])
def get_trip_booking_detail_route(trip_id, booking_id):
    return handle_request(
        endpoint="/trips/{tripId}/bookings/{bookingId}",
        method="GET",
        handler=endpoint.get_trip_booking_detail,
        path_values={"trip_id": trip_id, "booking_id": booking_id},
        path_schema=TRIP_BOOKING_PATH,
    )


@northstar.route("/trips/<int:trip_id>/bookings/<int:booking_id>", methods=["PUT"])
def update_trip_booking_detail_route(trip_id, booking_id):
    return handle_request(
        endpoint="/trips/{tripId}/bookings/{bookingId}",
        method="PUT",
        handler=endpoint.put_trip_booking_detail,
        path_values={"trip_id": trip_id, "booking_id": booking_id},
        path_schema=TRIP_BOOKING_PATH,
        body_schema=BOOKING_UPDATE_BODY,
    )


@northstar.route("/trips/<int:trip_id>/bookings/<int:booking_id>", methods=["DELETE"])
def delete_trip_booking_detail_route(trip_id, booking_id):
    return handle_request(
        endpoint="/trips/{tripId}/bookings/{bookingId}",
        method="DELETE",
        handler=endpoint.delete_trip_booking_detail,
        path_values={"trip_id": trip_id, "booking_id": booking_id},
        path_schema=TRIP_BOOKING_PATH,
    )
