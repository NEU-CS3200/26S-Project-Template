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

organizer_id = st.session_state.get("organizer_id", 4)

st.title("Add New Event")

@st.dialog("Success")
def show_success_dialog(event_name):
    st.markdown(f"### {event_name} has been successfully added to the system!")
    st.session_state.show_success_modal = False
    
    if st.button("Add Another Event", use_container_width=True):
            st.session_state.success_event_name = ""
            st.session_state.reset_form = True
            st.rerun()

if st.session_state.reset_form:
    st.session_state.form_key_counter += 1
    st.session_state.reset_form = False

API_URL = f"http://api:4000/event/events"

with st.form(f"add_event_form_{st.session_state.form_key_counter}"):
    st.subheader("Event Information")

    # Required fields
    name = st.text_input("Name")
    date = st.text_input("Date")
    location = st.text_input("Location")
    description = st.text_input("Description")
    size = st.text_input("Size")
    category = st.text_input("Category")

    submitted = st.form_submit_button("Add Event")

    if submitted:
        if not all([name, date, location, description, size, category]):
            st.error("Please fill in all required fields marked with *")
        else:
            event_data = {
                "name": name,
                "date": date,
                "location": location,
                "description": description,
                "size": size,
                "category": category
            }

            st.session_state.success_event_name = name

            try:
                response = requests.post(API_URL, json=event_data)

                if response.status_code == 201:
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
