import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title("Browse Events")

API_BASE = "http://web-api:4000"
attendee_id = st.session_state.get("attendee_id", 1)

col1, col2, col3 = st.columns(3)
with col1:
    category = st.text_input("Category (e.g. Music, Food)")
with col2:
    location = st.text_input("Location contains")
with col3:
    date = st.date_input("Date", value=None)

params = []
if category:
    params["category"] = category
if location:
    params["location"] = location
if date:
    params["date"] = date.isoformat()

try:
    response = requests.get(f"{API_BASE}/event/events", params=params)
    if response.status_code == 200:
        events = response.json()
        st.write(f"Found {len(events)} events")

        for event in events:
            with st.expander(f"{event['Name']} - {event['Date']}"):
                st.write(f"**Category:** {event['Category']}")
                st.write(f"**Location:** {event['Location']}")
                st.write(f"**Description:** {event['Description']}")
                st.write(f"**Size:** {event['Size']}")

                b1, b2 = st.columns(2)
                with b1:
                    if st.button("RSVP (Going)", key=f"rsvp_{event['EventID']}"):
                        payload = {"event_id": event["EventID"], "status": "Going"}
                        st.write(f"DEBUG sending: {payload}")
                        st.write(f"DEBUG URL: {API_BASE}/attendee/attendees/{attendee_id}/rsvps")
                        r = requests.post(f"{API_BASE}/attendee/attendees/{attendee_id}/rsvps", json=payload,)
                        st.write(f"DEBUG response status: {r.status_code}")
                        st.write(f"DEBUG response: {r.text}")
                        if r.status_code == 200:
                            st.success("RSVP saved!")
                        else:
                            st.error(f"Failed: {r.text}")
                with b2:
                    if st.button("⭐ Favorite", key=f"fav_{event['EventID']}"):
                        r = requests.post(
                            f"{API_BASE}/attendee/attendees/{attendee_id}/favorites",
                            json={"event_id": event["EventID"]},
                        )
                        if r.status_code == 200:
                            st.success("Added to favorites!")
                        else:
                            st.warning(r.json().get("message", "Failed"))
    else:
        st.error(f"API error: {response.status_code}")
except requests.exceptions.RequestException as e:
    st.error(f"Error connecting to API: {e}")