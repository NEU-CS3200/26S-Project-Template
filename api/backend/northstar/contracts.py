from backend.northstar.validation import (
    bool_field,
    date_field,
    date_order_rule,
    decimal_field,
    enum_field,
    int_field,
    list_field,
    must_be_true_rule,
    object_field,
    schema,
    string_field,
)


POSITIVE_INT = int_field(min_value=1)
NON_NEGATIVE_DECIMAL = decimal_field(min_value=0)
RATING_DECIMAL = decimal_field(min_value=0, max_value=5)
VOTE_VALUE = int_field(min_value=1, max_value=5)
TEXT = string_field()
BOOLEAN = bool_field()
DATE = date_field()


TRIP_ID_PATH = schema(required={"trip_id": POSITIVE_INT})
TRIP_BOOKING_PATH = schema(
    required={"trip_id": POSITIVE_INT, "booking_id": POSITIVE_INT}
)
TRIP_TRAVELER_PATH = schema(
    required={"trip_id": POSITIVE_INT, "traveler_id": POSITIVE_INT}
)
TRIP_LISTING_PATH = schema(
    required={"trip_id": POSITIVE_INT, "listing_id": POSITIVE_INT}
)
LISTING_ID_PATH = schema(required={"listing_id": POSITIVE_INT})
VENDOR_ID_PATH = schema(required={"vendor_id": POSITIVE_INT})
PROMOTION_ID_PATH = schema(required={"promotion_id": POSITIVE_INT})
TRAVELER_ID_PATH = schema(required={"traveler_id": POSITIVE_INT})
NOTIFICATION_ID_PATH = schema(required={"notification_id": POSITIVE_INT})


TRIPS_QUERY = schema(
    optional={
        "planner_id": POSITIVE_INT,
        "destination": TEXT,
        "trip_type": TEXT,
        "trip_status": TEXT,
        "is_active": BOOLEAN,
    }
)

TRIP_CREATE_BODY = schema(
    required={
        "planner_id": POSITIVE_INT,
        "destination": TEXT,
        "start_date": DATE,
        "end_date": DATE,
        "trip_type": TEXT,
        "group_size": POSITIVE_INT,
        "trip_status": TEXT,
    },
    optional={
        "trip_name": TEXT,
        "city": TEXT,
        "country": TEXT,
        "region": TEXT,
        "date_booked": DATE,
        "is_active": BOOLEAN,
    },
    rules=[date_order_rule("start_date", "end_date")],
)

TRIP_UPDATE_BODY = schema(
    optional={
        "trip_name": TEXT,
        "destination": TEXT,
        "city": TEXT,
        "country": TEXT,
        "region": TEXT,
        "start_date": DATE,
        "end_date": DATE,
        "trip_type": TEXT,
        "group_size": POSITIVE_INT,
        "trip_status": TEXT,
        "date_booked": DATE,
        "is_active": BOOLEAN,
    },
    at_least_one=[
        "trip_name",
        "destination",
        "city",
        "country",
        "region",
        "start_date",
        "end_date",
        "trip_type",
        "group_size",
        "trip_status",
        "date_booked",
        "is_active",
    ],
    rules=[date_order_rule("start_date", "end_date")],
)

TRIP_ITINERARY_QUERY = schema(optional={"include_inactive": BOOLEAN})

ITINERARY_ITEM = schema(
    required={"booking_id": POSITIVE_INT, "sequence": POSITIVE_INT}
)

TRIP_ITINERARY_UPDATE_BODY = schema(
    required={"items": list_field(object_field(ITINERARY_ITEM))}
)

BOOKING_CREATE_BODY = schema(
    required={"listing_id": POSITIVE_INT},
    optional={
        "promotion_id": POSITIVE_INT,
        "booking_date": DATE,
        "booking_status": TEXT,
        "traveler_ids": list_field(POSITIVE_INT),
        "is_active": BOOLEAN,
    },
)

BOOKING_BULK_UPDATE_ITEM = schema(
    required={"booking_id": POSITIVE_INT},
    optional={
        "promotion_id": POSITIVE_INT,
        "booking_date": DATE,
        "booking_status": TEXT,
        "traveler_ids": list_field(POSITIVE_INT),
        "is_active": BOOLEAN,
    },
    at_least_one=[
        "promotion_id",
        "booking_date",
        "booking_status",
        "traveler_ids",
        "is_active",
    ],
)

