import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome venue owner, {st.session_state['first_name']}.")
st.write('### Dashboard:')

if st.button('View all events',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/view_events.py')

if st.button('View all requests',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/view_request.py')

if st.button('Look at your bookings calendar',
             type='primary',
             use_container_width=True):
    st.session_state['menu_choice'] = 'Venue Calendar'
    st.switch_page('pages/venue_owner.py')

if st.button('Look at your revenue',
             type='primary',
             use_container_width=True):
    st.session_state['menu_choice'] = 'Venue Revenue'
    st.switch_page('pages/venue_owner.py')