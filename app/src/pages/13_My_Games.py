import logging

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot My Games")

import requests

from modules.nav import SideBarLinks

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks(show_home=True)

player_id = st.session_state.get("player_id", 3)


def fetch_player(pid):
    try:
        resp = requests.get(f"{API_BASE}/player/players/{pid}", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch player {pid}: {e}")
        return None


def fetch_recent_games(pid, limit=20):
    try:
        resp = requests.get(
            f"{API_BASE}/player/players/{pid}/recent-games",
            params={"limit": limit},
            timeout=5,
        )
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch recent games for player {pid}: {e}")
        return []


player_data = fetch_player(player_id)
games = fetch_recent_games(player_id)

st.title("My Game History")
st.caption("All your recent games and results")

if player_data:
    total = player_data.get("GamesPlayed", 0)
    wins = player_data.get("Wins", 0)
    losses = total - wins if total > 0 else 0
    win_rate = round((wins / total) * 100) if total > 0 else 0

    c1, c2, c3, c4 = st.columns(4)
    c1.metric("Games Played", total)
    c2.metric("Wins", wins)
    c3.metric("Losses", losses)
    c4.metric("Win Rate", f"{win_rate}%")
else:
    st.warning("Could not load player stats. Make sure the API is running.")

st.markdown("---")

col_filter, col_spacer = st.columns([2, 6])
with col_filter:
    result_filter = st.selectbox("Filter by Result", ["All", "Win", "Loss"])

filtered_games = games
if result_filter != "All":
    filtered_games = [g for g in games if g.get("Result") == result_filter]

if not filtered_games:
    st.info("No games found.")
else:
    for g in filtered_games:
        result = g.get("Result", "")
        court_name = g.get("CourtName", "")
        game_date = str(g.get("GameDate", ""))[:10]
        game_type = g.get("GameType", "Pickup")
        score = g.get("Score", "")

        with st.container(border=True):
            row = st.columns([1, 4, 2, 2])
            with row[0]:
                st.write(f"**{result}**")
            with row[1]:
                st.write(f"**{court_name}**")
                st.caption(game_type)
            with row[2]:
                st.caption("Date")
                st.write(game_date)
            with row[3]:
                st.caption("Score")
                st.write(f"**{score}**")
