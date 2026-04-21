import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

org_id = st.session_state.get('selected_org_id', st.session_state.get('user_id', 1))

st.title("Organizer Profile")

try:
    response = requests.get(f"http://web-api:4000/organizer/organizers/{org_id}", timeout=5)
    if response.status_code == 200:
        data = response.json()
    else:
        raise Exception(f"API returned status {response.status_code}")
except Exception as e:
    st.error(f"Could not load organizer profile: {e}")
    data = None

if data:
    # API returns a list; grab the first row
    row = data[0] if isinstance(data, list) else data
    col1, col2 = st.columns([1, 2])

    with col1:
        st.subheader("Contact Info")
        st.write(f"**Name:** {row.get('FName', '')} {row.get('LName', '')}")
        st.write(f"**Email:** {row.get('Email', 'N/A')}")
        st.write(f"**Location:** {row.get('Location', 'N/A')}")

    with col2:
        st.subheader("Booking Stats")
        st.metric("Total Venue Requests", row.get('TotalRequests', 0))
        st.metric("Approved Requests", row.get('ApprovedCount', 0))

if st.button("Back to Dashboard"):
    st.session_state['menu_choice'] = "Manage Requests"
    st.switch_page("pages/venue_owner.py")
