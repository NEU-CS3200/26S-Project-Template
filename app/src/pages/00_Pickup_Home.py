import logging

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot - Court Finder")

import pandas as pd
import pydeck as pdk
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
/* Status badges */
.status-badge {
    display: inline-flex;
    align-items: center;
    gap: 4px;
    padding: 3px 10px;
    border-radius: 20px;
    font-size: 0.7rem;
    font-weight: 600;
    font-family: 'Outfit', sans-serif;
    letter-spacing: 0.04em;
    text-transform: uppercase;
    vertical-align: middle;
}
.status-badge.active {
    background: rgba(34, 197, 94, 0.12);
    color: #4ADE80;
}
.status-badge.open {
    background: rgba(59, 130, 246, 0.12);
    color: #60A5FA;
}
.status-badge.quiet {
    background: rgba(100, 116, 139, 0.08);
    color: #94A3B8;
}

/* Player count text */
.player-count {
    font-size: 0.85rem;
    color: #94A3B8;
    font-family: 'Outfit', sans-serif;
}
.player-count strong {
    color: #E2E8F0;
    font-weight: 600;
}

/* Map container */
[data-testid="stDeckGlJsonChart"] iframe {
    border-radius: 14px !important;
}

/* Legend bar */
.map-legend {
    display: flex;
    gap: 1rem;
    align-items: center;
    font-family: 'Outfit', sans-serif;
    font-size: 0.75rem;
    color: #94A3B8;
    padding: 0.5rem 0;
}
.legend-dot {
    width: 8px;
    height: 8px;
    border-radius: 50%;
    display: inline-block;
    margin-right: 4px;
}

/* Court count header */
.court-count {
    font-family: 'Outfit', sans-serif;
    font-size: 0.9rem;
    color: #94A3B8;
    margin-bottom: 0.75rem;
}
.court-count strong {
    color: #F1F5F9;
    font-weight: 700;
}
"""

st.markdown(inject_css(PAGE_CSS), unsafe_allow_html=True)

# ---------------------------------------------------------------------------
# Session state defaults
# ---------------------------------------------------------------------------
player_id = st.session_state.get("player_id", 1)
first_name = st.session_state.get("first_name", "Marcus")

if "active_checkin_id" not in st.session_state:
    st.session_state["active_checkin_id"] = None
if "checked_in_court_id" not in st.session_state:
    st.session_state["checked_in_court_id"] = None

# ---------------------------------------------------------------------------
# Data fetching helpers
# ---------------------------------------------------------------------------


def fetch_courts(skill_level=None, court_type=None):
    params = {}
    if skill_level and skill_level != "All Levels":
        params["skill_level"] = skill_level
    if court_type and court_type != "All":
        params["court_type"] = court_type
    try:
        resp = requests.get(f"{API_BASE}/court/courts", params=params, timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch courts: {e}")
        return []


def fetch_court_detail(court_id):
    try:
        resp = requests.get(f"{API_BASE}/court/courts/{court_id}", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch court {court_id}: {e}")
        return None


def fetch_player(pid):
    try:
        resp = requests.get(f"{API_BASE}/player/players/{pid}", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch player {pid}: {e}")
        return None


def fetch_court_reviews(court_id):
    try:
        resp = requests.get(f"{API_BASE}/court/courts/{court_id}/reviews", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch reviews for court {court_id}: {e}")
        return []


def do_checkin(pid, court_id):
    try:
        resp = requests.post(
            f"{API_BASE}/player/checkins",
            json={"PlayerId": pid, "CourtId": court_id},
            timeout=5,
        )
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Check-in failed: {e}")
        return None


def do_checkout(checkin_id):
    try:
        resp = requests.put(
            f"{API_BASE}/player/checkins/{checkin_id}/checkout", timeout=5
        )
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Check-out failed: {e}")
        return None


# ---------------------------------------------------------------------------
# Sidebar: player profile
# ---------------------------------------------------------------------------
player_data = fetch_player(player_id)
if player_data:
    st.sidebar.markdown("---")
    st.sidebar.markdown(
        f"""
        <div style="
            background: linear-gradient(
                135deg,
                rgba(249,115,22,0.06) 0%,
                rgba(22,32,50,0.4) 100%
            );
            border: 1px solid rgba(249,115,22,0.1);
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
                    ">Skill</div>
                    <div style="
                        font-family:'Outfit',sans-serif;
                        font-size:1.4rem;
                        font-weight:700;
                        color:#F97316;
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
st.title("Court Finder")
st.caption("Find pickup games near you")