BOOKING_BULK_UPDATE_BODY = schema(
    required={"items": list_field(object_field(BOOKING_BULK_UPDATE_ITEM))}
)

BOOKING_BULK_DELETE_ITEM = schema(required={"booking_id": POSITIVE_INT})
BOOKING_BULK_DELETE_BODY = schema(
    required={"items": list_field(object_field(BOOKING_BULK_DELETE_ITEM))}
)

BOOKING_UPDATE_BODY = schema(
    optional={
        "promotion_id": POSITIVE_INT,
        "booking_date": DATE,
        "booking_status": TEXT,
        "traveler_ids": list_field(POSITIVE_INT),
        "is_active": BOOLEAN,
    },
    at_least_one=[
        "promotion_id",
        "booking_date",
        "booking_status",
        "traveler_ids",
        "is_active",
    ],
)

TRIP_BUDGET_QUERY = schema(optional={"include_breakdown": BOOLEAN})
TRIP_BUDGET_UPDATE_BODY = schema(
    optional={
        "estimated_total": NON_NEGATIVE_DECIMAL,
        "confirmed_total": NON_NEGATIVE_DECIMAL,
        "actual_spent": NON_NEGATIVE_DECIMAL,
    },
    at_least_one=["estimated_total", "confirmed_total", "actual_spent"],
)

TRIP_TRAVELER_CREATE_ITEM = schema(
    required={"traveler_id": POSITIVE_INT},
    optional={
        "start_date": DATE,
        "end_date": DATE,
        "participation_status": TEXT,
        "availability": TEXT,
    },
    rules=[date_order_rule("start_date", "end_date")],
)

TRIP_TRAVELER_UPDATE_ITEM = schema(
    required={"traveler_id": POSITIVE_INT},
    optional={
        "start_date": DATE,
        "end_date": DATE,
        "participation_status": TEXT,
        "availability": TEXT,
    },
    at_least_one=["start_date", "end_date", "participation_status", "availability"],
    rules=[date_order_rule("start_date", "end_date")],
)

TRIP_TRAVELERS_CREATE_BODY = schema(
    required={"items": list_field(object_field(TRIP_TRAVELER_CREATE_ITEM))}
)
TRIP_TRAVELERS_UPDATE_BODY = schema(
    required={"items": list_field(object_field(TRIP_TRAVELER_UPDATE_ITEM))}
)
TRIP_TRAVELERS_DELETE_BODY = schema(
    required={"traveler_ids": list_field(POSITIVE_INT)}
)

TRIP_TRAVELER_UPDATE_BODY = schema(
    optional={
        "start_date": DATE,
        "end_date": DATE,
        "participation_status": TEXT,
        "availability": TEXT,
    },
    at_least_one=["start_date", "end_date", "participation_status", "availability"],
    rules=[date_order_rule("start_date", "end_date")],
)

TRIP_TRAVELER_PREFERENCES_BODY = schema(
    optional={
        "food_preferences": list_field(TEXT),
        "lodging_preferences": list_field(TEXT),
        "activity_preferences": list_field(TEXT),
    },
    at_least_one=[
        "food_preferences",
        "lodging_preferences",
        "activity_preferences",
    ],
)

TRIP_PREFERENCES_QUERY = schema(
    optional={"group_by": enum_field("traveler", "category", "both")}
)
TRIP_PREFERENCES_DELETE_BODY = schema(
    required={"clear_all": BOOLEAN},
    rules=[must_be_true_rule("clear_all")],
)

TRIP_VOTES_CREATE_BODY = schema(
    required={
        "traveler_id": POSITIVE_INT,
        "listing_id": POSITIVE_INT,
        "vote_value": VOTE_VALUE,
    }
)
TRIP_VOTES_BULK_UPDATE_ITEM = schema(
    required={
        "traveler_id": POSITIVE_INT,
        "listing_id": POSITIVE_INT,
        "vote_value": VOTE_VALUE,
    }
)
TRIP_VOTES_BULK_UPDATE_BODY = schema(
    required={"items": list_field(object_field(TRIP_VOTES_BULK_UPDATE_ITEM))}
)
TRIP_VOTES_BULK_DELETE_ITEM = schema(
    required={"traveler_id": POSITIVE_INT, "listing_id": POSITIVE_INT}
)
TRIP_VOTES_BULK_DELETE_BODY = schema(
    required={"items": list_field(object_field(TRIP_VOTES_BULK_DELETE_ITEM))}
)

