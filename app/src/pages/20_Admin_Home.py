import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.title("Admin Home")
st.write("Project setup control panel for Phase 1.")

if st.button("Open Phase 1 Checklist", type="primary", use_container_width=True):
    st.switch_page("pages/21_Phase1_Checklist.py")

if st.button("Open Container Status", use_container_width=True):
    st.switch_page("pages/14_Container_Status.py")
