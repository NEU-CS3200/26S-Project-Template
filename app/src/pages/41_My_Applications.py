import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000"

# same cream background + dark card styling used on the other pages
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

# pull student id from login
student_id = st.session_state.get("student_id", 1)

st.title("My Applications")
st.write("Track every job you've applied to, update their status as you hear back, and keep prep notes in one spot.")


# ============================================================
# LIST APPLICATIONS (US1, US3)
# ============================================================

st.subheader("All Applications")

# filter by status - uses the ?status= query param on the GET route
status_options = ["All", "Applied", "Interview Scheduled", "Offer", "Rejected", "Withdrawn"]
status_filter = st.selectbox("Filter by Status", options=status_options)

params = {}
if status_filter != "All":
    params["status"] = status_filter

response = requests.get(f"{API_BASE}/alex/students/{student_id}/applications", params=params)
applications = response.json()

if applications:
    st.dataframe(applications, use_container_width=True)
    st.write(f"**{len(applications)} application(s) found**")
else:
    st.info("No applications match that filter.")


# ============================================================
# LOG A NEW APPLICATION (US1) - POST
# ============================================================

st.subheader("Log a New Application")

col1, col2 = st.columns(2)

with col1:
    position_id = st.number_input("Position ID", min_value=1, step=1, key="new_position_id")
    new_status = st.selectbox(
        "Status",
        options=["Applied", "Interview Scheduled", "Offer", "Rejected", "Withdrawn"],
        key="new_status"
    )

with col2:
    application_date = st.date_input("Application Date", key="new_date")
    resume_id = st.number_input("Resume ID (optional)", min_value=0, step=1, key="new_resume_id")

notes = st.text_area("Notes (optional)", key="new_notes")

if st.button("Add Application", type="primary"):
    new_input = {
        "position_id": position_id,
        "application_date": str(application_date),
        "status": new_status,
        "notes": notes if notes else None,
    }
    # only send resume_id if they actually entered one
    if resume_id > 0:
        new_input["resume_id"] = resume_id

    result = requests.post(
        f"{API_BASE}/alex/students/{student_id}/applications",
        json=new_input
    )

    if result.status_code == 201:
        st.success("Application logged successfully!")
        st.rerun()
    else:
        st.error(f"Couldn't log that application: {result.json().get('error', 'unknown error')}")


# ============================================================
# UPDATE STATUS OR NOTES (US3) - PUT
# ============================================================

st.subheader("Update an Application")
st.write("Change the status when you hear back, or add more notes.")

col1, col2 = st.columns(2)

with col1:
    update_id = st.number_input("Application ID to Update", min_value=1, step=1, key="update_id")
    updated_status = st.selectbox(
        "New Status",
        options=["Applied", "Interview Scheduled", "Offer", "Rejected", "Withdrawn"],
        key="updated_status"
    )

with col2:
    updated_notes = st.text_area("Updated Notes", key="updated_notes")

if st.button("Update Application", type="primary"):
    update_input = {
        "status": updated_status,
    }
    if updated_notes:
        update_input["notes"] = updated_notes

    result = requests.put(
        f"{API_BASE}/alex/applications/{update_id}",
        json=update_input
    )

    if result.status_code == 200:
        st.success("Application updated successfully!")
        st.rerun()
    else:
        st.error("Application not found.")


# ============================================================
# ARCHIVE (SOFT-DELETE) AN APPLICATION - DELETE
# ============================================================

st.subheader("Archive an Application")
st.write("Remove an application from your active list without losing the record.")

archive_id = st.number_input("Application ID to Archive", min_value=1, step=1, key="archive_id")

if st.button("Archive Application", type="primary"):
    result = requests.delete(f"{API_BASE}/alex/applications/{archive_id}")
    if result.status_code == 200:
        st.success("Application archived successfully!")
        st.rerun()
    else:
        st.error("Application not found.")


# ============================================================
# NOTES SECTION (US6) - GET + POST
# ============================================================

st.subheader("Interview Prep Notes")
st.write("View and add prep notes, interview feedback, or anything you want to remember about a specific application.")

notes_app_id = st.number_input("Application ID to View Notes For", min_value=1, step=1, key="notes_app_id")

# GET existing notes for the chosen application
notes_response = requests.get(f"{API_BASE}/alex/applications/{notes_app_id}/notes")

if notes_response.status_code == 200:
    notes_list = notes_response.json()
    if notes_list:
        st.write(f"**{len(notes_list)} note(s) for this application:**")
        st.dataframe(notes_list, use_container_width=True)
    else:
        st.info("No notes yet for this application.")
elif notes_response.status_code == 404:
    st.warning("That application doesn't exist.")

# POST a new note
st.write("**Add a New Note:**")
new_note_text = st.text_area("Note Text", key="new_note_text")

if st.button("Add Note", type="primary"):
    if new_note_text:
        result = requests.post(
            f"{API_BASE}/alex/applications/{notes_app_id}/notes",
            json={"note_text": new_note_text}
        )
        if result.status_code == 201:
            st.success("Note added successfully!")
            st.rerun()
        else:
            st.error("Couldn't add that note.")
    else:
        st.warning("Please write something before adding the note.")