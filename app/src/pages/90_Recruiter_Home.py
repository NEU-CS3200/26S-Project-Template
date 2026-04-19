import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title(f"Welcome, {st.session_state['first_name']}!")
st.write("### What would you like to do today?")

if st.button('Candidate Pipeline', type='primary', use_container_width=True):
    st.switch_page('pages/91_Candidate_Pipeline.py')

if st.button('Pipeline Stats', type='primary', use_container_width=True):
    st.switch_page('pages/93_Pipeline_Stats.py')