# ---------------------------------------------------------------------------
# Filters
# ---------------------------------------------------------------------------
filter_cols = st.columns([2, 2, 2, 4])
with filter_cols[0]:
    skill_filter = st.selectbox(
        "Skill Level",
        ["All Levels", "Beginner", "Intermediate", "Advanced"],
    )
with filter_cols[1]:
    type_filter = st.selectbox(
        "Court Type",
        ["All", "Outdoor", "Indoor"],
    )
with filter_cols[2]:
    sort_by = st.selectbox(
        "Sort By",
        ["Most Active", "Court Name"],
    )
with filter_cols[3]:
    search_query = st.text_input(
        "Search",
        placeholder="Search courts...",
    )

# ---------------------------------------------------------------------------
# Court detail dialog
# ---------------------------------------------------------------------------


@st.dialog("Court Details", width="large")
def show_court_dialog(court_id):
    detail = fetch_court_detail(court_id)
    if not detail:
        st.error("Could not load court details.")
        return

    st.subheader(detail["CourtName"])
    info_cols = st.columns(4)
    info_cols[0].metric("Hoops", detail.get("HoopCount", "?"))
    info_cols[1].metric("Surface", detail.get("SurfaceType", "?"))
    info_cols[2].metric("Type", detail.get("CourtType", "?"))
    info_cols[3].metric("Skill", detail.get("SkillLevel", "?"))

    st.caption(
        f"📍 {detail.get('Address', '')} · "
        f"{detail.get('NeighborhoodName', '')} · "
        f"Hours: {detail.get('Hours', 'N/A')}"
    )

    amenities = detail.get("amenities", [])
    if amenities:
        st.markdown("**Amenities:** " + " · ".join(a["AmenityName"] for a in amenities))

    # -- Reviews --------------------------------------------------------------
    reviews = fetch_court_reviews(court_id)
    if reviews:
        avg_rating = sum(float(r["Rating"]) for r in reviews) / len(reviews)
        avg_condition = sum(float(r["ConditionRating"]) for r in reviews) / len(reviews)

        st.markdown("---")
        rev_cols = st.columns(3)
        rev_cols[0].metric("Avg Rating", f"{avg_rating:.1f} / 5")
        rev_cols[1].metric("Court Condition", f"{avg_condition:.1f} / 5")
        rev_cols[2].metric("Reviews", len(reviews))

        st.markdown("**Recent Reviews**")
        for review in reviews[:5]:
            filled = round(float(review["Rating"]))
            stars_html = (
                f'<span style="color:#F97316;">{"★" * filled}</span>'
                f'<span style="color:#334155;">{"★" * (5 - filled)}</span>'
            )
            comment = review.get("Comment", "")
            username = review.get("Username", "Anonymous")
            st.markdown(
                f"**{username}** {stars_html}  \n{comment}"
                if comment
                else f"**{username}** {stars_html}",
                unsafe_allow_html=True,
            )
    else:
        st.caption("No reviews yet.")


# ---------------------------------------------------------------------------
# Fetch and filter courts
# ---------------------------------------------------------------------------
courts = fetch_courts(skill_level=skill_filter, court_type=type_filter)

if search_query:
    q = search_query.lower()
    courts = [
        c
        for c in courts
        if q in c.get("CourtName", "").lower()
        or q in c.get("NeighborhoodName", "").lower()
        or q in c.get("Address", "").lower()
    ]

if sort_by == "Court Name":
    courts.sort(key=lambda c: c.get("CourtName", ""))

# ---------------------------------------------------------------------------
# Map + Court List layout
# ---------------------------------------------------------------------------
if not courts:
    st.info("No courts match your filters. Try broadening your search.")
