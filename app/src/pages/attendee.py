import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome attendee, {st.session_state['first_name']}.")
st.write('### Dashboard:')

if st.button('View all events',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/view_events.py')

if st.button('View event feed',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/view_feed.py')

if st.button('Look at your events',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/view_attendee_events.py')

if st.button('Look at saved event list',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/view_events_list.py')

if st.button('Rate & Review Events',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/view_event_reviews.py')