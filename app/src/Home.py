##################################################
# This is the main/entry-point file for the
# sample application for your project
##################################################

# Set up basic logging infrastructure
import logging

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

# import the main streamlit library as well
# as SideBarLinks function from src/modules folder
import streamlit as st

from modules.nav import SideBarLinks

# streamlit supports regular and wide layout (how the controls
# are organized/displayed on the screen).
st.set_page_config(layout="wide")

# If a user is at this page, we assume they are not
# authenticated.  So we change the 'authenticated' value
# in the streamlit session_state to false.
st.session_state["authenticated"] = False

# Use the SideBarLinks function from src/modules/nav.py to control
# the links displayed on the left-side panel.
# IMPORTANT: ensure src/.streamlit/config.toml sets
# showSidebarNavigation = false in the [client] section
SideBarLinks(show_home=True)

# ***************************************************
#    The major content of this page
# ***************************************************

logger.info("Loading the Home page of the app")
st.title("HoopSpot")
st.write("#### Pick up. Check in. Run it back.")
st.write("")
st.write("**Choose a persona to get started:**")

if st.button(
    "Act as Marcus Reyes, a Pickup Player",
    type="primary",
    use_container_width=True,
):
    st.session_state["authenticated"] = True
    st.session_state["role"] = "pickup_player"
    st.session_state["first_name"] = "Marcus"
    st.session_state["player_id"] = 1
    logger.info("Logging in as Pickup Player Persona")
    st.switch_page("pages/00_Pickup_Home.py")
