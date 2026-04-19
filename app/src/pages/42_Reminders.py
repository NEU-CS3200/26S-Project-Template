import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000"

# same styling as my other pages so it all looks consistent
st.markdown("""
    <style>
        .stApp {
            background-color: #FAF9F6;
        }
        [data-testid="stHeader"] {
            background-color: #2c2c2c;
        }
    </style>
""", unsafe_allow_html=True)

student_id = st.session_state.get("student_id", 1)

st.title("Reminders")
st.write("Stay on top of follow-ups, interview dates, and offer deadlines so nothing slips through the cracks.")

# show everything the student has scheduled
st.subheader("Upcoming Reminders")

response = requests.get(f"{API_BASE}/alex/students/{student_id}/reminders")
reminders = response.json()

if reminders:
    st.dataframe(reminders, use_container_width=True)
    st.write(f"**{len(reminders)} reminder(s) scheduled**")
else:
    st.info("No reminders yet. Add one below to get started.")


# form to create a new reminder tied to one of their apps
st.subheader("Add a Reminder")
st.write("Tie a reminder to one of your applications so you know exactly what it's about.")

col1, col2 = st.columns(2)

with col1:
    new_app_id = st.number_input("Application ID", min_value=1, step=1, key="reminder_app_id")
    new_due_date = st.date_input("Due Date", key="reminder_due_date")

with col2:
    new_description = st.text_area("Description", key="reminder_description")

if st.button("Add Reminder", type="primary"):
    if new_description:
        new_input = {
            "application_id": new_app_id,
            "description": new_description,
            "due_date": str(new_due_date),
        }
        result = requests.post(
            f"{API_BASE}/alex/students/{student_id}/reminders",
            json=new_input
        )
        if result.status_code == 201:
            st.success("Reminder added successfully!")
            st.rerun()
        elif result.status_code == 404:
            st.error("Application not found. Double-check the Application ID.")
        else:
            st.error("Couldn't add that reminder.")
    else:
        st.warning("Please add a description before saving.")


# push a reminder out or reword it
st.subheader("Edit a Reminder")
st.write("Change the description, push the date out, or both.")

col1, col2 = st.columns(2)

with col1:
    update_reminder_id = st.number_input("Reminder ID to Update", min_value=1, step=1, key="update_reminder_id")
    updated_due_date = st.date_input("New Due Date", key="updated_due_date")

with col2:
    updated_description = st.text_area("New Description", key="updated_description")

if st.button("Update Reminder", type="primary"):
    # only send the description if they actually typed something, otherwise just update the date
    update_input = {}
    if updated_description:
        update_input["description"] = updated_description
    update_input["due_date"] = str(updated_due_date)

    result = requests.put(
        f"{API_BASE}/alex/reminders/{update_reminder_id}",
        json=update_input
    )
    if result.status_code == 200:
        st.success("Reminder updated successfully!")
        st.rerun()
    else:
        st.error("Reminder not found.")


# get rid of one that isn't needed anymore
st.subheader("Delete a Reminder")
st.write("Remove a reminder you no longer need.")

delete_reminder_id = st.number_input("Reminder ID to Delete", min_value=1, step=1, key="delete_reminder_id")

if st.button("Delete Reminder", type="primary"):
    result = requests.delete(f"{API_BASE}/alex/reminders/{delete_reminder_id}")
    if result.status_code == 200:
        st.success("Reminder deleted successfully!")
        st.rerun()
    else:
        st.error("Reminder not found.")