import logging
import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

st.set_page_config(layout="wide")
SideBarLinks()

st.title(f"Welcome Manager, {st.session_state.get('first_name', 'Karen')}.")
st.write("### What would you like to do today?")

if st.button("View Manager Dashboard", type="primary", use_container_width=True):
    st.switch_page("pages/51_Manager_Dashboard.py")

if st.button("View Vendor Performance", type="primary", use_container_width=True):
    st.switch_page("pages/52_Vendor_Performance.py")

if st.button("Review Data Quality Issues", type="primary", use_container_width=True):
    st.switch_page("pages/53_Data_Quality_Review.py")