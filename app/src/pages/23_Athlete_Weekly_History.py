import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title('Weekly History & Goals')

user_id = st.session_state['user_id']

col1, col2 = st.columns(2)

with col1:
    st.subheader('Weekly Nutrition History')
    start = st.date_input('Start Date')
    end = st.date_input('End Date')

    if st.button('Load History', type='primary', use_container_width=True):
        try:
            response = requests.get(
                f'http://api:4000/nutrition/history/{user_id}?start={start}&end={end}'
            )
            if response.status_code == 200:
                data = response.json()
                if data:
                    st.dataframe(data, use_container_width=True)
                else:
                    st.info('No history found for this date range.')
            else:
                st.error('Could not load history.')
        except Exception as e:
            st.error(f'Error: {e}')

with col2:
    st.subheader('Update a Nutrition Goal')
    goal_id = st.number_input('Goal ID', min_value=1, step=1)
    min_val = st.number_input('New Minimum Value', min_value=0.0, step=10.0)
    max_val = st.number_input('New Maximum Value', min_value=0.0, step=10.0)

    if st.button('Update Goal', type='primary', use_container_width=True):
        try:
            response = requests.put(
                f'http://api:4000/nutrition/goal/{int(goal_id)}',
                json={'min_value': min_val, 'max_value': max_val}
            )
            if response.status_code == 200:
                st.success('Goal updated successfully!')
            else:
                st.error('Failed to update goal.')
        except Exception as e:
            st.error(f'Error: {e}')
