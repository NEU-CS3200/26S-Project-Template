import logging
logger = logging.getLogger(__name__)
 
import streamlit as st
import requests
from modules.nav import SideBarLinks
 
st.set_page_config(layout='wide')
 
SideBarLinks()
 
st.title('My Performances & Matched Events')
 
performer_id = st.session_state.get('performer_id', 1)
 
# ----------------------------
# Upcoming confirmed performances
# ----------------------------
st.subheader('📍 Upcoming Confirmed Performances')
st.write('All events where you are confirmed to perform.')
 
try:
    response = requests.get(f'http://api:4000/performer/performers/{performer_id}/performances')
    if response.status_code == 200:
        performances = response.json()
 
        if not performances:
            st.info('No upcoming performances yet.')
        else:
            for perf in performances:
                with st.expander(f"🎵 {perf.get('Name', 'Event')} — {perf.get('Date', '')}"):
                    st.write(f"**Event:** {perf.get('Name', '')}")
                    st.write(f"**Date:** {perf.get('Date', '')}")
                    st.write(f"**Location:** {perf.get('Location', '')}")
                    st.write(f"**Venue:** {perf.get('VenueName', '')}")
                    st.write(f"**Status:** {perf.get('Status', '')}")
    else:
        st.error('Could not load performances.')
except Exception as e:
    st.error(f'Error loading performances: {e}')
 
st.divider()
 
# ----------------------------
# Matched events
# ----------------------------
st.subheader('🎯 Events Matched to Your Style')
st.write('Upcoming events that match your genre and availability.')
 
try:
    response = requests.get(f'http://api:4000/performer/performers/{performer_id}/matches')
    if response.status_code == 200:
        matches = response.json()
 
        if not matches:
            st.info('No matched events found.')
        else:
            for match in matches:
                with st.expander(
                    f"⭐ {match.get('Name', 'Event')} — Match Score: {match.get('MatchScore', 0)}"
                ):
                    st.write(f"**Event:** {match.get('Name', '')}")
                    st.write(f"**Date:** {match.get('Date', '')}")
                    st.write(f"**Location:** {match.get('Location', '')}")
                    st.write(f"**Category:** {match.get('Category', '')}")
                    st.write(f"**Match Score:** {match.get('MatchScore', 0)}")
                    st.write(f"**Relevance:** {match.get('Relevance', 0)}")
    else:
        st.error('Could not load matched events.')
except Exception as e:
    st.error(f'Error loading matches: {e}')