from __future__ import annotations


def make_query(sql, params=None, *, name=None):
    payload = {
        "sql": sql.strip(),
        "params": list(params or []),
    }
    if name:
        payload["name"] = name
    return payload


def single_query(sql, params=None, *, name=None, notes=None):
    payload = make_query(sql, params, name=name)
    if notes:
        payload["notes"] = notes
    return payload


def multi_query(queries, *, notes=None):
    payload = {"queries": queries}
    if notes:
        payload["notes"] = notes
    return payload


def collect_fields(data, field_names):
    return {field_name: data[field_name] for field_name in field_names if field_name in data}


def placeholder_list(count):
    return ", ".join(["%s"] * count)


def build_where(filters, *, equals=None, comparisons=None):
    clauses = []
    params = []

    for field_name, column_name in (equals or {}).items():
        if field_name in filters:
            clauses.append(f"{column_name} = %s")
            params.append(filters[field_name])

    for field_name, (column_name, operator) in (comparisons or {}).items():
        if field_name in filters:
            clauses.append(f"{column_name} {operator} %s")
            params.append(filters[field_name])

    return clauses, params


def select_payload(
    base_sql,
    *,
    filters=None,
    params=None,
    group_by=None,
    order_by=None,
    name=None,
    notes=None,
):
    sql = base_sql.strip()
    payload_params = list(params or [])

    if filters:
        clauses, filter_params = filters
        if clauses:
            sql += "\nWHERE " + " AND ".join(clauses)
            payload_params.extend(filter_params)

    if group_by:
        sql += f"\nGROUP BY {group_by}"

    if order_by:
        sql += f"\nORDER BY {order_by}"

    return single_query(sql, payload_params, name=name, notes=notes)


def insert_payload(table_name, values, *, notes=None):
    columns = ", ".join(values.keys())
    placeholders = ", ".join(["%s"] * len(values))
    sql = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
    return single_query(sql, list(values.values()), notes=notes)


def update_payload(table_name, values, *, where_clause, where_params, notes=None):
    assignments = ", ".join(f"{column} = %s" for column in values)
    sql = f"UPDATE {table_name} SET {assignments} WHERE {where_clause}"
    params = list(values.values()) + list(where_params)
    return single_query(sql, params, notes=notes)


def deactivate_payload(
    table_name,
    *,
    where_clause,
    where_params,
    active_column="is_active",
    notes=None,
):
    sql = f"UPDATE {table_name} SET {active_column} = %s WHERE {where_clause}"
    params = [False] + list(where_params)
    return single_query(sql, params, notes=notes)


def delete_payload(table_name, *, where_clause, where_params, notes=None):
    sql = f"DELETE FROM {table_name} WHERE {where_clause}"
    return single_query(sql, list(where_params), notes=notes)
