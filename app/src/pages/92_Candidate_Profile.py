import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000/rec"

if "selected_student_id" not in st.session_state:
    st.error("No candidate selected. Go back to the pipeline.")
    if st.button("Back to Pipeline"):
        st.switch_page("pages/91_Candidate_Pipeline.py")
    st.stop()

student_id = st.session_state["selected_student_id"]
app_id = st.session_state["selected_application_id"]

if st.button("← Back to Pipeline"):
    st.switch_page("pages/91_Candidate_Pipeline.py")

# Fetch candidate profile 
try:
    profile_res = requests.get(f"{API_BASE}/candidates/{student_id}")
    profile = profile_res.json() if profile_res.status_code == 200 else None
except Exception:
    profile = None

if not profile:
    st.error("Could not load candidate profile.")
    st.stop()

# --- Layout: left = info + stage, right = notes ---
left, right = st.columns([1, 1])

with left:
    st.subheader(f"{profile['FirstName']} {profile['LastName']}")
    st.write(f"**University:** {profile['university']}")
    st.write(f"**Email:** {profile['Email']}")
    st.write(f"**GPA:** {profile.get('GPA', 'N/A')}")
    st.write(f"**Year:** {profile.get('Year', 'N/A')}")

    st.divider()

    # Update Hiring Stage
    st.write("**Update Hiring Stage**")
    stages = ["Applied", "Screening", "Phone Interview",
              "Technical Interview", "Offer Sent", "Closed", "Rejected"]

    # Find current stage from applications
    current_stage = "Applied"
    for a in profile.get("applications", []):
        if a["ApplicationID"] == app_id:
            current_stage = a["stage"]
            break

    new_stage = st.selectbox("Stage", stages,
                             index=stages.index(current_stage) if current_stage in stages else 0)

    col1, col2 = st.columns(2)
    with col1:
        if st.button("Save", use_container_width=True):
            res = requests.put(f"{API_BASE}/applications/{app_id}/stage",
                               json={"stage": new_stage})
            if res.status_code == 200:
                st.success("Stage updated.")
            else:
                st.error("Failed to update stage.")
    with col2:
        if st.button("Cancel", use_container_width=True):
            st.rerun()

with right:
    st.subheader("Notes")

    # Fetch notes
    try:
        notes_res = requests.get(f"{API_BASE}/applications/{app_id}/notes")
        notes = notes_res.json() if notes_res.status_code == 200 else []
    except Exception:
        notes = []

    for note in notes:
        with st.container(border=True):
            ncol1, ncol2 = st.columns([5, 1])
            ncol1.write(f"**{str(note['Created_At'])[:10]}**")
            ncol1.write(note["Note_Text"])
            if ncol2.button("Delete", key=f"del_{note['NoteID']}"):
                del_res = requests.delete(f"{API_BASE}/notes/{note['NoteID']}")
                if del_res.status_code == 200:
                    st.rerun()

    st.divider()
    st.write("**Add a Note**")
    note_text = st.text_area("Type a note...", label_visibility="collapsed")
    if st.button("Save Note", use_container_width=True):
        if note_text.strip():
            res = requests.post(f"{API_BASE}/applications/{app_id}/notes",
                                json={"note_text": note_text})
            if res.status_code == 201:
                st.success("Note saved.")
                st.rerun()
            else:
                st.error("Failed to save note.")
        else:
            st.warning("Note cannot be empty.")
