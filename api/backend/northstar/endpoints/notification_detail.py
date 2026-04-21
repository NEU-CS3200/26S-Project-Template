from backend.northstar.endpoint_utils import delete_payload, select_payload, update_payload


def get_notification_detail(validated):
    notification_id = validated["path"]["notification_id"]
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
    return select_payload(sql, filters=(["notification_id = %s"], [notification_id]))


def put_notification_detail(validated):
    notification_id = validated["path"]["notification_id"]
    return update_payload(
        "Notification",
        {"read_status": validated["body"]["read_status"]},
        where_clause="notification_id = %s",
        where_params=[notification_id],
    )


def delete_notification_detail(validated):
    notification_id = validated["path"]["notification_id"]
    return delete_payload(
        "Notification",
        where_clause="notification_id = %s",
        where_params=[notification_id],
    )
