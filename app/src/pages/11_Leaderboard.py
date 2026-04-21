import logging

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot - Leaderboard")

import requests

from modules.nav import SideBarLinks
from modules.styles import inject_css

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks()

# ---------------------------------------------------------------------------
# Page-specific CSS  (blue accent for competitive persona)
# ---------------------------------------------------------------------------
PAGE_CSS = """
.rank-medal {
    font-size: 1.1rem;
    width: 2rem;
    text-align: center;
}
.skill-bar-bg {
    background: rgba(255,255,255,0.06);
    border-radius: 4px;
    height: 6px;
    width: 100%;
    overflow: hidden;
}
.skill-bar-fill {
    height: 6px;
    border-radius: 4px;
    background: linear-gradient(90deg, #3B82F6 0%, #6366F1 100%);
}
.you-badge {
    display: inline-block;
    padding: 2px 8px;
    border-radius: 20px;
    font-size: 0.65rem;
    font-weight: 700;
    font-family: 'Outfit', sans-serif;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    background: rgba(59,130,246,0.15);
    color: #60A5FA;
    margin-left: 6px;
    vertical-align: middle;
}
.position-tag {
    font-family: 'Outfit', sans-serif;
    font-size: 0.72rem;
    color: #64748B;
    text-transform: uppercase;
    letter-spacing: 0.06em;
}
"""

st.markdown(inject_css(PAGE_CSS), unsafe_allow_html=True)

# ---------------------------------------------------------------------------
# Session state
# ---------------------------------------------------------------------------
player_id = st.session_state.get("player_id", 3)
first_name = st.session_state.get("first_name", "Aaliyah")

# ---------------------------------------------------------------------------
# Data fetching
# ---------------------------------------------------------------------------


