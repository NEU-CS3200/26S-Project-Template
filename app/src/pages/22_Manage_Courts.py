import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks
 
logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)
 
SideBarLinks(show_home=True)
 
BASE_URL = "http://web-api:4000"
 
st.markdown("## Court Management")
 
# ── Top bar: search + filter + add button ───────────────────────────────────
top_left, top_right = st.columns([4, 1])
with top_left:
    search = st.text_input("", placeholder="🔍 Search Court", label_visibility="collapsed")
with top_right:
    add_court = st.button("+ Add Court", type="primary", use_container_width=True)
 
# ── Add Court form (shown when button clicked) ───────────────────────────────
if add_court:
    st.session_state["show_add_form"] = True
 
if st.session_state.get("show_add_form"):
    with st.form("add_court_form"):
        st.subheader("New Court")
        name       = st.text_input("Court Name")
        address    = st.text_input("Address")
        col1, col2 = st.columns(2)
        with col1:
            surface    = st.selectbox("Surface", ["Asphalt", "Concrete", "Wood", "Rubber", "Other"])
            hoop_count = st.number_input("Number of Hoops", min_value=1, step=1, value=2)
        with col2:
            hours      = st.text_input("Hours (e.g. 6am – 10pm)")
            court_type = st.selectbox("Type", ["Outdoor", "Indoor"])
        col_sub, col_cancel = st.columns(2)
        with col_sub:
            submitted = st.form_submit_button("Add Court", type="primary", use_container_width=True)
        with col_cancel:
            if st.form_submit_button("Cancel", use_container_width=True):
                st.session_state["show_add_form"] = False
                st.rerun()
 
    if submitted:
        if not name or not address:
            st.warning("Court name and address are required.")
        else:
            payload = {
                "name": name, "address": address, "surface": surface,
                "hoop_count": hoop_count, "hours": hours, "court_type": court_type,
            }
            try:
                r = requests.post(f"{BASE_URL}/admin/courts", json=payload)
                if r.status_code == 201:
                    st.success(f"✅ '{name}' added!")
                    st.session_state["show_add_form"] = False
                    st.rerun()
                else:
                    st.error(f"Error: {r.text}")
            except Exception as e:
                st.error(f"Could not reach API: {e}")
 
st.markdown("---")
 
# ── Court table ──────────────────────────────────────────────────────────────
try:
    r      = requests.get(f"{BASE_URL}/admin/courts", timeout=5)
    courts = r.json() if r.status_code == 200 else []
except Exception:
    courts = []
    st.error("Could not reach the API. Make sure the containers are running.")
 
if search:
    q = search.lower()
    courts = [c for c in courts if q in c.get("name", "").lower()
              or q in c.get("address", "").lower()]
 
if courts:
    # Table header
    header = st.columns([2, 2, 1.5, 1, 2])
    for col, label in zip(header, ["Court Name", "Location", "Status", "Court #", "Actions"]):
        col.markdown(f"**{label}**")
    st.markdown("---")
 
    for court in courts:
        court_id = court.get("court_id")
        name     = court.get("name", "—")
        address  = court.get("address", "—")
        status   = court.get("status", "Active")
        hoops    = court.get("hoop_count", "—")
 
        if status == "Active":
            status_badge = "🟢 Active"
            action_label = "Deactivate"
        elif status == "Remodeling":
            status_badge = "🟡 Remodeling"
            action_label = "Activate"
        else:
            status_badge = "🔴 Inactive"
            action_label = "Activate"
 
        row = st.columns([2, 2, 1.5, 1, 2])
        row[0].write(name)
        row[1].write(address)
        row[2].write(status_badge)
        row[3].write(str(hoops))
 
        with row[4]:
            if st.button(action_label, key=f"action_{court_id}", use_container_width=True):
                endpoint = "deactivate" if action_label == "Deactivate" else "activate"
                try:
                    resp = requests.put(f"{BASE_URL}/admin/courts/{court_id}/{endpoint}")
                    if resp.status_code == 200:
                        st.toast(f"✅ '{name}' {endpoint}d.")
                        st.rerun()
                    else:
                        st.error(f"Error: {resp.text}")
                except Exception as e:
                    st.error(f"Could not reach API: {e}")
        st.divider()
else:
    st.info("No courts found.")