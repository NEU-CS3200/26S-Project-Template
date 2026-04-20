# Persona: Maya Chen (CUSTOMER)
# Landing page — links out to all Maya user stories
import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

first_name = st.session_state.get("first_name", "there")
st.title(f"Welcome, {first_name}!")
st.write("Find, save, and review your next perfect date spot.")

col1, col2 = st.columns(2)
with col1:
    if st.button("🔍 Discover & My Lists", use_container_width=True, type="primary"):
        st.switch_page("pages/41_Discover_Venues.py")
with col2:
    if st.button("⭐ Reviews", use_container_width=True, type="primary"):
        st.switch_page("pages/43_My_Reviews.py")
