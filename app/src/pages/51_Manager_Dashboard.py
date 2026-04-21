import logging
from datetime import datetime

import altair as alt
import requests
import streamlit as st

from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

API_BASE = "http://api:4000"
DATE_RANGE_OPTIONS = ["Last 30 Days", "Last 90 Days", "Year to Date", "All Time"]
NAVY = "#0B1F3A"
BLUE = "#1E5AA8"
SKY = "#5DADEC"
TEAL = "#2AA7A5"
GOLD = "#F2B84B"
CORAL = "#E76F51"


def fetch_json(path):
    response = requests.get(f"{API_BASE}{path}", timeout=10)
    response.raise_for_status()
    return response.json()


def safe_float(value):
    try:
        return float(value)
    except (TypeError, ValueError):
        return 0.0


def safe_int(value):
    try:
        return int(float(value))
    except (TypeError, ValueError):
        return 0


def load_dashboard_data():
    destinations = fetch_json("/analytics/destinations")
    booking_trends = fetch_json("/analytics/bookings/trends")
    return destinations, booking_trends


def summarize_destinations(rows):
    totals = {
        "total_bookings": 0,
        "total_revenue": 0.0,
        "total_trips": 0,
    }
    by_destination = {}
    by_trip_type = {}

    for row in rows:
        destination = row.get("destination") or "Unknown"
        trip_type = row.get("trip_type") or "Unknown"
        trip_count = safe_int(row.get("trip_count"))
        booking_volume = safe_int(row.get("booking_volume"))
        revenue = safe_float(row.get("estimated_revenue_total"))

        totals["total_bookings"] += booking_volume
        totals["total_revenue"] += revenue
        totals["total_trips"] += trip_count

        by_destination.setdefault(destination, {"destination": destination, "booking_volume": 0, "trip_count": 0, "revenue": 0.0})
        by_destination[destination]["booking_volume"] += booking_volume
        by_destination[destination]["trip_count"] += trip_count
        by_destination[destination]["revenue"] += revenue

        by_trip_type.setdefault(trip_type, {"trip_type": trip_type, "trip_count": 0, "booking_volume": 0})
        by_trip_type[trip_type]["trip_count"] += trip_count
        by_trip_type[trip_type]["booking_volume"] += booking_volume

    avg_trip_value = 0.0
    if totals["total_trips"] > 0:
        avg_trip_value = totals["total_revenue"] / totals["total_trips"]

    top_destinations = sorted(
        by_destination.values(),
        key=lambda item: (item["booking_volume"], item["trip_count"], item["revenue"]),
        reverse=True,
    )[:5]

    trip_type_breakdown = sorted(
        by_trip_type.values(),
        key=lambda item: (item["trip_count"], item["booking_volume"]),
        reverse=True,
    )

    return totals, avg_trip_value, top_destinations, trip_type_breakdown


def summarize_booking_trends(rows):
    monthly_totals = {}

    for row in rows:
        month = row.get("booking_month")
        if not month:
            continue
        monthly_totals.setdefault(month, 0)
        monthly_totals[month] += safe_int(row.get("booking_count"))

    trend_rows = [
        {"booking_month": month, "booking_count": monthly_totals[month]}
        for month in sorted(monthly_totals.keys())
    ]
    return trend_rows


st.set_page_config(layout="wide")
SideBarLinks()

st.title("Dashboard: Demand & Performance")

filter_col1, filter_col2, filter_col3, filter_col4 = st.columns([1, 1, 1, 0.9])

with filter_col1:
    date_range = st.selectbox("Date Range", DATE_RANGE_OPTIONS, index=0)
with filter_col2:
    region = st.selectbox("Region", ["All"], index=0)
with filter_col3:
    planner_group = st.selectbox("Planner Group", ["All"], index=0)
with filter_col4:
    apply_filters = st.button("Apply Filters", type="primary", use_container_width=True)

if apply_filters:
    st.info(
        "Current analytics routes do not yet support server-side filtering by region, planner group, "
        "or custom date ranges. Filters are shown here to match the dashboard design."
    )

try:
    destination_rows, booking_trend_rows = load_dashboard_data()
except Exception as exc:
    st.error(f"Could not load dashboard analytics from the API: {exc}")
    st.warning("No fallback production metrics are being invented. Please start the API or verify the analytics routes.")
    st.stop()

