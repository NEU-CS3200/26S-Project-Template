import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title('Daily Nutrition Dashboard')
st.write('Track your nutrient intake and goal status for today.')

user_id = st.session_state['user_id']
date = st.date_input('Select Date')
date_str = str(date)

col1, col2 = st.columns(2)

with col1:
    st.subheader('Nutrient Totals vs Goals')
    try:
        response = requests.get(f'http://api:4000/nutrition/goals/{user_id}?date={date_str}')
        if response.status_code == 200:
            data = response.json()
            if data:
                for row in data:
                    status = row.get('status', '')
                    if status == 'ON TRACK':
                        color = 'green'
                    elif status == 'ABOVE':
                        color = 'red'
                    else:
                        color = 'orange'
                    st.markdown(
                        f"**{row['nutrient']}** ({row['unit']}): "
                        f"{row['daily_total']} / min {row['goal_min']} — "
                        f":{color}[{status}]"
                    )
            else:
                st.info('No nutrition data found for this date.')
        else:
            st.error('Could not load goal status.')
    except Exception as e:
        st.error(f'Error: {e}')

with col2:
    st.subheader('All Nutrients Today')
    try:
        response = requests.get(f'http://api:4000/nutrition/daily/{user_id}?date={date_str}')
        if response.status_code == 200:
            data = response.json()
            if data:
                st.dataframe(data, use_container_width=True)
            else:
                st.info('No meals logged for this date.')
        else:
            st.error('Could not load daily nutrition.')
    except Exception as e:
        st.error(f'Error: {e}')

st.divider()
st.subheader('Alerts')
try:
    response = requests.get(f'http://api:4000/nutrition/alerts/{user_id}')
    if response.status_code == 200:
        alerts = response.json()
        if alerts:
            for alert in alerts:
                st.warning(f"⚠️ {alert['alert_type'].upper()}: {alert['message']}")
        else:
            st.success('No unread alerts!')
    else:
        st.error('Could not load alerts.')
except Exception as e:
    st.error(f'Error: {e}')
