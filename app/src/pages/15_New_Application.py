import streamlit as st
import pandas as pd

from modules.nav import SideBarLinks
from modules.api_client import api_get, api_post, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

user_id = st.session_state.get("user_id", 4)

st.title("Venue Application")
st.caption("Submit a new venue to the platform so customers can discover your business.")
st.caption("📌 Covers: Marcus-5 (submit a new venue listing for admin approval)")

# ── Past applications ─────────────────────────────────────────────────────────
st.subheader("My Applications")
my_apps, err = api_get("/applications", params={"ownerId": user_id})
if err:
    show_api_error(err)
elif not my_apps:
    st.info("You haven't submitted any applications yet.")
else:
    df = pd.DataFrame(my_apps)[["applicationId", "name", "address", "status", "createdAt"]]
    df.columns = ["App ID", "Venue Name", "Address", "Status", "Submitted"]
    st.dataframe(df, use_container_width=True, hide_index=True)

st.divider()

# ── New application ───────────────────────────────────────────────────────────
st.subheader("New Application")
with st.form("application_form"):
    c1, c2 = st.columns(2)
    with c1:
        name    = st.text_input("Venue Name *")
        address = st.text_input("Address *")
        phone   = st.text_input("Phone Number")
    with c2:
        min_price   = st.number_input("Min Price ($)", min_value=0.0, value=10.0, step=1.0)
        max_price   = st.number_input("Max Price ($)", min_value=0.0, value=50.0, step=1.0)
        description = st.text_area("Description", placeholder="Tell us about this venue...", height=108)

    if st.form_submit_button("Submit Application", type="primary"):
        if not name.strip() or not address.strip():
            st.warning("Venue Name and Address are required.")
        elif max_price < min_price:
            st.warning("Max price must be ≥ min price.")
        else:
            _, app_err = api_post("/applications", {
                "ownerId": user_id, "name": name.strip(), "address": address.strip(),
                "phone": phone.strip() or None, "description": description.strip() or None,
                "minPrice": min_price, "maxPrice": max_price,
            })
            if app_err:
                show_api_error(app_err)
            else:
                st.success("Application submitted! The admin team will review it shortly.")
                st.rerun()
