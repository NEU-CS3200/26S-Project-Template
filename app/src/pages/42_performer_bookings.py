import logging
logger = logging.getLogger(__name__)
 
import streamlit as st
import requests
from modules.nav import SideBarLinks
 
st.set_page_config(layout='wide')
 
SideBarLinks()
 
st.title('My Booking Requests')
st.write('Review and respond to incoming booking requests from event organizers.')
 
performer_id = st.session_state.get('performer_id', 1)
 
# ----------------------------
# Load booking requests
# ----------------------------
try:
    response = requests.get(f'http://api:4000/performer/performers/{performer_id}/bookings')
    if response.status_code == 200:
        bookings = response.json()
 
        if not bookings:
            st.info('No booking requests yet.')
        else:
            for booking in bookings:
                with st.expander(
                    f"📅 Booking from {booking.get('OrganizerFirstName', '')} "
                    f"{booking.get('OrganizerLastName', '')} — Status: {booking.get('Status', '')}"
                ):
                    st.write(f"**Organizer:** {booking.get('OrganizerFirstName', '')} {booking.get('OrganizerLastName', '')}")
                    st.write(f"**Organizer Email:** {booking.get('OrganizerEmail', '')}")
                    st.write(f"**Compensation:** ${booking.get('Compensation', 0)}")
                    st.write(f"**Request Date:** {booking.get('RequestDate', '')}")
                    st.write(f"**Status:** {booking.get('Status', '')}")
 
                    booking_id = booking.get('BookingID')
 
                    col1, col2 = st.columns(2)
 
                    with col1:
                        if st.button(f'✅ Accept', key=f'accept_{booking_id}'):
                            try:
                                r = requests.put(
                                    f'http://api:4000/performer/performers/{performer_id}/bookings/{booking_id}',
                                    json={'Status': 'Confirmed'}
                                )
                                if r.status_code == 200:
                                    st.success('Booking accepted!')
                                else:
                                    st.error(f'Error: {r.text}')
                            except Exception as e:
                                st.error(f'Error: {e}')
 
                    with col2:
                        if st.button(f'❌ Decline', key=f'decline_{booking_id}'):
                            try:
                                r = requests.put(
                                    f'http://api:4000/performer/performers/{performer_id}/bookings/{booking_id}',
                                    json={'Status': 'Declined'}
                                )
                                if r.status_code == 200:
                                    st.success('Booking declined.')
                                else:
                                    st.error(f'Error: {r.text}')
                            except Exception as e:
                                st.error(f'Error: {e}')
    else:
        st.error('Could not load booking requests.')
except Exception as e:
    st.error(f'Error loading bookings: {e}')