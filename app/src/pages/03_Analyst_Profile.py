import streamlit as st
st.set_page_config(layout="wide", page_title="HoopSpot - Analytics")


from modules.nav import SideBarLinks
from modules.styles import inject_css

st.write(f"DEBUG on page: auth={st.session_state.get('authenticated')}, role={st.session_state.get('role')}")
SideBarLinks()

import logging
import requests
import pandas as pd
import pydeck as pdk


logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"



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

# ---------------------------------------------------------------------------
# Session state defaults
# ---------------------------------------------------------------------------



def fetch_checkins(start, end):
    try:
        resp = requests.get(f"{API_BASE}/analytics/checkins", params={"start": start, "end": end}, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"Failed to fetch checkins: {e}")
        return []
 
 
def fetch_court_conditions(start, end):
    try:
        resp = requests.get(f"{API_BASE}/analytics/court-conditions", params={"start": start, "end": end}, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"Failed to fetch court conditions: {e}")
        return []
 
 
st.markdown('<div class="analyst-header">Overview</div>', unsafe_allow_html=True)
st.markdown('<div class="analyst-sub">Boston pickup basketball activity insights</div>', unsafe_allow_html=True)
 
dcol1, dcol2, _ = st.columns([2, 2, 6])
with dcol1:
    start_date = st.date_input("Start Date", value=pd.Timestamp("2026-03-01"))
with dcol2:
    end_date = st.date_input("End Date", value=pd.Timestamp("2026-03-31"))
 
start_str = str(start_date)
end_str = str(end_date)
 
checkins_data = fetch_checkins(start_str, end_str)
conditions_data = fetch_court_conditions(start_str, end_str)
 
total_checkins = sum(c.get("TotalCheckIns", 0) for c in checkins_data)
most_used = checkins_data[0] if checkins_data else None
avg_condition = (
    round(
        sum(float(c["AvgConditionRating"]) for c in conditions_data if c.get("AvgConditionRating")) /
        max(1, sum(1 for c in conditions_data if c.get("AvgConditionRating"))), 1,
    ) if conditions_data else "N/A"
)
 
m1, m2, m3, m4 = st.columns(4)
with m1:
    st.markdown(f"""<div class="metric-card"><div class="metric-label">Total Check-Ins</div><div class="metric-value">{total_checkins:,}</div><div class="metric-sub">{start_str} → {end_str}</div></div>""", unsafe_allow_html=True)
with m2:
    st.markdown(f"""<div class="metric-card"><div class="metric-label">Most Used Court</div><div class="metric-value" style="font-size:1.1rem;padding-top:6px;">{most_used["CourtName"] if most_used else "—"}</div><div class="metric-sub">{most_used["TotalCheckIns"] if most_used else 0} check-ins</div></div>""", unsafe_allow_html=True)
with m3:
    st.markdown(f"""<div class="metric-card"><div class="metric-label">Courts Tracked</div><div class="metric-value">{len(checkins_data)}</div><div class="metric-sub">across Boston</div></div>""", unsafe_allow_html=True)
with m4:
    st.markdown(f"""<div class="metric-card"><div class="metric-label">Avg Court Condition</div><div class="metric-value">{avg_condition}</div><div class="metric-sub">out of 5.0</div></div>""", unsafe_allow_html=True)
 
st.markdown("<br>", unsafe_allow_html=True)
st.markdown('<div class="section-title">Top Check-In Courts</div>', unsafe_allow_html=True)
 
if checkins_data:
    df_top = pd.DataFrame(checkins_data[:10])
    st.bar_chart(df_top.set_index("CourtName")["TotalCheckIns"], use_container_width=True, height=300)
else:
    st.info("No check-in data available for this period.")