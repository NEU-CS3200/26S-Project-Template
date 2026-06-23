import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.title("REST API Scope")
st.write("Phase 1 locked resource scope for the GameGoats API.")

st.markdown(
    """
    ### Planned Resources
    - `games`
    - `comments`
    - `favorites`
    - `recommendations`
    - `reports`
    - `servers`
    - `alerts`

    Full matrix and route notes are in `docs/rest-api-matrix.md`.
    """
)
