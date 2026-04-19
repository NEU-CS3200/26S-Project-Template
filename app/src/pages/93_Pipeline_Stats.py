import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000/rec"

st.title("Pipeline Stats")
st.write("Breakdown of candidates by hiring stage across all active applications.")

if st.button("← Back to Home"):
    st.switch_page("pages/90_Recruiter_Home.py")

st.divider()

try:
    res = requests.get(f"{API_BASE}/pipeline/stats")
    stats = res.json() if res.status_code == 200 else []
except Exception:
    stats = []

if not stats:
    st.info("No pipeline data available.")
    st.stop()

df = pd.DataFrame(stats)

# Summary metrics row
total = df["count"].sum()
num_stages = len(df)

col1, col2 = st.columns(2)
col1.metric("Total Active Candidates", int(total))
col2.metric("Active Stages", num_stages)

st.divider()

# Bar chart
st.subheader("Candidates by Stage")
chart_df = df.set_index("stage")
st.bar_chart(chart_df["count"])

st.divider()

# Table breakdown
st.subheader("Stage Breakdown")
df["percentage"] = (df["count"] / total * 100).round(1).astype(str) + "%"
df.columns = ["Stage", "Count", "Percentage"]
st.dataframe(df, use_container_width=True, hide_index=True)
