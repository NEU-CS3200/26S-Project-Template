import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000/rec"

st.title("Candidate Pipeline")

# Filters
col1, col2, col3 = st.columns(3)

with col1:
    name_search = st.text_input("Search by name")
with col2:
    university_filter = st.text_input("Filter by University")
with col3:
    stage_filter = st.selectbox(
        "Filter by Stage",
        ["All", "Applied", "Screening", "Phone Interview",
         "Technical Interview", "Offer Sent", "Closed", "Rejected"]
    )

# Fetch candidates
params = {}
if name_search:
    params["name"] = name_search
if university_filter:
    params["university"] = university_filter
if stage_filter != "All":
    params["stage"] = stage_filter

try:
    response = requests.get(f"{API_BASE}/candidates", params=params)
    candidates = response.json() if response.status_code == 200 else []
except Exception:
    st.error("Could not connect to the API.")
    candidates = []

# Table header
st.write(f"**{len(candidates)} candidate(s) found**")

header = st.columns([2, 2, 2, 1.5, 1.5, 1])
header[0].write("**Name**")
header[1].write("**University**")
header[2].write("**Role**")
header[3].write("**Stage**")
header[4].write("**Applied**")
header[5].write("**Action**")

st.divider()

# Table rows
for c in candidates:
    row = st.columns([2, 2, 2, 1.5, 1.5, 1])
    row[0].write(c.get("full_name", ""))
    row[1].write(c.get("university", ""))
    row[2].write(c.get("role", ""))
    row[3].write(c.get("stage", ""))
    row[4].write(str(c.get("Application_Date", ""))[:10])
    if row[5].button("View", key=f"view_{c['ApplicationID']}"):
        st.session_state["selected_student_id"] = c["StudentID"]
        st.session_state["selected_application_id"] = c["ApplicationID"]
        st.switch_page("pages/92_Candidate_Profile.py")
