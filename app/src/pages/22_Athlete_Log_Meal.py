import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title('Log a Meal')

user_id = st.session_state['user_id']

col1, col2 = st.columns(2)

with col1:
    st.subheader('Browse Menu Items')
    date = st.date_input('Menu Date')
    date_str = str(date)

    try:
        response = requests.get(f'http://api:4000/nutrition/menu?date={date_str}')
        if response.status_code == 200:
            menu = response.json()
            if menu:
                seen = set()
                items = []
                for row in menu:
                    name = row['menu_item']
                    if name not in seen:
                        seen.add(name)
                        items.append(row)
                st.dataframe(items, use_container_width=True)
            else:
                st.info('No menu items found for this date.')
        else:
            st.error('Could not load menu.')
    except Exception as e:
        st.error(f'Error: {e}')

with col2:
    st.subheader('Log New Meal')
    log_date = st.date_input('Log Date')
    meal_period = st.selectbox('Meal Period', ['breakfast', 'lunch', 'dinner', 'snack'])
    item_id = st.number_input('Item ID', min_value=1, step=1)
    servings = st.number_input('Servings', min_value=0.5, step=0.5, value=1.0)

    if st.button('Log Meal', type='primary', use_container_width=True):
        payload = {
            'user_id': user_id,
            'log_date': str(log_date),
            'meal_period': meal_period,
            'items': [{'item_id': int(item_id), 'servings': servings}]
        }
        try:
            response = requests.post('http://api:4000/nutrition/log', json=payload)
            if response.status_code == 201:
                st.success(f"Meal logged! Log ID: {response.json()['log_id']}")
            else:
                st.error('Failed to log meal.')
        except Exception as e:
            st.error(f'Error: {e}')

st.divider()
st.subheader('Update or Delete a Meal Log')

log_id = st.number_input('Meal Log ID to edit/delete', min_value=1, step=1)

update_col, delete_col = st.columns(2)

with update_col:
    new_period = st.selectbox('New Meal Period', ['breakfast', 'lunch', 'dinner', 'snack'], key='update_period')
    if st.button('Update Meal Log', use_container_width=True):
        try:
            response = requests.put(
                f'http://api:4000/nutrition/log/{int(log_id)}',
                json={'meal_period': new_period}
            )
            if response.status_code == 200:
                st.success('Meal log updated!')
            else:
                st.error('Failed to update.')
        except Exception as e:
            st.error(f'Error: {e}')

with delete_col:
    if st.button('Delete Meal Log', type='primary', use_container_width=True):
        try:
            response = requests.delete(f'http://api:4000/nutrition/log/{int(log_id)}')
            if response.status_code == 200:
                st.success('Meal log deleted!')
            else:
                st.error('Failed to delete.')
        except Exception as e:
            st.error(f'Error: {e}')
