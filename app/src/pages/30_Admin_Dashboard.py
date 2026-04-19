import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000"

st.markdown("""
    <style>
        .stApp {
            background-color: #FAF9F6;
        }
        [data-testid="stMetric"] {
            background-color: #2c2c2c;
            padding: 15px 20px;
            border-radius: 8px;
            color: white;
        }
        [data-testid="stMetricLabel"] {
            color: #aaaaaa;
        }
        [data-testid="stMetricValue"] {
            color: white;
            font-size: 1.5rem;
        }
        [data-testid="stHeader"] {
            background-color: #2c2c2c;
        }
    </style>
""", unsafe_allow_html=True)

response = requests.get(f"{API_BASE}/admin/health")
health = response.json()

st.title("Platform Health Dashboard")
st.subheader("System Overview")

col1, col2, col3, col4 = st.columns(4)

with col1:
    st.metric(label="Active Users", 
              value=health["active_users"])

with col2:
    st.metric(label="API Response (avg)", 
              value=f"{health['api_response']}ms")

with col3:
    st.metric(label="Errors (last 24h)", 
              value=health["errors_24h"])

with col4:
    st.metric(label="Uptime", 
              value=f"{health['uptime']}%" 
              if health["uptime"] else "N/A")

st.subheader("System Status")

for component in health["components"]:
    col1, col2 = st.columns([4, 1])
    
    with col1:
        st.markdown(f"""
            <div style="
                background-color: #2c2c2c;
                padding: 12px 20px;
                border-radius: 6px;
                margin-bottom: 8px;
                color: white;
                    ">
                {component["Component_Name"]}
            </div>
        """, unsafe_allow_html=True)
    
    with col2:
        color = "green" 
        if component["Current_Status"] != "Operational":
            color = "red"

        st.markdown(f"""
            <div style="
                background-color: #2c2c2c;
                padding: 12px 20px;
                border-radius: 6px;
                margin-bottom: 8px;
                color: {color};
                text-align: right;
            ">
                {component["Current_Status"]}
            </div>
        """, unsafe_allow_html=True)

st.subheader("Recent Errors")

error_response = requests.get(f"{API_BASE}/admin/errors")
errors = error_response.json()
recent_errors = errors[:5]

col1, col2, col3 = st.columns([2, 2, 1])
with col1:
    st.markdown("**Component**")
with col2:
    st.markdown("**Error Type**")
with col3:
    st.markdown("**Status**")

rows_html = ""
for error in recent_errors:
    icon = "🟢"

    if error["Status"] == "Unresolved":
        icon = "🔴"
        
    rows_html += f"""<div style="display: flex; justify-content: space-between; padding: 10px 20px; border-bottom: 1px solid #444; color: white;">
<span style="flex: 1;">{error["Component_Name"]}</span>
<span style="flex: 1;">{error["Error_Type"]}</span>
<span style="flex: 1; text-align: right;">{icon} {error["Status"]}</span>
</div>"""

st.markdown(f'<div style="background-color: #2c2c2c; border-radius: 8px; overflow: hidden;">{rows_html}</div>', unsafe_allow_html=True)

st.markdown("<br>", unsafe_allow_html=True)

if st.button("View All Errors ->"):
    st.switch_page("pages/32_Error_Logs.py")