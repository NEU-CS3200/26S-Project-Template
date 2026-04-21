import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

st.title("Venue Directory")

API_URL = f"http://api:4000/venue/venues"

response = requests.get(API_URL)
if response.status_code == 200:
    venues = response.json()

    filtered_response = requests.get(API_URL)
    if filtered_response.status_code == 200:
        filtered_venues = filtered_response.json()

        st.write(f"Found {len(filtered_venues)} venues")

        for venue in filtered_venues:
            st.write(f"**Name:** {venue['Name']}")
            st.write(f"**Capacity:** {venue['Capacity']}")
            st.write(f"**Location:** {venue['Location']}")
            st.write(f"**Owner:** {venue['OwnerFirstName']} {venue['OwnerLastName']}")
            st.divider()

    st.divider()
    if st.button("Make a venue request", type="primary", use_container_width=True):
        st.switch_page("pages/post_venue_request.py")

else:
    st.error("Failed to fetch venue data from the API")