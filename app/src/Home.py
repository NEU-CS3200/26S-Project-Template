##################################################
# This is the main/entry-point file for the
# sample application for your project
##################################################

import logging
logging.basicConfig(format='%(filename)s:%(lineno)s:%(levelname)s -- %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
st.session_state['authenticated'] = False

SideBarLinks(show_home=True)

API_BASE = "http://web-api:4000"


def resolve_or_create_user(first_name, last_name, email):
    """Look up a user by email; create them if they don't exist. Returns user_id."""
    try:
        r = requests.get(f"{API_BASE}/users", params={"email": email}, timeout=5)
        r.raise_for_status()
        users = r.json()
        if users:
            return users[0]["user_id"]
        # Not found — create the user
        r2 = requests.post(f"{API_BASE}/users",
                           json={"first_name": first_name, "last_name": last_name,
                                 "user_email": email},
                           timeout=5)
        r2.raise_for_status()
        return r2.json()["user_id"]
    except Exception as e:
        logger.warning(f"Could not resolve user {email}: {e}")
        return None


logger.info("Loading the Home page of the app")
st.title('Bostonability')
st.write('#### Hi! As which user would you like to log in?')

if st.button("Act as Paul Baker, a Data Analyst",
             type='primary',
             use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'analyst'
    st.session_state['first_name'] = 'Paul'
    st.session_state['last_name'] = 'Baker'
    st.session_state['user_id'] = resolve_or_create_user('Paul', 'Baker', 'paul.baker@bostonability.com')
    logger.info("Logging in as Paul Baker")
    st.switch_page('pages/00_Analyst_Home.py')

if st.button('Act as Sally Locke, a daily user',
             type='primary',
             use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'user'
    st.session_state['first_name'] = 'Sally'
    st.session_state['last_name'] = 'Locke'
    st.session_state['user_id'] = resolve_or_create_user('Sally', 'Locke', 'sally.locke@bostonability.com')
    st.switch_page('pages/10_Basic_User_Home.py')

if st.button('Act as Wilson Lampisyobiford, a System Administrator',
             type='primary',
             use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'admin'
    st.session_state['first_name'] = 'Wilson'
    st.session_state['last_name'] = 'Lampisyobiford'
    st.session_state['user_id'] = resolve_or_create_user('Wilson', 'Lampisyobiford', 'wilson.lampisyobiford@bostonability.com')
    st.switch_page('pages/20_Admin_Home.py')
