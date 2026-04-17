import streamlit as st
from datetime import datetime
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="league_admin_persona")

# -------------------------------------------------------
# Mock Data
# -------------------------------------------------------
LEAGUES = ["Husky League", "Bull Games", "Ivy League"]

LEAGUE_DATA = {
    "Husky League": {
        "sport": "Volleyball",
        "roster_limit": 12,
        "skill_level": "Competitive",
        "season_start": "09/10/2025",
        "season_end": "12/06/2025",
    },
    "Bull Games": {
        "sport": "Basketball",
        "roster_limit": 10,
        "skill_level": "Recreational",
        "season_start": "01/15/2026",
        "season_end": "04/30/2026",
    },
    "Ivy League": {
        "sport": "Football",
        "roster_limit": 22,
        "skill_level": "Intermediate",
        "season_start": "08/01/2025",
        "season_end": "11/20/2025",
    },
}

TEAMS_DATA = {
    "Husky League": [
        {"name": "Team 1", "status": "Approved"},
        {"name": "Team 2", "status": "Pending"},
        {"name": "Team 3", "status": "Approved"},
        {"name": "Team 4", "status": "Pending"},
        {"name": "Team 5", "status": "Approved"},
    ],
    "Bull Games": [
        {"name": "Bulls A",   "status": "Approved"},
        {"name": "Bulls B",   "status": "Pending"},
        {"name": "Red Squad", "status": "Approved"},
    ],
    "Ivy League": [
        {"name": "Green Team", "status": "Approved"},
        {"name": "Gold Squad", "status": "Pending"},
        {"name": "Blue Crew",  "status": "Approved"},
        {"name": "Silver FC",  "status": "Pending"},
    ],
}

