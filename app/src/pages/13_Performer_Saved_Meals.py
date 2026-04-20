import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title("My Saved Meals")
st.write("Your go-to meal combinations for quick decisions.")

API_BASE = "http://localhost:5000/api"
user_id = st.session_state.get('user_id')

if not user_id:
    st.error("No user ID found. Please log in again.")
    st.stop()

try:
    response = requests.get(f"{API_BASE}/nutrition/saved-meals/{user_id}", timeout=5)

    if response.status_code != 200:
        st.error("Could not load saved meals")
        logger.error(f"Saved meals API error: {response.status_code}")
        st.stop()

    saved_meals = response.json().get('data', [])

    if not saved_meals:
        st.info("No saved meals yet! Head to **Menu Browse** to save your favorites.")
    else:
        st.subheader(f"You have {len(saved_meals)} saved meals")

        for meal in saved_meals:
            col1, col2, col3 = st.columns([2, 2, 1])

            with col1:
                st.write(f"### {meal['name']}")
                if meal.get('description'):
                    st.caption(f"_{meal['description']}_")
                st.caption(f"{meal['item_count']} items • Updated: {meal['updated_at'][:10]}")

            with col2:
                st.write("**Quick Stats:**")
                if meal.get('total_calories'):
                    st.metric("Total Calories", f"{int(meal['total_calories'])}")
                if meal.get('total_protein'):
                    st.metric("Total Protein", f"{meal['total_protein']}g")

            with col3:
                col_del, col_view = st.columns(2)

                with col_del:
                    if st.button('Delete', key=f"del_{meal['saved_meal_id']}"):
                        try:
                            del_response = requests.delete(
                                f"{API_BASE}/nutrition/saved-meals/{meal['saved_meal_id']}",
                                timeout=5
                            )

                            if del_response.status_code == 200:
                                st.success(f"Deleted '{meal['name']}'")
                                st.rerun()
                            else:
                                st.error(f"Error deleting meal: {del_response.json().get('message')}")
                                logger.error(f"Delete API error: {del_response.status_code}")

                        except Exception as e:
                            st.error(f"Could not delete meal: {e}")
                            logger.error(f"Delete error: {e}")

                with col_view:
                    if st.button('Details', key=f"view_{meal['saved_meal_id']}"):
                        st.session_state['expand_meal_id'] = meal['saved_meal_id']
            
            if st.session_state.get('expand_meal_id') == meal['saved_meal_id']:
                with st.expander("Meal Items", expanded=True):
                    st.write("*Detailed breakdown of items in this saved meal:*")
                    st.caption(f"Items: {meal['item_count']} • Total: {meal.get('total_calories', 'N/A')} cal, {meal.get('total_protein', 'N/A')}g protein")

            st.divider()

except requests.RequestException as e:
    st.error(f"Connection error: {e}")
    logger.error(f"API request error: {e}")
except Exception as e:
    st.error(f"Error loading saved meals: {e}")
    logger.error(f"Unexpected error: {e}")

st.divider()
st.write("#### Tip")
st.write("Save your favorite meal combinations here for quick access before performances. Mix and match based on your energy needs!")
