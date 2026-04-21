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

st.markdown("## Player Management")

search = st.text_input("", placeholder="Search by username or email", label_visibility="collapsed")

st.markdown("---")

try:
    r = requests.get(f"{BASE_URL}/player/players", timeout=5)
    players = r.json() if r.status_code == 200 else []
except Exception:
    players = []
    st.error("Could not reach the API. Make sure the containers are running.")

if search:
    q = search.lower()
    players = [
        p for p in players
        if q in p.get("Username", "").lower()
        or q in p.get("Email", "").lower()
    ]

if players:
    header = st.columns([2, 2.5, 1.5, 1, 2])
    for col, label in zip(header, ["Username", "Email", "Status", "Rating", "Actions"]):
        col.markdown(f"**{label}**")
    st.markdown("---")

    for player in players:
        pid = player.get("PlayerId")
        username = player.get("Username", "")
        email = player.get("Email", "")
        is_active = player.get("IsActive", True)
        rating = player.get("SkillRating", "")

        status_badge = "Active" if is_active else "Inactive"
        toggle_label = "Deactivate" if is_active else "Activate"
        new_status = False if is_active else True

        row = st.columns([2, 2.5, 1.5, 1, 2])
        row[0].write(username)
        row[1].write(email)
        row[2].write(status_badge)
        row[3].write(str(rating))

        with row[4]:
            if st.button(toggle_label, key=f"toggle_{pid}", use_container_width=True):
                try:
                    resp = requests.put(
                        f"{BASE_URL}/player/players/{pid}",
                        json={"IsActive": new_status},
                        timeout=5,
                    )
                    if resp.status_code == 200:
                        st.toast(f"'{username}' updated.")
                        st.rerun()
                    else:
                        st.error(f"Error: {resp.text}")
                except Exception as e:
                    st.error(f"Could not reach API: {e}")

        st.divider()
else:
    st.info("No players found.")
