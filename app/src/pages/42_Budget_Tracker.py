import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://api:4000"

st.title("💰 Trip Budget Tracker")
st.write("Track estimated vs. confirmed costs for each trip.")

# ── Load trips for dropdown ────────────────────────────────────────────────────
try:
    r = requests.get(f"{API_BASE}/trips")
    if r.status_code == 200:
        trips = r.json()
        if not trips:
            st.info("No trips found. Create a trip first.")
            st.stop()
        trip_options = {
            f"{t['trip_id']} – {t.get('trip_name', '')} ({t.get('destination', '')})": t['trip_id']
            for t in trips
        }
    else:
        st.error("Could not load trips.")
        st.stop()
except Exception as e:
    st.error(f"Error connecting to API: {e}")
    st.stop()

selected_label = st.selectbox("Select a trip:", list(trip_options.keys()))
trip_id = trip_options[selected_label]

# ── View budget summary ────────────────────────────────────────────────────────
st.subheader("Budget Summary")
try:
    r2 = requests.get(f"{API_BASE}/trips/{trip_id}/budget")
    if r2.status_code == 200:
        result = r2.json()

        # The API returns a multi_query response — get the budget_summary block
        budget = None
        if isinstance(result, list):
            for block in result:
                if isinstance(block, dict) and 'budget_summary' in block.get('name', ''):
                    budget = block.get('data', [{}])[0]
                    break
            if not budget and result:
                budget = result[0] if isinstance(result[0], dict) else {}
        elif isinstance(result, dict):
            budget = result

        if budget:
            col1, col2, col3 = st.columns(3)
            col1.metric("📊 Estimated Total",  f"${float(budget.get('estimated_total', 0)):,.2f}")
            col2.metric("✅ Confirmed Total",   f"${float(budget.get('confirmed_total', 0)):,.2f}")
            col3.metric("💸 Actual Spent",      f"${float(budget.get('actual_spent', 0)):,.2f}")
        else:
            st.info("No budget data found for this trip yet.")

        # Optionally load breakdown
        if st.checkbox("Show full booking breakdown"):
            r3 = requests.get(f"{API_BASE}/trips/{trip_id}/budget", params={"include_breakdown": True})
            if r3.status_code == 200:
                breakdown_result = r3.json()
                breakdown = None
                if isinstance(breakdown_result, list) and len(breakdown_result) > 1:
                    breakdown = breakdown_result[1].get('data', [])
                if breakdown:
                    st.dataframe(breakdown, use_container_width=True)
                else:
                    st.info("No breakdown available.")
    else:
        st.warning(f"Could not load budget. ({r2.status_code})")
except Exception as e:
    st.error(f"Error: {e}")

st.divider()

# ── Update actual spent ────────────────────────────────────────────────────────
st.subheader("Update Actual Amount Spent")
st.write("Update the recorded amount your team has actually spent on this trip.")

with st.form("update_budget_form"):
    actual_spent = st.number_input("Actual Amount Spent ($)", min_value=0.0, step=50.0)
    upd_submitted = st.form_submit_button("Save", type='primary')

if upd_submitted:
    payload = {"actual_spent": actual_spent}
    try:
        r4 = requests.put(f"{API_BASE}/trips/{trip_id}/budget", json=payload)
        if r4.status_code == 200:
            st.success("Budget updated successfully!")
            st.rerun()
        else:
            st.error(f"Update failed. ({r4.status_code}) — {r4.text}")
    except Exception as e:
        st.error(f"Error: {e}")
