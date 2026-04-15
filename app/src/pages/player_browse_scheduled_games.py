import streamlit as st
from datetime import datetime
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="player_persona")
# -------------------------------------------------------
# Schedule Data
# -------------------------------------------------------
GAMES = [
    {
        "location": "Matthew's Stadium",
        "home": "Northeastern University",
        "away": "Boston University",
        "time": datetime(2026, 3, 6, 15, 0),
    },
    {
        "location": "Fenway Stadium",
        "home": "Northeastern University",
        "away": "Bentley University",
        "time": datetime(2026, 3, 7, 15, 0),
    },
    {
        "location": "Matthew's Stadium",
        "home": "Northeastern University",
        "away": "Boston University",
        "time": datetime(2026, 3, 10, 15, 0),
    },
    {
        "location": "Fenway Stadium",
        "home": "Harvard University",
        "away": "Northeastern University",
        "time": datetime(2026, 3, 15, 15, 0),
    },
    {
        "location": "Matthew's Stadium",
        "home": "Northeastern University",
        "away": "Boston University",
        "time": datetime(2026, 3, 19, 15, 0),
    },
    {
        "location": "Fenway Stadium",
        "home": "Emerson College",
        "away": "Northeastern University",
        "time": datetime(2026, 3, 25, 15, 0),
    },
]

TRAININGS = [
    {
        "location": "Matthews Arena",
        "description": "Pre-season conditioning",
        "time": datetime(2026, 3, 4, 10, 0),
    },
    {
        "location": "Cabot Center",
        "description": "Skill drills",
        "time": datetime(2026, 3, 11, 10, 0),
    },
]

MEETINGS = [
    {
        "location": "Zoom",
        "description": "Team strategy review",
        "time": datetime(2026, 3, 5, 18, 0),
    },
    {
        "location": "Curry Student Center",
        "description": "Season kickoff",
        "time": datetime(2026, 3, 8, 17, 0),
    },
]

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            .schedule-table {
                width: 100%;
                border-collapse: collapse;
                font-family: monospace;
                font-size: 15px;
                border: 2px solid #333;
            }
            .schedule-table th {
                background-color: #f0f0f0;
                padding: 12px 16px;
                text-align: left;
                border: 1px solid #ccc;
                font-weight: bold;
            }
            .schedule-table td {
                padding: 14px 16px;
                border: 1px solid #ddd;
            }
            .schedule-table tr:hover td {
                background-color: #f9f9f9;
            }
            .profile-badge {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                font-family: monospace;
                font-size: 40px;
                font-weight: 600;
            }
            .profile-initials {
                width: 55px;
                height: 55px;
                border-radius: 50%;
                border: 2px solid #333;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 20px;
                font-family: monospace;
            }
        </style>
    """, unsafe_allow_html=True)


# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    # Header row: profile left, title right
    col1, col2 = st.columns([3, 2])
    with col1:
        # Get name from session state if available, else default
        first = st.session_state.get("first_name", "Yixi")
        initials = (first[0]).upper() if first else "Y"
        full_name = f"{first}"
        st.html(f"""
            <div class="profile-badge">
                <span class="profile-initials">{initials}</span>
                <span>{full_name}</span>
            </div>
        """)
    with col2:
        st.markdown("<h1 style='text-align:right; font-family:monospace;'>Schedule</h1>", unsafe_allow_html=True)

    st.markdown("<br>", unsafe_allow_html=True)

    # Tabs
    tab1, tab2, tab3 = st.tabs(["**Games**", "Trainings", "Meetings"])

    # --- Games Tab ---
    with tab1:
        rows_html = ""
        for g in GAMES:
            rows_html += f"""
            <tr>
                <td>{g['location']}</td>
                <td>{g['home']}</td>
                <td>{g['away']}</td>
                <td>{g['time'].strftime('%-m/%d/%Y %I:%M %p')}</td>
            </tr>
            """
        st.html(f"""
        <table class="schedule-table">
            <thead>
                <tr>
                    <th>Location</th>
                    <th>Home</th>
                    <th>Away</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>{rows_html}</tbody>
        </table>
        """)

    # --- Trainings Tab ---
    with tab2:
        rows_html = ""
        for t in TRAININGS:
            rows_html += f"""
            <tr>
                <td>{t['location']}</td>
                <td>{t['description']}</td>
                <td>{t['time'].strftime('%-m/%d/%Y %I:%M %p')}</td>
            </tr>
            """
        st.html(f"""
        <table class="schedule-table">
            <thead>
                <tr>
                    <th>Location</th>
                    <th>Description</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>{rows_html}</tbody>
        </table>
        """)

    # --- Meetings Tab ---
    with tab3:
        rows_html = ""
        for m in MEETINGS:
            rows_html += f"""
            <tr>
                <td>{m['location']}</td>
                <td>{m['description']}</td>
                <td>{m['time'].strftime('%-m/%d/%Y %I:%M %p')}</td>
            </tr>
            """
        st.html(f"""
        <table class="schedule-table">
            <thead>
                <tr>
                    <th>Location</th>
                    <th>Description</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>{rows_html}</tbody>
        </table>
        """)


show()