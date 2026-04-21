import logging
logger = logging.getLogger(__name__)

import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

API_BASE = "http://api:4000"

st.title("📋 My Trips")
st.write("View your trips and manage itinerary items.")

tab1, tab2, tab3 = st.tabs(["View Trips & Itinerary", "Create New Trip", "Update Itinerary"])

# ── TAB 1: View trips + itinerary ─────────────────────────────────────────────
with tab1:
    st.subheader("All Trips")
    try:
        r = requests.get(f"{API_BASE}/trips")
        if r.status_code == 200:
            trips = r.json()
            if trips:
                trip_options = {
                    f"{t['trip_id']} – {t.get('trip_name', '')} ({t.get('destination', '')})": t['trip_id']
                    for t in trips
                }
                selected_label = st.selectbox("Select a trip to view its itinerary:", list(trip_options.keys()))
                trip_id = trip_options[selected_label]

                display_cols = ['trip_id', 'trip_name', 'destination', 'city', 'country',
                                'start_date', 'end_date', 'group_size', 'trip_status', 'total_spent']
                filtered_trips = [{k: t.get(k) for k in display_cols} for t in trips]
                st.dataframe(filtered_trips, use_container_width=True)

                st.subheader(f"Itinerary for Trip {trip_id}")
                r2 = requests.get(f"{API_BASE}/trips/{trip_id}/itinerary")
                if r2.status_code == 200:
                    itinerary = r2.json()
                    if itinerary:
                        display_itin = ['booking_id', 'booking_date', 'booking_status',
                                        'service_category', 'description', 'price',
                                        'vendor_name', 'promotion_title', 'discount_value']
                        filtered_itin = [{k: item.get(k) for k in display_itin} for item in itinerary]
                        st.dataframe(filtered_itin, use_container_width=True)
                    else:
                        st.info("No itinerary items found for this trip yet.")
                else:
                    st.warning(f"Could not load itinerary. ({r2.status_code})")
            else:
                st.info("No trips found.")
        else:
            st.error(f"Could not load trips. ({r.status_code})")
    except Exception as e:
        st.error(f"Error connecting to API: {e}")

# ── TAB 2: Create new trip ─────────────────────────────────────────────────────
with tab2:
    st.subheader("Create a New Trip")
    with st.form("create_trip_form"):
        trip_name   = st.text_input("Trip Name")
        destination = st.text_input("Destination")
        city        = st.text_input("City")
        country     = st.text_input("Country")
        region      = st.text_input("Region")
        trip_type   = st.selectbox("Trip Type", ["Leisure", "Business", "Adventure", "Cultural", "Other"])
        start_date  = st.date_input("Start Date")
        end_date    = st.date_input("End Date")
        group_size  = st.number_input("Group Size", min_value=1, step=1)
        trip_status = st.selectbox("Status", ["Planning", "Confirmed", "Completed", "Cancelled"])
        submitted   = st.form_submit_button("Create Trip", type='primary')

    if submitted:
        if not destination or not trip_name:
            st.warning("Please enter at least a trip name and destination.")
        elif end_date < start_date:
            st.warning("End date must be after start date.")
        else:
            payload = {
                "planner_id":  st.session_state.get('user_id', 1),
                "trip_name":   trip_name,
                "destination": destination,
                "city":        city,
                "country":     country,
                "region":      region,
                "trip_type":   trip_type,
                "start_date":  str(start_date),
                "end_date":    str(end_date),
                "group_size":  group_size,
                "trip_status": trip_status,
                "date_booked": str(start_date),
                "is_active":   True,
            }
            try:
                r = requests.post(f"{API_BASE}/trips", json=payload)
                if r.status_code in (200, 201):
                    st.success(f"Trip '{trip_name}' to {destination} created successfully!")
                else:
                    st.error(f"Failed to create trip. ({r.status_code}) — {r.text}")
            except Exception as e:
                st.error(f"Error: {e}")

# ── TAB 3: Reorder itinerary ───────────────────────────────────────────────────
with tab3:
    st.subheader("Update Itinerary Order")
    st.write("Load a trip's itinerary, then enter the booking IDs in your preferred order.")

    trip_id_input = st.number_input("Trip ID:", min_value=1, step=1, key="upd_trip_id")

    if st.button("Load Itinerary", key="load_itin"):
        try:
            r = requests.get(f"{API_BASE}/trips/{trip_id_input}/itinerary")
            if r.status_code == 200:
                items = r.json()
                if items:
                    st.session_state['itin_items'] = items
                    cols = ['booking_id', 'booking_date', 'service_category', 'description', 'booking_status']
                    st.dataframe([{k: i.get(k) for k in cols} for i in items], use_container_width=True)
                else:
                    st.info("No itinerary items found.")
            else:
                st.warning(f"Could not load itinerary. ({r.status_code})")
        except Exception as e:
            st.error(f"Error: {e}")

    booking_ids_input = st.text_input("Enter Booking IDs in new order (comma-separated):", placeholder="e.g. 3, 1, 2")

    if st.button("Save Order", type='primary'):
        if not booking_ids_input:
            st.warning("Please enter booking IDs.")
        else:
            try:
                id_list = [int(x.strip()) for x in booking_ids_input.split(",")]
                payload = {"items": [{"booking_id": bid} for bid in id_list]}
                r = requests.put(f"{API_BASE}/trips/{trip_id_input}/itinerary", json=payload)
                if r.status_code == 200:
                    st.success("Itinerary updated successfully!")
                else:
                    st.error(f"Update failed. ({r.status_code}) — {r.text}")
            except ValueError:
                st.warning("Please enter valid numbers separated by commas.")
            except Exception as e:
                st.error(f"Error: {e}")
