##################################################
# Main / entry-point file for OfferWatch
##################################################

import logging
logging.basicConfig(
    format='%(filename)s:%(lineno)s:%(levelname)s -- %(message)s',
    level=logging.INFO
)
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# User is not authenticated on the home screen
st.session_state['authenticated'] = False

# Show home link in sidebar
SideBarLinks(show_home=True)

logger.info("Loading the Home page of the app")

st.title("OfferWatch")
st.write("#### Choose a persona to log in as")

col1, col2 = st.columns(2)

with col1:
    if st.button("Act as Alex Chen, Student", type="primary", use_container_width=True):
        st.session_state['authenticated'] = True
        st.session_state['role'] = 'student'
        st.session_state['first_name'] = 'Alex'
        logger.info("Logging in as Student persona")
        st.switch_page('pages/00_Student_Home.py')

    if st.button("Act as Lisa Rodriguez, Career Services Analyst", type="primary", use_container_width=True):
        st.session_state['authenticated'] = True
        st.session_state['role'] = 'analyst'
        st.session_state['first_name'] = 'Lisa'
        logger.info("Logging in as Analyst persona")
        st.switch_page('pages/10_Analyst_Home.py')

with col2:
    if st.button("Act as Reece James, Recruiter", type="primary", use_container_width=True):
        st.session_state['authenticated'] = True
        st.session_state['role'] = 'recruiter'
        st.session_state['first_name'] = 'Reece'
        logger.info("Logging in as Recruiter persona")
        st.switch_page('pages/20_Recruiter_Home.py')

if st.button('Act as System Administrator',
             type='primary',
             use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'administrator'
    st.session_state['first_name'] = 'SysAdmin'
    st.switch_page('pages/30_Admin_Dashboard.py')

if st.button('Act as Reece James, a Recruiter',
             type='primary',
             use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'recruiter'
    st.session_state['first_name'] = 'Reece'
    st.switch_page('pages/90_Recruiter_Home.py')

if st.button('Act as Alex, a Job Seeker',
             type='primary',
             use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'job_seeker'
    st.session_state['first_name'] = 'Alex'
    st.session_state['student_id'] = 1
    logger.info("Logging in as Job Seeker Persona")
    st.switch_page('pages/40_Job_Seeker_Home.py')
