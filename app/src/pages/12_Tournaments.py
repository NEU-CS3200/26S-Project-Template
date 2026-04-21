import logging

import streamlit as st
import streamlit.components.v1 as components

st.set_page_config(layout="wide", page_title="HoopSpot - Tournaments")

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
# Page-specific CSS
# ---------------------------------------------------------------------------
PAGE_CSS = """
.tournament-status-upcoming {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 20px;
    font-size: 0.65rem;
    font-weight: 700;
    font-family: 'Outfit', sans-serif;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    background: rgba(59,130,246,0.15);
    color: #60A5FA;
}
.tournament-status-ongoing {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 20px;
    font-size: 0.65rem;
    font-weight: 700;
    font-family: 'Outfit', sans-serif;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    background: rgba(34,197,94,0.15);
    color: #4ADE80;
}
.tournament-status-completed {
    display: inline-block;
    padding: 2px 10px;
    border-radius: 20px;
    font-size: 0.65rem;
    font-weight: 700;
    font-family: 'Outfit', sans-serif;
    letter-spacing: 0.06em;
    text-transform: uppercase;
    background: rgba(100,116,139,0.15);
    color: #94A3B8;
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


def fetch_tournaments(status=None):
    try:
        params = {}
        if status and status != "All":
            params["status"] = status
        resp = requests.get(f"{API_BASE}/tournament/tournaments", params=params, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch tournaments: {e}")
        return []


def fetch_brackets(tournament_id):
    try:
        resp = requests.get(
            f"{API_BASE}/tournament/tournaments/{tournament_id}/brackets", timeout=5
        )
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch brackets for tournament {tournament_id}: {e}")
        return []


def fetch_player(pid):
    try:
        resp = requests.get(f"{API_BASE}/player/players/{pid}", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch player {pid}: {e}")
        return None


def register_for_tournament(tournament_id, pid):
    try:
        resp = requests.post(
            f"{API_BASE}/tournament/tournaments/{tournament_id}/register",
            json={"PlayerId": pid},
            timeout=5,
        )
        resp.raise_for_status()
        return True, resp.json().get("message", "Registered successfully")
    except requests.RequestException as e:
        logger.error(f"Failed to register for tournament {tournament_id}: {e}")
        return False, str(e)

def build_bracket_html(matches):
    """
    Turns flat match rows from the API into a visual single-elimination
    bracket rendered as an HTML/SVG component.
    """
    # ── Organise matches by round ──────────────────────────────────────────
    rounds = {}
    for m in matches:
        r = m.get("RoundNumber", 1)
        rounds.setdefault(r, {})
        mid = m["MatchId"]
        if mid not in rounds[r]:
            rounds[r][mid] = {
                "MatchId": mid,
                "MatchStatus": m.get("MatchStatus", "Scheduled"),
                "MatchOrder": m.get("MatchOrder", 1),
                "players": [],
            }
        rounds[r][mid]["players"].append({
            "name": m.get("PlayerName", "TBD"),
            "is_winner": m.get("IsWinner", False),
        })
 
    sorted_rounds = sorted(rounds.keys())
    num_rounds = len(sorted_rounds)
 
    # ── Layout constants ───────────────────────────────────────────────────
    CARD_W = 160
    CARD_H = 36
    GAP_X = 80          # horizontal space between rounds
    COL_W = CARD_W + GAP_X
    SLOT_H = 90         # vertical space allocated per match slot
 
    # Figure out max matches in round 1 to size the SVG height
    max_matches = max(len(v) for v in rounds.values()) if rounds else 1
    first_round_matches = len(rounds[sorted_rounds[0]]) if sorted_rounds else 1
    svg_height = max(300, first_round_matches * SLOT_H + 60)
    svg_width = num_rounds * COL_W + 40
 
    def slot_y(round_idx, match_idx, total_in_round):
        """Centre y of a match card for a given round and position."""
        spacing = svg_height / total_in_round
        return spacing * match_idx + spacing / 2
 
    # ── Build SVG ──────────────────────────────────────────────────────────
    lines = []
 
    # Background
    lines.append(
        f'<rect width="{svg_width}" height="{svg_height}" '
        f'fill="#0F172A" rx="12"/>'
    )
 
    round_match_positions = {}   # round_num -> list of centre-y for each match
 
    for col_idx, round_num in enumerate(sorted_rounds):
        match_dict = rounds[round_num]
        sorted_matches = sorted(match_dict.values(), key=lambda m: m["MatchOrder"])
        total = len(sorted_matches)
        x = col_idx * COL_W + 20
 
        # Round label
        label_x = x + CARD_W / 2
        round_label = "Final" if col_idx == num_rounds - 1 else f"Round {round_num}"
        lines.append(
            f'<text x="{label_x}" y="18" text-anchor="middle" '
            f'font-family="Outfit,sans-serif" font-size="10" '
            f'fill="#475569" letter-spacing="1" '
            f'text-transform="uppercase">{round_label.upper()}</text>'
        )
 
        centre_ys = []
        for match_idx, match in enumerate(sorted_matches):
            cy = slot_y(col_idx, match_idx, total)
            centre_ys.append(cy)
 
            players = match["players"]
            status = match["MatchStatus"]
 
            p1 = players[0] if len(players) > 0 else {"name": "TBD", "is_winner": False}
            p2 = players[1] if len(players) > 1 else {"name": "TBD", "is_winner": False}
 
            card_y = cy - CARD_H
 
            # Card background
            lines.append(
                f'<rect x="{x}" y="{card_y}" width="{CARD_W}" '
                f'height="{CARD_H * 2}" rx="8" '
                f'fill="#1E293B" stroke="#334155" stroke-width="1"/>'
            )
 
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
st.title("Boston Tournaments")
st.caption("Register for upcoming competitions and track your bracket progress")

# ---------------------------------------------------------------------------
# Status filter
# ---------------------------------------------------------------------------
col_filter, col_spacer = st.columns([2, 6])
with col_filter:
    status_filter = st.selectbox(
        "Filter by Status", ["All", "Upcoming", "Ongoing", "Completed"]
    )

# ---------------------------------------------------------------------------
# Fetch tournaments
# ---------------------------------------------------------------------------
tournaments = fetch_tournaments(status_filter)

if not tournaments:
    st.warning("No tournaments found. Make sure the API is running.")
else:
    # Summary metrics
    upcoming_count = sum(1 for t in tournaments if t.get("Status") == "Upcoming")
    ongoing_count = sum(1 for t in tournaments if t.get("Status") == "Ongoing")
    metric_cols = st.columns(3)
    metric_cols[0].metric("Total Tournaments", len(tournaments))
    metric_cols[1].metric("Upcoming", upcoming_count)
    metric_cols[2].metric("Ongoing", ongoing_count)

    st.markdown("---")

    # ---------------------------------------------------------------------------
    # Bracket dialog
    # ---------------------------------------------------------------------------
    @st.dialog("Tournament Bracket", width="large")
    def show_bracket(tournament_id, tournament_name):
        st.subheader(tournament_name)
        matches = fetch_brackets(tournament_id)

        if not matches:
            st.info("No bracket data available yet.")
            return

        # Group by round
        rounds = {}
        for m in matches:
            r = m.get("RoundNumber", 1)
            rounds.setdefault(r, []).append(m)

        for round_num in sorted(rounds.keys()):
            st.markdown(
                f'<div class="bracket-round-label">Round {round_num}</div>',
                unsafe_allow_html=True,
            )
            round_matches = rounds[round_num]

            # Deduplicate by MatchId (two rows per match due to self-join)
            seen = {}
            for m in round_matches:
                mid = m["MatchId"]
                if mid not in seen:
                    seen[mid] = m

            for match in seen.values():
                player_name = match.get("PlayerName", "TBD")
                opponent_name = match.get("OpponentName", "TBD")
                is_winner = match.get("IsWinner")
                status = match.get("MatchStatus", "Scheduled")

                if status == "Completed":
                    p_class = "bracket-match-winner" if is_winner else "bracket-match-loser"
                    o_class = "bracket-match-loser" if is_winner else "bracket-match-winner"
                else:
                    p_class = "bracket-match-pending"
                    o_class = "bracket-match-pending"

                with st.container(border=True):
                    c1, c2, c3 = st.columns([4, 1, 4])
                    with c1:
                        st.markdown(
                            f'<span class="{p_class}">{player_name}</span>',
                            unsafe_allow_html=True,
                        )
                    with c2:
                        st.markdown(
                            "<div style='text-align:center;color:#475569;font-size:0.8rem;'>vs</div>",
                            unsafe_allow_html=True,
                        )
                    with c3:
                        st.markdown(
                            f'<span class="{o_class}">{opponent_name}</span>',
                            unsafe_allow_html=True,
                        )

            st.markdown("")

    # ---------------------------------------------------------------------------
    # Tournament cards
    # ---------------------------------------------------------------------------
    for t in tournaments:
        tid = t["TournamentId"]
        name = t.get("TournamentName", "Unnamed Tournament")
        status = t.get("Status", "")
        court = t.get("CourtName", "Unknown Court")
        start = t.get("StartDate", "")
        end = t.get("EndDate", "")
        registered = t.get("RegisteredPlayers", 0)

        if status == "Upcoming":
            status_html = f'<span class="tournament-status-upcoming">{status}</span>'
        elif status == "Ongoing":
            status_html = f'<span class="tournament-status-ongoing">{status}</span>'
        else:
            status_html = f'<span class="tournament-status-completed">{status}</span>'

        with st.container(border=True):
            header_col, action_col = st.columns([7, 3])

            with header_col:
                st.markdown(
                    f"""
                    <div style="margin-bottom:4px;">
                        <span style="
                            font-family:'Outfit',sans-serif;
                            font-size:1.1rem;
                            font-weight:700;
                            color:#F1F5F9;
                            margin-right:10px;
                        ">{name}</span>
                        {status_html}
                    </div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:0.78rem;
                        color:#64748B;
                        margin-bottom:2px;
                    ">📍 {court}</div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:0.78rem;
                        color:#64748B;
                    ">🗓 {start} – {end} &nbsp;·&nbsp; {registered} registered</div>
                    """,
                    unsafe_allow_html=True,
                )

            with action_col:
                btn_col1, btn_col2 = st.columns(2)

                with btn_col1:
                    if status == "Upcoming":
                        if st.button("Register", key=f"reg_{tid}", use_container_width=True):
                            ok, msg = register_for_tournament(tid, player_id)
                            if ok:
                                st.success("Registered!")
                            else:
                                st.error(f"Error: {msg}")

                with btn_col2:
                    if status in ("Ongoing", "Completed"):
                        if st.button("Bracket", key=f"bracket_{tid}", use_container_width=True):
                            show_bracket(tid, name)
