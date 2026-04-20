import logging
import os
from datetime import date, datetime

import requests
import streamlit as st

from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

API_BASE = os.getenv("API_BASE", "http://api:4000")
QUALITY_ROUTE = "/analytics/data-quality/trips"

CORAL = "#E76F51"
GOLD = "#F2B84B"
TEAL = "#2AA7A5"
BLUE = "#1E5AA8"
NAVY = "#0B1F3A"
GRAY = "#6B7280"


def fetch_flagged_trips():
    response = requests.get(f"{API_BASE}{QUALITY_ROUTE}", timeout=10)
    response.raise_for_status()
    return response.json()


def normalize_api_rows(payload):
    """
    Accepts either:
    - a direct list of rows
    - a wrapped dict such as {"data": [...]}, {"rows": [...]}, {"result": [...]}
    """
    if isinstance(payload, list):
        return payload

    if isinstance(payload, dict):
        for key in ("data", "rows", "result", "results", "records"):
            value = payload.get(key)
            if isinstance(value, list):
                return value

    return None


def is_missing(value):
    return value is None or value == ""


def parse_date(value):
    if value in (None, ""):
        return None

    if isinstance(value, date):
        return value

    try:
        return datetime.fromisoformat(str(value)).date()
    except ValueError:
        return None


def infer_issue_type(row):
    """
    Fallback issue inference in case the API returns trip rows but does not include
    a data_quality_issue field.
    """
    if is_missing(row.get("destination")):
        return "missing_destination"

    if is_missing(row.get("start_date")) or is_missing(row.get("end_date")):
        return "missing_dates"

    start = parse_date(row.get("start_date"))
    end = parse_date(row.get("end_date"))
    if start and end and start > end:
        return "invalid_date_range"

    if is_missing(row.get("group_size")):
        return "missing_group_size"

    if is_missing(row.get("total_spent")):
        return "missing_total_spent"

    if row.get("is_active") in (False, 0, "0") and row.get("active_booking_count", 0):
        return "inactive_trip_with_active_bookings"

    return row.get("data_quality_issue") or "review_required"


def severity_for_issue(issue_type):
    severity_map = {
        "inactive_trip_with_active_bookings": "High",
        "invalid_date_range": "High",
        "missing_dates": "Medium",
        "missing_group_size": "Medium",
        "missing_total_spent": "Medium",
        "missing_destination": "Low",
        "review_required": "Low",
    }
    return severity_map.get(issue_type, "Low")


def issue_label(issue_type):
    label_map = {
        "missing_destination": "Missing destination",
        "missing_dates": "Missing dates",
        "invalid_date_range": "Invalid date range",
        "inactive_trip_with_active_bookings": "Inactive trip with active bookings",
        "missing_group_size": "Missing group size",
        "missing_total_spent": "Missing total spent",
        "review_required": "Review required",
    }
    return label_map.get(issue_type or "", str(issue_type).replace("_", " ").title())


def planner_label(row):
    planner_name = row.get("planner_name") or row.get("primary_planner")
    if planner_name:
        return planner_name

    planner_id = row.get("planner_id")
    if planner_id in (None, ""):
        return "Unknown Planner"

    return f"Planner {planner_id}"


def traveler_label(row):
    traveler_name = row.get("primary_traveler") or row.get("traveler_name")
    if traveler_name:
        return traveler_name

    traveler_id = row.get("traveler_id")
    if traveler_id not in (None, ""):
        return f"Traveler {traveler_id}"

    return "Not available"


def vendor_label(row):
    vendor_name = row.get("vendor_name") or row.get("vendor")
    if vendor_name:
        return vendor_name

    vendor_id = row.get("vendor_id")
    if vendor_id not in (None, ""):
        return f"Vendor {vendor_id}"

    return "Not available"


def last_updated_label(row):
    return (
        row.get("last_updated")
        or row.get("updated_at")
        or row.get("date_booked")
        or row.get("booking_date")
        or "Not available"
    )


def problem_field_for_issue(issue_type):
    field_map = {
        "missing_destination": "Destination",
        "missing_dates": "Start / End Date",
        "invalid_date_range": "Travel Dates",
        "inactive_trip_with_active_bookings": "Trip Status / Bookings",
        "missing_group_size": "Group Size",
        "missing_total_spent": "Total Spent",
        "review_required": "Trip Record",
    }
    return field_map.get(issue_type, "Trip Record")


