import logging

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot Dashboard")

import requests

from modules.nav import SideBarLinks

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks(show_home=True)

player_id = st.session_state.get("player_id", 3)
first_name = st.session_state.get("first_name", "Aaliyah")


def fetch_player(pid):
    try:
        resp = requests.get(f"{API_BASE}/player/players/{pid}", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch player {pid}: {e}")
        return None


def fetch_upcoming_tournaments():
    try:
        resp = requests.get(
            f"{API_BASE}/tournament/tournaments",
            params={"status": "Upcoming"},
            timeout=5,
        )
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch upcoming tournaments: {e}")
        return []


player_data = fetch_player(player_id)
upcoming = fetch_upcoming_tournaments()

st.title(f"Welcome back, {first_name}")
st.caption("Your competitive dashboard")

if player_data:
    c1, c2, c3, c4 = st.columns(4)
    c1.metric("Games Played", player_data.get("GamesPlayed", 0))
    c2.metric("Wins", player_data.get("Wins", 0))
    c3.metric("Skill Rating", player_data.get("SkillRating", 0))
    c4.metric("Rank", f"#{player_data.get('SkillRank', '?')}")
else:
    st.warning("Could not load player stats. Make sure the API is running.")

st.markdown("---")
st.subheader("Upcoming Tournaments")

if not upcoming:
    st.info("No upcoming tournaments right now. Check back soon!")
else:
    for t in upcoming[:4]:
        tid = t.get("TournamentId")
        name = t.get("TournamentName", "Unnamed")
        court = t.get("CourtName", "")
        start = t.get("StartDate", "")
        end = t.get("EndDate", "")
        registered = t.get("RegisteredPlayers", 0)

        with st.container(border=True):
            col_info, col_btn = st.columns([5, 1])
            with col_info:
                st.write(f"**{name}**")
                st.caption(f"Court: {court}  |  {start} to {end}  |  {registered} registered")
            with col_btn:
                if st.button("View", key=f"view_{tid}", use_container_width=True, type="primary"):
                    st.switch_page("pages/12_Tournaments.py")

st.markdown("---")
st.subheader("Quick Actions")

col_a, col_b, col_c = st.columns(3)
with col_a:
    if st.button("Leaderboard", type="primary", use_container_width=True):
        st.switch_page("pages/11_Leaderboard.py")
with col_b:
    if st.button("Tournaments", type="primary", use_container_width=True):
        st.switch_page("pages/12_Tournaments.py")
with col_c:
    if st.button("My Games", type="primary", use_container_width=True):
        st.switch_page("pages/13_My_Games.py")
