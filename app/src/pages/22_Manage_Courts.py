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

# Neighborhood lookup — matches seed data in 01_DDL.sql
NEIGHBORHOODS = {
    1: "Back Bay",
    2: "Mission Hill",
    3: "Fenway",
    4: "South End",
    5: "Dorchester",
    6: "Jamaica Plain",
    7: "Allston",
    8: "Brighton",
    9: "Roxbury",
    10: "Cambridgeport",
    11: "Union Square",
    12: "Brookline Village",
    13: "Charlestown",
    14: "East Boston",
    15: "South Boston",
}
NEIGHBORHOOD_OPTIONS = [f"{nid} — {name}" for nid, name in NEIGHBORHOODS.items()]

st.markdown("## Court Management")

# ── Top bar: search + add button ────────────────────────────────────────────
top_left, top_right = st.columns([4, 1])
with top_left:
    search = st.text_input("", placeholder="🔍 Search Court", label_visibility="collapsed")
with top_right:
    add_court = st.button("+ Add Court", type="primary", use_container_width=True)

# ── Add Court form ───────────────────────────────────────────────────────────
if add_court:
    st.session_state["show_add_form"] = True

if st.session_state.get("show_add_form"):
    with st.form("add_court_form"):
        st.subheader("New Court")
        court_name = st.text_input("Court Name")
        address    = st.text_input("Address")

        col1, col2 = st.columns(2)
        with col1:
            latitude   = st.number_input("Latitude",  value=42.36, format="%.6f")
            skill      = st.selectbox("Skill Level", ["Beginner", "Intermediate", "Advanced", "All Levels"])
            surface    = st.selectbox("Surface", ["Asphalt", "Concrete", "Hardwood", "Sport Tile"])
        with col2:
            longitude  = st.number_input("Longitude", value=-71.06, format="%.6f")
            court_type = st.selectbox("Court Type", ["Outdoor", "Indoor"])
            hoop_count = st.number_input("Number of Hoops", min_value=1, step=1, value=2)

        hours        = st.text_input("Hours (e.g. 6 AM - 10 PM)")
        neighborhood = st.selectbox("Neighborhood", NEIGHBORHOOD_OPTIONS)
        neighborhood_id = int(neighborhood.split(" — ")[0])

        col_sub, col_cancel = st.columns(2)
        with col_sub:
            submitted = st.form_submit_button("Add Court", type="primary", use_container_width=True)
        with col_cancel:
            cancelled = st.form_submit_button("Cancel", use_container_width=True)

    if cancelled:
        st.session_state["show_add_form"] = False
        st.rerun()

    if submitted:
        if not court_name or not address or not hours:
            st.warning("Court name, address, and hours are required.")
        else:
            # Field names must match the API's required_fields list
            payload = {
                "CourtName":      court_name,
                "Address":        address,
                "Latitude":       latitude,
                "Longitude":      longitude,
                "SkillLevel":     skill,
                "CourtType":      court_type,
                "SurfaceType":    surface,
                "HoopCount":      hoop_count,
                "Hours":          hours,
                "NeighborhoodId": neighborhood_id,
            }
            try:
                r = requests.post(f"{BASE_URL}/court/courts", json=payload, timeout=5)
                if r.status_code == 201:
                    st.success(f"'{court_name}' added successfully!")
                    st.session_state["show_add_form"] = False
                    st.rerun()
                else:
                    st.error(f"Error: {r.text}")
            except Exception as e:
                st.error(f"Could not reach API: {e}")

st.markdown("---")

# ── Court table ──────────────────────────────────────────────────────────────
try:
    r      = requests.get(f"{BASE_URL}/court/courts", timeout=5)
    courts = r.json() if r.status_code == 200 else []
except Exception:
    courts = []
    st.error("Could not reach the API. Make sure the containers are running.")

if search:
    q = search.lower()
    courts = [
        c for c in courts
        if q in c.get("CourtName", "").lower()
        or q in c.get("Address", "").lower()
        or q in c.get("NeighborhoodName", "").lower()
    ]

if courts:
    header = st.columns([2, 2, 1.5, 1, 2])
    for col, label in zip(header, ["Court Name", "Location", "Status", "Hoops", "Actions"]):
        col.markdown(f"**{label}**")
    st.markdown("---")

    for court in courts:
        court_id  = court.get("CourtId")
        name      = court.get("CourtName", "—")
        address   = court.get("Address", "—")
        is_active = court.get("IsActive", True)
        hoops     = court.get("HoopCount", "—")

        status_badge  = "🟢 Active"   if is_active else "🔴 Inactive"
        action_label  = "Deactivate"  if is_active else "Activate"
        new_status    = False          if is_active else True

        row = st.columns([2, 2, 1.5, 1, 2])
        row[0].write(name)
        row[1].write(address)
        row[2].write(status_badge)
        row[3].write(str(hoops))

        with row[4]:
            if st.button(action_label, key=f"action_{court_id}", use_container_width=True):
                try:
                    # PUT /court/courts/{id} with IsActive toggle
                    resp = requests.put(
                        f"{BASE_URL}/court/courts/{court_id}",
                        json={"IsActive": new_status},
                        timeout=5,
                    )
                    if resp.status_code == 200:
                        st.toast(f"'{name}' updated.")
                        st.rerun()
                    else:
                        st.error(f"Error: {resp.text}")
                except Exception as e:
                    st.error(f"Could not reach API: {e}")
        st.divider()
else:
    st.info("No courts found.")
