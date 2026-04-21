import logging
logging.basicConfig(format='%(filename)s:%(lineno)s:%(levelname)s -- %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

import requests
import streamlit as st
from modules.nav import SideBarLinks

API_BASE = 'http://web-api:4000'

st.set_page_config(layout='wide')
st.session_state['authenticated'] = False
SideBarLinks(show_home=True)

logger.info("Loading the Home page of the app")
st.title('communevent')
st.write('#### Hi! As which user would you like to log in?')


def fetch_users(path):
    try:
        resp = requests.get(f'{API_BASE}{path}', timeout=3)
        return resp.json() if resp.status_code == 200 else []
    except Exception:
        return []


col1, col2 = st.columns(2)

# ── Attendee ──────────────────────────────────────────────────────────────────
with col1:
    st.subheader('Attendee')
    attendees = fetch_users('/attendee/attendees')
    attendee_map = {f"{a['FName']} {a['LName']}": a for a in attendees}
    selected = st.selectbox('Select an attendee', list(attendee_map.keys()), key='sel_attendee')
    if st.button('Log in as Attendee', type='primary', use_container_width=True):
        if not selected:
            st.error('Please select an attendee first.')
            st.stop()
        user = attendee_map[selected]
        st.session_state['authenticated'] = True
        st.session_state['role'] = 'attendee'
        st.session_state['first_name'] = user['FName']
        st.session_state['user_id'] = user['AttendeeID']
        logger.info(f"Logging in as attendee id={user['AttendeeID']}")
        st.switch_page('pages/attendee.py')

# ── Venue Owner ───────────────────────────────────────────────────────────────
with col2:
    st.subheader('Venue Owner')
    owners = fetch_users('/owner/owners')
    owner_map = {f"{o['FName']} {o['LName']}": o for o in owners}
    selected = st.selectbox('Select a venue owner', list(owner_map.keys()), key='sel_owner')
    if st.button('Log in as Venue Owner', type='primary', use_container_width=True):
        if not selected:
            st.error('Please select a venue owner first.')
            st.stop()
        user = owner_map[selected]
        st.session_state['authenticated'] = True
        st.session_state['role'] = 'venue_owner'
        st.session_state['first_name'] = user['FName']
        st.session_state['user_id'] = user['OwnerID']
        logger.info(f"Logging in as owner id={user['OwnerID']}")
        st.switch_page('pages/venue_owner.py')

col3, col4 = st.columns(2)

# ── Event Organizer ───────────────────────────────────────────────────────────
with col3:
    st.subheader('Event Organizer')
    organizers = fetch_users('/organizer/organizers')
    organizer_map = {f"{o['FName']} {o['LName']}": o for o in organizers}
    selected = st.selectbox('Select an organizer', list(organizer_map.keys()), key='sel_organizer')
    if st.button('Log in as Organizer', type='primary', use_container_width=True):
        if not selected:
            st.error('Please select an organizer first.')
            st.stop()
        user = organizer_map[selected]
        st.session_state['authenticated'] = True
        st.session_state['role'] = 'organizer'
        st.session_state['first_name'] = user['FName']
        st.session_state['user_id'] = user['OrganizerID']
        logger.info(f"Logging in as organizer id={user['OrganizerID']}")
        st.switch_page('pages/organizer.py')

# ── Performer ─────────────────────────────────────────────────────────────────
with col4:
    st.subheader('Performer')
    performers = fetch_users('/performer/performers')
    performer_map = {f"{p['FName']} {p['LName']}": p for p in performers}
    selected = st.selectbox('Select a performer', list(performer_map.keys()), key='sel_performer')
    if st.button('Log in as Performer', type='primary', use_container_width=True):
        if not selected:
            st.error('Please select a performer first.')
            st.stop()
        user = performer_map[selected]
        st.session_state['authenticated'] = True
        st.session_state['role'] = 'performer'
        st.session_state['first_name'] = user['FName']
        st.session_state['user_id'] = user['PerformerID']
        logger.info(f"Logging in as performer id={user['PerformerID']}")
        st.switch_page('pages/40_performer_home.py')
