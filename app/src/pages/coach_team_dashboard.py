import streamlit as st
from datetime import datetime
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="coach_persona")

# -------------------------------------------------------
# Mock Data
# -------------------------------------------------------
MY_TEAM = "Huskies"

UPCOMING_GAMES = [
    {"opponent": "Team 1", "date": datetime(2026, 4, 7)},
    {"opponent": "Team 2", "date": datetime(2026, 4, 10)},
    {"opponent": "Team 3", "date": datetime(2026, 4, 14)},
]

STANDINGS = [
    {"rank": 1, "team": "Huskies",  "w": 14, "l": 0},
    {"rank": 2, "team": "Team 4",   "w": 10, "l": 4},
    {"rank": 3, "team": "Team 2",   "w": 8,  "l": 6},
    {"rank": 4, "team": "Team 7",   "w": 7,  "l": 5},
    {"rank": 5, "team": "Team 1",   "w": 6,  "l": 8},
    {"rank": 6, "team": "Team 3",   "w": 4,  "l": 10},
]

HEAD_TO_HEAD = {
    "Team 4": {
        "my_wins": 2,
        "their_wins": 1,
        "history": [
            {"date": "Mar 3",  "result": "W", "score": "36 - 24"},
            {"date": "Feb 17", "result": "L", "score": "32 - 28"},
            {"date": "Feb 3",  "result": "W", "score": "40 - 35"},
        ],
    },
    "Team 2": {
        "my_wins": 3,
        "their_wins": 0,
        "history": [
            {"date": "Mar 10", "result": "W", "score": "41 - 30"},
            {"date": "Feb 22", "result": "W", "score": "38 - 27"},
            {"date": "Jan 15", "result": "W", "score": "44 - 31"},
        ],
    },
    "Team 1": {
        "my_wins": 1,
        "their_wins": 2,
        "history": [
            {"date": "Mar 18", "result": "L", "score": "28 - 33"},
            {"date": "Feb 10", "result": "W", "score": "35 - 29"},
            {"date": "Jan 28", "result": "L", "score": "30 - 37"},
        ],
    },
}

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            .dash-label {
                font-family: monospace;
                font-size: 14px;
                color: #555;
                margin-bottom: 6px;
            }
            .game-card {
                border: 1.5px solid #ccc;
                padding: 14px 18px;
                margin-bottom: 8px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-family: monospace;
            }
            .game-card:last-child { margin-bottom: 0; }
            .game-matchup { font-size: 18px; font-weight: bold; }
            .game-date { font-size: 16px; color: #444; }
            .standings-table {
                width: 100%;
                border-collapse: collapse;
                font-family: monospace;
                font-size: 14px;
            }
            .standings-table th {
                border: 1.5px solid #ccc;
                padding: 8px 12px;
                text-align: center;
                font-weight: bold;
                background: #f5f5f5;
            }
            .standings-table td {
                border: 1.5px solid #ccc;
                padding: 8px 12px;
                text-align: center;
            }
            .standings-table tr.my-team td {
                font-weight: bold;
                background: #fff8f8;
            }
            .h2h-box {
                border: 2px solid #333;
                padding: 24px 20px;
                font-family: monospace;
            }
            .h2h-title {
                font-size: 26px;
                font-weight: bold;
                text-align: center;
                font-family: monospace;
                margin-bottom: 18px;
            }
            .h2h-scores {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 20px;
                margin: 20px 0;
            }
            .h2h-team-box {
                border: 2.5px solid #333;
                border-radius: 16px;
                padding: 20px 40px;
                text-align: center;
                font-family: monospace;
                min-width: 160px;
            }
            .h2h-team-name { font-weight: bold; font-size: 18px; }
            .h2h-wins { font-size: 15px; margin-top: 4px; }
            .h2h-dash { font-size: 24px; color: #333; }
            .h2h-history-box {
                border: 1.5px solid #ccc;
                margin-top: 16px;
                max-height: 200px;
                overflow-y: auto;
            }
            .h2h-row {
                display: flex;
                justify-content: center;
                gap: 60px;
                padding: 12px 20px;
                border-bottom: 1px solid #eee;
                font-family: monospace;
                font-size: 15px;
            }
            .h2h-row:last-child { border-bottom: none; }
            .win  { color: #2e7d32; font-weight: bold; }
            .loss { color: #c61717; font-weight: bold; }
        </style>
    """, unsafe_allow_html=True)

# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    st.markdown("<h1 style='font-family:monospace; text-align:center;'>Huskies</h1>", unsafe_allow_html=True)

    # ---- Upcoming Games (full width) ----
    st.markdown('<div class="dash-label">Upcoming Games</div>', unsafe_allow_html=True)
    games_html = ""
    for g in UPCOMING_GAMES:
        d = g["date"].day
        suffix = "th" if 11 <= d <= 13 else {1:"st",2:"nd",3:"rd"}.get(d%10, "th")
        day = g["date"].strftime(f"%a, %b %-d{suffix}")
        games_html += f"""
        <div class="game-card">
            <span class="game-matchup">{MY_TEAM} vs. {g['opponent']}</span>
            <span class="game-date">{day}</span>
        </div>"""
    st.html(f'<div style="border:2px solid #333; padding:12px;">{games_html}</div>')

    st.markdown("<br>", unsafe_allow_html=True)

    # ---- Division Standings (full width) ----
    st.markdown('<div class="dash-label">Division Standings</div>', unsafe_allow_html=True)
    rows = ""
    for s in STANDINGS:
        row_class = "my-team" if s["team"] == MY_TEAM else ""
        rows += f"<tr class='{row_class}'><td>{s['rank']}</td><td>{s['team']}</td><td>{s['w']}</td><td>{s['l']}</td></tr>"
    st.html(f"""
    <div style="border:2px solid #333; padding:12px;">
        <table class="standings-table">
            <thead><tr><th>Rank</th><th>Team</th><th>W</th><th>L</th></tr></thead>
            <tbody>{rows}</tbody>
        </table>
    </div>
    """)

    st.markdown("<br>", unsafe_allow_html=True)

    # ---- Head-to-Head (full width) ----
    selected_team = st.selectbox("Opponent", list(HEAD_TO_HEAD.keys()), label_visibility="collapsed")
    h2h = HEAD_TO_HEAD[selected_team]

    history_rows = ""
    for game in h2h["history"]:
        cls = "win" if game["result"] == "W" else "loss"
        label = f"W {game['score']}" if game["result"] == "W" else f"L {game['score']}"
        history_rows += f"""
        <div class="h2h-row">
            <span>{game['date']}</span>
            <span class="{cls}">{label}</span>
        </div>"""

    st.html(f"""
    <div class="h2h-box">
        <div class="h2h-title">Head-to-Head</div>
        <div class="h2h-scores">
            <div class="h2h-team-box">
                <div class="h2h-team-name">{MY_TEAM}</div>
                <div class="h2h-wins">{h2h['my_wins']} Wins</div>
            </div>
            <span class="h2h-dash">—</span>
            <div class="h2h-team-box">
                <div class="h2h-team-name">{selected_team}</div>
                <div class="h2h-wins">{h2h['their_wins']} Wins</div>
            </div>
        </div>
        <div class="h2h-history-box">{history_rows}</div>
    </div>
    """)

show()