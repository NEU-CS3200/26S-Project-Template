import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

st.title("Your Events")

st.write(f"Organizer ID: {st.session_state['user_id']}")

API_URL = f"http://api:4000/organizer/organizers/{st.session_state['user_id']}/events"

response = requests.get(API_URL)

if response.status_code == 200:
    events = response.json()

    filtered_response = requests.get(API_URL)
    if filtered_response.status_code == 200:
        filtered_events = filtered_response.json()

        st.write(f"Found {len(filtered_events)} events")

        for event in filtered_events:
            st.write(f"**Name:** {event['Name']}")
            st.write(f"**Date:** {event['Date']}")
            st.write(f"**Location:** {event['Location']}")
            st.write(f"**Category:** {event['Category']}")
            st.write(f"**Size:** {event['Size']}")
            st.divider()

    st.divider()
    if st.button("Post a new event", type="primary", use_container_width=True):
        st.switch_page("pages/post_event.py")
    if st.button("Update event", type="primary", use_container_width=True):
        st.switch_page("pages/update_event.py")
    if st.button("Delete an event", type="primary", use_container_width=True):
        st.switch_page("pages/delete_event.py")

else:
    st.error("Failed to fetch venue data from the API")