import logging
from datetime import date, datetime

import altair as alt
import requests
import streamlit as st

from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

API_BASE = "http://api:4000"
BLUE = "#1E5AA8"
TEAL = "#2AA7A5"
GOLD = "#F2B84B"


def fetch_vendor_analytics():
    response = requests.get(f"{API_BASE}/analytics/vendors", timeout=10)
    response.raise_for_status()
    return response.json()


def parse_date(value):
    if not value:
        return None
    try:
        return datetime.strptime(str(value), "%Y-%m-%d").date()
    except ValueError:
        return None


def safe_int(value):
    try:
        return int(float(value))
    except (TypeError, ValueError):
        return 0


def safe_float(value):
    try:
        return float(value)
    except (TypeError, ValueError):
        return 0.0


def recency_bucket(last_active_date):
    if last_active_date is None:
        return "Unknown"

    days_since = (date.today() - last_active_date).days
    if days_since <= 30:
        return "Recent (30 days)"
    if days_since <= 90:
        return "Moderate (31-90 days)"
    return "Stale (90+ days)"


st.set_page_config(layout="wide")
SideBarLinks()

st.title("Vendor Performance")
st.write(
    "Compare vendor engagement, booking frequency, and traveler ratings across service "
    "categories to evaluate partner performance."
)

try:
    analytics_rows = fetch_vendor_analytics()
except Exception as exc:
    st.error(f"Could not load vendor analytics from the API: {exc}")
    st.warning(
        "This page is showing no fallback production metrics. Start the API or verify "
        "the `/analytics/vendors` route."
    )
    st.stop()

if not isinstance(analytics_rows, list):
    st.error("Unexpected analytics response format. Expected a list of vendor analytics rows.")
    st.stop()

normalized_rows = []
for row in analytics_rows:
    if not isinstance(row, dict):
        continue

    last_active = parse_date(row.get("last_active_date"))
    normalized_rows.append(
        {
            "vendor_id": row.get("vendor_id"),
            "vendor_name": row.get("vendor_name") or "Unknown Vendor",
            "service_category": row.get("service_category") or "Unknown",
            "booking_frequency": safe_int(row.get("booking_frequency")),
            "avg_rating": safe_float(row.get("average_traveler_rating")),
            "last_active_date": row.get("last_active_date"),
            "recent_status": recency_bucket(last_active),
        }
    )

if not normalized_rows:
    st.warning("The analytics route returned no usable vendor rows.")
    st.stop()

all_categories = sorted({row["service_category"] for row in normalized_rows})
all_statuses = sorted({row["recent_status"] for row in normalized_rows})

filter_col1, filter_col2 = st.columns(2)
with filter_col1:
    selected_category = st.selectbox("Service Category", ["All"] + all_categories)
with filter_col2:
    selected_status = st.selectbox("Vendor Recent Status", ["All"] + all_statuses)

filtered_rows = normalized_rows
if selected_category != "All":
    filtered_rows = [row for row in filtered_rows if row["service_category"] == selected_category]
if selected_status != "All":
    filtered_rows = [row for row in filtered_rows if row["recent_status"] == selected_status]

if not filtered_rows:
    st.warning("No vendor analytics matched the selected filters.")
    st.stop()

unique_vendor_ids = {row["vendor_id"] for row in filtered_rows if row["vendor_id"] is not None}
total_bookings = sum(row["booking_frequency"] for row in filtered_rows)
ratings = [row["avg_rating"] for row in filtered_rows if row["avg_rating"] > 0]
average_vendor_rating = (sum(ratings) / len(ratings)) if ratings else 0.0

kpi_col1, kpi_col2, kpi_col3 = st.columns(3)
with kpi_col1:
    with st.container(border=True):
        st.metric("Total Vendors", f"{len(unique_vendor_ids):,}")
with kpi_col2:
    with st.container(border=True):
        st.metric("Total Bookings", f"{total_bookings:,}")
with kpi_col3:
    with st.container(border=True):
        rating_display = f"{average_vendor_rating:.2f}" if ratings else "N/A"
        st.metric("Average Vendor Rating", rating_display)

table_rows = [
    {
        "vendor_id": row["vendor_id"],
        "vendor_name": row["vendor_name"],
        "service_category": row["service_category"],
        "booking_frequency": row["booking_frequency"],
        "avg_rating": round(row["avg_rating"], 2) if row["avg_rating"] else None,
        "last_active_date": row["last_active_date"],
        "recent_status": row["recent_status"],
    }
    for row in filtered_rows
]

st.subheader("Vendor Performance Table")
st.dataframe(table_rows, use_container_width=True, hide_index=True)

chart_col1, chart_col2 = st.columns(2)

with chart_col1:
    st.subheader("Booking Frequency by Vendor")
    booking_chart_rows = sorted(
        filtered_rows,
        key=lambda row: (row["booking_frequency"], row["vendor_name"]),
        reverse=True,
    )[:10]

    if booking_chart_rows:
        booking_chart_values = [
            {
                "vendor_label": f"#{row['vendor_id']} {row['vendor_name']}",
                "booking_frequency": row["booking_frequency"],
            }
            for row in booking_chart_rows
        ]
        booking_chart = alt.Chart(alt.Data(values=booking_chart_values)).mark_bar(
            color=TEAL,
            cornerRadiusTopRight=4,
            cornerRadiusBottomRight=4,
        ).encode(
            x=alt.X("booking_frequency:Q", title="Booking Frequency"),
            y=alt.Y("vendor_label:N", sort="-x", title="Vendor"),
            tooltip=[
                alt.Tooltip("vendor_label:N", title="Vendor"),
                alt.Tooltip("booking_frequency:Q", title="Booking Frequency"),
            ],
        ).properties(height=320)
        st.altair_chart(booking_chart, use_container_width=True)
    else:
        st.warning("The analytics data did not include chartable booking frequency values.")

with chart_col2:
    st.subheader("Average Rating by Vendor")
    rating_chart_rows = [row for row in filtered_rows if row["avg_rating"] > 0]
    rating_chart_rows = sorted(
        rating_chart_rows,
        key=lambda row: (row["avg_rating"], row["vendor_name"]),
        reverse=True,
    )[:10]

    if rating_chart_rows:
        rating_chart_values = [
            {
                "vendor_label": f"#{row['vendor_id']} {row['vendor_name']}",
                "avg_rating": row["avg_rating"],
            }
            for row in rating_chart_rows
        ]
        rating_chart = alt.Chart(alt.Data(values=rating_chart_values)).mark_bar(
            color=GOLD,
            cornerRadiusTopRight=4,
            cornerRadiusBottomRight=4,
        ).encode(
            x=alt.X("avg_rating:Q", title="Average Rating"),
            y=alt.Y("vendor_label:N", sort="-x", title="Vendor"),
            tooltip=[
                alt.Tooltip("vendor_label:N", title="Vendor"),
                alt.Tooltip("avg_rating:Q", title="Average Rating", format=".2f"),
            ],
        ).properties(height=320)
        st.altair_chart(rating_chart, use_container_width=True)
    else:
        st.warning("No vendor rating values were available to chart from the current analytics response.")

st.caption(
    "Data source: `/analytics/vendors`. Recent-status filtering is derived from `last_active_date` "
    "because the analytics response does not currently expose a direct active/inactive flag."
)
