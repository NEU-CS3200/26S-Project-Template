import requests
import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.title("Container Status")
st.write("Quick checks for API and database connectivity in Docker.")

API_BASE = "http://web-api:4000"

col1, col2 = st.columns(2)

with col1:
    st.subheader("API Health")
    try:
        resp = requests.get(f"{API_BASE}/health", timeout=5)
        if resp.status_code == 200:
            st.success(f"API reachable: {resp.json()}")
        else:
            st.error(f"API returned status {resp.status_code}")
    except requests.exceptions.RequestException as exc:
        st.error(f"API not reachable: {exc}")

with col2:
    st.subheader("Database Health")
    try:
        resp = requests.get(f"{API_BASE}/health/db", timeout=5)
        if resp.status_code == 200:
            st.success(f"DB reachable through API: {resp.json()}")
        else:
            st.error(f"DB health route returned status {resp.status_code}")
    except requests.exceptions.RequestException as exc:
        st.error(f"DB health check failed: {exc}")

if st.button("Refresh Checks", use_container_width=True):
    st.rerun()
