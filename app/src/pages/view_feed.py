import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title("Your Event Feed")
st.caption("Events in your area matching your interests.")

API_BASE = "http://web-api:4000"
attendee_id = st.session_state.get("attendee_id", 1)

try:
    response = requests.get(f"{API_BASE}/attendee/attendees/{attendee_id}/feed")
    if response.status_code == 200:
        events = response.json()
        if not events:
            st.info("No events in your feed yet — try updating your interests or checking back later.")
        else:
            for event in events:
                st.subheader(event["Name"])
                st.write(f"📍 {event['Location']}  |  🗓 {event['Date']}")
                st.write(event["Description"])

                b1, b2 = st.columns(2)
                with b1:
                    if st.button("RSVP", key=f"feed_rsvp_{event['EventID']}"):
                        r = requests.post(
                            f"{API_BASE}/attendee/attendees/{attendee_id}/rsvps",
                            json={"event_id": event["EventID"], "status": "Going"},
                        )
                        if r.status_code == 200:
                            st.success("RSVP saved!")
                        else:
                            st.error(f"Failed: {r.text}")
                with b2:
                    if st.button("⭐ Favorite", key=f"feed_fav_{event['EventID']}"):
                        r = requests.post(
                            f"{API_BASE}/attendee/attendees/{attendee_id}/favorites",
                            json={"event_id": event["EventID"]},
                        )
                        if r.status_code == 200:
                            st.success("Added to favorites!")
                        else:
                            st.warning(r.json().get("message", "Failed"))
                st.divider()
    else:
        st.error(f"API error: {response.status_code}")
except requests.exceptions.RequestException as e:
    st.error(f"Error connecting to API: {e}")