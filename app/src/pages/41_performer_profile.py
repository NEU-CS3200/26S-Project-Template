import logging
logger = logging.getLogger(__name__)
 
import streamlit as st
import requests
from modules.nav import SideBarLinks
 
st.set_page_config(layout='wide')
 
SideBarLinks()
 
st.title('My Performer Profile')
st.write('View and update your performer profile so organizers can discover you.')
 
# Use performer ID from session state
performer_id = st.session_state.get('performer_id', 1)
 
# ----------------------------
# Load existing profile
# ----------------------------
st.subheader('Current Profile')
 
try:
    response = requests.get(f'http://api:4000/performer/performers/{performer_id}')
    if response.status_code == 200:
        profile = response.json()
        st.write(f"**Name:** {profile.get('FName', '')} {profile.get('LName', '')}")
        st.write(f"**Genre:** {profile.get('Genre', '')}")
        st.write(f"**Bio:** {profile.get('Bio', '')}")
        st.write(f"**Availability:** {profile.get('Availability', '')}")
        st.write(f"**Media Links:** {profile.get('MediaLinks', '')}")
        st.write(f"**Views:** {profile.get('Views', 0)}")
        st.write(f"**Ranking:** {profile.get('Ranking', 0)}")
    else:
        st.warning('Could not load profile.')
except Exception as e:
    st.error(f'Error loading profile: {e}')
 
st.divider()
 
# ----------------------------
# Update profile form
# ----------------------------
st.subheader('Update Your Profile')
st.write('Updating your profile also increases your visibility (Views).')
 
with st.form('update_profile_form'):
    genre        = st.text_input('Genre (e.g. Indie Rock, Jazz)')
    bio          = st.text_area('Bio')
    media_links  = st.text_input('Media Links (e.g. SoundCloud, Instagram URLs)')
    availability = st.text_input('Availability (e.g. Weekends, May-August 2026)')
 
    submitted = st.form_submit_button('Save Changes', type='primary')
 
    if submitted:
        payload = {
            'Genre': genre,
            'Bio': bio,
            'MediaLinks': media_links,
            'Availability': availability
        }
        try:
            r = requests.put(
                f'http://api:4000/performer/performers/{performer_id}',
                json=payload
            )
            if r.status_code == 200:
                st.success('Profile updated successfully!')
            else:
                st.error(f'Error updating profile: {r.text}')
        except Exception as e:
            st.error(f'Error: {e}')
 
st.divider()
 
# ----------------------------
# Create new profile
# ----------------------------
st.subheader('Create a New Performer Profile')
 
with st.form('create_profile_form'):
    new_fname        = st.text_input('First Name')
    new_lname        = st.text_input('Last Name')
    new_genre        = st.text_input('Genre')
    new_bio          = st.text_area('Bio')
    new_media        = st.text_input('Media Links')
    new_availability = st.text_input('Availability')
 
    create_submitted = st.form_submit_button('Create Profile', type='primary')
 
    if create_submitted:
        payload = {
            'FName': new_fname,
            'LName': new_lname,
            'Genre': new_genre,
            'Bio': new_bio,
            'MediaLinks': new_media,
            'Availability': new_availability
        }
        try:
            r = requests.post(
                'http://api:4000/performer/performers',
                json=payload
            )
            if r.status_code == 201:
                st.success('Performer profile created successfully!')
            else:
                st.error(f'Error creating profile: {r.text}')
        except Exception as e:
            st.error(f'Error: {e}')