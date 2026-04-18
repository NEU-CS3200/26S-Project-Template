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

 
def fetch_heatmap(start, end):
    try:
        resp = requests.get(f"{API_BASE}/analytics/heatmap", params={"start": start, "end": end}, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        logger.error(f"Failed to fetch heatmap: {e}")
        return []
 
 
st.markdown('<div class="analyst-header">Heatmap</div>', unsafe_allow_html=True)
st.markdown('<div class="analyst-sub">Boston neighborhood basketball activity</div>', unsafe_allow_html=True)
 
dcol1, dcol2, _ = st.columns([2, 2, 6])
with dcol1:
    start_date = st.date_input("Start Date", value=pd.Timestamp("2026-03-01"))
with dcol2:
    end_date = st.date_input("End Date", value=pd.Timestamp("2026-03-31"))
 
start_str = str(start_date)
end_str = str(end_date)
 
heatmap_data = fetch_heatmap(start_str, end_str)
 
st.markdown('<div class="section-title">Boston Neighborhood Heatmap</div>', unsafe_allow_html=True)
 
if heatmap_data:
    df_heat = pd.DataFrame(heatmap_data)
    df_heat["latitude"] = df_heat["Latitude"].astype(float)
    df_heat["longitude"] = df_heat["Longitude"].astype(float)
    df_heat["activity"] = df_heat["ActivityCount"].astype(int)
    df_heat["weight"] = df_heat["activity"].apply(lambda x: max(1, x * 10))
 
    heatmap_layer = pdk.Layer(
        "HeatmapLayer",
        data=df_heat,
        get_position=["longitude", "latitude"],
        get_weight="weight",
        radius_pixels=60,
        opacity=0.8,
    )
 
    scatter_layer = pdk.Layer(
        "ScatterplotLayer",
        data=df_heat,
        get_position=["longitude", "latitude"],
        get_fill_color=[249, 115, 22, 180],
        get_radius=80,
        pickable=True,
        radius_min_pixels=4,
        radius_max_pixels=20,
    )
 
    view = pdk.ViewState(latitude=42.345, longitude=-71.085, zoom=11, pitch=0)
 
    tooltip = {
        "html": "<b>{CourtName}</b><br/>{NeighborhoodName}<br/>{ActivityCount} check-ins",
        "style": {
            "backgroundColor": "#1E293B",
            "color": "#F1F5F9",
            "borderRadius": "8px",
            "padding": "8px 12px",
            "fontFamily": "Outfit, sans-serif",
            "fontSize": "13px",
        },
    }
 
    deck = pdk.Deck(
        layers=[heatmap_layer, scatter_layer],
        initial_view_state=view,
        map_style="dark",
        tooltip=tooltip,
    )
 
    st.pydeck_chart(deck, use_container_width=True)
 
    st.markdown("<br>", unsafe_allow_html=True)
    st.markdown('<div class="section-title">Activity by Neighborhood</div>', unsafe_allow_html=True)
    df_neighborhood = df_heat.groupby("NeighborhoodName")["activity"].sum().reset_index()
    df_neighborhood.columns = ["Neighborhood", "CheckIns"]
    df_neighborhood = df_neighborhood.sort_values("CheckIns", ascending=False)
    st.bar_chart(df_neighborhood.set_index("Neighborhood")["CheckIns"], use_container_width=True, height=250)
else:
    st.info("No heatmap data available.")