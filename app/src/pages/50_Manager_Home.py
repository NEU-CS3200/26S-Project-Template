import logging
import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger(__name__)

st.set_page_config(layout='wide')
SideBarLinks()

st.title(f"Welcome, {st.session_state.get('first_name', 'Karen')} Vick")
st.write("### Manager Home")

st.markdown(
    """
    Karen Vick is the manager persona for NorthStar. Her role is to monitor vendor-side
    operations, review business performance, and keep an eye on data quality concerns
    that affect the overall platform experience.
    """
)

st.subheader("Planned Manager Pages")

st.info("`51_Manager_Dashboard.py` — planned dashboard view for manager operations and summary metrics.")
st.info("`52_Vendor_Performance.py` — planned view for vendor trends, engagement, and performance tracking.")
st.info("`53_Data_Quality_Review.py` — planned review space for incomplete, inconsistent, or outdated data.")

st.caption("These pages are referenced here for navigation planning and are not implemented yet.")
