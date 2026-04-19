import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

if "authenticated" not in st.session_state or not st.session_state["authenticated"]:
    st.switch_page("Home.py")

SideBarLinks()

API_BASE = "http://api:4000"

st.title("💰 Salary Insights")
st.write("Review salary analytics from submitted offers.")

def fetch_json(endpoint: str):
    response = requests.get(f"{API_BASE}{endpoint}", timeout=10)
    response.raise_for_status()
    return response.json()

try:
    salary = fetch_json("/analytics/average-salary")
except Exception as e:
    st.error(f"Could not load salary data: {e}")
    salary = None

if salary:
    st.subheader("Overview")

    if "average_salary" in salary and salary["average_salary"] is not None:
        st.metric("Average Salary", f"${salary['average_salary']:,.2f}")

        salary_df = pd.DataFrame({
            "Metric": ["Average Salary"],
            "Value": [salary["average_salary"]]
        })

        st.subheader("Salary Data")
        st.dataframe(salary_df, use_container_width=True, hide_index=True)

    elif "labels" in salary and "values" in salary:
        salary_df = pd.DataFrame({
            "Category": salary["labels"],
            "Value": salary["values"]
        })

        st.bar_chart(salary_df.set_index("Category"))

        st.subheader("Salary Data")
        st.dataframe(salary_df, use_container_width=True, hide_index=True)

    else:
        st.subheader("Raw Salary Response")
        st.json(salary)
else:
    st.info("Salary data is not available yet.")