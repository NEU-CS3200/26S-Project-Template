from backend.northstar.endpoint_utils import (
    collect_fields,
    deactivate_payload,
    select_payload,
    update_payload,
)


PROMOTION_UPDATE_FIELDS = [
    "title",
    "discount_type",
    "discount_value",
    "start_date",
    "end_date",
    "description",
    "is_active",
]


def get_promotion_detail(validated):
    promotion_id = validated["path"]["promotion_id"]
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
    return select_payload(sql, filters=(["promotion_id = %s"], [promotion_id]))


def put_promotion_detail(validated):
    promotion_id = validated["path"]["promotion_id"]
    values = collect_fields(validated["body"], PROMOTION_UPDATE_FIELDS)
    return update_payload(
        "Promotion",
        values,
        where_clause="promotion_id = %s",
        where_params=[promotion_id],
    )


def delete_promotion_detail(validated):
    promotion_id = validated["path"]["promotion_id"]
    return deactivate_payload(
        "Promotion",
        where_clause="promotion_id = %s",
        where_params=[promotion_id],
    )
