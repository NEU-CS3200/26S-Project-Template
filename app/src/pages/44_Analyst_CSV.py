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

def fetch_export(start, end, neighborhood=None):
    params = {"start": start, "end": end}
    if neighborhood:
        params["neighborhood"] = neighborhood
    try:
        resp = requests.get(f"{API_BASE}/analytics/checkins/export", params=params, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"Failed to fetch export: {e}")
        return []
 
 
st.markdown('<div class="analyst-header">CSV Export</div>', unsafe_allow_html=True)
st.markdown('<div class="analyst-sub">Download check-in data for analysis</div>', unsafe_allow_html=True)
 
dcol1, dcol2, _ = st.columns([2, 2, 6])
with dcol1:
    start_date = st.date_input("Start Date", value=pd.Timestamp("2026-03-01"))
with dcol2:
    end_date = st.date_input("End Date", value=pd.Timestamp("2026-03-31"))
 
start_str = str(start_date)
end_str = str(end_date)
 
st.markdown('<div class="section-title">Export Check-In Data</div>', unsafe_allow_html=True)
 
neighborhoods = [
    "All Neighborhoods", "Back Bay", "Mission Hill", "Fenway", "South End",
    "Roxbury", "Dorchester", "Jamaica Plain", "Allston", "Brighton",
    "Charlestown", "East Boston", "South Boston", "Cambridgeport",
    "Brookline Village", "Union Square",
]
neighborhood_filter = st.selectbox("Filter by Neighborhood", neighborhoods)
 
export_data = fetch_export(
    start_str,
    end_str,
    neighborhood=None if neighborhood_filter == "All Neighborhoods" else neighborhood_filter,
)
 
if export_data:
    df_export = pd.DataFrame(export_data)
    st.markdown(f"**{len(df_export)} records found**")
    st.dataframe(df_export, use_container_width=True, hide_index=True)
 
    csv = df_export.to_csv(index=False).encode("utf-8")
    st.download_button(
        label="Download CSV",
        data=csv,
        file_name=f"hoopspot_checkins_{start_str}_{end_str}.csv",
        mime="text/csv",
        type="primary",
    )
else:
    st.info("No data available for export with the selected filters.")