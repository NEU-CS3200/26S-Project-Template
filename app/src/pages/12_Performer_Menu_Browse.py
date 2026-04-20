import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title("Menu Browse & Quick Save")
st.write("Find healthy meals and save your favorites.")

API_BASE = "http://localhost:5000/api"

st.subheader("Filter Options")
col1, col2, col3 = st.columns(3)

with col1:
    try:
        halls_response = requests.get(f"{API_BASE}/nutrition/dining-halls", timeout=5)
        halls_data = halls_response.json()['data'] if halls_response.status_code == 200 else []
        hall_options = {h['name']: h['hall_id'] for h in halls_data}
        hall_options['All Halls'] = None
        selected_hall_name = st.selectbox('Dining Hall', options=['All Halls'] + [h['name'] for h in halls_data])
        selected_hall_id = hall_options.get(selected_hall_name)
    except Exception as e:
        st.error(f"Could not load dining halls: {e}")
        logger.error(f"Halls API error: {e}")
        selected_hall_id = None

with col2:
    meal_period = st.selectbox('Meal Period',
        options=['All', 'breakfast', 'lunch', 'dinner', 'all_day'],
        format_func=lambda x: x.capitalize() if x != 'all_day' else 'All Day')

with col3:
    search_term = st.text_input('Search item name', placeholder='e.g. chicken, salad')

try:
    params = {
        'date': '2025-04-04',
        'hall_id': selected_hall_id,
        'meal_period': None if meal_period == 'All' else meal_period,
        'search': search_term
    }
    params = {k: v for k, v in params.items() if v is not None}

    menu_response = requests.get(f"{API_BASE}/nutrition/menu-browse", params=params, timeout=5)

    if menu_response.status_code != 200:
        st.error("Could not load menu items")
        logger.error(f"Menu API error: {menu_response.status_code}")
        st.stop()

    menu_data = menu_response.json()
    items = menu_data.get('data', [])

    if not items:
        st.info("No items match your filters. Try adjusting your search.")
    else:
        st.subheader(f"Found {len(items)} items")

        for item in items:
            col_a, col_b, col_c, col_d = st.columns([3, 1, 1, 1])

            with col_a:
                st.write(f"**{item['name']}**")
                st.caption(f"{item['dining_hall']} • {item['meal_period'].title()}")
                if item.get('description'):
                    st.caption(item['description'])

            with col_b:
                if item.get('calories'):
                    st.metric("Cal", f"{int(item['calories'])}")

            with col_c:
                if item.get('protein'):
                    st.metric("Protein", f"{item['protein']}g")

            with col_d:
                if st.button('Save', key=f"save_{item['item_id']}"):
                    st.session_state['selected_item'] = item
                    st.session_state['show_save_modal'] = True

except requests.RequestException as e:
    st.error(f"Connection error: {e}")
    logger.error(f"API request error: {e}")
except Exception as e:
    st.error(f"Error loading menu: {e}")
    logger.error(f"Unexpected error: {e}")

st.divider()

if st.session_state.get('show_save_modal'):
    st.subheader("Add to Saved Meal")

    item = st.session_state.get('selected_item', {})
    st.write(f"**Item:** {item.get('name')}")

    meal_name = st.text_input('Saved meal name', placeholder='e.g., Pre-Show Energy Boost')
    servings = st.number_input('Servings', min_value=0.5, value=1.0, step=0.5)
    description = st.text_area('Description (optional)', placeholder='Why you love this meal...')

    col_save1, col_save2 = st.columns(2)

    with col_save1:
        if st.button('Create Saved Meal'):
            if meal_name:
                try:
                    payload = {
                        'user_id': st.session_state.get('user_id'),
                        'name': meal_name,
                        'description': description,
                        'items': [{'item_id': item['item_id'], 'servings': servings}]
                    }

                    save_response = requests.post(f"{API_BASE}/nutrition/saved-meals",
                        json=payload, timeout=5)

                    if save_response.status_code == 201:
                        st.success(f"Saved '{meal_name}' successfully!")
                        st.session_state['show_save_modal'] = False
                        st.rerun()
                    else:
                        st.error(f"Error saving meal: {save_response.json().get('message')}")
                        logger.error(f"Save API error: {save_response.status_code}")

                except Exception as e:
                    st.error(f"Could not save meal: {e}")
                    logger.error(f"Save error: {e}")
            else:
                st.warning("Please enter a name for the saved meal")

    with col_save2:
        if st.button('Cancel'):
            st.session_state['show_save_modal'] = False
            st.rerun()
