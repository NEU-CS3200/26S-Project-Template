import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.title("Player Home")
st.write("Use this workspace to validate core setup in Phase 1.")

if st.button("Open Container Status", type="primary", use_container_width=True):
    st.switch_page("pages/14_Container_Status.py")

if st.button("Open REST API Scope", use_container_width=True):
    st.switch_page("pages/15_REST_API_Scope.py")
