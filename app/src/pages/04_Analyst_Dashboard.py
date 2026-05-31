import logging
import requests
import pandas as pd
import pydeck as pdk
import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot - Analytics")

from modules.nav import SideBarLinks
from modules.styles import inject_css

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks()

# ---------------------------------------------------------------------------
# Page CSS
# ---------------------------------------------------------------------------
PAGE_CSS = """
.analyst-header {
    font-family: 'Outfit', sans-serif;
    font-size: 1.8rem;
    font-weight: 800;
    color: #F1F5F9;
    letter-spacing: -0.02em;
    margin-bottom: 0.25rem;
}
.analyst-sub {
    font-family: 'Outfit', sans-serif;
    font-size: 0.9rem;
    color: #64748B;
    margin-bottom: 1.5rem;
}
.metric-card {
    background: linear-gradient(135deg, rgba(249,115,22,0.06) 0%, rgba(22,32,50,0.8) 100%);
    border: 1px solid rgba(249,115,22,0.12);
    border-radius: 16px;
    padding: 1.25rem 1.5rem;
    font-family: 'Outfit', sans-serif;
}
.metric-label {
    font-size: 0.7rem;
    color: #64748B;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    margin-bottom: 4px;
}
.metric-value {
    font-size: 2rem;
    font-weight: 800;
    color: #F97316;
    line-height: 1.1;
}
.metric-sub {
    font-size: 0.75rem;
    color: #94A3B8;
    margin-top: 2px;
}
.section-title {
    font-family: 'Outfit', sans-serif;
    font-size: 1rem;
    font-weight: 700;
    color: #F1F5F9;
    margin-bottom: 0.75rem;
    padding-bottom: 0.5rem;
    border-bottom: 1px solid rgba(249,115,22,0.1);
}
.nav-pill {
    display: inline-flex;
    gap: 0.5rem;
    background: rgba(15,23,42,0.6);
    border: 1px solid rgba(249,115,22,0.1);
    border-radius: 12px;
    padding: 4px;
    margin-bottom: 1.5rem;
}
"""
st.markdown(inject_css(PAGE_CSS), unsafe_allow_html=True)

def fetch_peak_hours(start, end):
    try:
        resp = requests.get(f"{API_BASE}/analytics/peak-hours", params={"start": start, "end": end}, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"Failed to fetch peak hours: {e}")
        return []
 
 
st.markdown('<div class="analyst-header">Dashboards</div>', unsafe_allow_html=True)
st.markdown('<div class="analyst-sub">Peak usage patterns across courts</div>', unsafe_allow_html=True)
 
dcol1, dcol2, _ = st.columns([2, 2, 6])
with dcol1:
    start_date = st.date_input("Start Date", value=pd.Timestamp("2026-03-01"))
with dcol2:
    end_date = st.date_input("End Date", value=pd.Timestamp("2026-03-31"))
 
start_str = str(start_date)
end_str = str(end_date)
 
peak_data = fetch_peak_hours(start_str, end_str)
 
st.markdown('<div class="section-title">Peak Usage Hours by Court</div>', unsafe_allow_html=True)
 
if peak_data:
    df_peak = pd.DataFrame(peak_data)
    court_names = sorted(df_peak["CourtName"].unique().tolist())
    selected_court = st.selectbox("Select Court", ["All Courts"] + court_names)
 
    if selected_court != "All Courts":
        df_peak = df_peak[df_peak["CourtName"] == selected_court]
 
    day_order = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    df_pivot = df_peak.groupby(["HourOfDay", "DayOfWeek"])["CheckInCount"].sum().reset_index()
    df_pivot = df_pivot.pivot(index="HourOfDay", columns="DayOfWeek", values="CheckInCount").fillna(0)
    existing_days = [d for d in day_order if d in df_pivot.columns]
    df_pivot = df_pivot[existing_days]
 
    st.markdown("**Check-ins by Hour and Day of Week**")
    st.dataframe(df_pivot.style.background_gradient(cmap="Oranges"), use_container_width=True)
 
    st.markdown("<br>", unsafe_allow_html=True)
    st.markdown('<div class="section-title">Busiest Hours Overall</div>', unsafe_allow_html=True)
    df_hour = df_peak.groupby("HourOfDay")["CheckInCount"].sum().reset_index()
    df_hour.columns = ["Hour", "CheckIns"]
    st.bar_chart(df_hour.set_index("Hour")["CheckIns"], use_container_width=True, height=250)
else:
    st.info("No peak hours data available.")
 