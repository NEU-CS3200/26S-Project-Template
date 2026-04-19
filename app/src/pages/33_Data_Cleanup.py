import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000"

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

st.title("Data Cleanup")
st.write("Review and Permantly delete outdated/archived records")

st.subheader("Outdated / Archived Records")

response = requests.get(f"{API_BASE}/admin/data-cleanup")
records = response.json()

if records:
    st.dataframe(records, use_container_width=True)
    st.write(f"**{len(records)} record(s)** flagged for cleanup")

    st.subheader("Delete Records")

    st.write("**Delete a Specific Record**")
    application_id = st.number_input("Enter Application ID to delete", min_value=1, step=1)
    st.warning("This action is permanent and can't be reversed.")

    col1, col2, col3, col4, col5 = st.columns([2, 2, 1.5, 1, 1])
    with col1:
        if st.button("Delete Record", type="primary"):
            result = requests.delete(f"{API_BASE}/admin/data-cleanup/{application_id}")
            if result.status_code == 200:
                st.success(f"Record {application_id} deleted successfully.")
                st.rerun()
            else:
                st.error("Record not found.")

    with col2:
        if st.button("Delete All Records", type="primary"):
            result = requests.delete(f"{API_BASE}/admin/data-cleanup")
            if result.status_code == 200:
                data = result.json()
                st.success(f"Successfully deleted {data['num_rows_deleted']} record(s).")
                st.rerun()
            else:
                st.error("Something went wrong")
else:
    st.success("No Outdated/Archieved Records found")