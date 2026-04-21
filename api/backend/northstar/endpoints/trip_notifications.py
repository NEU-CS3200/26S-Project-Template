from backend.northstar.endpoint_utils import make_query, multi_query, placeholder_list, select_payload


def get_trip_notifications(validated):
    trip_id = validated["path"]["trip_id"]
    query = validated["query"]
    clauses = ["tt.trip_id = %s"]
    params = [trip_id]

    if "traveler_id" in query:
        clauses.append("n.traveler_id = %s")
        params.append(query["traveler_id"])
    if "read_status" in query:
        clauses.append("n.read_status = %s")
        params.append(query["read_status"])
    if "type" in query:
        clauses.append("n.type = %s")
        params.append(query["type"])

    sql = """
        SELECT
            n.notification_id,
            n.traveler_id,
            n.type,
            n.message,
            n.created_date,
            n.read_status
        FROM Notification n
        JOIN Trip_Traveler tt ON tt.traveler_id = n.traveler_id
    """
    return select_payload(
        sql,
        filters=(clauses, params),
        order_by="n.created_date DESC, n.notification_id DESC",
        notes=[
            "Trip-scoped notifications are inferred through Trip_Traveler because Notification currently stores traveler_id only.",
        ],
    )


def post_trip_notifications(validated):
    body = validated["body"]
    queries = []
    for traveler_id in body["traveler_ids"]:
        queries.append(
            make_query(
                """
                INSERT INTO Notification (traveler_id, type, message, created_date, read_status)
                VALUES (%s, %s, %s, %s, %s)
                """,
                [
                    traveler_id,
                    body.get("type", "trip_update"),
                    body["message"],
                    body.get("created_date"),
                    body.get("read_status", False),
                ],
                name=f"trip_notification_{traveler_id}",
            )
        )
    return multi_query(
        queries,
        notes=[
            "Trip identity is carried by the API route; the current Notification table does not persist trip_id directly.",
        ],
    )


def put_trip_notifications(validated):
    body = validated["body"]
    placeholders = placeholder_list(len(body["notification_ids"]))
    return make_query(
        f"""
        UPDATE Notification
        SET read_status = %s
        WHERE notification_id IN ({placeholders})
        """,
        [body["read_status"], *body["notification_ids"]],
        name="bulk_update_trip_notifications",
    )


def delete_trip_notifications(validated):
    notification_ids = validated["body"]["notification_ids"]
    placeholders = placeholder_list(len(notification_ids))
    return make_query(
        f"DELETE FROM Notification WHERE notification_id IN ({placeholders})",
        notification_ids,
        name="bulk_delete_trip_notifications",
    )