def build_records(api_rows):
    records = []

    for row in api_rows:
        if not isinstance(row, dict):
            continue

        issue_type = infer_issue_type(row)
        severity = severity_for_issue(issue_type)

        records.append(
            {
                "trip_id": row.get("trip_id"),
                "trip_name": row.get("trip_name") or "Unnamed Trip",
                "primary_traveler": traveler_label(row),
                "planner": planner_label(row),
                "vendor": vendor_label(row),
                "problem_field": row.get("problem_field") or problem_field_for_issue(issue_type),
                "issue_type": issue_type,
                "issue_label": issue_label(issue_type),
                "severity": row.get("severity") or severity,
                "last_updated": last_updated_label(row),
                "destination": row.get("destination"),
                "trip_status": row.get("trip_status"),
                "start_date": row.get("start_date"),
                "end_date": row.get("end_date"),
                "group_size": row.get("group_size"),
                "total_spent": row.get("total_spent"),
                "raw": row,
            }
        )

    return records


def severity_card(label, value, color):
    st.markdown(
        f"""
        <div style="
            border: 1px solid #d1d5db;
            border-radius: 0.75rem;
            padding: 1rem 1.25rem;
            min-height: 7rem;
            background-color: #ffffff;
        ">
            <div style="font-size: 0.95rem; color: {GRAY}; font-weight: 600;">{label}</div>
            <div style="font-size: 2rem; color: {color}; font-weight: 700; margin-top: 0.35rem;">{value}</div>
        </div>
        """,
        unsafe_allow_html=True,
    )


def render_empty_state():
    st.warning("The data-quality route returned no flagged trip records.")
    st.info(
        "This usually means the current mock database does not contain trips with NULL, "
        "missing, or inconsistent fields. To demonstrate this workflow, add a few intentionally "
        "problematic Trip records to the mock SQL data, then recreate the database container."
    )

    summary_cols = st.columns(4)
    with summary_cols[0]:
        severity_card("High Severity", 0, CORAL)
    with summary_cols[1]:
        severity_card("Medium Severity", 0, GOLD)
    with summary_cols[2]:
        severity_card("Low Severity", 0, TEAL)
    with summary_cols[3]:
        severity_card("Total Flagged Records", 0, GRAY)

    st.divider()
    st.subheader("Flagged Trip Records")
    st.dataframe(
        [
            {
                "Trip ID": None,
                "Trip Name": "No flagged records returned",
                "Primary Traveler": "",
                "Planner": "",
                "Vendor": "",
                "Problem Field": "",
                "Issue Type": "",
                "Severity": "",
                "Last Updated": "",
            }
        ],
        use_container_width=True,
        hide_index=True,
    )

    st.caption(
        f"Data source: `{QUALITY_ROUTE}`. The page loaded successfully, but the backend "
        "did not return records to review."
    )


st.set_page_config(layout="wide")
SideBarLinks()

st.title("Data Integrity: Problem Trip Records")
st.write("Audit and review incomplete, outdated, or inconsistent trip records for platform maintenance.")

try:
    payload = fetch_flagged_trips()
except Exception as exc:
    st.error(f"Could not load data-quality trip records from the API: {exc}")
    st.warning(
        "This page is not inventing fallback production data. Please verify the API service "
        f"and the `{QUALITY_ROUTE}` route."
    )
    st.stop()

api_rows = normalize_api_rows(payload)

if api_rows is None:
    st.error(
        "Unexpected response format from the data-quality route. Expected a list of trip records "
        "or a dictionary containing a list under data, rows, result, results, or records."
    )
    st.json(payload)
    st.stop()

records = build_records(api_rows)

if not records:
    render_empty_state()
    st.stop()

severity_counts = {
    "High": sum(1 for row in records if row["severity"] == "High"),
    "Medium": sum(1 for row in records if row["severity"] == "Medium"),
    "Low": sum(1 for row in records if row["severity"] == "Low"),
}

summary_cols = st.columns(4)
with summary_cols[0]:
    severity_card("High Severity", severity_counts["High"], CORAL)
with summary_cols[1]:
    severity_card("Medium Severity", severity_counts["Medium"], GOLD)
with summary_cols[2]:
    severity_card("Low Severity", severity_counts["Low"], TEAL)
with summary_cols[3]:
    severity_card("Total Flagged Records", len(records), GRAY)

st.divider()

issue_options = sorted({row["issue_label"] for row in records})
planner_options = sorted({row["planner"] for row in records})
vendor_options = sorted({row["vendor"] for row in records})
last_updated_options = sorted({row["last_updated"] for row in records})

filter_cols = st.columns(5)

