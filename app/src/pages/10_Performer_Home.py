import logging
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title(f"Welcome, {st.session_state['first_name']}!")
st.write("### Keep your energy up between performances!")
st.write("Quick access to healthy dining options on campus.")

col1, col2, col3 = st.columns(3)

with col1:
    if st.button('Find Nearby Dining',
                type='primary',
                use_container_width=True,
                key='btn_location'):
        st.switch_page('pages/11_Performer_Location_Map.py')

with col2:
    if st.button('Browse Menu',
                type='primary',
                use_container_width=True,
                key='btn_menu'):
        st.switch_page('pages/12_Performer_Menu_Browse.py')

with col3:
    if st.button('My Saved Meals',
                type='primary',
                use_container_width=True,
                key='btn_saved'):
        st.switch_page('pages/13_Performer_Saved_Meals.py')

st.divider()
st.write("#### Why Nutrition Matters for Performers")
st.write("""
- **Pre-Performance**: Fuel up with carbs and protein before shows
- **Recovery**: Rebuild muscles with protein-rich meals after performances
- **Energy**: Stay alert and perform at your best all day
- **Time**: Find quick options when your schedule is packed
""")
