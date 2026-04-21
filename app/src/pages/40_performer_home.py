import logging
logger = logging.getLogger(__name__)
 
import streamlit as st
from modules.nav import SideBarLinks
 
st.set_page_config(layout='wide')
 
SideBarLinks()
 
st.title(f"Welcome, {st.session_state.get('first_name', 'Performer')}!")
st.write('### What would you like to do today?')
 
if st.button('My Profile',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/41_performer_profile.py')

if st.button('My Booking Requests',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/42_performer_bookings.py')
 
if st.button('My Upcoming Performances',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/43_Performer_Performances.py')