import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://api:4000"

st.title("🏨 Browse & Compare Listings")
st.write("Compare lodging, transport, and activity options for your trips.")

tab1, tab2 = st.tabs(["Browse Listings", "Add a Listing"])

# ── TAB 1: Browse ──────────────────────────────────────────────────────────────
with tab1:
    st.subheader("Available Listings")
    try:
        r = requests.get(f"{API_BASE}/listings")
        if r.status_code == 200:
            listings = r.json()
            if listings:
                # Filters
                col1, col2 = st.columns(2)
                with col1:
                    categories = list(set(l.get('service_category', 'Unknown') for l in listings))
                    selected_cat = st.selectbox("Filter by Category:", ["All"] + sorted(categories))
                with col2:
                    max_price = st.number_input("Max Price ($):", min_value=0, value=10000, step=100)

                filtered = listings
                if selected_cat != "All":
                    filtered = [l for l in filtered if l.get('service_category') == selected_cat]
                filtered = [l for l in filtered if float(l.get('price', 0)) <= max_price]

                st.write(f"Showing **{len(filtered)}** listings")
                st.dataframe(filtered, use_container_width=True)
            else:
                st.info("No listings found.")
        else:
            st.error(f"Could not load listings. ({r.status_code})")
    except Exception as e:
        st.error(f"Error connecting to API: {e}")

# ── TAB 2: Add listing ─────────────────────────────────────────────────────────
with tab2:
    st.subheader("Add a New Listing")
    with st.form("add_listing_form"):
        service_category = st.selectbox("Category", ["Lodging", "Transportation", "Activity", "Food", "Other"])
        description      = st.text_area("Description")
        price            = st.number_input("Price ($)", min_value=0.0, step=10.0)
        submitted        = st.form_submit_button("Add Listing", type='primary')

    if submitted:
        if not description:
            st.warning("Please enter a description.")
        else:
            payload = {
                "service_category": service_category,
                "description":      description,
                "price":            price,
            }
            try:
                r2 = requests.post(f"{API_BASE}/listings", json=payload)
                if r2.status_code in (200, 201):
                    st.success("Listing added successfully!")
                else:
                    st.error(f"Failed to add listing. ({r2.status_code}) — {r2.text}")
            except Exception as e:
                st.error(f"Error: {e}")
