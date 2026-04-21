import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

st.title("Attendees That Match Your Event")

organizer_id = st.session_state.get('user_id', 1)

# Fetch organizer's events
events_res = requests.get(
    f"http://web-api:4000/organizer/organizers/{organizer_id}/events", timeout=5
)
if events_res.status_code != 200:
    st.error("Could not load your events.")
    st.stop()

events = events_res.json()
if not events:
    st.info("You have no events yet. Post an event first.")
    st.stop()

event_options = {f"{e['Name']} (ID {e['EventID']})": e['EventID'] for e in events}
selected_label = st.selectbox("Select an event", list(event_options.keys()))
event_id = event_options[selected_label]

tab1, tab2 = st.tabs(["Matched Attendees (by Interest)", "Confirmed RSVPs"])

with tab1:
    st.subheader("Attendees whose interests match this event's category")
    res = requests.get(
        f"http://web-api:4000/event/events/{event_id}/matched-users", timeout=5
    )
    if res.status_code == 200:
        matches = res.json()
        if matches:
            st.write(f"Found **{len(matches)}** matched attendee(s)")
            for m in matches:
                with st.expander(f"{m['FName']} {m['LName']}"):
                    st.write(f"**Email:** {m.get('Email', 'N/A')}")
                    st.write(f"**Matching Interests:** {m.get('MatchingInterests', 0)}")
        else:
            st.info("No attendees matched by interest for this event.")
    else:
        st.error("Could not load matched attendees.")

with tab2:
    st.subheader("Confirmed RSVPs for this event")
    res2 = requests.get(
        f"http://web-api:4000/event/events/{event_id}/attendees", timeout=5
    )
    if res2.status_code == 200:
        data = res2.json()
        attendees = data.get('attendees', [])
        total = data.get('total', 0)
        st.metric("Confirmed Attendees", total)
        for a in attendees:
            st.write(f"- **{a['FName']} {a['LName']}** ({a.get('Email', '')})")
    else:
        st.error("Could not load RSVPs.")
