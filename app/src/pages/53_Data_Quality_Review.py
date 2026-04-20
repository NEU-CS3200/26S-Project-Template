import logging

import requests
import streamlit as st

from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

API_BASE = "http://api:4000"
QUALITY_ROUTE = "/analytics/data-quality/trips"


def fetch_flagged_trips():
    response = requests.get(f"{API_BASE}{QUALITY_ROUTE}", timeout=10)
    response.raise_for_status()
    return response.json()


def severity_for_issue(issue_type):
    severity_map = {
        "inactive_trip_with_active_bookings": "High",
        "invalid_date_range": "High",
        "missing_dates": "Medium",
        "missing_destination": "Low",
        "review_required": "Low",
    }
    return severity_map.get(issue_type, "Low")


def planner_label(planner_id):
    if planner_id in (None, ""):
        return "Unknown Planner"
    return f"Planner {planner_id}"


def issue_label(issue_type):
    label_map = {
        "missing_destination": "Missing destination",
        "missing_dates": "Missing dates",
        "invalid_date_range": "Invalid date range",
        "inactive_trip_with_active_bookings": "Inactive trip with active bookings",
        "review_required": "Review required",
    }
    return label_map.get(issue_type or "", str(issue_type).replace("_", " ").title())


def vendor_label(_row):
    # The current analytics route does not expose vendor information for flagged records.
    return "Not available"


def last_updated_label(_row):
    # The current analytics route does not expose a last-updated timestamp.
    return "Not available"


st.set_page_config(layout="wide")
SideBarLinks()

st.title("Data Integrity: Problem Trip Records")
st.write("Audit and review incomplete, outdated, or inconsistent trip records for platform maintenance.")

try:
    api_rows = fetch_flagged_trips()
except Exception as exc:
    st.error(f"Could not load data-quality trip records from the API: {exc}")
    st.warning(
        "This page is not inventing fallback production data. Please verify the API and "
        "the `/analytics/data-quality/trips` route."
    )
    st.stop()

if not isinstance(api_rows, list):
    st.error("Unexpected response format from the data-quality route. Expected a list of trip records.")
    st.stop()

records = []
for row in api_rows:
    if not isinstance(row, dict):
        continue
    issue_type = row.get("data_quality_issue", "review_required")
    severity = severity_for_issue(issue_type)
    records.append(
        {
            "trip_id": row.get("trip_id"),
            "trip_name": row.get("trip_name") or "Unnamed Trip",
            "planner_id": row.get("planner_id"),
            "planner": planner_label(row.get("planner_id")),
            "vendor": vendor_label(row),
            "problem_field": issue_label(issue_type),
            "issue_type": issue_type,
            "issue_label": issue_label(issue_type),
            "severity": severity,
            "last_updated": last_updated_label(row),
            "destination": row.get("destination"),
            "trip_status": row.get("trip_status"),
            "start_date": row.get("start_date"),
            "end_date": row.get("end_date"),
            "group_size": row.get("group_size"),
        }
    )

if not records:
    st.warning("The data-quality route returned no flagged trip records.")
    st.stop()

severity_counts = {
    "High": sum(1 for row in records if row["severity"] == "High"),
    "Medium": sum(1 for row in records if row["severity"] == "Medium"),
    "Low": sum(1 for row in records if row["severity"] == "Low"),
}

summary_cols = st.columns(4)
with summary_cols[0]:
    with st.container(border=True):
        st.metric("High Severity", severity_counts["High"])
with summary_cols[1]:
    with st.container(border=True):
        st.metric("Medium Severity", severity_counts["Medium"])
with summary_cols[2]:
    with st.container(border=True):
        st.metric("Low Severity", severity_counts["Low"])
with summary_cols[3]:
    with st.container(border=True):
        st.metric("Total Flagged Records", len(records))

st.divider()

issue_options = sorted({row["issue_label"] for row in records})
planner_options = sorted({row["planner"] for row in records})

filter_cols = st.columns(5)
with filter_cols[0]:
    selected_issue = st.selectbox("Issue Type", ["All Issues"] + issue_options)
with filter_cols[1]:
    selected_planner = st.selectbox("Planner", ["All Planners"] + planner_options)
with filter_cols[2]:
    selected_vendor = st.selectbox("Vendor", ["All Vendors", "Not available"])
with filter_cols[3]:
    selected_last_updated = st.selectbox("Last Updated", ["Any", "Not available"])
with filter_cols[4]:
    search_query = st.text_input("Search Trips", placeholder="ID, name, destination")

if selected_vendor != "All Vendors":
    st.info("Vendor filtering is limited because the current data-quality route does not return vendor data.")
if selected_last_updated != "Any":
    st.info("Last Updated filtering is limited because the current data-quality route does not return timestamps.")

filtered_records = records
if selected_issue != "All Issues":
    filtered_records = [row for row in filtered_records if row["issue_label"] == selected_issue]
if selected_planner != "All Planners":
    filtered_records = [row for row in filtered_records if row["planner"] == selected_planner]
if selected_vendor == "Not available":
    filtered_records = [row for row in filtered_records if row["vendor"] == "Not available"]
if selected_last_updated == "Not available":
    filtered_records = [row for row in filtered_records if row["last_updated"] == "Not available"]
if search_query.strip():
    term = search_query.strip().lower()
    filtered_records = [
        row
        for row in filtered_records
        if term in str(row["trip_id"]).lower()
        or term in row["trip_name"].lower()
        or term in str(row.get("destination") or "").lower()
    ]

if not filtered_records:
    st.warning("No flagged trip records matched the selected filters.")
    st.stop()

left_col, right_col = st.columns([2.3, 1])

with left_col:
    st.subheader("Flagged Trip Records")
    table_rows = [
        {
            "Trip ID": row["trip_id"],
            "Trip Name": row["trip_name"],
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
    st.write(f"**Planner:** {selected_record['planner']}")
    st.write(f"**Vendor:** {selected_record['vendor']}")
    st.write(f"**Issue:** {selected_record['issue_label']}")
    st.write(f"**Severity:** {selected_record['severity']}")
    st.write(f"**Destination:** {selected_record.get('destination') or 'Missing'}")
    st.write(f"**Trip Status:** {selected_record.get('trip_status') or 'Missing'}")
    st.write(f"**Start Date:** {selected_record.get('start_date') or 'Missing'}")
    st.write(f"**End Date:** {selected_record.get('end_date') or 'Missing'}")
    st.write(f"**Group Size:** {selected_record.get('group_size') or 'Missing'}")

    st.divider()
    st.subheader("Workflow Actions")
    st.caption(
        "The current backend exposes a read-only analytics route for flagged trip records. "
        "No dedicated workflow update route currently exists for these statuses."
    )

    st.button("Mark in progress", disabled=True, use_container_width=True)
    st.button("Mark fixed", disabled=True, use_container_width=True)
    st.button("False positive", disabled=True, use_container_width=True)

    st.warning(
        "Workflow buttons are disabled because no matching PUT/DELETE route exists for "
        "data-quality review state changes."
    )

st.caption(
    f"Data source: `{QUALITY_ROUTE}`. Severity is derived in the UI from the returned "
    "`data_quality_issue` field because the backend does not currently send an explicit severity column."
)
