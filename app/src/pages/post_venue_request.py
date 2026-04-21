import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

if "reset_form" not in st.session_state:
    st.session_state.reset_form = False
if "form_key_counter" not in st.session_state:
    st.session_state.form_key_counter = 0
if "show_success_modal" not in st.session_state:
    st.session_state.show_success_modal = False
if "success_venue_name" not in st.session_state:
    st.session_state.success_venue_name = ""

st.title("Add New Request")

@st.dialog("Success")
def show_success_dialog(request_name):
    st.markdown(f"### You sent a booking request to {request_name}")
    st.session_state.show_success_modal = False
    
    if st.button("Add Another Request", use_container_width=True):
            st.session_state.success_request_name = ""
            st.session_state.reset_form = True
            st.rerun()

if st.session_state.reset_form:
    st.session_state.form_key_counter += 1
    st.session_state.reset_form = False

organizer_id = st.session_state.get("organizer_id", 1)

API_URL = f"http://api:4000"

with st.form(f"add_request_form_{st.session_state.form_key_counter}"):
    st.subheader("Request Information")

    # Required fields
    name = st.text_input("Name")

    submitted = st.form_submit_button("Add Request")

    if submitted:
        if not all([name]):
            st.error("Please fill in all required fields marked with *")
        else:
            try:
                response = requests.get(f"{API_URL}/venue/venues")
                if response.status_code == 200:
                    venues = response.json()
                    match = next(
                        (e for e in venues if e.get("Name", "").lower() == name.strip().lower()),
                        None
                    )
                    if match:
                        st.session_state.fetched_event = match
                        venue_id = match.get("VenueID")
                        st.success(f"Venue found! Request is being processed.")

                        request_data = {
                            "request_name": name,
                            "venue_id": venue_id
                        }

                        st.session_state.success_venue_name = name

                        response = requests.post(f"{API_URL}/organizer/organizers/{organizer_id}/venue-requests", json=request_data)

                        if response.status_code == 201:
                            st.session_state.show_success_modal = True
                            st.session_state.success_ngo_name = name
                            st.rerun()
                        else:
                            st.error(
                                f"Failed to add request: {response.json().get('error', 'Unknown error')}"
                            )

                    else:
                        st.error("No venue found with that name. Please check and try again.")
                        st.session_state.fetched_event = None
                        st.session_state.fetched_event_id = None

            except requests.exceptions.RequestException as e:
                st.error(f"Error connecting to the API: {str(e)}")
                st.info("Please ensure the API server is running")

if st.session_state.show_success_modal:
    show_success_dialog(st.session_state.success_venue_name)

if st.button("Return to Venue Directory"):
    st.switch_page("pages/get_venues.py")