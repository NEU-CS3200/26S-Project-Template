import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

# 1. Page Header (This replaces the general dashboard title)
st.title("📝 Venue Booking Management")

# 2. Setup
VENUE_ID = 1 
BASE_URL = "http://api:4000/venue"

# 3. Fetch Data
try:
    response = requests.get(f"{BASE_URL}/venues/{VENUE_ID}/requests")
    if response.status_code == 200:
        data = response.json()
        if data:
            # Table Headers
            cols = st.columns([3, 2, 2, 4])
            cols[0].write("**Organizer**")
            cols[1].write("**Event**")
            cols[2].write("**Status**")
            cols[3].write("**Actions**")
            st.divider()

            # 4. Loop through requests for individual buttons
            for req in data:
                r_id = req['RequestID']
                r_name = req['RequestName']
                
                c1, c2, c3, c4 = st.columns([3, 2, 2, 4])
                c1.write(f"{req['OrganizerFirstName']} {req['OrganizerLastName']}")
                c2.write(r_name)
                c3.info(req['Status'])

                # Individual Accept/Reject buttons in the last column
                btn_acc, btn_rej = c4.columns(2)
                if btn_acc.button("✅ Accept", key=f"acc_{r_id}"):
                    requests.put(f"{BASE_URL}/venues/{VENUE_ID}/requests/{r_id}", json={"status": "Approved"})
                    st.rerun()
                if btn_rej.button("❌ Reject", key=f"rej_{r_id}"):
                    requests.put(f"{BASE_URL}/venues/{VENUE_ID}/requests/{r_id}", json={"status": "Rejected"})
                    st.rerun()
        else:
            st.info("No requests found.")
except Exception as e:
    st.error(f"API Connection Error: {e}")

    