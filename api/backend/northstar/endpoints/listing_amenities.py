from backend.northstar.endpoint_utils import delete_payload, make_query, multi_query, select_payload


def get_listing_amenities(validated):
    listing_id = validated["path"]["listing_id"]
    sql = """
        SELECT
            listing_id,
            amenity
        FROM Listing_Amenity
    """
    return select_payload(
        sql,
        filters=(["listing_id = %s"], [listing_id]),
        order_by="amenity",
    )


def post_listing_amenities(validated):
    listing_id = validated["path"]["listing_id"]
    queries = _amenity_insert_queries(listing_id, validated["body"]["amenities"])
    return multi_query(queries)


def put_listing_amenities(validated):
    listing_id = validated["path"]["listing_id"]
    queries = [
        delete_payload(
            "Listing_Amenity",
            where_clause="listing_id = %s",
            where_params=[listing_id],
            notes=["Replace the listing's full amenity set with the supplied payload."],
        )
    ]
    queries.extend(_amenity_insert_queries(listing_id, validated["body"]["amenities"]))
    return multi_query(queries)


def delete_listing_amenities(validated):
    listing_id = validated["path"]["listing_id"]
    body = validated["body"]
    if body.get("clear_all"):
        return delete_payload(
            "Listing_Amenity",
            where_clause="listing_id = %s",
            where_params=[listing_id],
        )

    queries = []
    for index, amenity in enumerate(body.get("amenities", []), start=1):
        queries.append(
            make_query(
                "DELETE FROM Listing_Amenity WHERE listing_id = %s AND amenity = %s",
                [listing_id, amenity],
                name=f"delete_amenity_{index}",
            )
        )
    return multi_query(queries)


def _amenity_insert_queries(listing_id, amenities):
    queries = []
    for index, amenity in enumerate(amenities, start=1):
        queries.append(
            make_query(
                "INSERT INTO Listing_Amenity (listing_id, amenity) VALUES (%s, %s)",
                [listing_id, amenity],
                name=f"amenity_insert_{index}",
            )
        )
    return queries
