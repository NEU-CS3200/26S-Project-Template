import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome, {st.session_state['first_name']}.")
st.write('### What would you like to do today?')

if st.button('Report an Obstruction',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/11_Report_Obstruction.py')

if st.button('Find Accessibility Info',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/12_Find_Accessibility_Info.py')

if st.button('View Profile',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/16_User_View_Profile.py')

