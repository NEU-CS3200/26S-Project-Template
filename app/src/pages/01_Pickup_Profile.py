import logging
from datetime import UTC, datetime

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot - Profile")

import plotly.graph_objects as go
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
# Page-specific CSS — editorial sports-profile feel
# ---------------------------------------------------------------------------
PAGE_CSS = """
.block-container { padding-top: 3.5rem !important; max-width: 1400px; }

/* Profile hero — horizontal compact layout */
.profile-hero {
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 1.15rem;
    padding: 0.6rem 0.25rem;
    position: relative;
    height: 100%;
}
.profile-hero::before {
    content: "";
    position: absolute;
    inset: -12px -28px;
    background:
        radial-gradient(380px 180px at 22% 50%,
            rgba(249,115,22,0.09) 0%,
            rgba(249,115,22,0.0) 65%);
    pointer-events: none;
    z-index: 0;
}
.profile-hero > * { position: relative; z-index: 1; }
.hero-text {
    display: flex;
    flex-direction: column;
    gap: 0.28rem;
    min-width: 0;
}

.avatar-ring {
    width: 88px;
    height: 88px;
    flex-shrink: 0;
    border-radius: 50%;
    padding: 2.5px;
    background: #F97316;
}
.avatar-inner {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    background: linear-gradient(135deg, #1A2238 0%, #0C1222 100%);
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Outfit', sans-serif;
    font-size: 1.8rem;
    font-weight: 700;
    letter-spacing: -0.04em;
    color: #F1F5F9;
    border: 1px solid rgba(255,255,255,0.05);
}

.profile-name {
    font-family: 'Outfit', sans-serif;
    font-size: 1.65rem;
    font-weight: 700;
    letter-spacing: -0.035em;
    color: #F1F5F9;
    margin: 0;
    line-height: 1.05;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.profile-location {
    font-family: 'Outfit', sans-serif;
    font-size: 0.82rem;
    color: #64748B;
    font-weight: 400;
    letter-spacing: 0.01em;
}
.rank-pill {
    display: inline-flex;
    align-items: center;
    gap: 0.4rem;
    padding: 0.28rem 0.75rem;
    border-radius: 999px;
    background: linear-gradient(135deg,
        rgba(249,115,22,0.18) 0%,
        rgba(249,115,22,0.06) 100%);
    border: 1px solid rgba(249,115,22,0.3);
    color: #FB923C;
    font-family: 'Outfit', sans-serif;
    font-size: 0.7rem;
    font-weight: 600;
    letter-spacing: 0.04em;
    text-transform: uppercase;
    margin-top: 0.1rem;
    align-self: flex-start;
}
.rank-pill .rank-dot {
    width: 5px; height: 5px; border-radius: 50%;
    background: #F97316;
    box-shadow: 0 0 8px #F97316;
}

/* Stat cards */
.stat-card {
    background:
        linear-gradient(180deg,
            rgba(255,255,255,0.02) 0%,
            rgba(255,255,255,0) 100%);
    border: 1px solid rgba(255,255,255,0.06);
    border-radius: 14px;
    padding: 0.95rem 1.1rem 0.85rem;
    height: 100%;
    position: relative;
    overflow: hidden;
    transition: border-color 0.2s ease, transform 0.2s ease;
}
.stat-card:hover {
    border-color: rgba(249,115,22,0.22);
    transform: translateY(-1px);
}
.stat-card::after {
    content: "";
    position: absolute;
    left: 1.1rem; right: 1.1rem; bottom: 0;
    height: 1px;
    background: linear-gradient(90deg,
        transparent 0%,
        rgba(249,115,22,0.35) 50%,
        transparent 100%);
    opacity: 0.5;
}
.stat-label {
    font-family: 'Outfit', sans-serif;
    font-size: 0.64rem;
    text-transform: uppercase;
    letter-spacing: 0.14em;
    color: #64748B;
    font-weight: 600;
    margin-bottom: 0.35rem;
}
.stat-value {
    font-family: 'Outfit', sans-serif;
    font-size: 2.05rem;
    font-weight: 700;
    letter-spacing: -0.04em;
    color: #F1F5F9;
    font-variant-numeric: tabular-nums;
    line-height: 1.05;
}
.stat-value.accent { color: #F97316; }
.stat-sub {
    font-family: 'Outfit', sans-serif;
    font-size: 0.72rem;
    color: #64748B;
    margin-top: 0.25rem;
    font-weight: 400;
}
.wl-split { display: flex; align-items: baseline; gap: 0.3rem; }
.wl-wins   { color: #4ADE80; font-weight: 700; font-size: 2.05rem;
             font-variant-numeric: tabular-nums; letter-spacing: -0.04em; }
.wl-slash  { color: #334155; font-weight: 500; font-size: 1.45rem; }
.wl-losses { color: #F87171; font-weight: 700; font-size: 2.05rem;
             font-variant-numeric: tabular-nums; letter-spacing: -0.04em; }
.trend-up {
    color: #4ADE80;
    font-size: 0.7rem;
    font-weight: 600;
    margin-left: 0.35rem;
}

/* Section heading */
.section-head {
    display: flex;
    align-items: baseline;
    justify-content: space-between;
    margin: 1.2rem 0 0.55rem;
}
.section-title {
    font-family: 'Outfit', sans-serif;
    font-size: 1.1rem;
    font-weight: 600;
    color: #F1F5F9;
    letter-spacing: -0.015em;
}
.section-meta {
    font-family: 'Outfit', sans-serif;
    font-size: 0.78rem;
    color: #64748B;
    text-transform: uppercase;
    letter-spacing: 0.1em;
}

/* Recent games row */
.game-row {
    display: grid;
    grid-template-columns: 1fr auto;
    align-items: center;
    gap: 0.7rem;
    padding: 0.6rem 0.85rem;
    border-radius: 10px;
    border: 1px solid rgba(255,255,255,0.05);
    background: rgba(255,255,255,0.015);
    transition: border-color 0.15s ease, background 0.15s ease;
    margin-bottom: 0.35rem;
    min-width: 0;
}
.game-row > div { min-width: 0; }
.game-row:hover {
    border-color: rgba(249,115,22,0.18);
    background: rgba(249,115,22,0.03);
}
.game-index {
    font-family: 'Outfit', sans-serif;
    font-variant-numeric: tabular-nums;
    font-size: 0.8rem;
    color: #475569;
    width: 1.2rem;
    text-align: right;
}
.game-title {
    font-family: 'Outfit', sans-serif;
    font-size: 0.9rem;
    font-weight: 600;
    color: #F1F5F9;
    letter-spacing: -0.01em;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.game-sub {
    font-family: 'Outfit', sans-serif;
    font-size: 0.72rem;
    color: #64748B;
    margin-top: 1px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
.game-date {
    font-family: 'Outfit', sans-serif;
    font-size: 0.78rem;
    color: #94A3B8;
    font-variant-numeric: tabular-nums;
}
.result-badge {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    min-width: 54px;
    padding: 0.25rem 0.7rem;
    border-radius: 999px;
    font-family: 'Outfit', sans-serif;
    font-size: 0.72rem;
    font-weight: 700;
    letter-spacing: 0.08em;
    text-transform: uppercase;
}
.result-badge.win {
    background: rgba(74,222,128,0.12);
    color: #4ADE80;
    border: 1px solid rgba(74,222,128,0.22);
}
.result-badge.loss {
    background: rgba(248,113,113,0.10);
    color: #F87171;
    border: 1px solid rgba(248,113,113,0.22);
}
"""

