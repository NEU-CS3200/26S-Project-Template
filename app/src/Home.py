##################################################
# This is the main/entry-point file for the
# sample application for your project
##################################################

# Set up basic logging infrastructure
import logging
logging.basicConfig(format='%(filename)s:%(lineno)s:%(levelname)s -- %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

# import the main streamlit library as well
# as SideBarLinks function from src/modules folder
import streamlit as st
from modules.nav import SideBarLinks
from Style import apply_bold_button_styles

# streamlit supports regular and wide layout (how the controls
# are organized/displayed on the screen).
st.set_page_config(layout='wide')

# If a user is at this page, we assume they are not
# authenticated.  So we change the 'authenticated' value
# in the streamlit session_state to false.
st.session_state['authenticated'] = False

# Use the SideBarLinks function from src/modules/nav.py to control
# the links displayed on the left-side panel.
# IMPORTANT: ensure src/.streamlit/config.toml sets
# showSidebarNavigation = false in the [client] section
SideBarLinks(show_home=True)

# ***************************************************
#    The major content of this page
# ***************************************************

logger.info("Loading the Home page of the app")
st.title('Husky League')
st.write('#### Hi! What would you like to log in as?')

# For each of the user personas for which we are implementing
# functionality, we put a button on the screen that the user
# can click to MIMIC logging in as that mock user.

apply_bold_button_styles()

if st.button("Act as Maya, a Soccer and Volleyball Player",
             type='primary',
             use_container_width=True):
    
    # when user clicks the button, they are now considered authenticated
    st.session_state['authenticated'] = True

    # we set the role of the current user
    st.session_state['role'] = 'player_persona'

    # we add the first name of the user (so it can be displayed on
    # subsequent pages).
    st.session_state['first_name'] = 'Maya'

    # finally, we ask streamlit to switch to another page, in this case, the
    # landing page for this particular user type
    logger.info("Logging in as Player Persona")
    st.switch_page('pages/player_browse_profile.py')

if st.button("Act as Allan, the Team Captain",
             type="primary",
             use_container_width=True):
    
    st.session_state['authenticated'] = True

    st.session_state['role'] = 'coach_persona'

    st.session_state['first_name'] = 'Allan'

    logger.info("Logging in as Coach Persona")

    st.switch_page('pages/coach_form_team.py')

if st.button("Act as Derrick, the League Administrator",
             type="primary",
             use_container_width=True):
    
    st.session_state['authenticated'] = True

    st.session_state['role'] = 'league_administrator_persona'

    st.session_state['first_name'] = 'Derrick'

    logger.info("Logging in as League Administrator Persona")

    st.switch_page('pages/league_admin_venue_schedule.py')

if st.button("Act as Dr. Priya, the Sports Analyst",
             type="primary",
             use_container_width=True):
    
    st.session_state['authenticated'] = True

    st.session_state['role'] = 'sports_analyst_persona'

    st.session_state['first_name'] = 'Dr. Priya'

    logger.info("Logging in as Sports Analyst Persona")

    st.switch_page('pages/analyst_intramural_report.py')