totals, avg_trip_value, top_destinations, trip_type_breakdown = summarize_destinations(destination_rows)
booking_trends = summarize_booking_trends(booking_trend_rows)

kpi_col1, kpi_col2, kpi_col3 = st.columns(3)

with kpi_col1:
    with st.container(border=True):
        st.metric("Total Bookings", f"{totals['total_bookings']:,}")

with kpi_col2:
    with st.container(border=True):
        st.metric("Revenue", f"${totals['total_revenue']:,.0f}")

with kpi_col3:
    with st.container(border=True):
        st.metric("Avg. Trip Value", f"${avg_trip_value:,.0f}")

top_col, type_col = st.columns([1.2, 1])

with top_col:
    st.subheader("Top Destinations")
    if top_destinations:
        destination_chart = alt.Chart(alt.Data(values=top_destinations)).mark_bar(
            color=BLUE,
            cornerRadiusTopRight=4,
            cornerRadiusBottomRight=4,
        ).encode(
            x=alt.X("booking_volume:Q", title="Booking Volume"),
            y=alt.Y("destination:N", sort="-x", title="Destination"),
            tooltip=[
                alt.Tooltip("destination:N", title="Destination"),
                alt.Tooltip("booking_volume:Q", title="Booking Volume"),
                alt.Tooltip("trip_count:Q", title="Trips"),
                alt.Tooltip("revenue:Q", title="Revenue", format=",.0f"),
            ],
        ).properties(height=260)
        st.altair_chart(destination_chart, use_container_width=True)

        destination_table = [
            {
                "Destination": item["destination"],
                "Booking Volume": item["booking_volume"],
                "Trips": item["trip_count"],
                "Revenue": f"${item['revenue']:,.0f}",
            }
            for item in top_destinations
        ]
        st.dataframe(destination_table, use_container_width=True, hide_index=True)
    else:
        st.warning("The analytics endpoint returned no destination rows to chart.")

with type_col:
    st.subheader("Trip Type Breakdown")
    if trip_type_breakdown:
        trip_type_chart = alt.Chart(alt.Data(values=trip_type_breakdown)).mark_bar(
            cornerRadiusTopLeft=4,
            cornerRadiusTopRight=4,
        ).encode(
            x=alt.X("trip_type:N", title="Trip Type", sort="-y"),
            y=alt.Y("trip_count:Q", title="Trips"),
            color=alt.Color(
                "trip_type:N",
                scale=alt.Scale(range=[SKY, TEAL, GOLD, CORAL]),
                legend=None,
            ),
            tooltip=[
                alt.Tooltip("trip_type:N", title="Trip Type"),
                alt.Tooltip("trip_count:Q", title="Trips"),
                alt.Tooltip("booking_volume:Q", title="Bookings"),
            ],
        ).properties(height=260)
        st.altair_chart(trip_type_chart, use_container_width=True)

        trip_type_table = [
            {
                "Trip Type": item["trip_type"],
                "Trips": item["trip_count"],
                "Bookings": item["booking_volume"],
            }
            for item in trip_type_breakdown
        ]
        st.dataframe(trip_type_table, use_container_width=True, hide_index=True)
    else:
        st.warning("The analytics endpoint did not provide enough trip type data for a breakdown.")

st.subheader("Booking Volume Over Time")
if booking_trends:
    trend_chart = alt.Chart(alt.Data(values=booking_trends)).mark_line(
        color=NAVY,
        point=alt.OverlayMarkDef(color=NAVY, filled=True, size=60),
        strokeWidth=3,
    ).encode(
        x=alt.X("booking_month:N", title="Booking Month"),
        y=alt.Y("booking_count:Q", title="Bookings"),
        tooltip=[
            alt.Tooltip("booking_month:N", title="Booking Month"),
            alt.Tooltip("booking_count:Q", title="Bookings"),
        ],
    ).properties(height=320)

    st.altair_chart(trend_chart, use_container_width=True)

    st.caption(
        f"Using monthly booking totals from `/analytics/bookings/trends`. "
        f"Selected display range: {date_range.lower()}."
    )
else:
    st.warning(
        "The current booking trends route did not return chartable time-series data for this view."
    )

st.caption(
    f"Dashboard rendered at {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}. "
    "If a section looks sparse, that reflects current backend data availability rather than fabricated production metrics."
)