st.markdown(inject_css(PAGE_CSS), unsafe_allow_html=True)

# ---------------------------------------------------------------------------
# Session defaults
# ---------------------------------------------------------------------------
player_id = st.session_state.get("player_id", 1)
first_name = st.session_state.get("first_name", "Marcus")
last_name = st.session_state.get("last_name", "Reyes")
location = st.session_state.get("location", "Roxbury, MA")


# ---------------------------------------------------------------------------
# Data fetching
# ---------------------------------------------------------------------------
def fetch_player(pid):
    try:
        resp = requests.get(f"{API_BASE}/player/players/{pid}", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch player {pid}: {e}")
        return None


def fetch_recent_games(pid, limit=10):
    try:
        resp = requests.get(
            f"{API_BASE}/player/players/{pid}/recent-games",
            params={"limit": limit},
            timeout=5,
        )
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch recent games for {pid}: {e}")
        return []


def fetch_skill_history(pid):
    try:
        resp = requests.get(f"{API_BASE}/player/players/{pid}/skill-history", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch skill history for {pid}: {e}")
        return []


def relative_date(iso_str):
    if not iso_str:
        return ""
    try:
        dt = datetime.fromisoformat(iso_str.replace("Z", "+00:00"))
    except ValueError:
        return iso_str
    now = datetime.now(dt.tzinfo or UTC)
    delta = now - dt
    days = delta.days
    if days < 0:
        return dt.strftime("%b %d")
    if days == 0:
        return "today"
    if days == 1:
        return "yesterday"
    if days < 7:
        return f"{days} days ago"
    if days < 30:
        weeks = days // 7
        return f"{weeks} week{'s' if weeks > 1 else ''} ago"
    return dt.strftime("%b %d, %Y")


# ---------------------------------------------------------------------------
# Data
# ---------------------------------------------------------------------------
player = fetch_player(player_id)
if not player:
    st.error("Could not load profile. Check your connection and try again.")
    st.stop()

games_played = int(player.get("GamesPlayed", 0) or 0)
wins = int(player.get("Wins", 0) or 0)
losses = max(0, games_played - wins)
skill_rating = float(player.get("SkillRating", 0) or 0)
skill_display = round(skill_rating * 1000) if skill_rating else 0
rank = player.get("SkillRank", "?")
username = player.get("Username", "")
initials = (first_name[:1] + last_name[:1]).upper() if first_name else "M"

# ---------------------------------------------------------------------------
# Hero + stat cards (side-by-side on desktop)
# ---------------------------------------------------------------------------
win_rate = (wins / games_played * 100) if games_played else 0
top_cols = st.columns([2.2, 1.4, 1.4, 1.4], gap="medium")

with top_cols[0]:
    st.markdown(
        f"""
        <div class="profile-hero">
            <div class="avatar-ring"><div class="avatar-inner">{initials}</div></div>
            <div class="hero-text">
                <div class="profile-name">{first_name} {last_name}</div>
                <div class="profile-location">{location} · @{username}</div>
                <div class="rank-pill">
                    <span class="rank-dot"></span>
                    Rank #{rank}
                </div>
            </div>
        </div>
        """,
        unsafe_allow_html=True,
    )

with top_cols[1]:
    st.markdown(
        f"""
        <div class="stat-card">
            <div class="stat-label">Games Played</div>
            <div class="stat-value">{games_played}</div>
            <div class="stat-sub">Lifetime · all courts</div>
        </div>
        """,
        unsafe_allow_html=True,
    )

with top_cols[2]:
    st.markdown(
        f"""
        <div class="stat-card">
            <div class="stat-label">Win / Loss</div>
            <div class="wl-split">
                <span class="wl-wins">{wins}</span>
                <span class="wl-slash">/</span>
                <span class="wl-losses">{losses}</span>
            </div>
            <div class="stat-sub">{win_rate:.0f}% win rate</div>
        </div>
        """,
        unsafe_allow_html=True,
    )

with top_cols[3]:
    st.markdown(
        f"""
        <div class="stat-card">
            <div class="stat-label">Skill Score</div>
            <div>
                <span class="stat-value accent">{skill_display:,}</span>
                <span class="trend-up">▲ trending</span>
            </div>
            <div class="stat-sub">Rating {skill_rating:.1f} / 5.0</div>
        </div>
        """,
        unsafe_allow_html=True,
    )

# ---------------------------------------------------------------------------
# Skill Score chart
# ---------------------------------------------------------------------------
history = fetch_skill_history(player_id)
recent = fetch_recent_games(player_id, limit=8)

bottom_cols = st.columns([2, 1.2], gap="large")

with bottom_cols[0]:
    st.markdown(
        """
        <div class="section-head">
            <div class="section-title">Skill Score</div>
            <div class="section-meta">Past games · chronological</div>
        </div>
        """,
        unsafe_allow_html=True,
    )

    if history:
        x_vals = list(range(1, len(history) + 1))
        y_vals = [h["SkillScore"] for h in history]
        dates = [
            datetime.fromisoformat(h["GameDate"]).strftime("%b %d, %Y")
            if h.get("GameDate")
            else ""
            for h in history
        ]

        fig = go.Figure()

        fig.add_trace(
            go.Scatter(
                x=x_vals,
                y=y_vals,
                mode="lines",
                line=dict(color="rgba(249,115,22,0.95)", width=2.5, shape="spline"),
                fill="tozeroy",
                fillcolor="rgba(249,115,22,0.12)",
                hovertemplate=(
                    "<b>%{customdata}</b><br>Skill Score: <b>%{y:,}</b><extra></extra>"
                ),
                customdata=dates,
                showlegend=False,
            )
        )

        fig.add_trace(
            go.Scatter(
                x=[x_vals[-1]],
                y=[y_vals[-1]],
                mode="markers",
                marker=dict(
                    size=12,
                    color="#F97316",
                    line=dict(color="#0C1222", width=3),
                ),
                hoverinfo="skip",
                showlegend=False,
            )
        )

        y_min = min(y_vals)
        y_max = max(y_vals)
        y_pad = max(40, (y_max - y_min) * 0.18)

        fig.update_layout(
            height=320,
            margin=dict(l=0, r=0, t=10, b=10),
            paper_bgcolor="rgba(0,0,0,0)",
            plot_bgcolor="rgba(0,0,0,0)",
            font=dict(family="Outfit, sans-serif", color="#94A3B8", size=12),
            hoverlabel=dict(
                bgcolor="#1E293B",
                bordercolor="rgba(255,255,255,0.1)",
                font=dict(family="Outfit, sans-serif", color="#F1F5F9", size=13),
            ),
            xaxis=dict(
                showgrid=False,
                zeroline=False,
                showticklabels=False,
                fixedrange=True,
            ),
            yaxis=dict(
                showgrid=True,
                gridcolor="rgba(255,255,255,0.04)",
                gridwidth=1,
                griddash="dot",
                zeroline=False,
                showticklabels=True,
                tickfont=dict(color="#475569", size=10),
                range=[max(0, y_min - y_pad), y_max + y_pad],
                fixedrange=True,
            ),
        )

        st.plotly_chart(fig, use_container_width=True, config={"displayModeBar": False})
    else:
        st.caption("No games played yet — your skill trajectory will appear here.")

with bottom_cols[1]:
    st.markdown(
        f"""
        <div class="section-head">
            <div class="section-title">Recent Games</div>
            <div class="section-meta">Last {len(recent)}</div>
        </div>
        """,
        unsafe_allow_html=True,
    )

    if not recent:
        st.caption("No games on record yet. Check in at a court to get started.")
    else:
        for g in recent:
            result = (g.get("Result") or "").strip()
            is_win = result.lower() == "win"
            badge_class = "win" if is_win else "loss"
            rel = relative_date(g.get("GameDate"))
            court_name = g.get("CourtName", "Unknown Court")
            game_type = g.get("GameType", "")
            score = g.get("Score", "?")

            st.markdown(
                f"""
                <div class="game-row">
                    <div>
                        <div class="game-title">{court_name}</div>
                        <div class="game-sub">{game_type} · {score} pts · {rel}</div>
                    </div>
                    <div class="result-badge {badge_class}">
                        {"Win" if is_win else "Loss"}
                    </div>
                </div>
                """,
                unsafe_allow_html=True,
            )
