import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.title("Moderator Home")
st.write("Phase 1 moderation workspace for setup and team workflow checks.")

if st.button("Open Branching Rules", type="primary", use_container_width=True):
    st.switch_page("pages/16_Branching_Rules.py")

if st.button("Open Container Status", use_container_width=True):
    st.switch_page("pages/14_Container_Status.py")
