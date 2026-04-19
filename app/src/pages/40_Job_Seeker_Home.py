import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000"

# same styling as the other persona dashboards so everything feels consistent
st.markdown("""
    <style>
        .stApp {
            background-color: #FAF9F6;
        }
        [data-testid="stMetric"] {
            background-color: #2c2c2c;
            padding: 15px 20px;
            border-radius: 8px;
            color: white;
        }
        [data-testid="stMetricLabel"] {
            color: #aaaaaa;
        }
        [data-testid="stMetricValue"] {
            color: white;
            font-size: 1.5rem;
        }
    </style>
""", unsafe_allow_html=True)

# grab the logged-in student's id from session_state (set in Home.py on login)
student_id = st.session_state.get("student_id", 1)
first_name = st.session_state.get("first_name", "Student")

st.title(f"Welcome back, {first_name}")
st.subheader("Your Job Search at a Glance")

# personal hiring funnel - pulls from the /alex/students/<id>/funnel route
funnel_response = requests.get(f"{API_BASE}/alex/students/{student_id}/funnel")
funnel = funnel_response.json()

col1, col2, col3, col4, col5 = st.columns(5)

with col1:
    st.metric(label="Applications", value=funnel["total_applications"])

with col2:
    st.metric(label="Interviews", value=funnel["total_interviews"])

with col3:
    st.metric(label="Offers", value=funnel["total_offers"])

with col4:
    st.metric(
        label="App → Interview",
        value=f"{funnel['application_to_interview_rate']}%"
    )

with col5:
    st.metric(
        label="Interview → Offer",
        value=f"{funnel['interview_to_offer_rate']}%"
    )

st.markdown("<br>", unsafe_allow_html=True)

# recent applications preview - first 5 most recent apps
st.subheader("Recent Applications")

apps_response = requests.get(f"{API_BASE}/alex/students/{student_id}/applications")
applications = apps_response.json()
recent_apps = applications[:5]

if not recent_apps:
    st.info("You haven't logged any applications yet. Head to My Applications to add your first one.")
else:
    # header row
    col1, col2, col3, col4 = st.columns([2, 2, 2, 1])
    with col1:
        st.markdown("**Company**")
    with col2:
        st.markdown("**Position**")
    with col3:
        st.markdown("**Applied On**")
    with col4:
        st.markdown("**Status**")

    # build the rows as dark cards to match the admin dashboard look
    rows_html = ""
    for app in recent_apps:
        # pick an emoji based on status for quick visual scanning
        status = app.get("Status", "")
        if "Offer" in status:
            icon = "🟢"
        elif "Interview" in status:
            icon = "🟡"
        elif "Reject" in status:
            icon = "🔴"
        else:
            icon = "⚪"

        # the API returns dates like "Mon, 05 Mar 2026 10:30:00 GMT" - grab just the date part
        applied_date = app.get("Application_Date", "")
        if applied_date:
            applied_date = applied_date.split(" ")
            applied_date = f"{applied_date[1]} {applied_date[2]} {applied_date[3]}" if len(applied_date) >= 4 else ""

        rows_html += f"""<div style="display: flex; justify-content: space-between; padding: 10px 20px; border-bottom: 1px solid #444; color: white;">
<span style="flex: 2;">{app.get("employer_name", "")}</span>
<span style="flex: 2;">{app.get("position_title", "")}</span>
<span style="flex: 2;">{applied_date}</span>
<span style="flex: 1; text-align: right;">{icon} {status}</span>
</div>"""

    st.markdown(
        f'<div style="background-color: #2c2c2c; border-radius: 8px; overflow: hidden;">{rows_html}</div>',
        unsafe_allow_html=True
    )

st.markdown("<br>", unsafe_allow_html=True)

# nav buttons to the feature pages
col1, col2, col3 = st.columns(3)

with col1:
    if st.button("View All Applications →", use_container_width=True):
        st.switch_page("pages/41_My_Applications.py")

with col2:
    if st.button("Check Reminders →", use_container_width=True):
        st.switch_page("pages/42_Reminders.py")

with col3:
    if st.button("Compare Offers →", use_container_width=True):
        st.switch_page("pages/43_Offers.py")