else:
    map_col, list_col = st.columns([3, 2])

    # -- Map ----------------------------------------------------------------
    with map_col:
        df = pd.DataFrame(courts)
        df["latitude"] = df["Latitude"].astype(float)
        df["longitude"] = df["Longitude"].astype(float)
        df["players"] = df["ActivePlayerCount"].astype(int)

        # Color based on activity (RGBA)
        def court_color(players):
            if players > 5:
                return [74, 222, 128, 200]  # green
            if players > 0:
                return [96, 165, 250, 200]  # blue
            return [148, 163, 184, 120]  # gray

        df["color"] = df["players"].apply(court_color)
        df["radius"] = df["players"].apply(lambda p: max(60, min(250, 60 + p * 30)))

        layer = pdk.Layer(
            "ScatterplotLayer",
            data=df,
            get_position=["longitude", "latitude"],
            get_fill_color="color",
            get_radius="radius",
            pickable=True,
            radius_min_pixels=6,
            radius_max_pixels=30,
        )

        view_state = pdk.ViewState(
            latitude=df["latitude"].mean(),
            longitude=df["longitude"].mean(),
            zoom=11,
            pitch=0,
        )

        tooltip = {
            "html": "<b>{CourtName}</b><br/>{players} players",
            "style": {
                "backgroundColor": "#1E293B",
                "color": "#F1F5F9",
                "border": "1px solid rgba(255,255,255,0.1)",
                "borderRadius": "8px",
                "padding": "8px 12px",
                "fontFamily": "Outfit, sans-serif",
                "fontSize": "13px",
            },
        }

        deck = pdk.Deck(
            layers=[layer],
            initial_view_state=view_state,
            map_style="dark",
            tooltip=tooltip,
        )

        map_container = st.empty()
        map_container.pydeck_chart(deck, use_container_width=True)

        legend_col, btn_col = st.columns([3, 1])
        legend_col.markdown(
            """
            <div class="map-legend">
                <span><span class="legend-dot" style="background:#4ADE80;"></span>
                5+ players</span>
                <span><span class="legend-dot" style="background:#60A5FA;"></span>
                1-5 players</span>
                <span><span class="legend-dot" style="background:#94A3B8;"></span>
                Empty</span>
            </div>
            """,
            unsafe_allow_html=True,
        )
        if btn_col.button("Re-center", use_container_width=True):
            map_container.empty()
            map_container.pydeck_chart(deck, use_container_width=True)

    # -- Court list ---------------------------------------------------------
    with list_col:
        st.markdown(
            f'<div class="court-count"><strong>{len(courts)}</strong> courts found</div>',
            unsafe_allow_html=True,
        )

        for court in courts:
            court_id = court["CourtId"]
            name = court["CourtName"]
            neighborhood = court.get("NeighborhoodName", "")
            skill = court.get("SkillLevel", "")
            ctype = court.get("CourtType", "")
            active = court.get("ActivePlayerCount", 0)
            is_checked_in_here = st.session_state["checked_in_court_id"] == court_id

            # Status badge
            if active > 5:
                badge = '<span class="status-badge active">Active</span>'
            elif active > 0:
                badge = '<span class="status-badge open">Open</span>'
            else:
                badge = '<span class="status-badge quiet">Quiet</span>'

            with st.container(border=True):
                row = st.columns([5, 2])
                with row[0]:
                    st.markdown(
                        f"**{name}** &nbsp;{badge}",
                        unsafe_allow_html=True,
                    )
                    st.caption(f"{neighborhood} · {ctype} · {skill}")
                    st.markdown(
                        f'<span class="player-count">'
                        f"<strong>{active}</strong> "
                        f"player{'s' if active != 1 else ''} checked in</span>",
                        unsafe_allow_html=True,
                    )
                with row[1]:
                    if is_checked_in_here:
                        if st.button(
                            "Check Out",
                            key=f"checkout_{court_id}",
                            type="secondary",
                            use_container_width=True,
                        ):
                            result = do_checkout(st.session_state["active_checkin_id"])
                            if result:
                                st.session_state["active_checkin_id"] = None
                                st.session_state["checked_in_court_id"] = None
                                st.toast("Checked out!")
                                st.rerun()
                    elif st.session_state["checked_in_court_id"] is not None:
                        st.button(
                            "Check In",
                            key=f"checkin_{court_id}",
                            disabled=True,
                            use_container_width=True,
                        )
                    else:
                        if st.button(
                            "Check In",
                            key=f"checkin_{court_id}",
                            type="primary",
                            use_container_width=True,
                        ):
                            result = do_checkin(player_id, court_id)
                            if result and "CheckInId" in result:
                                st.session_state["active_checkin_id"] = result[
                                    "CheckInId"
                                ]
                                st.session_state["checked_in_court_id"] = court_id
                                st.toast(f"Checked in at {name}!")
                                st.rerun()
                            else:
                                st.error("Check-in failed. Try again.")

                    # Detail dialog button
                    if st.button(
                        "Details",
                        key=f"detail_{court_id}",
                        use_container_width=True,
                    ):
                        show_court_dialog(court_id)
