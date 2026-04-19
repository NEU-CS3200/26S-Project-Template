import logging
logger = logging.getLogger(__name__)
import requests
import pandas as pd
import plotly.express as px
import streamlit as st
from datetime import date, timedelta
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.markdown("## Trends & Exports")
st.write(f"### Welcome to the Trends page, {st.session_state['first_name']}.")

API_BASE = "http://web-api:4000"

ISSUE_TYPES   = ["All", "Entrance issue", "Ramp issue", "Sidewalk issue", "Transport issue"]
NEIGHBORHOODS = ["All", "Roxbury", "Allston", "South End", "Back Bay", "Jamaica Plain", "Other"]

# --- Filters -----------------------------------------------------------------
st.markdown("#### Filters")
fc1, fc2, fc3 = st.columns(3)

with fc1:
    date_range = st.date_input(
        "Date Range",
        value=(date.today() - timedelta(days=365), date.today()),
        min_value=date(2020, 1, 1),
        max_value=date.today(),
    )

with fc2:
    selected_issue = st.selectbox("Issue Type", ISSUE_TYPES)

with fc3:
    selected_neighborhood = st.selectbox("Neighborhood", NEIGHBORHOODS)

# Guard: wait until user has picked both dates
if isinstance(date_range, (list, tuple)) and len(date_range) == 2:
    date_from, date_to = date_range
else:
    st.info("Please select a start and end date.")
    st.stop()

# --- Fetch data --------------------------------------------------------------
params = {"date_from": str(date_from), "date_to": str(date_to)}
if selected_issue != "All":
    params["issue_type"] = selected_issue

try:
    r = requests.get(f"{API_BASE}/reports", params=params, timeout=10)
    r.raise_for_status()
    df = pd.DataFrame(r.json())
except requests.exceptions.ConnectionError:
    st.error(f"Cannot reach API at `{API_BASE}`. Is the `api` container running?")
    st.stop()
except requests.exceptions.HTTPError as e:
    st.error(f"API error {e.response.status_code}")
    st.code(e.response.text, language="json")
    st.stop()
except Exception as e:
    st.error("Unexpected error loading reports.")
    st.code(str(e))
    st.stop()

if df.empty:
    st.warning("No reports found for the selected filters.")
    st.stop()

# Client-side neighborhood filter
if selected_neighborhood != "All" and "neighborhood_name" in df.columns:
    df = df[df["neighborhood_name"] == selected_neighborhood]

if df.empty:
    st.warning("No reports match the selected filters.")
    st.stop()

st.divider()

# --- Line graph: reports over time ------------------------------------------
st.markdown("#### Reports Submitted Over Time")

if "report_date" in df.columns:
    trend_df = df.copy()
    trend_df["report_date"] = pd.to_datetime(trend_df["report_date"])
    trend_df["month"] = trend_df["report_date"].dt.to_period("M").dt.to_timestamp()

    trend_counts = (
        trend_df.groupby("month")
        .size()
        .reset_index(name="Reports")
    )

    fig = px.line(
        trend_counts,
        x="month",
        y="Reports",
        markers=True,
        labels={"month": "Month"},
        color_discrete_sequence=["#3b82f6"],
    )

    fig.update_layout(
        paper_bgcolor="rgba(0,0,0,0)",
        plot_bgcolor="rgba(0,0,0,0)",
        font_color="#e2e8f0",
        xaxis=dict(showgrid=True, gridcolor="#2e2e3e"),
        yaxis=dict(showgrid=True, gridcolor="#2e2e3e"),
        margin=dict(t=20, b=20, l=10, r=10),
        legend_title_text="Issue Type",
    )
    st.plotly_chart(fig, use_container_width=True)

st.divider()

# --- Filtered reports table --------------------------------------------------
st.markdown(f"#### Reports ({len(df)} results)")

col_map = {
    "report_id":        "ID",
    "issue_type_name":  "Issue Type",
    "neighborhood_name":"Neighborhood",
    "report_date":      "Date",
    "urgency":          "Priority",
    "report_status":    "Status",
    "report_type":      "Type",
}

available = [c for c in col_map if c in df.columns]
table_df = df[available].rename(columns=col_map).copy()

if "Priority" in table_df.columns:
    priority_labels = {1: "1 – Very Low", 2: "2 – Low", 3: "3 – Medium", 4: "4 – High", 5: "5 – Critical"}
    table_df["Priority"] = table_df["Priority"].map(priority_labels).fillna(table_df["Priority"])

st.dataframe(
    table_df,
    use_container_width=True,
    hide_index=True,
    column_config={
        "ID":           st.column_config.NumberColumn("ID", width="small"),
        "Date":         st.column_config.DatetimeColumn("Date", format="YYYY-MM-DD", width="medium"),
        "Issue Type":   st.column_config.TextColumn("Issue Type", width="medium"),
        "Neighborhood": st.column_config.TextColumn("Neighborhood", width="medium"),
        "Priority":     st.column_config.TextColumn("Priority", width="medium"),
        "Status":       st.column_config.TextColumn("Status", width="small"),
        "Type":         st.column_config.TextColumn("Type", width="small"),
    },
)
