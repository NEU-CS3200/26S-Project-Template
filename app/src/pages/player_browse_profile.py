import streamlit as st
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="player_persona")
# -------------------------------------------------------
# Athlete Season Data
# -------------------------------------------------------
SEASONS = [
    {
        "season": "Fall 2025",
        "sport": "Volleyball",
        "team": "Northeastern University",
        "stats": {
            "Games Played": 18,
            "Sets Played": 52,
            "Kills": 142,
            "Kills/Set": 2.73,
            "Assists": 34,
            "Digs": 89,
            "Aces": 12,
            "Blocks": 28,
            "Hitting %": ".312",
            "Errors": 21,
        },
    },
    {
        "season": "Spring 2025",
        "sport": "Volleyball",
        "team": "Northeastern University",
        "stats": {
            "Games Played": 14,
            "Sets Played": 40,
            "Kills": 108,
            "Kills/Set": 2.70,
            "Assists": 22,
            "Digs": 71,
            "Aces": 9,
            "Blocks": 19,
            "Hitting %": ".289",
            "Errors": 18,
        },
    },
    {
        "season": "Fall 2024",
        "sport": "Volleyball",
        "team": "Northeastern University",
        "stats": {
            "Games Played": 16,
            "Sets Played": 45,
            "Kills": 119,
            "Kills/Set": 2.64,
            "Assists": 18,
            "Digs": 65,
            "Aces": 7,
            "Blocks": 22,
            "Hitting %": ".271",
            "Errors": 24,
        },
    },
]

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            .profile-badge {
                display: inline-flex;
                align-items: center;
                gap: 14px;
                font-family: monospace;
                font-size: 32px;
                font-weight: 600;
            }
            .profile-initials {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                border: 2px solid #333;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                font-weight: bold;
                font-size: 20px;
                font-family: monospace;
            }
            .profile-role {
                font-family: monospace;
                font-size: 18px;
                color: #555;
                margin-left: 8px;
            }
            .season-card {
                border: 2px solid #333;
                margin-bottom: 20px;
                font-family: monospace;
            }
            .season-header {
                display: flex;
                gap: 40px;
                padding: 12px 16px;
                border-bottom: 2px solid #333;
                font-size: 16px;
                background-color: #f8f8f8;
            }
            .season-header span {
                font-weight: 500;
            }
            .stats-table {
                width: 100%;
                border-collapse: collapse;
                font-family: monospace;
                font-size: 14px;
            }
            .stats-table th {
                background-color: #f0f0f0;
                padding: 10px 14px;
                text-align: center;
                border: 1px solid #ddd;
                font-weight: bold;
            }
            .stats-table td {
                padding: 12px 14px;
                text-align: center;
                border: 1px solid #ddd;
            }
        </style>
    """, unsafe_allow_html=True)


# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    # Header
    first = st.session_state.get("first_name", "Yixi")
    last = st.session_state.get("last_name", "Xu")
    initials = (first[0]).upper() if first else "Y"
    full_name = f"{first}"

    col1, col2 = st.columns([3, 2])
    with col1:
        st.html(f"""
            <div style="display:flex; align-items:center; gap:14px;">
                <div class="profile-initials">{initials}</div>
                <span class="profile-badge" style="font-size:32px;">{full_name}</span>
            </div>
        """)

    st.markdown("<br>", unsafe_allow_html=True)

    # Season cards
    for s in SEASONS:
        stats = s["stats"]
        headers = "".join(f"<th>{k}</th>" for k in stats.keys())
        values = "".join(f"<td>{v}</td>" for v in stats.values())

        st.html(f"""
        <div class="season-card">
            <div class="season-header">
                <span>{s['season']}</span>
                <span>{s['sport']}</span>
                <span>{s['team']}</span>
            </div>
            <table class="stats-table">
                <thead><tr>{headers}</tr></thead>
                <tbody><tr>{values}</tr></tbody>
            </table>
        </div>
        """)


show()