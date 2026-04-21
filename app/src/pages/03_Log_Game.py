import logging
from datetime import date

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot Log a Game")

import requests

from modules.nav import SideBarLinks
from modules.styles import inject_css

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks(show_home=True)

PAGE_CSS = """
.stApp {
    background: radial-gradient(
        ellipse at 50% 0%,
        rgba(249, 115, 22, 0.05) 0%,
        transparent 55%
    );
}
.game-type-badge {
    display: inline-flex;
    align-items: center;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 600;
    font-family: 'Outfit', sans-serif;
    letter-spacing: 0.04em;
    text-transform: uppercase;
}
.game-type-badge.pickup {
    background: rgba(249, 115, 22, 0.12);
    color: #FB923C;
}
.game-type-badge.tournament {
    background: rgba(139, 92, 246, 0.12);
    color: #A78BFA;
}
.game-type-badge.practice {
    background: rgba(59, 130, 246, 0.12);
    color: #60A5FA;
}
.result-badge {
    display: inline-flex;
    align-items: center;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 700;
    font-family: 'Outfit', sans-serif;
    letter-spacing: 0.06em;
    text-transform: uppercase;
}
.result-badge.win {
    background: rgba(34, 197, 94, 0.12);
    color: #4ADE80;
}
.result-badge.loss {
    background: rgba(239, 68, 68, 0.10);
    color: #F87171;
}
.section-label {
    font-family: 'Outfit', sans-serif;
    font-size: 0.65rem;
    font-weight: 600;
    letter-spacing: 0.1em;
    text-transform: uppercase;
    color: #475569;
    margin-bottom: 0.5rem;
}
.game-date {
    font-family: 'Outfit', sans-serif;
    font-size: 0.85rem;
    color: #94A3B8;
}
.game-court {
    font-family: 'Outfit', sans-serif;
    font-size: 1rem;
    font-weight: 700;
    color: #F1F5F9;
}
.game-address {
    font-family: 'Outfit', sans-serif;
    font-size: 0.8rem;
    color: #475569;
}
.form-section-header {
    font-family: 'Outfit', sans-serif;
    font-size: 0.65rem;
    font-weight: 600;
    letter-spacing: 0.12em;
    text-transform: uppercase;
    color: #F97316;
    margin: 1.25rem 0 0.5rem 0;
}
"""

st.markdown(inject_css(PAGE_CSS), unsafe_allow_html=True)

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
court_ids = {c.get("CourtName", "Unknown"): c.get("CourtId") for c in courts}

tab_browse, tab_log = st.tabs(["Browse Recent Games", "Log a New Game"])

# ---------------------------------------------------------------------------
# Browse tab
# ---------------------------------------------------------------------------
with tab_browse:
    selected_court = st.selectbox(
        "Filter by Court", ["All Courts"] + court_names, key="browse_court"
    )
    cid = court_ids.get(selected_court) if selected_court != "All Courts" else None
    games = fetch_games(court_id=cid)

    if not games:
        st.info("No games found. Log one in the next tab!")
    else:
        st.markdown(
            f'<div class="section-label">{len(games)} game{"s" if len(games) != 1 else ""} found</div>',
            unsafe_allow_html=True,
        )
        for g in games[:10]:
            gtype = g.get("GameType", "Pickup").lower()
            badge_class = gtype if gtype in ("pickup", "tournament", "practice") else "pickup"
            with st.container(border=True):
                left, right = st.columns([4, 2])
                with left:
                    st.markdown(
                        f'<div class="game-court">{g.get("CourtName", "")}</div>'
                        f'<div class="game-address">{g.get("Address", "")}</div>',
                        unsafe_allow_html=True,
                    )
                with right:
                    st.markdown(
                        f'<div style="text-align:right;">'
                        f'<span class="game-type-badge {badge_class}">{g.get("GameType", "Pickup")}</span>'
                        f'<div class="game-date" style="margin-top:6px;">'
                        f'{str(g.get("GameDate", ""))[:10]}</div>'
                        f'</div>',
                        unsafe_allow_html=True,
                    )

# ---------------------------------------------------------------------------
# Log tab
# ---------------------------------------------------------------------------
with tab_log:
    if st.session_state.get("_game_logged"):
        st.success(st.session_state.pop("_game_logged"))

    with st.form("log_game_form"):
        st.markdown(
            '<div class="form-section-header">Game Details</div>',
            unsafe_allow_html=True,
        )
        col1, col2 = st.columns(2)
        with col1:
            log_court = st.selectbox("Court", court_names, key="log_court")
            game_type = st.selectbox("Game Type", ["Pickup", "Tournament", "Practice"])
        with col2:
            game_date = st.date_input("Date", value=date.today())
            min_rating = st.number_input(
                "Min Skill Rating",
                min_value=0.0,
                max_value=5.0,
                value=0.0,
                step=0.1,
                format="%.1f",
            )

        st.markdown(
            '<div class="form-section-header">Your Result</div>',
            unsafe_allow_html=True,
        )
        res_col, pts_col = st.columns(2)
        with res_col:
            result = st.selectbox("Result", ["Win", "Loss"])
        with pts_col:
            points = st.number_input("Points Scored", min_value=0, step=1, value=0)

        submitted = st.form_submit_button(
            "Log Game", type="primary", use_container_width=True
        )

    if submitted:
        payload = {
            "CourtId": court_ids.get(log_court),
            "GameDate": str(game_date),
            "GameType": game_type,
            "MinSkillRating": min_rating,
            "players": [{"PlayerId": player_id, "Result": result, "Score": points}],
        }
        try:
            resp = requests.post(
                f"{API_BASE}/tournament/games", json=payload, timeout=5
            )
            if resp.status_code == 201:
                st.session_state["_game_logged"] = (
                    f"Game logged! {result} — {points} pts at {log_court}"
                )
                st.rerun()
            else:
                st.error(f"Error: {resp.text}")
        except Exception as e:
            st.error(f"Could not reach API: {e}")
