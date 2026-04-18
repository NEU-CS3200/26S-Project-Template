import logging
import streamlit as st
from modules.nav import SideBarLinks

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

st.set_page_config(layout="wide")

SideBarLinks(show_home=True)

st.markdown("## Welcome, Devon 👋")
st.caption("System Administrator · HoopSpot Platform")
st.markdown("---")

col1, col2 = st.columns(2)
with col1:
    if st.button("🏀 Manage Courts", use_container_width=True, type="primary"):
        st.switch_page("pages/22_Manage_Courts.py")
with col2:
    if st.button("⭐ Moderate Reviews", use_container_width=True, type="primary"):
        st.switch_page("pages/23_Manage_Reviews.py")