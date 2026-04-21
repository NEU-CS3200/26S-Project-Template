from backend.northstar.endpoint_utils import (
    collect_fields,
    delete_payload,
    make_query,
    multi_query,
    select_payload,
    update_payload,
)


BOOKING_MUTABLE_FIELDS = [
    "promotion_id",
    "booking_date",
    "booking_status",
    "is_active",
]


def get_trip_booking_detail(validated):
    trip_id = validated["path"]["trip_id"]
    booking_id = validated["path"]["booking_id"]
    sql = """
        SELECT
            b.booking_id,
            b.trip_id,
            b.listing_id,
            b.vendor_id,
            v.vendor_name,
            b.promotion_id,
            p.title AS promotion_title,
            b.booking_date,
            b.booking_status,
            b.is_active,
            l.service_category,
            l.description,
            l.price
        FROM Booking b
        JOIN Listing l ON l.listing_id = b.listing_id
        JOIN Vendor v ON v.vendor_id = b.vendor_id
        LEFT JOIN Promotion p ON p.promotion_id = b.promotion_id
    """
    return select_payload(
        sql,
        filters=(["b.trip_id = %s", "b.booking_id = %s"], [trip_id, booking_id]),
    )


def put_trip_booking_detail(validated):
    trip_id = validated["path"]["trip_id"]
    booking_id = validated["path"]["booking_id"]
    body = validated["body"]
    queries = []

    values = collect_fields(body, BOOKING_MUTABLE_FIELDS)
    if values:
        queries.append(
            update_payload(
                "Booking",
                values,
                where_clause="trip_id = %s AND booking_id = %s",
                where_params=[trip_id, booking_id],
            )
        )

    if "traveler_ids" in body:
        queries.append(
            delete_payload(
                "Traveler_Booking",
                where_clause="booking_id = %s",
                where_params=[booking_id],
                notes=["Replace booking-to-traveler links from the supplied list."],
            )
        )
        for traveler_id in body["traveler_ids"]:
            queries.append(
                make_query(
                    "INSERT INTO Traveler_Booking (traveler_id, booking_id) VALUES (%s, %s)",
                    [traveler_id, booking_id],
                    name=f"booking_{booking_id}_traveler_{traveler_id}",
                )
            )

    return multi_query(queries)


def delete_trip_booking_detail(validated):
    trip_id = validated["path"]["trip_id"]
    booking_id = validated["path"]["booking_id"]
    return update_payload(
        "Booking",
        {"is_active": False},
        where_clause="trip_id = %s AND booking_id = %s",
        where_params=[trip_id, booking_id],
        notes=["Soft delete scaffold for removing a booking from the itinerary."],
    )
