import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Data Analyst, {st.session_state['first_name']}.")
st.write('### What would you like to do today?')

if st.button('View Neighborhood Accessibility Dashboard',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/01_Accessibility_Dashboard.py')

if st.button('View Trends',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/02_Analyst_Trends_Exports.py')

if st.button('View Reports',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/03_View_Reports.py')