TRIP_TRAVELER_VOTE_BODY = schema(
    required={"listing_id": POSITIVE_INT, "vote_value": VOTE_VALUE}
)
TRIP_TRAVELER_VOTE_DELETE_BODY = schema(required={"listing_id": POSITIVE_INT})

TRIP_LISTING_VOTES_QUERY = schema(optional={"traveler_id": POSITIVE_INT})
TRIP_LISTING_VOTE_CREATE_BODY = schema(
    required={"traveler_id": POSITIVE_INT, "vote_value": VOTE_VALUE}
)
TRIP_LISTING_VOTE_DELETE_BODY = schema(required={"traveler_id": POSITIVE_INT})

TRIP_NOTIFICATIONS_QUERY = schema(
    optional={
        "traveler_id": POSITIVE_INT,
        "read_status": BOOLEAN,
        "type": TEXT,
    }
)
TRIP_NOTIFICATIONS_CREATE_BODY = schema(
    required={"traveler_ids": list_field(POSITIVE_INT), "message": TEXT},
    optional={"type": TEXT, "created_date": DATE, "read_status": BOOLEAN},
)
TRIP_NOTIFICATIONS_UPDATE_BODY = schema(
    required={"notification_ids": list_field(POSITIVE_INT), "read_status": BOOLEAN}
)
TRIP_NOTIFICATIONS_DELETE_BODY = schema(
    required={"notification_ids": list_field(POSITIVE_INT)}
)

LISTINGS_QUERY = schema(
    optional={
        "service_category": TEXT,
        "vendor_id": POSITIVE_INT,
        "availability": TEXT,
        "min_price": NON_NEGATIVE_DECIMAL,
        "max_price": NON_NEGATIVE_DECIMAL,
        "min_rating": RATING_DECIMAL,
        "listing_status": TEXT,
        "is_active": BOOLEAN,
    }
)
LISTING_CREATE_BODY = schema(
    required={
        "vendor_id": POSITIVE_INT,
        "service_category": TEXT,
        "price": NON_NEGATIVE_DECIMAL,
        "availability": TEXT,
    },
    optional={
        "operating_hours": TEXT,
        "description": TEXT,
        "promotional_notes": TEXT,
        "listing_status": TEXT,
        "traveler_rating": RATING_DECIMAL,
        "is_active": BOOLEAN,
    },
)
LISTING_UPDATE_BODY = schema(
    optional={
        "availability": TEXT,
        "operating_hours": TEXT,
        "price": NON_NEGATIVE_DECIMAL,
        "service_category": TEXT,
        "description": TEXT,
        "promotional_notes": TEXT,
        "listing_status": TEXT,
        "traveler_rating": RATING_DECIMAL,
        "is_active": BOOLEAN,
    },
    at_least_one=[
        "availability",
        "operating_hours",
        "price",
        "service_category",
        "description",
        "promotional_notes",
        "listing_status",
        "traveler_rating",
        "is_active",
    ],
)

LISTING_AMENITIES_ADD_BODY = schema(required={"amenities": list_field(TEXT)})
LISTING_AMENITIES_DELETE_BODY = schema(
    optional={"amenities": list_field(TEXT), "clear_all": BOOLEAN},
    at_least_one=["amenities", "clear_all"],
    rules=[must_be_true_rule("clear_all")],
)

VENDORS_QUERY = schema(
    optional={"is_active": BOOLEAN, "last_active_since": DATE}
)
VENDOR_CREATE_BODY = schema(
    required={"vendor_name": TEXT},
    optional={"last_active_date": DATE, "is_active": BOOLEAN},
)
VENDOR_UPDATE_BODY = schema(
    optional={"vendor_name": TEXT, "last_active_date": DATE, "is_active": BOOLEAN},
    at_least_one=["vendor_name", "last_active_date", "is_active"],
)

