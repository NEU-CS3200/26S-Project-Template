import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

if "authenticated" not in st.session_state or not st.session_state["authenticated"]:
    st.switch_page("Home.py")

SideBarLinks()

API_BASE = "http://api:4000"

st.title("📉 Trends")
st.write("Track monthly application pipeline activity over time.")

def fetch_json(endpoint: str):
    response = requests.get(f"{API_BASE}{endpoint}", timeout=10)
    response.raise_for_status()
    return response.json()

try:
    trends = fetch_json("/analytics/trends")
except Exception as e:
    st.error(f"Could not load trends data: {e}")
    trends = None

if trends and isinstance(trends, list) and len(trends) > 0:
    trends_df = pd.DataFrame(trends)

    if "month_bucket" in trends_df.columns:
        display_df = trends_df.rename(columns={
            "month_bucket": "Month",
            "applications": "Applications",
            "interviews": "Interviews",
            "offers": "Offers"
        })

        latest = display_df.iloc[-1]

        c1, c2, c3 = st.columns(3)
        with c1:
            st.metric("Applications", int(latest["Applications"]))
        with c2:
            st.metric("Interviews", int(latest["Interviews"]))
        with c3:
            st.metric("Offers", int(latest["Offers"]))

        st.subheader("Monthly Trend Chart")
        chart_df = display_df.set_index("Month")

        if len(chart_df) <= 2:
            st.bar_chart(chart_df)
        else:
            st.line_chart(chart_df)

        st.subheader("Trend Data")
        st.dataframe(display_df, use_container_width=True, hide_index=True)
    else:
        st.dataframe(trends_df, use_container_width=True, hide_index=True)
else:
    st.info("Trend data is not available yet.")