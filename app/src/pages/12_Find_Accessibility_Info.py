import logging
logger = logging.getLogger(__name__)

import requests
import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(page_title="Find Accessibility Info | Bostonability", layout="wide")
SideBarLinks()

st.markdown("## Find Accessibility Info")
st.caption("Search streets and neighborhoods in Boston for known accessibility obstructions.")

API_BASE = "http://web-api:4000"

NEIGHBORHOODS = ["Any", "Roxbury", "Allston", "South End", "Back Bay",
                 "Jamaica Plain", "Dorchester", "Fenway", "South Boston",
                 "Charlestown", "Other"]

SEVERITY_LABEL = {1: "Minor", 2: "Low", 3: "Moderate", 4: "High", 5: "Critical"}

if "nb_filter" not in st.session_state:
    st.session_state["nb_filter"] = "Any"

st.markdown("#### Search")
sc1, sc2, sc3 = st.columns([3, 2, 1])

with sc1:
    street_query = st.text_input("Street name", placeholder="e.g. Tremont, Blue Hill Ave")
with sc2:
    nb_index = NEIGHBORHOODS.index(st.session_state["nb_filter"]) if st.session_state["nb_filter"] in NEIGHBORHOODS else 0
    neighborhood_filter = st.selectbox("Neighborhood", NEIGHBORHOODS, index=nb_index)
    st.session_state["nb_filter"] = neighborhood_filter
with sc3:
    st.write("")
    search_btn = st.button("Search", type="primary", use_container_width=True)

st.divider()

if search_btn or street_query or neighborhood_filter != "Any":
    params = {}
    if street_query.strip():
        params["street_name_like"] = street_query.strip()
    if neighborhood_filter != "Any":
        params["neighborhood"] = neighborhood_filter

    try:
        r = requests.get(f"{API_BASE}/locations", params=params, timeout=10)
        r.raise_for_status()
        locations = r.json()
    except Exception as e:
        st.error("Cannot reach API.")
        st.code(str(e))
        st.stop()

    if not locations:
        st.info("No locations found. Try a different search.")
        st.stop()

    st.markdown(f"**{len(locations)} location{'s' if len(locations) != 1 else ''} found**")

    for loc in locations:
        loc_id   = loc.get("location_id")
        street   = loc.get("street_name", "Unknown street")
        hood     = loc.get("neighborhood_name", "")
        zip_code = loc.get("zip_code", "")

        label = street
        if hood:
            label += f" - {hood}"
        if zip_code:
            label += f" ({zip_code})"

        with st.expander(label):
            try:
                obs_r = requests.get(
                    f"{API_BASE}/locations/{loc_id}/obstructions", timeout=10
                )
                obs_r.raise_for_status()
                obstructions = obs_r.json()
            except Exception:
                obstructions = []

            col_info, col_obs = st.columns([1, 2])

            with col_info:
                st.markdown("**Location Details**")
                st.write(f"Neighborhood: {hood or 'N/A'}")
                st.write(f"ZIP Code: {zip_code or 'N/A'}")
                st.write(f"Location ID: {loc_id}")

            with col_obs:
                if obstructions:
                    st.markdown(f"**Known Obstructions ({len(obstructions)})**")
                    for obs in obstructions:
                        sev  = obs.get("severity_level", 1)
                        slbl = SEVERITY_LABEL.get(sev, str(sev))
                        name = obs.get("obstruction_name", "Unknown")
                        desc = obs.get("obstruction_desc", "")
                        st.markdown(
                            f"**{name}** - Severity: *{slbl}*"
                            + (f"\n\n_{desc}_" if desc else "")
                        )
                else:
                    st.success("No known obstructions at this location.")

else:
    st.markdown("Enter a street name or select a neighborhood above to find accessibility information.")

    st.divider()
    st.markdown("#### Browse by Neighborhood")
    nb_cols = st.columns(3)
    for idx, nb in enumerate(NEIGHBORHOODS[1:]):
        with nb_cols[idx % 3]:
            if st.button(nb, use_container_width=True, key=f"nb_{nb}"):
                st.session_state["nb_filter"] = nb
                st.rerun()

st.divider()
st.markdown("#### Quick Navigation")
qn1, qn2 = st.columns(2)
with qn1:
    if st.button("Report a New Issue", use_container_width=True):
        st.switch_page("pages/11_Report_Obstruction.py")
with qn2:
    if st.button("View My Profile", use_container_width=True):
        st.switch_page("pages/16_User_View_Profile.py")