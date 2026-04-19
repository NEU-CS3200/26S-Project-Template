import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://web-api:4000"

# same styling as my other pages
st.markdown("""
    <style>
        .stApp {
            background-color: #FAF9F6;
        }
        [data-testid="stHeader"] {
            background-color: #2c2c2c;
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
            font-size: 1.3rem;
        }
    </style>
""", unsafe_allow_html=True)

student_id = st.session_state.get("student_id", 1)

st.title("Compare Offers")
st.write("When decision time comes, see all your offers side by side so you can pick with confidence.")


# pull every offer tied to this student
response = requests.get(f"{API_BASE}/alex/students/{student_id}/offers")
offers = response.json()


if not offers:
    st.info("No offers yet. Keep grinding — they'll come.")
else:
    st.subheader(f"You have {len(offers)} offer(s)")

    # build one card per offer, laid out side by side in columns
    cols = st.columns(len(offers))

    for idx, offer in enumerate(offers):
        with cols[idx]:
            # header — company + role
            st.markdown(f"### {offer.get('employer_name', 'Unknown')}")
            st.markdown(f"**{offer.get('position_title', '')}**")
            st.markdown("---")

            # the big numbers first
            salary = offer.get("salary")
            if salary:
                st.metric(label="Salary", value=f"${float(salary):,.0f}")

            # grab just the date portion from the API's date strings
            def short_date(date_str):
                if not date_str:
                    return "—"
                parts = date_str.split(" ")
                return f"{parts[1]} {parts[2]} {parts[3]}" if len(parts) >= 4 else date_str

            st.markdown(f"**Location:** {offer.get('location') or '—'}")
            st.markdown(f"**Start Date:** {short_date(offer.get('start_date'))}")
            st.markdown(f"**Deadline:** {short_date(offer.get('deadline'))}")

            if offer.get("benefits"):
                st.markdown(f"**Benefits:** {offer.get('benefits')}")

            # show current status - accepted, declined, or still deciding
            accepted = offer.get("offer_accepted")
            if accepted is True:
                st.success("✅ Accepted")
            elif accepted is False:
                st.error("❌ Declined")
            else:
                st.info("⏳ Pending decision")




# accept or decline an offer once they've made up their mind
st.subheader("Make a Decision")
st.write("Accept or decline an offer by entering its Offer ID below.")

col1, col2 = st.columns([2, 1])

with col1:
    decision_offer_id = st.number_input("Offer ID", min_value=1, step=1, key="decision_offer_id")

with col2:
    decision = st.selectbox("Decision", options=["Accept", "Decline"], key="decision")

if st.button("Submit Decision", type="primary"):
    payload = {"offer_accepted": True if decision == "Accept" else False}
    result = requests.put(
        f"{API_BASE}/alex/offers/{decision_offer_id}",
        json=payload
    )
    if result.status_code == 200:
        if decision == "Accept":
            st.success("Offer accepted! Congrats.")
        else:
            st.success("Offer declined.")
        st.rerun()
    else:
        st.error("Offer not found.")