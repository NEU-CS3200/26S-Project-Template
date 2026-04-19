import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

st.title('System Admin Home Page')
st.write('### What would you like to do today?')

if st.button('Manage Users',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/21_Manage_Users.py')

if st.button('Manage Reports',
            type='primary',
            use_container_width=True):
    st.switch_page('pages/22_Manage_Reports.py')
