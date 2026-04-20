import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

first_name = st.session_state.get("first_name", "there")
st.title(f"Welcome, {first_name}!")
st.write("Explore platform data, track growth trends, and generate reports for the founding team.")

if st.button("📊 Open Analytics Dashboard", use_container_width=True, type="primary"):
    st.switch_page("pages/21_User_Signups.py")
