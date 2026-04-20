import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title(f"Welcome, {st.session_state['first_name']}!")
st.write("### What would you like to do today?")

if st.button('View Daily Nutrition Dashboard',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/21_Athlete_Daily_Nutrition.py')

if st.button('Log a Meal',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/22_Athlete_Log_Meal.py')

if st.button('View Weekly History & Goals',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/23_Athlete_Weekly_History.py')
