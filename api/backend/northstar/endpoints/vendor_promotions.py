from backend.northstar.endpoint_utils import (
    collect_fields,
    insert_payload,
    make_query,
    multi_query,
    placeholder_list,
    select_payload,
    update_payload,
)


PROMOTION_FIELDS = [
    "title",
    "discount_type",
    "discount_value",
    "start_date",
    "end_date",
    "description",
    "is_active",
]


def get_vendor_promotions(validated):
    vendor_id = validated["path"]["vendor_id"]
    sql = """
        SELECT
            promotion_id,
            vendor_id,
            title,
            discount_type,
            discount_value,
            start_date,
            end_date,
            description,
            is_active
        FROM Promotion
    """
    return select_payload(
        sql,
        filters=(["vendor_id = %s"], [vendor_id]),
        order_by="start_date DESC, promotion_id DESC",
    )


def post_vendor_promotions(validated):
    vendor_id = validated["path"]["vendor_id"]
    values = collect_fields(validated["body"], PROMOTION_FIELDS)
    values["vendor_id"] = vendor_id
    values.setdefault("is_active", True)
    return insert_payload("Promotion", values)


def put_vendor_promotions(validated):
    vendor_id = validated["path"]["vendor_id"]
    queries = []
    for index, item in enumerate(validated["body"]["items"], start=1):
        promotion_id = item["promotion_id"]
        values = collect_fields(item, PROMOTION_FIELDS)
        queries.append(
            update_payload(
                "Promotion",
                values,
                where_clause="vendor_id = %s AND promotion_id = %s",
                where_params=[vendor_id, promotion_id],
                notes=[f"Bulk vendor promotion update item {index}."],
            )
        )
    return multi_query(queries)


def delete_vendor_promotions(validated):
    vendor_id = validated["path"]["vendor_id"]
    promotion_ids = validated["body"]["promotion_ids"]
    placeholders = placeholder_list(len(promotion_ids))
    return make_query(
        f"""
        UPDATE Promotion
        SET is_active = %s
        WHERE vendor_id = %s AND promotion_id IN ({placeholders})
        """,
        [False, vendor_id, *promotion_ids],
        name="bulk_deactivate_vendor_promotions",
    )
