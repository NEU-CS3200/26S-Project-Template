from backend.northstar.endpoint_utils import (
    collect_fields,
    insert_payload,
    make_query,
    placeholder_list,
    select_payload,
)


TRAVELER_NOTIFICATION_FIELDS = ["message", "type", "created_date", "read_status"]


def get_traveler_notifications(validated):
    traveler_id = validated["path"]["traveler_id"]
    query = validated["query"]
    clauses = ["traveler_id = %s"]
    params = [traveler_id]
    if "read_status" in query:
        clauses.append("read_status = %s")
        params.append(query["read_status"])
    if "type" in query:
        clauses.append("type = %s")
        params.append(query["type"])

    sql = """
        SELECT
            notification_id,
            traveler_id,
            type,
            message,
            created_date,
            read_status
        FROM Notification
    """
    return select_payload(
        sql,
        filters=(clauses, params),
        order_by="created_date DESC, notification_id DESC",
    )


def post_traveler_notifications(validated):
    traveler_id = validated["path"]["traveler_id"]
    values = collect_fields(validated["body"], TRAVELER_NOTIFICATION_FIELDS)
    values["traveler_id"] = traveler_id
    values.setdefault("read_status", False)
    return insert_payload("Notification", values)


def put_traveler_notifications(validated):
    body = validated["body"]
    placeholders = placeholder_list(len(body["notification_ids"]))
    return make_query(
        f"""
        UPDATE Notification
        SET read_status = %s
        WHERE traveler_id = %s AND notification_id IN ({placeholders})
        """,
        [body["read_status"], validated["path"]["traveler_id"], *body["notification_ids"]],
        name="bulk_update_traveler_notifications",
    )


def delete_traveler_notifications(validated):
    notification_ids = validated["body"]["notification_ids"]
    placeholders = placeholder_list(len(notification_ids))
    return make_query(
        f"""
        DELETE FROM Notification
        WHERE traveler_id = %s AND notification_id IN ({placeholders})
        """,
        [validated["path"]["traveler_id"], *notification_ids],
        name="bulk_delete_traveler_notifications",
    )
