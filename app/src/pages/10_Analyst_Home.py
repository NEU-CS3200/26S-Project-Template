import streamlit as st
from modules.nav import SideBarLinks

SideBarLinks()

st.title("Career Services Analyst Home")
st.write("Welcome to OfferWatch analytics, Lisa.")

col1, col2, col3 = st.columns(3)

with col1:
    if st.button("Analytics Dashboard", use_container_width=True):
        st.switch_page("pages/17_Analytics_Dashboard.py")

with col2:
    if st.button("Trends", use_container_width=True):
        st.switch_page("pages/12_Trends.py")

with col3:
    if st.button("Salary Insights", use_container_width=True):
        st.switch_page("pages/13_Salary_Insights.py")