import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title('Export Configuration')
st.write('Create, update, or delete your data export configs.')

#hardcoded to immanuel for now, need to pull from session state later
user_id = 3

#show existing configs
st.subheader('Your Export Configs')
try:
    response = requests.get(f'http://api:4000/analytics/exports/user/{user_id}')
    if response.status_code == 200:
        configs = response.json()
        if configs:
            df = pd.DataFrame(configs)
            st.dataframe(df, use_container_width=True) #table of all configs
        else:
            st.info('No export configs found.')
    else:
        st.error('Failed to load configs.')
except Exception as e:
    st.error(f'Error: {e}')

st.divider()

#generate a report (hits POST /analytics/reports)
st.subheader('Generate a Report')
with st.form('report_form'): #st.form groups inputs together, only sends on submit
    title = st.text_input('Report Title')
    report_type = st.selectbox('Report Type', ['nutrition_summary', 'trend_analysis', 'engagement'])
    col1, col2 = st.columns(2)
    with col1:
        date_from = st.date_input('Date From', value=pd.to_datetime('2025-03-29'))
    with col2:
        date_to = st.date_input('Date To', value=pd.to_datetime('2025-04-04'))
    submitted = st.form_submit_button('Generate Report')

    if submitted:
        if not title:
            st.error('Title is required')
        else:
            try:
                payload = {
                    'created_by': user_id,
                    'title': title,
                    'report_type': report_type,
                    'filter_params': { #gets serialized to json by our route
                        'date_from': str(date_from),
                        'date_to': str(date_to)
                    }
                }
                resp = requests.post('http://api:4000/analytics/reports', json=payload)
                if resp.status_code == 201: #201 = created
                    st.success(f"Report queued! ID: {resp.json()['report_id']}")
                else:
                    st.error(f"Failed: {resp.json().get('error', 'unknown')}")
            except Exception as e:
                st.error(f'Error: {e}')

st.divider()

# update config (hits PUT /analytics/exports/<id>)
st.subheader('Update Export Config')
config_id_update = st.number_input('Config ID to update', min_value=1, step=1, key='update_id')
new_name = st.text_input('New Name (leave blank to skip)')
new_format = st.selectbox('New Format', ['', 'csv', 'xlsx', 'json', 'pdf'], key='update_format')

if st.button('Update Config'):
    update_data = {}
    if new_name: #only include fields that were actually filled in
        update_data['name'] = new_name
    if new_format:
        update_data['format'] = new_format
    if not update_data:
        st.error('Nothing to update')
    else:
        try:
            resp = requests.put(f'http://api:4000/analytics/exports/{int(config_id_update)}', json=update_data)
            if resp.status_code == 200:
                st.success(resp.json()['message'])
            else:
                st.error(f"Failed: {resp.json().get('error', 'unknown')}")
        except Exception as e:
            st.error(f'Error: {e}')

st.divider()

#delete config (hits DELETE /analytics/exports/<id>)
st.subheader('Delete Export Config')
config_id_delete = st.number_input('Config ID to delete', min_value=1, step=1, key='delete_id')
if st.button('Delete Config', type='primary'):
    try:
        resp = requests.delete(f'http://api:4000/analytics/exports/{int(config_id_delete)}')
        if resp.status_code == 200:
            st.success(resp.json()['message'])
        else:
            st.error(f"Failed: {resp.json().get('error', 'unknown')}")
    except Exception as e:
        st.error(f'Error: {e}')