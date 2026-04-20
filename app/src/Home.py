import logging
logging.basicConfig(format='%(filename)s:%(lineno)s:%(levelname)s -- %(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

import streamlit as st
from modules.api_client import api_post, show_api_error

st.set_page_config(layout='wide')

st.session_state.setdefault('authenticated', False)
st.session_state.setdefault('role', None)
st.session_state.setdefault('first_name', None)
st.session_state.setdefault('user_id', None)

logger.info("Loading the Home page of the app")


def route_by_role(role):
    if role in ('VENUE_OWNER', 'venue_owner'):
        st.switch_page('pages/10_Marcus_Home.py')
    elif role in ('DATA_ANALYST', 'data_analyst'):
        st.switch_page('pages/20_Joey_Home.py')
    elif role in ('ADMIN', 'admin'):
        st.switch_page('pages/30_Josh_Home.py')
    else:
        st.switch_page('pages/40_Date_Seeker_Home.py')


if st.session_state['authenticated']:
    route_by_role(st.session_state.get('role'))

st.title('PinDate')
st.write('### Find, Rate, and Share Your Next Date Spot')
st.write('##### Log in with your username and password:')

with st.form('login_form'):
    username = st.text_input('Username', placeholder='mayac')
    pwd_hash = st.text_input('Password', type='password', placeholder='password')
    submitted = st.form_submit_button('Log In', type='primary', use_container_width=True)

if submitted:
    if not username.strip() or not pwd_hash.strip():
        st.warning('Enter both username and password.')
    else:
        user, err = api_post('/users/login', {'username': username.strip(), 'pwdHash': pwd_hash.strip()})
        if err:
            if '401' in err:
                st.error('Invalid username or password.')
            else:
                show_api_error(err)
        elif not user:
            st.error('Invalid username or password.')
        else:
            st.session_state['authenticated'] = True
            st.session_state['role'] = user.get('role')
            st.session_state['first_name'] = user.get('firstName')
            st.session_state['user_id'] = user.get('accountId')
            logger.info("Logging in as %s (%s)", user.get('username'), user.get('role'))
            route_by_role(user.get('role'))

st.caption('Use the seeded hash values from the database if you are testing locally.')
