import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title('Outlier Detection')
st.write('Find users eating way more or less than the average for any nutrient.')

#same 3 filters as /compare route
col1, col2, col3 = st.columns(3)

with col1:
    start_date = st.date_input('Start Date', value=pd.to_datetime('2025-03-29'))
with col2:
    end_date = st.date_input('End Date', value=pd.to_datetime('2025-04-04'))
with col3:
    nutrient = st.selectbox('Nutrient', ['All', 'Calories', 'Protein', 'Sodium',
                            'Total Fat', 'Total Carbohydrate', 'Dietary Fiber', 'Total Sugars'])

#build params for the api call
params = {
    'start': str(start_date),
    'end': str(end_date)
}
if nutrient != 'All': #only send if they picked one
    params['nutrient'] = nutrient

#hits /analytics/outliers — the big stddev query
try:
    response = requests.get('http://api:4000/analytics/outliers', params=params)
    if response.status_code == 200:
        data = response.json()
        if data:
            df = pd.DataFrame(data)
            st.subheader(f'Found {len(df)} outliers') #show count
            st.dataframe(df, use_container_width=True)
        else:
            st.info('No outliers found for this date range.')
    else:
        st.error('Failed to load outlier data.')
except Exception as e:
    st.error(f'Error: {e}')