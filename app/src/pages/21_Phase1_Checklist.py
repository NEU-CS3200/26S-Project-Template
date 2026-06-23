import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.title("Phase 1 Setup Checklist")

st.markdown(
    """
    ### Completed in this branch
    - Template/demo code removed from API and app.
    - REST API resource scope locked in docs.
    - Branching workflow documented.
    - Docker startup and verification steps documented.
    - README rewritten with exact setup instructions.

    ### Deferred to Phase 2
    - Final database schema for game resources.
    - Seed data at persona-demo scale.
    - Full CRUD route implementation.
    """
)
