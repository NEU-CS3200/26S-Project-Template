import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

if st.button("Home"):
    st.switch_page("Home.py")

st.title("About communevent")

st.write("""
communevent is a platform that connects event attendees, organizers, 
performers, and venue owners in one place.

**Built by the Funky Bunch** for CS 3200, Spring 2026.
""")

st.subheader("Roles")
st.write("""
- **Attendees** browse events, RSVP, save favorites, and leave reviews
- **Organizers** post and manage events, and book venues and performers
- **Venue Owners** manage their venues and review incoming requests
- **Performers** manage their profiles and respond to booking requests
""")