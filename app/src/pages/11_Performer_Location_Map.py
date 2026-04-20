import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
import json
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title("Dining Locations & Wait Times")
st.write("Find the quickest dining option near you.")

API_BASE = "http://localhost:5000/api"

try:
    wait_response = requests.get(f"{API_BASE}/nutrition/wait-times", timeout=5)
    if wait_response.status_code != 200:
        st.error("Could not load wait time data")
        logger.error(f"Wait times API error: {wait_response.status_code}")
        st.stop()

    wait_data = wait_response.json()['data']

    wait_data_sorted = sorted(wait_data, key=lambda x: x['wait_minutes'])

    st.subheader("Sorted by Shortest Wait Time")

    for hall in wait_data_sorted:
        col1, col2, col3 = st.columns([2, 1, 2])

        with col1:
            st.write(f"**{hall['name']}**")

        with col2:
            if hall['wait_minutes'] <= 5:
                st.success(f"{hall['wait_minutes']} min")
            elif hall['wait_minutes'] <= 10:
                st.info(f"{hall['wait_minutes']} min")
            else:
                st.warning(f"{hall['wait_minutes']} min")

        with col3:
            st.caption(f"Peak: {', '.join(hall['peak_hours'])}")

    st.divider()

    halls_response = requests.get(f"{API_BASE}/nutrition/dining-halls", timeout=5)
    if halls_response.status_code == 200:
        halls = halls_response.json()['data']

        st.subheader("Hall Details")
        for hall in halls:
            with st.expander(f"{hall['name']} — {hall['location']}"):
                col_a, col_b = st.columns(2)
                with col_a:
                    st.write(f"**Building Code:** {hall['building_code']}")
                    st.write(f"**Location:** {hall['location']}")
                with col_b:
                    st.write(f"**Coordinates:** {hall['latitude']}, {hall['longitude']}")

                if hall['operating_hours']:
                    st.write("**Operating Hours:**")
                    hours_dict = json.loads(hall['operating_hours']) if isinstance(hall['operating_hours'], str) else hall['operating_hours']
                    for day, times in hours_dict.items():
                        st.caption(f"  {day}: {times}")

except requests.RequestException as e:
    st.error(f"Connection error: {e}")
    logger.error(f"API request error: {e}")
except Exception as e:
    st.error(f"Error loading dining locations: {e}")
    logger.error(f"Unexpected error: {e}")
