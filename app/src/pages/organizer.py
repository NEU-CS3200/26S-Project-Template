import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome event organizer, {st.session_state['first_name']}.")
st.write('### Dashboard:')

if st.button('View your events',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/get_events.py')

if st.button('Post a new event',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/post_event.py')

if st.button('Update event',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/update_event.py')

if st.button('Delete event',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/delete_event.py')

if st.button('View attendees matching your events',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/get_event_matches.py')

if st.button('View venues',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/get_venues.py')

if st.button('View performers',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/get_performers.py')