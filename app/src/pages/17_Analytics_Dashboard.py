import streamlit as st
import requests
import pandas as pd
from modules.nav import SideBarLinks

# Prevent direct access without login
if "authenticated" not in st.session_state or not st.session_state["authenticated"]:
    st.switch_page("Home.py")

SideBarLinks()

API_BASE = "http://api:4000"

st.title("📊 OfferWatch Analytics Dashboard")
st.write("Review high-level placement, hiring funnel, salary, time-to-offer, and trend analytics.")

def fetch_json(endpoint: str):
    response = requests.get(f"{API_BASE}{endpoint}", timeout=10)
    response.raise_for_status()
    return response.json()

try:
    placement = fetch_json("/analytics/placement-rate")
except Exception as e:
    st.error(f"Could not load placement-rate data: {e}")
    placement = None

try:
    funnel = fetch_json("/analytics/conversion-funnel")
except Exception as e:
    st.warning(f"Could not load conversion-funnel data: {e}")
    funnel = None

try:
    salary = fetch_json("/analytics/average-salary")
except Exception as e:
    st.warning(f"Could not load average-salary data: {e}")
    salary = None

try:
    time_to_offer = fetch_json("/analytics/time-to-offer")
except Exception as e:
    st.warning(f"Could not load time-to-offer data: {e}")
    time_to_offer = None

try:
    trends = fetch_json("/analytics/trends")
except Exception as e:
    st.warning(f"Could not load trends data: {e}")
    trends = None

st.subheader("Overview")

col1, col2, col3 = st.columns(3)

with col1:
    if placement and "placement_rate" in placement:
        st.metric("Placement Rate", f"{placement['placement_rate']}%")
    else:
        st.metric("Placement Rate", "N/A")

with col2:
    if salary and "average_salary" in salary and salary["average_salary"] is not None:
        st.metric("Average Salary", f"${salary['average_salary']:,.2f}")
    else:
        st.metric("Average Salary", "N/A")

with col3:
    if time_to_offer:
        if "average_days" in time_to_offer:
            st.metric("Time to Offer", f"{time_to_offer['average_days']} days")
        elif "avg_days_to_offer" in time_to_offer:
            st.metric("Time to Offer", f"{time_to_offer['avg_days_to_offer']} days")
        elif "time_to_offer" in time_to_offer:
            st.metric("Time to Offer", f"{time_to_offer['time_to_offer']} days")
        elif "average_weeks" in time_to_offer:
            st.metric("Time to Offer", f"{time_to_offer['average_weeks']} weeks")
        else:
            st.metric("Time to Offer", "N/A")
    else:
        st.metric("Time to Offer", "N/A")

if placement:
    st.subheader("Placement Snapshot")
    snap_col1, snap_col2 = st.columns(2)

    with snap_col1:
        if "students_placed" in placement:
            st.write("**Students placed:**", placement["students_placed"])
        if "total_students" in placement:
            st.write("**Total students:**", placement["total_students"])

    with snap_col2:
        st.write("This metric tracks the percentage of students who accepted an offer.")

chart_col1, chart_col2 = st.columns(2)

with chart_col1:
    st.subheader("Conversion Funnel")
    if funnel:
        funnel_df = pd.DataFrame({
            "Stage": ["Applications", "Interviews", "Offers"],
            "Count": [
                funnel.get("total_applications", 0),
                funnel.get("total_interviews", 0),
                funnel.get("total_offers", 0)
            ]
        })
        st.bar_chart(funnel_df.set_index("Stage"))

        rate_col1, rate_col2 = st.columns(2)
        with rate_col1:
            st.metric(
                "App → Interview Rate",
                f"{funnel.get('application_to_interview_rate', 0)}%"
            )
        with rate_col2:
            st.metric(
                "Interview → Offer Rate",
                f"{funnel.get('interview_to_offer_rate', 0)}%"
            )

        with st.expander("View funnel data"):
            st.dataframe(funnel_df, use_container_width=True)
    else:
        st.info("Conversion funnel data is not available.")

with chart_col2:
    st.subheader("Trends")
    st.caption("Monthly pipeline volume (applications → interviews → offers)")

    if trends and isinstance(trends, list) and len(trends) > 0:
        trends_df = pd.DataFrame(trends)

        if "month_bucket" in trends_df.columns:
            chart_df = trends_df[["month_bucket", "applications", "interviews", "offers"]].copy()
            chart_df = chart_df.rename(columns={"month_bucket": "Month"})
            chart_df = chart_df.set_index("Month")

            # 🔥 Smart visualization switch
            if len(chart_df) <= 2:
                st.bar_chart(chart_df)
            else:
                st.line_chart(chart_df)

            with st.expander("View trends data"):
                st.dataframe(chart_df, use_container_width=True)

        else:
            st.dataframe(trends_df, use_container_width=True)

    else:
        st.info("Trend data is not available.")

bottom_col1, bottom_col2 = st.columns(2)

with bottom_col1:
    st.subheader("Salary Insights")
    if salary:
        if "average_salary" in salary:
            salary_df = pd.DataFrame({
                "Metric": ["Average Salary"],
                "Value": [salary["average_salary"]]
            })
            st.dataframe(salary_df, use_container_width=True)
        elif "labels" in salary and "values" in salary:
            salary_df = pd.DataFrame({
                "Category": salary["labels"],
                "Value": salary["values"]
            })
            st.bar_chart(salary_df.set_index("Category"))
            with st.expander("View salary data"):
                st.dataframe(salary_df, use_container_width=True)
        else:
            st.json(salary)
    else:
        st.info("Salary data is not available.")

with bottom_col2:
    st.subheader("Time to Offer Insights")
    if time_to_offer:
        if "average_days" in time_to_offer:
            tto_df = pd.DataFrame({
                "Metric": ["Average Days to Offer"],
                "Value": [time_to_offer["average_days"]]
            })
            st.dataframe(tto_df, use_container_width=True)
        elif "average_weeks" in time_to_offer:
            tto_df = pd.DataFrame({
                "Metric": ["Average Weeks to Offer"],
                "Value": [time_to_offer["average_weeks"]]
            })
            st.dataframe(tto_df, use_container_width=True)
        elif "labels" in time_to_offer and "values" in time_to_offer:
            tto_df = pd.DataFrame({
                "Category": time_to_offer["labels"],
                "Value": time_to_offer["values"]
            })
            st.bar_chart(tto_df.set_index("Category"))
            with st.expander("View time-to-offer data"):
                st.dataframe(tto_df, use_container_width=True)
        else:
            st.json(time_to_offer)
    else:
        st.info("Time-to-offer data is not available.")

with st.expander("Debug API responses"):
    if placement is not None:
        st.write("**Placement Rate Response**")
        st.json(placement)

    if funnel is not None:
        st.write("**Conversion Funnel Response**")
        st.json(funnel)

    if salary is not None:
        st.write("**Average Salary Response**")
        st.json(salary)

    if time_to_offer is not None:
        st.write("**Time to Offer Response**")
        st.json(time_to_offer)

    if trends is not None:
        st.write("**Trends Response**")
        st.json(trends)