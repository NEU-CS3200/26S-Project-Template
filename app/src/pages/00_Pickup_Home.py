import logging

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot - Court Finder")

import pandas as pd
import pydeck as pdk
import requests

from modules.nav import SideBarLinks

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks()

# ---------------------------------------------------------------------------
# Session state defaults
# ---------------------------------------------------------------------------
player_id = st.session_state.get("player_id", 1)
first_name = st.session_state.get("first_name", "Marcus")

if "selected_court" not in st.session_state:
    st.session_state["selected_court"] = None
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
# Sidebar: player profile summary
# ---------------------------------------------------------------------------
player_data = fetch_player(player_id)
if player_data:
    st.sidebar.markdown("---")
    st.sidebar.markdown(f"### {first_name}")
    st.sidebar.caption(f"@{player_data.get('Username', '')}")
    col_a, col_b = st.sidebar.columns(2)
    col_a.metric("Games", player_data.get("GamesPlayed", 0))
    col_b.metric("Wins", player_data.get("Wins", 0))
    st.sidebar.caption(
        f"Skill {player_data.get('SkillRating', '?')} | "
        f"Rank #{player_data.get('SkillRank', '?')}"
    )

# ---------------------------------------------------------------------------
# Header
# ---------------------------------------------------------------------------
st.title("Court Finder")

# ---------------------------------------------------------------------------
# Filters
# ---------------------------------------------------------------------------
filter_cols = st.columns([2, 2, 2, 4])
with filter_cols[0]:
    skill_filter = st.selectbox(
        "Skill Level",
        ["All Levels", "Beginner", "Intermediate", "Advanced"],
        label_visibility="collapsed",
    )
with filter_cols[1]:
    type_filter = st.selectbox(
        "Court Type",
        ["All", "Outdoor", "Indoor"],
        label_visibility="collapsed",
    )
with filter_cols[2]:
    sort_by = st.selectbox(
        "Sort",
        ["Most Active", "Court Name"],
        label_visibility="collapsed",
    )
with filter_cols[3]:
    search_query = st.text_input(
        "Search",
        placeholder="Search courts...",
        label_visibility="collapsed",
    )

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
        df["lat"] = df["Latitude"].astype(float)
        df["lon"] = df["Longitude"].astype(float)
        df["players"] = df["ActivePlayerCount"].astype(int)

        # Color: green when players are active, gray when empty
        def row_color(row):
            if row["players"] > 5:
                return [34, 197, 94, 200]  # green
            if row["players"] > 0:
                return [59, 130, 246, 200]  # blue
            return [156, 163, 175, 160]  # gray

        df["color"] = df.apply(row_color, axis=1)
        # Radius scales with player count (min 60, max 200)
        df["radius"] = df["players"].apply(lambda p: max(60, min(200, 60 + p * 20)))

        center_lat = df["lat"].mean()
        center_lon = df["lon"].mean()

        layer = pdk.Layer(
            "ScatterplotLayer",
            data=df,
            get_position=["lon", "lat"],
            get_radius="radius",
            get_fill_color="color",
            pickable=True,
            auto_highlight=True,
        )

        view_state = pdk.ViewState(
            latitude=center_lat,
            longitude=center_lon,
            zoom=12,
            pitch=0,
        )

        deck = pdk.Deck(
            layers=[layer],
            initial_view_state=view_state,
            tooltip={
                "text": "{CourtName}\n{players} active players",
            },
            map_style="mapbox://styles/mapbox/light-v11",
        )

        st.pydeck_chart(deck, use_container_width=True, height=480)

        st.caption("🟢 5+ players  🔵 1-5 players  ⚪ Empty")

    # -- Court list ---------------------------------------------------------
    with list_col:
        st.markdown(f"**{len(courts)} courts found**")

        for court in courts:
            court_id = court["CourtId"]
            name = court["CourtName"]
            neighborhood = court.get("NeighborhoodName", "")
            skill = court.get("SkillLevel", "")
            ctype = court.get("CourtType", "")
            active = court.get("ActivePlayerCount", 0)
            is_checked_in_here = st.session_state["checked_in_court_id"] == court_id

            # Status indicator
            if active > 5:
                status = "🟢 Active"
            elif active > 0:
                status = "🔵 Open"
            else:
                status = "⚪ Quiet"

            with st.container(border=True):
                row = st.columns([5, 2])
                with row[0]:
                    st.markdown(f"**{name}**")
                    st.caption(f"{neighborhood} · {ctype} · {skill}")
                    st.caption(
                        f"{status} · {active} player{'s' if active != 1 else ''}"
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

                    # Detail expander button
                    if st.button(
                        "Details",
                        key=f"detail_{court_id}",
                        use_container_width=True,
                    ):
                        st.session_state["selected_court"] = court_id
                        st.rerun()

# ---------------------------------------------------------------------------
# Court detail panel
# ---------------------------------------------------------------------------
if st.session_state.get("selected_court"):
    st.markdown("---")
    detail = fetch_court_detail(st.session_state["selected_court"])
    if detail:
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
            st.markdown(
                "**Amenities:** " + " · ".join(a["AmenityName"] for a in amenities)
            )

        if st.button("Close", key="close_detail"):
            st.session_state["selected_court"] = None
            st.rerun()
