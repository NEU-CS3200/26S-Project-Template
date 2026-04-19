import logging
logger = logging.getLogger(__name__)
import requests
import pandas as pd
import streamlit as st
from datetime import date, timedelta
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.markdown("## View Reports")

API_BASE = "http://web-api:4000"

REPORT_TYPES  = ["All", "Feedback", "Complaint", "Emergency"]
STATUSES      = ["All", "Open", "In Progress", "Resolved", "Closed"]
ISSUE_TYPES   = ["All", "Entrance issue", "Ramp issue", "Sidewalk issue", "Transport issue"]
NEIGHBORHOODS = ["All", "Roxbury", "Allston", "South End", "Back Bay", "Jamaica Plain", "Other"]
PRIORITIES    = {"All": None, "1 – Very Low": 1, "2 – Low": 2, "3 – Medium": 3, "4 – High": 4, "5 – Critical": 5}


@st.cache_data(ttl=60)
def fetch_all_reports():
    r = requests.get(f"{API_BASE}/reports", timeout=10)
    r.raise_for_status()
    return pd.DataFrame(r.json())


@st.cache_data(ttl=120)
def fetch_users():
    try:
        r = requests.get(f"{API_BASE}/users", timeout=10)
        r.raise_for_status()
        return pd.DataFrame(r.json())
    except Exception:
        return pd.DataFrame()


try:
    df = fetch_all_reports()
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

users_df = fetch_users()

# Build user dropdown and id->name lookup
user_options = {"All": None}
user_name_map = {}
if not users_df.empty and "user_id" in users_df.columns:
    for _, u in users_df.iterrows():
        uid = int(u["user_id"])
        full_name = f"{u.get('first_name', '')} {u.get('last_name', '')}".strip()
        user_name_map[uid] = full_name
        user_options[f"{full_name} (ID: {uid})"] = uid

# --- Search & filters --------------------------------------------------------
search = st.text_input("Search", placeholder="Search by description, street, neighborhood, issue type, ID…")

st.markdown("#### Filters")
r1c1, r1c2, r1c3 = st.columns(3)
r2c1, r2c2, r2c3, r2c4 = st.columns(4)

with r1c1:
    date_range = st.date_input(
        "Date Range",
        value=(date.today() - timedelta(days=365), date.today()),
        min_value=date(2020, 1, 1),
        max_value=date.today(),
    )
with r1c2:
    selected_type = st.selectbox("Report Type", REPORT_TYPES)
with r1c3:
    selected_status = st.selectbox("Status", STATUSES)

with r2c1:
    selected_issue = st.selectbox("Issue Type", ISSUE_TYPES)
with r2c2:
    selected_neighborhood = st.selectbox("Neighborhood", NEIGHBORHOODS)
with r2c3:
    selected_priority = st.selectbox("Priority", list(PRIORITIES.keys()))
with r2c4:
    selected_user = st.selectbox("User", list(user_options.keys()))

st.divider()

# --- Apply filters -----------------------------------------------------------
filtered = df.copy()

if isinstance(date_range, (list, tuple)) and len(date_range) == 2:
    d_from, d_to = date_range
    if "report_date" in filtered.columns:
        filtered["report_date"] = pd.to_datetime(filtered["report_date"])
        filtered = filtered[
            (filtered["report_date"].dt.date >= d_from) &
            (filtered["report_date"].dt.date <= d_to)
        ]

if selected_type != "All" and "report_type" in filtered.columns:
    filtered = filtered[filtered["report_type"] == selected_type]
if selected_status != "All" and "report_status" in filtered.columns:
    filtered = filtered[filtered["report_status"] == selected_status]
if selected_issue != "All" and "issue_type_name" in filtered.columns:
    filtered = filtered[filtered["issue_type_name"] == selected_issue]
if selected_neighborhood != "All" and "neighborhood_name" in filtered.columns:
    filtered = filtered[filtered["neighborhood_name"] == selected_neighborhood]
if PRIORITIES[selected_priority] is not None and "urgency" in filtered.columns:
    filtered = filtered[filtered["urgency"] == PRIORITIES[selected_priority]]
if user_options[selected_user] is not None and "user_id" in filtered.columns:
    filtered = filtered[filtered["user_id"] == user_options[selected_user]]

if search.strip():
    q = search.strip().lower()
    search_cols = ["description", "street_name", "neighborhood_name",
                   "issue_type_name", "report_type", "report_status"]
    mask = pd.Series(False, index=filtered.index)
    for col in search_cols:
        if col in filtered.columns:
            mask |= filtered[col].fillna("").str.lower().str.contains(q)
    if q.isdigit():
        for col in ["report_id", "user_id"]:
            if col in filtered.columns:
                mask |= filtered[col].astype(str).str.contains(q)
    filtered = filtered[mask]

# --- Sort + table ------------------------------------------------------------
sort_col, _ = st.columns([2, 6])
with sort_col:
    sort_asc = st.radio("Sort by Report ID", ["Ascending", "Descending"], horizontal=True)

if "report_id" in filtered.columns:
    filtered = filtered.sort_values("report_id", ascending=(sort_asc == "Ascending"))

st.markdown(f"#### Results — {len(filtered)} report{'s' if len(filtered) != 1 else ''}")

if filtered.empty:
    st.info("No reports match the current filters.")
    st.stop()

# Attach user full name
if user_name_map and "user_id" in filtered.columns:
    filtered = filtered.copy()
    filtered["user_name"] = filtered["user_id"].map(user_name_map).fillna("Unknown")

col_map = {
    "report_id":        "Report ID",
    "user_name":        "User",
    "user_id":          "User ID",
    "report_type":      "Type",
    "report_status":    "Status",
    "urgency":          "Priority",
    "issue_type_name":  "Issue Type",
    "neighborhood_name":"Neighborhood",
    "street_name":      "Street",
    "report_date":      "Date",
    "description":      "Description",
}

available = [c for c in col_map if c in filtered.columns]
table_df = filtered[available].rename(columns=col_map).copy()

if "Priority" in table_df.columns:
    priority_labels = {1: "1 – Very Low", 2: "2 – Low", 3: "3 – Medium",
                       4: "4 – High", 5: "5 – Critical"}
    table_df["Priority"] = table_df["Priority"].map(priority_labels).fillna(table_df["Priority"])

st.dataframe(
    table_df,
    use_container_width=True,
    hide_index=True,
    column_config={
        "Report ID":    st.column_config.NumberColumn("Report ID",   width="small"),
        "User":         st.column_config.TextColumn("User",          width="medium"),
        "User ID":      st.column_config.NumberColumn("User ID",     width="small"),
        "Type":         st.column_config.TextColumn("Type",          width="small"),
        "Status":       st.column_config.TextColumn("Status",        width="small"),
        "Priority":     st.column_config.TextColumn("Priority",      width="medium"),
        "Issue Type":   st.column_config.TextColumn("Issue Type",    width="medium"),
        "Neighborhood": st.column_config.TextColumn("Neighborhood",  width="medium"),
        "Street":       st.column_config.TextColumn("Street",        width="medium"),
        "Date":         st.column_config.DatetimeColumn("Date", format="YYYY-MM-DD", width="medium"),
        "Description":  st.column_config.TextColumn("Description",   width="large"),
    },
)
