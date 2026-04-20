import logging
logger = logging.getLogger(__name__)
import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title(f"Welcome, {st.session_state['first_name']}!")
st.write("### What would you like to do today?")

if st.button('Filter & Visualize Nutrition Data',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/31_Analyst_Filter_Visualize.py')

if st.button('Configure Data Exports',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/32_Analyst_Export_Config.py')

if st.button('Detect Outliers',
             type='primary',
             use_container_width=True):
    st.switch_page('pages/33_Analyst_Outliers.py')
