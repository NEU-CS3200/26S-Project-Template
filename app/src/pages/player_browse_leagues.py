import streamlit as st
from datetime import datetime
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="player_persona")

# -------------------------------------------------------
# League Data
# -------------------------------------------------------
LEAGUES = [
    {
        "sport": "Basketball",
        "league": "Mens",
        "regStart": datetime(2025, 8, 7),
        "regEnd": datetime(2025, 9, 5),
        "status": "Open",
        "seasonStart": datetime(2025, 9, 10),
        "seasonEnd": datetime(2025, 12, 6),
    },
    {
        "sport": "Volleyball",
        "league": "Womens",
        "regStart": datetime(2025, 8, 7),
        "regEnd": datetime(2025, 9, 5),
        "status": "Open",
        "seasonStart": datetime(2025, 9, 10),
        "seasonEnd": datetime(2025, 12, 6),
    },
    {
        "sport": "Hockey",
        "league": "Mens",
        "regStart": datetime(2025, 8, 7),
        "regEnd": datetime(2025, 9, 5),
        "status": "Closed",
        "seasonStart": datetime(2025, 9, 10),
        "seasonEnd": datetime(2025, 12, 6),
    },
    {
        "sport": "Soccer",
        "league": "Co-ed",
        "regStart": datetime(2025, 8, 7),
        "regEnd": datetime(2025, 9, 5),
        "status": "Open",
        "seasonStart": datetime(2025, 9, 10),
        "seasonEnd": datetime(2025, 12, 6),
    },
    {
        "sport": "Football",
        "league": "Mens",
        "regStart": datetime(2025, 8, 7),
        "regEnd": datetime(2025, 9, 5),
        "status": "Open",
        "seasonStart": datetime(2025, 9, 10),
        "seasonEnd": datetime(2025, 12, 6),
    },
]

SEASONS = ["Fall 2025", "Spring 2026", "Summer 2026"]

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_table_styles():
    st.markdown("""
        <style>
            .league-table {
                width: 100%;
                border-collapse: collapse;
                font-family: monospace;
                font-size: 15px;
                border: 2px solid #333;
            }
            .league-table th {
                background-color: #f0f0f0;
                padding: 12px 16px;
                text-align: left;
                border: 1px solid #ccc;
                font-weight: bold;
                font-size: 15px;
            }
            .league-table td {
                padding: 14px 16px;
                border: 1px solid #ddd;
                vertical-align: middle;
            }
            .league-table tr:hover td {
                background-color: #f9f9f9;
            }
            .status-open {
                color: #2e7d32;
                font-weight: bold;
            }
            .status-closed {
                color: #c61717;
                font-weight: bold;
            }
            .league-link {
                color: #1a56db;
                text-decoration: underline;
                cursor: pointer;
            }
            .search-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 12px;
            }
        </style>
    """, unsafe_allow_html=True)


# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_table_styles()

    st.title("Leagues")

    # Top controls row: season selector + search
    col1, col2 = st.columns([2, 3])
    with col1:
        selected_season = st.selectbox("Season", SEASONS, label_visibility="collapsed")
    with col2:
        search = st.text_input("Search", placeholder="Search...", label_visibility="collapsed")

    # Filter leagues by search term
    filtered = [
        l for l in LEAGUES
        if search.lower() in l["sport"].lower()
        or search.lower() in l["league"].lower()
        or search.lower() in l["status"].lower()
    ]

    # Build HTML table
    rows_html = ""
    for l in filtered:
        reg_range = f"{l['regStart'].strftime('%m/%d')} - {l['regEnd'].strftime('%m/%d')}"
        season_range = f"{l['seasonStart'].strftime('%m/%d')}-{l['seasonEnd'].strftime('%m/%d')}"
        status_class = "status-open" if l["status"] == "Open" else "status-closed"
        rows_html += f"""
        <tr>
            <td>{l['sport']}</td>
            <td><span class="league-link">{l['league']}</span></td>
            <td>{reg_range}</td>
            <td><span class="{status_class}">{l['status']}</span></td>
            <td>{season_range}</td>
        </tr>
        """

    table_html = f"""
    <table class="league-table">
        <thead>
            <tr>
                <th>Sport</th>
                <th>League</th>
                <th>Reg Start - End</th>
                <th>Status</th>
                <th>Season</th>
            </tr>
        </thead>
        <tbody>
            {rows_html if rows_html else '<tr><td colspan="5" style="text-align:center; padding:20px;">No leagues found.</td></tr>'}
        </tbody>
    </table>
    """

    st.html(table_html)


show()