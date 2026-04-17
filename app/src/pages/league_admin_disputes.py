import streamlit as st
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="league_admin_persona")

# -------------------------------------------------------
# Mock Data
# -------------------------------------------------------
LEAGUES = ["Husky League", "Bull Games", "Ivy League"]

DISPUTES = {
    "Husky League": [
        {
            "matchup": "Team 1 vs Team 2",
            "submitted": "4/13/2026",
            "from": "Travis Jones (Referee)",
            "prev_score": "11 - 7",
            "corrected_score": "7 - 11",
        },
        {
            "matchup": "Team 3 vs Team 2",
            "submitted": "5/29/2026",
            "from": "Mary Jane (Referee)",
            "prev_score": "5 - 6",
            "corrected_score": "6 - 6",
        },
    ],
    "Bull Games": [
        {
            "matchup": "Bulls A vs Red Squad",
            "submitted": "3/22/2026",
            "from": "Chris Park (Referee)",
            "prev_score": "88 - 74",
            "corrected_score": "86 - 74",
        },
        {
            "matchup": "Bulls B vs Bulls A",
            "submitted": "4/02/2026",
            "from": "Leo Tran (Referee)",
            "prev_score": "72 - 68",
            "corrected_score": "68 - 72",
        },
        {
            "matchup": "Red Squad vs Bulls B",
            "submitted": "4/08/2026",
            "from": "Nina Patel (Coach)",
            "prev_score": "55 - 60",
            "corrected_score": "55 - 58",
        },
    ],
    "Ivy League": [
        {
            "matchup": "Green Team vs Blue Crew",
            "submitted": "4/01/2026",
            "from": "Dana White (Referee)",
            "prev_score": "21 - 14",
            "corrected_score": "14 - 14",
        },
        {
            "matchup": "Gold Squad vs Silver FC",
            "submitted": "4/05/2026",
            "from": "Sam Rivera (Coach)",
            "prev_score": "10 - 13",
            "corrected_score": "13 - 10",
        },
    ],
}

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            div[data-testid="stSelectbox"] label { display: none; }
        </style>
    """, unsafe_allow_html=True)

# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    st.markdown("<h1 style='font-family:monospace; text-align:center;'>Manage Disputes</h1>", unsafe_allow_html=True)
    st.markdown("<br>", unsafe_allow_html=True)
    # Select League
    lbl_col, sel_col, _ = st.columns([1.2, 2, 4])
    with lbl_col:
        st.markdown("<div style='font-family:monospace;font-size:20px;font-weight:bold;padding-top:6px;'>Select League</div>", unsafe_allow_html=True)
    with sel_col:
        selected_league = st.selectbox("league_select", LEAGUES, label_visibility="collapsed")

    st.markdown("<hr style='margin:8px 0;'>", unsafe_allow_html=True)

    disputes = DISPUTES.get(selected_league, [])

    if not disputes:
        st.markdown("<div style='font-family:monospace; color:#888; padding:20px;'>No disputes for this league.</div>", unsafe_allow_html=True)
        return

    # Dispute cards
    cards_html = ""
    for d in disputes:
        cards_html += f"""
        <div style="border:2px solid #333; border-radius:12px; padding:20px 24px; margin-bottom:12px; background:#f9f9f9;">
            <div style="display:flex; justify-content:space-between; align-items:flex-start;">
                <div>
                    <div style="font-family:monospace; font-size:17px; font-weight:bold; margin-bottom:8px;">{d['matchup']}</div>
                    <div style="font-family:monospace; font-size:15px; margin-bottom:4px;">Previous Score: {d['prev_score']}</div>
                    <div style="font-family:monospace; font-size:15px;">Corrected Score: {d['corrected_score']}</div>
                </div>
                <div style="text-align:right;">
                    <div style="font-family:monospace; font-size:14px; color:#444;">Submitted: {d['submitted']}</div>
                    <div style="font-family:monospace; font-size:14px; color:#444; margin-top:4px;">From: {d['from']}</div>
                </div>
            </div>
            <div style="display:flex; gap:16px; margin-top:16px;">
                <button style="flex:1; font-family:monospace; font-size:15px; padding:10px;
                    border:2px solid #2e7d32; color:#2e7d32; border-radius:999px;
                    background:white; cursor:pointer;">Accept</button>
                <button style="flex:1; font-family:monospace; font-size:15px; padding:10px;
                    border:2px solid #c61717; color:#c61717; border-radius:999px;
                    background:white; cursor:pointer;">Reject</button>
            </div>
        </div>"""

    st.html(f"""
    <div style="border:2px solid #333; border-radius:8px; padding:16px;">
        {cards_html}
    </div>
    """)

show()