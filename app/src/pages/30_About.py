import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.write("# About GameGoats")
st.markdown(
    """
    GameGoats is a team project for managing game-community signals and safety operations.

    In Phase 1, this repository focuses on:
    - consistent local startup with Docker,
    - shared branch workflow,
    - locked REST route/resource scope,
    - cleaned template baseline for future implementation.
    """
)

if st.button("Return to Home", type="primary"):
    st.switch_page("Home.py")