SPORTS       = ["Volleyball", "Basketball", "Football"]
SKILL_LEVELS = ["Beginner", "Recreational", "Intermediate", "Competitive"]
ROSTER_OPTS  = list(range(1, 101))

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            /* Hide all labels in the left panel */
            div[data-testid="stTextInput"] label,
            div[data-testid="stSelectbox"] label {
                display: none;
            }

            .row-label {
                font-family: monospace;
                font-size: 15px;
                text-align: right;
                padding-top: 10px;
                padding-right: 8px;
            }
        </style>
    """, unsafe_allow_html=True)

# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    st.markdown("<h1 style='font-family:monospace; text-align:center;'>Manage League</h1>", unsafe_allow_html=True)
    
    st.markdown("<br>", unsafe_allow_html=True)
    st.markdown("<br>", unsafe_allow_html=True)
    # Select League — real Streamlit dropdown
    lbl_col, sel_col, _ = st.columns([1.2, 2, 4])
    with lbl_col:
        st.markdown("<div style='font-family:monospace;font-size:20px;font-weight:bold;padding-top:6px;'>Select League</div>", unsafe_allow_html=True)
    with sel_col:
        selected_league = st.selectbox("league_select", LEAGUES, label_visibility="collapsed")

    data  = LEAGUE_DATA[selected_league]
    teams = TEAMS_DATA[selected_league]

    # Reset dates when league changes
    if st.session_state.get("_last_league") != selected_league:
        st.session_state["_last_league"]      = selected_league
        st.session_state["season_start_val"]  = data["season_start"]
        st.session_state["season_end_val"]    = data["season_end"]
    st.session_state.setdefault("season_start_val", data["season_start"])
    st.session_state.setdefault("season_end_val",   data["season_end"])
    st.markdown("<hr style='margin: 8px 0;'>", unsafe_allow_html=True)
    st.markdown("<br>", unsafe_allow_html=True)

    left, spacer, right = st.columns([5, 1, 6])

    # Aligned section headers
    with left:
        st.markdown("<div style='font-family:monospace;font-size:18px;font-weight:bold;margin-bottom:8px;'>&nbsp;</div>", unsafe_allow_html=True)
    with right:
        st.markdown("<div style='font-family:monospace;font-size:18px;font-weight:bold;margin-bottom:8px;'>Teams Configuration</div>", unsafe_allow_html=True)

    # ---- LEFT: League Config ----
    with left:
        def row(label, widget_fn):
            la, lb = st.columns([2, 3])
            with la:
                st.markdown(f"<div class='row-label'>{label}</div>", unsafe_allow_html=True)
            with lb:
                widget_fn()

        row("League Name",  lambda: st.text_input("league_name", value=selected_league, label_visibility="collapsed"))
        row("Sport:",        lambda: st.selectbox("sport", SPORTS, index=SPORTS.index(data["sport"]), label_visibility="collapsed"))
        row("Roster Limit:", lambda: st.selectbox("roster_limit", ROSTER_OPTS, index=ROSTER_OPTS.index(data["roster_limit"]), label_visibility="collapsed"))
        row("Skill Level",   lambda: st.selectbox("skill_level", SKILL_LEVELS, index=SKILL_LEVELS.index(data["skill_level"]), label_visibility="collapsed"))

        # Season Start
        la, lb = st.columns([2, 3])
        with la:
            st.markdown("<div class='row-label'>Season Start:</div>", unsafe_allow_html=True)
        with lb:
            new_start = st.text_input("season_start_input", value=st.session_state["season_start_val"], placeholder="MM/DD/YYYY", label_visibility="collapsed")
            if new_start != st.session_state["season_start_val"]:
                try:
                    datetime.strptime(new_start, "%m/%d/%Y")
                    st.session_state["season_start_val"] = new_start
                except ValueError:
                    st.warning("Use MM/DD/YYYY format.")

        # Season End
        la, lb = st.columns([2, 3])
        with la:
            st.markdown("<div class='row-label'>Season End:</div>", unsafe_allow_html=True)
        with lb:
            new_end = st.text_input("season_end_input", value=st.session_state["season_end_val"], placeholder="MM/DD/YYYY", label_visibility="collapsed")
            if new_end != st.session_state["season_end_val"]:
                try:
                    datetime.strptime(new_end, "%m/%d/%Y")
                    st.session_state["season_end_val"] = new_end
                except ValueError:
                    st.warning("Use MM/DD/YYYY format.")

        st.markdown("<br>", unsafe_allow_html=True)
        st.button("Finalize")
    
    with right:
        rows_html = ""
        for t in teams:
            if t["status"] == "Approved":
                status_html = "<span style='color:#2e7d32;font-weight:bold;font-family:monospace;'>Approved</span>"
                action_html = """<button style="font-family:monospace;padding:5px 14px;border:1.5px solid #c61717;
                                color:#c61717;border-radius:6px;background:white;cursor:pointer;">Remove</button>"""
            else:
                status_html = "<span style='color:#aaa;font-family:monospace;'>Pending</span>"
                action_html = """
                    <button style="font-family:monospace;padding:5px 14px;border:1.5px solid #2e7d32;
                        color:#2e7d32;border-radius:6px;background:white;cursor:pointer;margin-right:6px;">Accept</button>
                    <button style="font-family:monospace;padding:5px 14px;border:1.5px solid #c61717;
                        color:#c61717;border-radius:6px;background:white;cursor:pointer;">Reject</button>"""
            rows_html += f"""
            <tr>
                <td style="padding:11px 14px;font-family:monospace;border:1px solid #ddd;">{t['name']}</td>
                <td style="padding:11px 14px;border:1px solid #ddd;">{status_html}</td>
                <td style="padding:11px 14px;border:1px solid #ddd;">{action_html}</td>
            </tr>"""

        st.html(f"""
        <table style="width:100%;border-collapse:collapse;border:2px solid #333;font-family:monospace;font-size:15px;">
            <thead>
                <tr style="background:#f5f5f5;">
                    <th style="padding:10px 14px;border:1px solid #bbb;font-weight:bold;">Name</th>
                    <th style="padding:10px 14px;border:1px solid #bbb;font-weight:bold;">Status</th>
                    <th style="padding:10px 14px;border:1px solid #bbb;font-weight:bold;">Actions</th>
                </tr>
            </thead>
            <tbody>{rows_html}</tbody>
        </table>
        """)

show()