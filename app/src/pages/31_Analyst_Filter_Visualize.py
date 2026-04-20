import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.title('Filter & Visualize Nutrition Data')
st.write('Filter by dining hall, student type, and date range to explore nutrition trends.')

#4 columns for the filters, matches wireframe 5
col1, col2, col3, col4 = st.columns(4)

#selectbox = dropdown, date_input = calendar
with col1:
    hall = st.selectbox('Dining Hall', ['All', 'Stetson East', 'Stetson West',
                        'International Village', 'Levine Marketplace', 'Outtakes Express'])
with col2:
    student_type = st.selectbox('Student Type', ['All', 'undergraduate', 'graduate', 'staff'])
with col3:
    start_date = st.date_input('Start Date', value=pd.to_datetime('2025-03-29'))
with col4:
    end_date = st.date_input('End Date', value=pd.to_datetime('2025-04-04'))

#params dict, requests lib converts to ?start=...&end=... etc
params = {
    'start': str(start_date),
    'end': str(end_date)
}
if hall != 'All': #dont send if they picked All
    params['hall'] = hall
if student_type != 'All':
    params['student_type'] = student_type

#calls /analytics/filter route
try:
    response = requests.get('http://api:4000/analytics/filter', params=params)
    if response.status_code == 200:
        data = response.json()
        if data:
            df = pd.DataFrame(data) #json to dataframe
            df['avg_intake'] = pd.to_numeric(df['avg_intake']) #comes back as string for some reason

            #pick nutrient for the chart
            nutrients = df['nutrient'].unique().tolist()
            selected_nutrient = st.selectbox('Nutrient to chart', nutrients)

            chart_df = df[df['nutrient'] == selected_nutrient] #filter to just that nutrient

            st.subheader(f'Avg {selected_nutrient} Intake by Dining Hall')
            st.bar_chart(chart_df, x='dining_hall', y='avg_intake', color='college_year') #color = college year groups

            #raw data
            st.subheader('Filtered Data')
            st.dataframe(df, use_container_width=True)
        else:
            st.info('No data found for these filters.')
    else:
        st.error('Failed to load data from API.')
except Exception as e:
    st.error(f'Error connecting to API: {e}')