def fetch_leaderboard():
    try:
        resp = requests.get(f"{API_BASE}/player/leaderboard", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch leaderboard: {e}")
        return []


def fetch_player(pid):
    try:
        resp = requests.get(f"{API_BASE}/player/players/{pid}", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch player {pid}: {e}")
        return None


# ---------------------------------------------------------------------------
# Sidebar: player profile card
# ---------------------------------------------------------------------------
player_data = fetch_player(player_id)
if player_data:
    st.sidebar.markdown("---")
    st.sidebar.markdown(
        f"""
        <div style="
            background: linear-gradient(
                135deg,
                rgba(59,130,246,0.08) 0%,
                rgba(22,32,50,0.4) 100%
            );
            border: 1px solid rgba(59,130,246,0.15);
            border-radius: 14px;
            padding: 1.25rem;
        ">
            <div style="
                font-family:'Outfit',sans-serif;
                font-size:1.15rem;
                font-weight:700;
                color:#F1F5F9;
            ">{first_name}</div>
            <div style="
                font-family:'Outfit',sans-serif;
                font-size:0.8rem;
                color:#64748B;
                margin-bottom:1rem;
            ">@{player_data.get("Username", "")}</div>
            <div style="display:flex;gap:1.25rem;margin-bottom:0.5rem;">
                <div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:0.65rem;
                        color:#64748B;
                        text-transform:uppercase;
                        letter-spacing:0.08em;
                        margin-bottom:2px;
                    ">Games</div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:1.4rem;
                        font-weight:700;
                        color:#F1F5F9;
                    ">{player_data.get("GamesPlayed", 0)}</div>
                </div>
                <div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:0.65rem;
                        color:#64748B;
                        text-transform:uppercase;
                        letter-spacing:0.08em;
                        margin-bottom:2px;
                    ">Wins</div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:1.4rem;
                        font-weight:700;
                        color:#F1F5F9;
                    ">{player_data.get("Wins", 0)}</div>
                </div>
                <div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:0.65rem;
                        color:#64748B;
                        text-transform:uppercase;
                        letter-spacing:0.08em;
                        margin-bottom:2px;
                    ">Rating</div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:1.4rem;
                        font-weight:700;
                        color:#3B82F6;
                    ">{player_data.get("SkillRating", "?")}</div>
                </div>
            </div>
            <div style="
                font-family:'Outfit',sans-serif;
                font-size:0.75rem;
                color:#475569;
            ">Rank #{player_data.get("SkillRank", "?")}</div>
        </div>
        """,
        unsafe_allow_html=True,
    )

# ---------------------------------------------------------------------------
# Header
# ---------------------------------------------------------------------------
st.title("Boston Leaderboard")
st.caption("Top-ranked players in the city — updated after every game")

# ---------------------------------------------------------------------------
# Fetch leaderboard
# ---------------------------------------------------------------------------
leaders = fetch_leaderboard()

if not leaders:
    st.warning("Could not load leaderboard. Make sure the API is running.")
else:
    # Find the current player's rank
    my_rank = next(
        (i + 1 for i, p in enumerate(leaders) if p["PlayerId"] == player_id), None
    )

    # -- Summary metrics -----------------------------------------------------
    metric_cols = st.columns(3)
    metric_cols[0].metric("Total Players", len(leaders))
    if leaders:
        metric_cols[1].metric("Top Rating", leaders[0]["SkillRating"])
    if my_rank:
        metric_cols[2].metric("Your Rank", f"#{my_rank}")

    st.markdown("---")

    # -- Position filter -----------------------------------------------------
    positions = ["All Positions"] + sorted(
        set(p["Position"] for p in leaders if p.get("Position"))
    )
    col_filter, col_spacer = st.columns([2, 6])
    with col_filter:
        pos_filter = st.selectbox("Filter by Position", positions)

    filtered = (
        leaders
        if pos_filter == "All Positions"
        else [p for p in leaders if p.get("Position") == pos_filter]
    )

    # -- Leaderboard rows ----------------------------------------------------
    max_rating = max((p["SkillRating"] for p in filtered), default=5.0)

    for i, player in enumerate(filtered):
        global_rank = leaders.index(player) + 1
        is_me = player["PlayerId"] == player_id

        # Medal for top 3
        if global_rank == 1:
            medal = "🥇"
        elif global_rank == 2:
            medal = "🥈"
        elif global_rank == 3:
            medal = "🥉"
        else:
            medal = f"<span style='font-family:Outfit,sans-serif;font-size:0.95rem;color:#64748B;font-weight:600;'>#{global_rank}</span>"

        rating = player.get("SkillRating", 0)
        bar_pct = int((float(rating) / float(max_rating)) * 100)
        position = player.get("Position", "")
        username = player.get("Username", "")
        you_badge = '<span class="you-badge">You</span>' if is_me else ""

        border_style = (
            "border-color: rgba(59,130,246,0.3) !important; "
            "box-shadow: 0 0 0 1px rgba(59,130,246,0.1);"
            if is_me
            else ""
        )

        with st.container(border=True):
            st.markdown(
                f'<div style="{border_style}"></div>', unsafe_allow_html=True
            )
            row = st.columns([1, 5, 3, 3])

            with row[0]:
                st.markdown(
                    f'<div class="rank-medal">{medal}</div>',
                    unsafe_allow_html=True,
                )

            with row[1]:
                st.markdown(
                    f"**{username}** {you_badge}",
                    unsafe_allow_html=True,
                )
                st.markdown(
                    f'<span class="position-tag">{position}</span>',
                    unsafe_allow_html=True,
                )

            with row[2]:
                st.markdown(
                    f"""
                    <div style="padding-top:4px;">
                        <div style="
                            font-family:'Outfit',sans-serif;
                            font-size:0.7rem;
                            color:#64748B;
                            margin-bottom:4px;
                        ">SKILL RATING</div>
                        <div class="skill-bar-bg">
                            <div class="skill-bar-fill" style="width:{bar_pct}%;"></div>
                        </div>
                    </div>
                    """,
                    unsafe_allow_html=True,
                )

            with row[3]:
                st.markdown(
                    f"""
                    <div style="text-align:right;padding-top:2px;">
                        <div style="
                            font-family:'Outfit',sans-serif;
                            font-size:1.6rem;
                            font-weight:800;
                            color:{'#3B82F6' if is_me else '#F1F5F9'};
                            letter-spacing:-0.02em;
                        ">{rating}</div>
                        <div style="
                            font-family:'Outfit',sans-serif;
                            font-size:0.65rem;
                            color:#64748B;
                            text-transform:uppercase;
                            letter-spacing:0.06em;
                        ">/ 5.0</div>
                    </div>
                    """,
                    unsafe_allow_html=True,
                )
