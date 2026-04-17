import streamlit as st
from datetime import datetime, timedelta
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="league_admin_persona")

# -------------------------------------------------------
# Mock Data
# -------------------------------------------------------
VENUES = ["Matthew's Arena", "Fenway Stadium"]

# Bookings: venue -> list of {date, hour, courts[]}
from datetime import date

BOOKINGS = {
    "Matthew's Arena": [
        {"date": date(2026, 4, 13), "hour": 15, "courts": ["Court 1"]},
        {"date": date(2026, 4, 14), "hour": 16, "courts": ["Court 1"]},
        {"date": date(2026, 4, 15), "hour": 17, "courts": ["Court 2"]},
        {"date": date(2026, 4, 16), "hour": 17, "courts": ["Court 2"]},
        {"date": date(2026, 4, 17), "hour": 17, "courts": ["Court 1"]},
        {"date": date(2026, 4, 19), "hour": 16, "courts": ["Court 2"]},
        {"date": date(2026, 4, 19), "hour": 18, "courts": ["Court 3", "Court 4"]},
        {"date": date(2026, 4, 21), "hour": 9,  "courts": ["Court 1"]},
        {"date": date(2026, 4, 21), "hour": 11, "courts": ["Court 2", "Court 3"]},
        {"date": date(2026, 4, 22), "hour": 14, "courts": ["Court 1"]},
        {"date": date(2026, 4, 23), "hour": 19, "courts": ["Court 2"]},
    ],
    "Fenway Stadium": [
        {"date": date(2026, 4, 13), "hour": 10, "courts": ["Field A"]},
        {"date": date(2026, 4, 14), "hour": 13, "courts": ["Field B"]},
        {"date": date(2026, 4, 15), "hour": 15, "courts": ["Field A", "Field B"]},
        {"date": date(2026, 4, 17), "hour": 18, "courts": ["Field A"]},
        {"date": date(2026, 4, 18), "hour": 9,  "courts": ["Field B"]},
        {"date": date(2026, 4, 19), "hour": 11, "courts": ["Field A"]},
        {"date": date(2026, 4, 20), "hour": 16, "courts": ["Field B", "Field C"]},
    ],
}

HOURS = list(range(6, 22))  # 6AM to 10PM (last slot = 9PM start)
DAYS = ["Mon", "Tues", "Wed", "Thurs", "Fri", "Sat", "Sun"]

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            .venue-table {
                width: 100%;
                border-collapse: collapse;
                font-family: monospace;
                font-size: 14px;
                border: 2px solid #333;
            }
            .venue-table th {
                border: 1.5px solid #555;
                padding: 10px 6px;
                text-align: center;
                background: #f5f5f5;
                font-weight: bold;
                font-size: 15px;
            }
            .venue-table td {
                border: 1px solid #bbb;
                padding: 8px 6px;
                vertical-align: top;
                min-width: 90px;
                min-height: 60px;
                height: 60px;
            }
            .time-cell {
                font-weight: bold;
                font-size: 15px;
                text-align: right;
                padding-right: 10px;
                white-space: nowrap;
                background: #fafafa;
                border-right: 2px solid #555 !important;
                width: 80px;
            }
            .week-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                border: 2px solid #333;
                border-bottom: 2px solid #555;
                padding: 10px 16px;
                font-family: monospace;
                font-size: 18px;
                font-weight: bold;
                background: #f9f9f9;
            }
            .court-chip {
                display: inline-block;
                border: 1.5px solid #555;
                border-radius: 4px;
                padding: 3px 8px;
                margin: 2px 5px 2px 0;
                font-size: 13px;
                font-family: monospace;
                background: white;
                white-space: nowrap;
            }
            .select-venue-label {
                font-family: monospace;
                font-size: 18px;
                font-weight: bold;
                margin-right: 10px;
            }
        </style>
    """, unsafe_allow_html=True)

# -------------------------------------------------------
# Helpers
# -------------------------------------------------------
def get_week_start(d):
    """Get Monday of the week containing date d."""
    return d - timedelta(days=d.weekday())

def fmt_hour(h):
    if h == 12:
        return "12:00pm"
    elif h > 12:
        return f"{h-12}:00pm"
    else:
        return f"{h}:00am"

# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    st.markdown("<h1 style='font-family:monospace; text-align:center;'>Venue Schedule</h1>", unsafe_allow_html=True)

    # Session state for week offset and venue
    if "week_offset" not in st.session_state:
        st.session_state["week_offset"] = 0

    # Select Venue row
    col_label, col_select = st.columns([1, 3])
    with col_label:
        st.markdown("<div style='font-family:monospace; font-size:18px; font-weight:bold; padding-top:8px;'>Select Venue</div>", unsafe_allow_html=True)
    with col_select:
        selected_venue = st.selectbox("venue", VENUES, label_visibility="collapsed")

    # Compute week
    today = date.today()
    week_start = get_week_start(today) + timedelta(weeks=st.session_state["week_offset"])
    week_dates = [week_start + timedelta(days=i) for i in range(7)]
    week_label = f"Week of {week_start.strftime('%-m/%-d/%Y')}"

    # Build booking lookup: {date: {hour: [courts]}}
    bookings = BOOKINGS.get(selected_venue, [])
    lookup = {}
    for b in bookings:
        lookup.setdefault(b["date"], {}).setdefault(b["hour"], []).extend(b["courts"])

    # Week nav header
    nav_col1, nav_col2, nav_col3 = st.columns([1, 8, 1])
    with nav_col1:
        if st.button("＜", use_container_width=True):
            st.session_state["week_offset"] -= 1
            st.rerun()
    with nav_col2:
        st.markdown(
            f"<div style='text-align:center; font-family:monospace; font-size:18px; font-weight:bold; padding-top:6px;'>{week_label}</div>",
            unsafe_allow_html=True,
        )
    with nav_col3:
        if st.button("＞", use_container_width=True):
            st.session_state["week_offset"] += 1
            st.rerun()

    # Build calendar table HTML
    # Header row
    header_cells = "<th style='width:80px;'></th>"
    for i, day in enumerate(DAYS):
        d = week_dates[i]
        header_cells += f"<th>{day}<br><span style='font-weight:normal;font-size:12px;'>{d.strftime('%-m/%-d')}</span></th>"

    rows_html = ""
    for hour in HOURS:
        time_label = fmt_hour(hour)
        row = f"<td class='time-cell'>{time_label}</td>"
        for i in range(7):
            d = week_dates[i]
            courts = lookup.get(d, {}).get(hour, [])
            if courts:
                chips = "".join(f"<div class='court-chip'>{c}</div>" for c in courts)
                row += f"<td>{chips}</td>"
            else:
                row += "<td></td>"
        rows_html += f"<tr>{row}</tr>"

    table_html = f"""
    <div style="overflow-x:auto;">
        <table class="venue-table">
            <thead><tr>{header_cells}</tr></thead>
            <tbody>{rows_html}</tbody>
        </table>
    </div>
    """
    st.html(table_html)

show()