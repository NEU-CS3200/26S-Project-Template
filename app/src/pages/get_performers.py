import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

st.title("Performer Directory")

organizer_id = st.session_state.get("organizer_id", 1)

API_URL = f"http://api:4000/performer/performers"

response = requests.get(API_URL)
if response.status_code == 200:
    performers = response.json()

    filtered_response = requests.get(API_URL)
    if filtered_response.status_code == 200:
        filtered_performers = filtered_response.json()

        st.write(f"Found {len(filtered_performers)} performers")

        for performer in filtered_performers:
            st.write(f"**Name:** {performer['FName']} {performer['LName']}")
            st.write(f"**Genre:** {performer['Genre']}")
            st.write(f"**Biography:** {performer['Bio']}")
            st.write(f"**Media Links:** {performer['MediaLinks']}")
            st.write(f"**Availability:** {performer['Genre']}")
            st.write(f"**Views:** {performer['Views']}")
            st.write(f"**Ranking:** {performer['Ranking']}")
            st.divider()

    st.divider()
    if st.button("Send booking request to performer", type="primary", use_container_width=True):
        st.switch_page("pages/request_performer_booking.py")

else:
    st.error("Failed to fetch venue data from the API")