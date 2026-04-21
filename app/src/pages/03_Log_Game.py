import logging
from datetime import date

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot Log a Game")

import requests

from modules.nav import SideBarLinks

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks(show_home=True)

player_id = st.session_state.get("player_id", 1)


def fetch_courts():
    try:
        resp = requests.get(f"{API_BASE}/court/courts", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch courts: {e}")
        return []


def fetch_games(court_id=None):
    try:
        params = {}
        if court_id:
            params["court_id"] = court_id
        resp = requests.get(f"{API_BASE}/tournament/games", params=params, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch games: {e}")
        return []


courts = fetch_courts()

st.title("Log a Game")
st.caption("Record your pickup game results and keep track of your progress")

if not courts:
    st.error("Could not load courts. Make sure the API is running.")
    st.stop()

court_names = [c.get("CourtName", "Unknown") for c in courts]
court_ids = {c.get("CourtName"): c.get("CourtId") for c in courts}

tab_browse, tab_log = st.tabs(["Browse Recent Games", "Log a New Game"])

with tab_browse:
    selected_court = st.selectbox("Filter by Court", ["All Courts"] + court_names, key="browse_court")
    cid = court_ids.get(selected_court) if selected_court != "All Courts" else None
    games = fetch_games(court_id=cid)

    if not games:
        st.info("No games found. Log one in the next tab!")
    else:
        for g in games[:10]:
            with st.container(border=True):
                c1, c2, c3 = st.columns([3, 2, 2])
                with c1:
                    st.write(f"**{g.get('CourtName', '')}**")
                    st.caption(g.get("Address", ""))
                with c2:
                    st.caption("Date")
                    st.write(str(g.get("GameDate", ""))[:10])
                with c3:
                    st.caption("Type")
                    st.write(g.get("GameType", "Pickup"))

with tab_log:
    with st.form("log_game_form"):
        st.markdown("**Game Details**")
        col1, col2 = st.columns(2)
        with col1:
            log_court = st.selectbox("Court", court_names, key="log_court")
            game_type = st.selectbox("Game Type", ["Pickup", "Tournament", "Practice"])
        with col2:
            game_date = st.date_input("Date", value=date.today())
            min_rating = st.number_input("Min Skill Rating", min_value=0.0, max_value=5.0, value=0.0, step=0.1, format="%.1f")

        st.markdown("**Your Result**")
        result = st.selectbox("Result", ["Win", "Loss"])
        score = st.number_input("Your Score (points)", min_value=0, step=1, value=0)
        submitted = st.form_submit_button("Log Game", type="primary", use_container_width=True)

    if submitted:
        payload = {
            "CourtId": court_ids.get(log_court),
            "GameDate": str(game_date),
            "GameType": game_type,
            "MinSkillRating": min_rating,
            "players": [{"PlayerId": player_id, "Result": result, "Score": score}],
        }
        try:
            resp = requests.post(f"{API_BASE}/tournament/games", json=payload, timeout=5)
            if resp.status_code == 201:
                st.success(f"Game logged: {result}, {score} pts!")
                st.rerun()
            else:
                st.error(f"Error: {resp.text}")
        except Exception as e:
            st.error(f"Could not reach API: {e}")
