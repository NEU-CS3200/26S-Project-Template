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
if "success_event_name" not in st.session_state:
    st.session_state.success_event_name = ""

st.title("Update Event")

@st.dialog("Success")
def show_success_dialog(event_name):
    st.markdown(f"### {event_name} has been updated!")
    st.session_state.show_success_modal = False
    
    if st.button("Update Event Again", use_container_width=True):
            st.session_state.success_event_name = ""
            st.session_state.reset_form = True
            st.rerun()

if st.session_state.reset_form:
    st.session_state.form_key_counter += 1
    st.session_state.reset_form = False

API_URL = f"http://api:4000"

event_name = st.text_input("Enter Event Name to Update")
fetch_clicked = st.button("Fetch Event Details")

if fetch_clicked:
    try:
        response = requests.get(f"{API_URL}/event/events")
        if response.status_code == 200:
            events = response.json()
            match = next(
                (e for e in events if e.get("Name", "").lower() == event_name.strip().lower()),
                None
            )
            if match:
                st.session_state.fetched_event = match
                st.session_state.fetched_event_id = match.get("EventID")
                st.success(f"Event found! You may now edit the fields below.")
            else:
                st.error("No event found with that name. Please check and try again.")
                st.session_state.fetched_event = None
                st.session_state.fetched_event_id = None
    except requests.exceptions.RequestException as e:
        st.error(f"Error connecting to the API: {str(e)}")
        st.session_state.fetched_event = None

event = st.session_state.get("fetched_event") or {}

with st.form(f"add_event_form_{st.session_state.form_key_counter}"):
    st.subheader("Updated Event Information")

    # Required fields
    name = st.text_input("New Name")
    date = st.text_input("New Date")
    location = st.text_input("New Location")
    description = st.text_input("New Description")
    size = st.text_input("New Size")
    category = st.text_input("New Category")

    submitted = st.form_submit_button("Update Event")

    if submitted:
        if not all([name, date, location, description, size, category]):
            st.error("Please fill in all required fields")
        else:
            event_data = {
                "Name": name,
                "Date": date,
                "Location": location,
                "Description": description,
                "Size": size,
                "Category": category
            }
            event_id = st.session_state.fetched_event_id

            try:
                response = requests.put(f"{API_URL}/event/events/{event_id}", json=event_data)

                st.write("Status code:", response.status_code)
                st.write("Response body:", response.json())

                if response.status_code == 200:
                    st.session_state.show_success_modal = True
                    st.session_state.success_ngo_name = name
                    st.rerun()
                else:
                    st.error(
                        f"Failed to add event: {response.json().get('error', 'Unknown error')}"
                    )

            except requests.exceptions.RequestException as e:
                st.error(f"Error connecting to the API: {str(e)}")
                st.info("Please ensure the API server is running")

if st.session_state.show_success_modal:
    show_success_dialog(st.session_state.success_event_name)

if st.button("Return to Organizer Page"):
    st.switch_page("pages/organizer.py")