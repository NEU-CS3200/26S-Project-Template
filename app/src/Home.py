import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks(show_home=True)

st.title("GameGoats")
st.write("Phase 1 setup workspace. Choose a page to continue.")

col1, col2, col3 = st.columns(3)

with col1:
    st.subheader("Player Persona")
    if st.button("Open Player Home", type="primary", use_container_width=True):
        st.switch_page("pages/00_Player_Home.py")

with col2:
    st.subheader("Moderator Persona")
    if st.button("Open Moderator Home", type="primary", use_container_width=True):
        st.switch_page("pages/10_Moderator_Home.py")

with col3:
    st.subheader("Admin Persona")
    if st.button("Open Admin Home", type="primary", use_container_width=True):
        st.switch_page("pages/20_Admin_Home.py")