VENDOR_LISTINGS_QUERY = schema(
    optional={
        "include_booking_totals": BOOLEAN,
        "include_status_counts": BOOLEAN,
        "include_ratings": BOOLEAN,
        "include_interest_metrics": BOOLEAN,
    }
)
VENDOR_LISTING_CREATE_BODY = schema(
    required={
        "service_category": TEXT,
        "price": NON_NEGATIVE_DECIMAL,
        "availability": TEXT,
    },
    optional={
        "operating_hours": TEXT,
        "description": TEXT,
        "promotional_notes": TEXT,
        "listing_status": TEXT,
        "traveler_rating": RATING_DECIMAL,
        "is_active": BOOLEAN,
    },
)

PROMOTION_CREATE_BODY = schema(
    required={
        "title": TEXT,
        "discount_type": TEXT,
        "discount_value": NON_NEGATIVE_DECIMAL,
        "start_date": DATE,
        "end_date": DATE,
    },
    optional={"description": TEXT, "is_active": BOOLEAN},
    rules=[date_order_rule("start_date", "end_date")],
)
PROMOTION_UPDATE_BODY = schema(
    optional={
        "title": TEXT,
        "discount_type": TEXT,
        "discount_value": NON_NEGATIVE_DECIMAL,
        "start_date": DATE,
        "end_date": DATE,
        "description": TEXT,
        "is_active": BOOLEAN,
    },
    at_least_one=[
        "title",
        "discount_type",
        "discount_value",
        "start_date",
        "end_date",
        "description",
        "is_active",
    ],
    rules=[date_order_rule("start_date", "end_date")],
)
PROMOTION_BULK_UPDATE_ITEM = schema(
    required={"promotion_id": POSITIVE_INT},
    optional={
        "title": TEXT,
        "discount_type": TEXT,
        "discount_value": NON_NEGATIVE_DECIMAL,
        "start_date": DATE,
        "end_date": DATE,
        "description": TEXT,
        "is_active": BOOLEAN,
    },
    at_least_one=[
        "title",
        "discount_type",
        "discount_value",
        "start_date",
        "end_date",
        "description",
        "is_active",
    ],
    rules=[date_order_rule("start_date", "end_date")],
)
PROMOTION_BULK_UPDATE_BODY = schema(
    required={"items": list_field(object_field(PROMOTION_BULK_UPDATE_ITEM))}
)
PROMOTION_BULK_DELETE_BODY = schema(
    required={"promotion_ids": list_field(POSITIVE_INT)}
)

TRAVELERS_QUERY = schema(
    optional={
        "is_active": BOOLEAN,
        "availability": TEXT,
        "traveler_status": TEXT,
    }
)
TRAVELER_CREATE_BODY = schema(
    required={"first_name": TEXT, "last_name": TEXT},
    optional={
        "phone": TEXT,
        "email": TEXT,
        "availability": TEXT,
        "traveler_status": TEXT,
        "is_active": BOOLEAN,
    },
)
TRAVELER_UPDATE_BODY = schema(
    optional={
        "first_name": TEXT,
        "last_name": TEXT,
        "phone": TEXT,
        "email": TEXT,
        "availability": TEXT,
        "traveler_status": TEXT,
        "is_active": BOOLEAN,
    },
    at_least_one=[
        "first_name",
        "last_name",
        "phone",
        "email",
        "availability",
        "traveler_status",
        "is_active",
    ],
)

TRAVELER_NOTIFICATIONS_QUERY = schema(
    optional={"read_status": BOOLEAN, "type": TEXT}
)
TRAVELER_NOTIFICATION_CREATE_BODY = schema(
    required={"message": TEXT},
    optional={"type": TEXT, "created_date": DATE, "read_status": BOOLEAN},
)
TRAVELER_NOTIFICATIONS_UPDATE_BODY = schema(
    required={"notification_ids": list_field(POSITIVE_INT), "read_status": BOOLEAN}
)
TRAVELER_NOTIFICATIONS_DELETE_BODY = schema(
    required={"notification_ids": list_field(POSITIVE_INT)}
)
NOTIFICATION_UPDATE_BODY = schema(required={"read_status": BOOLEAN})
