import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

first_name = st.session_state.get("first_name", "there")
st.title(f"Welcome, {first_name}!")
st.write("Manage tickets, moderate users, review venue applications, and keep the platform clean.")

col1, col2 = st.columns(2)
with col1:
    if st.button("🎫 People & Tickets", use_container_width=True, type="primary"):
        st.switch_page("pages/31_Manage_Tickets.py")
with col2:
    if st.button("🛠️ Platform Tools", use_container_width=True, type="primary"):
        st.switch_page("pages/34_Duplicate_Venues.py")
