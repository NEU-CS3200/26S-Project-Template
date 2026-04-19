import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000"

st.markdown("""
    <style>
        .stApp {
            background-color: #FAF9F6;
        }
        [data-testid="stHeader"] {
            background-color: #2c2c2c;
        }
    </style>
""", unsafe_allow_html=True)

st.title("Error Logs")
st.write("View recent system errors and failed operations")

col1, col2 = st.columns(2)

status_option = ["All", "Resolved", "Unresolved"]
severity_option = ["All", "Low", "Medium", "High"]

with col1:
    status_filter = st.selectbox("Filter by Status", options=status_option)

with col2:
    severity_filter = st.selectbox("Filter by Severity", options=severity_option)

values = {}
if status_filter != "All":
    values["status"] = status_filter
if severity_filter != "All":
    values["severity"] = severity_filter

response = requests.get(f"{API_BASE}/admin/errors", params=values)
errors = response.json()

if errors:
    st.dataframe(errors, use_container_width=True)
    st.write(f"**{len(errors)} error(s) found**")
else:
    st.success("No errors found")