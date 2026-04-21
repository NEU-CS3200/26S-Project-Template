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
if "success_performer_name" not in st.session_state:
    st.session_state.success_performer_name = ""

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

API_URL = f"http://api:4000"

with st.form(f"add_request_form_{st.session_state.form_key_counter}"):
    st.subheader("Request Information")

    # Required fields
    name = st.text_input("Name")
    compensation = st.text_input("Compensation")

    submitted = st.form_submit_button("Add Request")

    if submitted:
        if not all([name]):
            st.error("Please fill in all required fields")
        else:
            try:
                response = requests.get(f"{API_URL}/performer/performers")
                if response.status_code == 200:
                    performers = response.json()
                    match = next(
                        (e for e in performers if f"{e.get('FName', '')} {e.get('LName', '')}".lower() == name.strip().lower()),
                        None
                    )
                    if match:
                        st.session_state.fetched_event = match
                        performer_id = match.get("PerformerID")
                        st.success(f"Performer found! Request is being processed.")

                    else:
                        st.error("No performer found with that name. Please check and try again.")
                        st.session_state.fetched_event = None
                        st.session_state.fetched_event_id = None
            
                request_data = {
                    "performer_id": performer_id,
                    "compensation": compensation
                }

                st.session_state.success_performer_name = name

                response = requests.post(f"{API_URL}/organizer/organizers/{st.session_state['user_id']}/performer-bookings", json=request_data)

                if response.status_code == 201:
                    st.session_state.show_success_modal = True
                    st.session_state.success_ngo_name = name
                    st.rerun()
                else:
                    st.error(
                        f"Failed to add request: {response.json().get('error', 'Unknown error')}"
                    )

            except requests.exceptions.RequestException as e:
                st.error(f"Error connecting to the API: {str(e)}")
                st.info("Please ensure the API server is running")

if st.session_state.show_success_modal:
    show_success_dialog(st.session_state.success_performer_name)

if st.button("Return to Performer Directory"):
    st.switch_page("pages/get_performers.py")