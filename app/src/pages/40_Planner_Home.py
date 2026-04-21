import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title(f"Welcome, {st.session_state.get('first_name', 'Planner')} 🧭")
st.write("### What would you like to do today?")

if st.button("📋 View & Manage My Trips", type='primary', use_container_width=True):
    st.switch_page('pages/41_My_Trips.py')

if st.button("💰 Trip Budget Tracker", type='primary', use_container_width=True):
    st.switch_page('pages/42_Budget_Tracker.py')

if st.button("🏨 Browse & Compare Listings", type='primary', use_container_width=True):
    st.switch_page('pages/43_Browse_Listings.py')