with filter_cols[0]:
    selected_issue = st.selectbox("Issue Type", ["All Issues"] + issue_options)

with filter_cols[1]:
    selected_planner = st.selectbox("Planner", ["All Planners"] + planner_options)

with filter_cols[2]:
    selected_vendor = st.selectbox("Vendor", ["All Vendors"] + vendor_options)

with filter_cols[3]:
    selected_last_updated = st.selectbox("Last Updated", ["Any"] + last_updated_options)

with filter_cols[4]:
    search_query = st.text_input("Search Trips", placeholder="ID, name, destination")

if "Not available" in vendor_options:
    st.caption("Some vendor values are unavailable because the current data-quality route may not expose vendor data.")

if "Not available" in last_updated_options:
    st.caption("Some last-updated values are unavailable because the current route may not expose timestamps.")

filtered_records = records

if selected_issue != "All Issues":
    filtered_records = [row for row in filtered_records if row["issue_label"] == selected_issue]

if selected_planner != "All Planners":
    filtered_records = [row for row in filtered_records if row["planner"] == selected_planner]

if selected_vendor != "All Vendors":
    filtered_records = [row for row in filtered_records if row["vendor"] == selected_vendor]

if selected_last_updated != "Any":
    filtered_records = [row for row in filtered_records if row["last_updated"] == selected_last_updated]

if search_query.strip():
    term = search_query.strip().lower()
    filtered_records = [
        row
        for row in filtered_records
        if term in str(row["trip_id"]).lower()
        or term in row["trip_name"].lower()
        or term in str(row.get("destination") or "").lower()
        or term in str(row.get("primary_traveler") or "").lower()
        or term in str(row.get("planner") or "").lower()
    ]

if not filtered_records:
    st.warning("No flagged trip records matched the selected filters.")
    st.stop()

left_col, right_col = st.columns([2.4, 1])

with left_col:
    st.subheader("Flagged Trip Records")

    table_rows = [
        {
            "Trip ID": row["trip_id"],
            "Trip Name": row["trip_name"],
            "Primary Traveler": row["primary_traveler"],
            "Planner": row["planner"],
            "Vendor": row["vendor"],
            "Problem Field": row["problem_field"],
            "Issue Type": row["issue_label"],
            "Severity": row["severity"],
            "Last Updated": row["last_updated"],
        }
        for row in filtered_records
    ]

    st.dataframe(table_rows, use_container_width=True, hide_index=True)

    record_options = {
        f"#{row['trip_id']} - {row['trip_name']} ({row['severity']})": row
        for row in filtered_records
    }

    selected_key = st.selectbox("Selected Trip Record", list(record_options.keys()))
    selected_record = record_options[selected_key]

with right_col:
    st.subheader("Selected Trip Detail")

    st.markdown(f"**Trip:** {selected_record['trip_name']}")
    st.write(f"**Trip ID:** {selected_record['trip_id']}")
    st.write(f"**Primary Traveler:** {selected_record['primary_traveler']}")
    st.write(f"**Planner:** {selected_record['planner']}")
    st.write(f"**Vendor:** {selected_record['vendor']}")
    st.write(f"**Issue:** {selected_record['issue_label']}")
    st.write(f"**Severity:** {selected_record['severity']}")
    st.write(f"**Destination:** {selected_record.get('destination') or 'Missing'}")
    st.write(f"**Trip Status:** {selected_record.get('trip_status') or 'Missing'}")
    st.write(f"**Start Date:** {selected_record.get('start_date') or 'Missing'}")
    st.write(f"**End Date:** {selected_record.get('end_date') or 'Missing'}")
    st.write(f"**Group Size:** {selected_record.get('group_size') or 'Missing'}")
    st.write(f"**Total Spent:** {selected_record.get('total_spent') if selected_record.get('total_spent') is not None else 'Missing'}")

    st.divider()
    st.subheader("Workflow Actions")

    st.caption(
        "The current backend exposes a read-only analytics route for flagged trip records. "
        "No dedicated workflow update route currently exists for these review statuses."
    )

    st.button("Mark in progress", disabled=True, use_container_width=True)
    st.button("Mark fixed", disabled=True, use_container_width=True)
    st.button("False positive", disabled=True, use_container_width=True)

    st.warning(
        "Workflow buttons are disabled because no matching PUT/DELETE route exists for "
        "data-quality review state changes."
    )

st.caption(
    f"Data source: `{QUALITY_ROUTE}`. Severity is derived from the returned issue field "
    "or inferred from missing/inconsistent trip fields when the backend does not provide one."
)