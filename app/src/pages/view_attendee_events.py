import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title("My RSVPs")

API_BASE = "http://web-api:4000"
attendee_id = st.session_state.get("attendee_id", 1)

try:
    response = requests.get(f"{API_BASE}/attendee/attendees/{attendee_id}/rsvps")
    if response.status_code == 200:
        events = response.json()
        if not events:
            st.info("You haven't RSVP'd to any events yet.")
        else:
            st.write(f"You're attending {len(events)} event(s).")
            for event in events:
                with st.expander(f"{event['Name']} — {event['Date']}  [{event['Status']}]"):
                    st.write(f"**Location:** {event['Location']}")
                    st.write(f"**Description:** {event['Description']}")
                    if st.button("Cancel RSVP", key=f"cancel_{event['EventID']}"):
                        r = requests.delete(
                            f"{API_BASE}/attendee/attendees/{attendee_id}/rsvps/{event['EventID']}"
                        )
                        if r.status_code == 200:
                            st.success("RSVP cancelled.")
                            st.rerun()
                        else:
                            st.error(f"Failed: {r.text}")
    else:
        st.error(f"API error: {response.status_code}")
except requests.exceptions.RequestException as e:
    st.error(f"Error connecting to API: {e}")