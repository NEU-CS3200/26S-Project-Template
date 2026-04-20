# Persona: Maya Chen (CUSTOMER)
# Maya-1: Search & filter venues by name, city, category, vibe, price  [Discover tab]
# Maya-2: Save venues to personal lists                                  [My Lists > Saved tab]
# Maya-5: Mark venues as visited / unmark                               [My Lists > Visited tab]
# Maya-6: Find similar venues based on a saved spot                     [My Lists > Similar Venues tab]
import streamlit as st

from modules.nav import SideBarLinks
from modules.api_client import api_get, api_post, api_delete, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

user_id = st.session_state.get("user_id", 1)

if "save_msgs" not in st.session_state:
    st.session_state.save_msgs = {}
if "list_msgs" not in st.session_state:
    st.session_state.list_msgs = {}
if "active_vibes" not in st.session_state:
    st.session_state.active_vibes = set()

st.title("Venues")

tab_discover, tab_lists = st.tabs(["🔍 Discover", "🔖 My Lists"])


# ── Helpers ───────────────────────────────────────────────────────────────────
def safe_float(val):
    try:
        return float(val)
    except (TypeError, ValueError):
        return None

def stars_str(rating):
    r = int(round(rating))
    return "★" * r + "☆" * (5 - r)

def venue_card(v, key_prefix):
    vid = v["venueId"]
    rating = safe_float(v.get("rating")) or 0.0
    price_min = safe_float(v.get("minPrice"))
    price_max = safe_float(v.get("maxPrice"))
    price_str = ""
    if price_min is not None and price_max is not None:
        price_str = f" · ${int(price_min)}–${int(price_max)}"
    elif price_min is not None:
        price_str = f" · From ${int(price_min)}"

    with st.container(border=True):
        left, right = st.columns([4, 1])
        with left:
            img_col, info_col = st.columns([1, 3])
            with img_col:
                st.markdown(
                    """<div style="background:#e8e0f0;border-radius:12px;height:110px;
                       display:flex;align-items:center;justify-content:center;font-size:2rem;">🏛️</div>""",
                    unsafe_allow_html=True,
                )
            with info_col:
                st.markdown(f"### {v['name']}")
                st.markdown(f"{stars_str(rating)} **{round(rating, 1)}**{price_str}")
                st.caption(f"📍 {v.get('city', '')}  {v.get('address', '')}")
                if v.get("description"):
                    desc = v["description"]
                    st.write(desc[:160] + ("…" if len(desc) > 160 else ""))
                tags = []
                if v.get("categories"):
                    tags += [f"🏷 {c.strip()}" for c in v["categories"].split(",")]
                if v.get("vibes"):
                    tags += [f"✨ {b.strip()}" for b in v["vibes"].split(",")]
                if tags:
                    st.markdown(" &nbsp; ".join([f"`{t}`" for t in tags]), unsafe_allow_html=True)
        with right:
            st.markdown("<br>", unsafe_allow_html=True)
            save_key = f"{key_prefix}_{vid}"
            if st.button("🔖 Save", key=save_key, use_container_width=True, type="primary"):
                _, save_err = api_post(f"/users/{user_id}/saved", {"venueId": vid})
                if save_err:
                    if "Duplicate" in save_err or "1062" in save_err:
                        st.session_state.save_msgs[save_key] = ("info", "Already saved!")
                    else:
                        st.session_state.save_msgs[save_key] = ("error", save_err)
                else:
                    st.session_state.save_msgs[save_key] = ("success", "Saved!")
                st.rerun()
            msg = st.session_state.save_msgs.get(save_key)
            if msg:
                if msg[0] == "success":
                    st.success(msg[1])
                elif msg[0] == "info":
                    st.info(msg[1])
                else:
                    st.error(msg[1])


# ══════════════════════════════════════════════════════════════════════════════
# TAB 1 — DISCOVER
# ══════════════════════════════════════════════════════════════════════════════
with tab_discover:
    st.caption("Find your next perfect date spot")
    st.caption("📌 Covers: Maya-1 (search & filter venues) · Maya-2 (save to lists)")

    search_q = st.text_input("", placeholder="Search restaurants, bars, parks...", label_visibility="collapsed", key="dv_search")

    VIBE_LABELS = ["Romantic", "Cozy", "Adventurous", "Casual", "Fancy"]
    vibes_data, _ = api_get("/vibes")
    vibe_map = {v["name"]: v["vibeId"] for v in vibes_data} if vibes_data else {}

    st.markdown("**Vibe**")
    vibe_cols = st.columns(len(VIBE_LABELS))
    for i, label in enumerate(VIBE_LABELS):
        with vibe_cols[i]:
            active = label in st.session_state.active_vibes
            if st.button(label, key=f"vibe_{label}", type="primary" if active else "secondary", use_container_width=True):
                st.session_state.active_vibes = set() if active else {label}
                st.rerun()

    f1, f2, f3 = st.columns(3)
    with f1:
        price_range = st.selectbox("Price Range", ["Any", "$", "$$", "$$$", "$$$$"])
    with f2:
        cats_data, _ = api_get("/categories")
        cat_map = {}
        cat_options = ["Any"]
        if cats_data:
            cat_map = {c["name"]: c["categoryId"] for c in cats_data}
            cat_options += list(cat_map.keys())
        date_type = st.selectbox("Date Type", cat_options)
    with f3:
        city_filter = st.text_input("City", placeholder="e.g. Boston", key="dv_city")

    params = {}
    if search_q.strip():
        params["q"] = search_q.strip()
    if city_filter.strip():
        params["city"] = city_filter.strip()
    if date_type != "Any":
        params["category_id"] = cat_map.get(date_type)
    if st.session_state.active_vibes:
        chosen_vibe = next(iter(st.session_state.active_vibes))
        if chosen_vibe in vibe_map:
            params["vibe_id"] = vibe_map[chosen_vibe]
    if price_range != "Any":
        params["max_price"] = {"$": 15, "$$": 35, "$$$": 75, "$$$$": 999}[price_range]

    st.divider()

    if params:
        # Active search — show filtered results
        venues, err = api_get("/venues/search", params=params)
        if err:
            show_api_error(err)
            st.stop()
        st.markdown(f"**{len(venues) if venues else 0} venues found**")
        if not venues:
            st.info("No venues match your filters. Try broadening your search.")
        else:
            for v in venues:
                venue_card(v, "search")
    else:
        # No filters — show community picks as default
        st.markdown("### 🌟 Community Picks")
        st.caption("Top-rated spots across all PinDate users — search or filter above to find your own")
        top, _ = api_get("/venues/search", params={"min_rating": 4.5})
        if top:
            for v in top:
                venue_card(v, "comm")
        else:
            st.info("No top-rated venues yet.")


# ══════════════════════════════════════════════════════════════════════════════
# TAB 2 — MY LISTS
# ══════════════════════════════════════════════════════════════════════════════
with tab_lists:
    saved, saved_err = api_get(f"/users/{user_id}/saved")
    visited, visited_err = api_get(f"/users/{user_id}/visited")

    saved = saved or []
    visited = visited or []

    st.caption("📌 Covers: Maya-2 (saved lists) · Maya-5 (visited places) · Maya-6 (similar venues)")
    sub_saved, sub_visited, sub_similar = st.tabs([
        f"🔖 Saved ({len(saved)})",
        f"📍 Visited ({len(visited)})",
        "✨ Similar Venues",
    ])

    # ── Saved ──────────────────────────────────────────────────────────────────
    with sub_saved:
        if saved_err:
            show_api_error(saved_err)
        elif not saved:
            st.info("You haven't saved any venues yet. Use Discover to find some!")
        else:
            for v in saved:
                vid = v["venueId"]
                rating = safe_float(v.get("rating")) or 0.0

                with st.container(border=True):
                    top_left, top_right = st.columns([5, 1])
                    with top_left:
                        img_col, info_col = st.columns([1, 4])
                        with img_col:
                            st.markdown(
                                """<div style="background:#e8e0f0;border-radius:12px;height:90px;
                                   display:flex;align-items:center;justify-content:center;font-size:2rem;">🏛️</div>""",
                                unsafe_allow_html=True,
                            )
                        with info_col:
                            st.markdown(f"### {v['name']}")
                            st.markdown(f"{stars_str(rating)} **{round(rating, 1)}**")
                            st.caption(f"📍 {v.get('city', '')}  {v.get('address', '')}")
                            saved_at = str(v.get("savedAt", ""))[:10]
                            if saved_at:
                                st.caption(f"Saved on {saved_at}")
                    with top_right:
                        st.markdown("<br>", unsafe_allow_html=True)
                        if st.button("✅ Visited", key=f"vis_{vid}", use_container_width=True):
                            _, v_err = api_post(f"/users/{user_id}/visited", {"venueId": vid})
                            if v_err and "Duplicate" not in v_err and "1062" not in v_err:
                                st.session_state.list_msgs[f"vis_{vid}"] = ("error", v_err)
                            else:
                                st.session_state.list_msgs[f"vis_{vid}"] = ("success", "Marked visited!")
                            st.rerun()
                        if st.button("🗑 Remove", key=f"unsave_{vid}", use_container_width=True):
                            _, d_err = api_delete(f"/users/{user_id}/saved", {"venueId": vid})
                            if d_err:
                                st.session_state.list_msgs[f"unsave_{vid}"] = ("error", d_err)
                            else:
                                st.session_state.list_msgs[f"unsave_{vid}"] = ("success", "Removed!")
                            st.rerun()
                        for key in [f"vis_{vid}", f"unsave_{vid}"]:
                            msg = st.session_state.list_msgs.get(key)
                            if msg:
                                if msg[0] == "success":
                                    st.success(msg[1])
                                else:
                                    st.error(msg[1])

                    with st.expander("📝 My Notes"):
                        note_key = f"note_{vid}"
                        note_text = st.text_area(
                            "Note",
                            value=st.session_state.get(note_key, ""),
                            key=f"note_input_{vid}",
                            placeholder="e.g. Great for anniversaries, ask for the corner table",
                            label_visibility="collapsed",
                        )
                        if st.button("Save Note", key=f"save_note_{vid}"):
                            st.session_state[note_key] = note_text
                            st.success("Note saved!")

    # ── Visited ────────────────────────────────────────────────────────────────
    with sub_visited:
        if visited_err:
            show_api_error(visited_err)
        elif not visited:
            st.info("You haven't marked any venues as visited yet.")
        else:
            for v in visited:
                vid = v["venueId"]
                rating = safe_float(v.get("rating")) or 0.0

                with st.container(border=True):
                    img_col, info_col, action_col = st.columns([1, 4, 1])
                    with img_col:
                        st.markdown(
                            """<div style="background:#d0f0e8;border-radius:12px;height:90px;
                               display:flex;align-items:center;justify-content:center;font-size:2rem;">✅</div>""",
                            unsafe_allow_html=True,
                        )
                    with info_col:
                        st.markdown(f"### {v['name']}")
                        st.markdown(f"{stars_str(rating)} **{round(rating, 1)}**")
                        st.caption(f"📍 {v.get('city', '')}  {v.get('address', '')}")
                    with action_col:
                        st.markdown("<br>", unsafe_allow_html=True)
                        if st.button("↩ Unmark", key=f"unvis_{vid}", use_container_width=True):
                            _, uv_err = api_delete(f"/users/{user_id}/visited", {"venueId": vid})
                            if uv_err:
                                st.session_state.list_msgs[f"unvis_{vid}"] = ("error", uv_err)
                            else:
                                st.session_state.list_msgs[f"unvis_{vid}"] = ("success", "Unmarked!")
                            st.rerun()
                        msg = st.session_state.list_msgs.get(f"unvis_{vid}")
                        if msg:
                            if msg[0] == "success":
                                st.success(msg[1])
                            else:
                                st.error(msg[1])

    # ── Similar Venues ─────────────────────────────────────────────────────────
    with sub_similar:
        st.caption("Pick one of your saved spots and we'll find similar venues.")
        if not saved:
            st.info("Save some venues first to get recommendations.")
        else:
            sim_options = {f"{v['name']} ({v.get('city', '')})": v["venueId"] for v in saved}
            sim_selected = st.selectbox("Base your recommendations on:", list(sim_options.keys()), key="sim_select")
            base_id = sim_options[sim_selected]

            similar, sim_err = api_get(f"/venues/{base_id}/similar")
            if sim_err:
                show_api_error(sim_err)
            elif not similar:
                st.info(f"No similar venues found for **{sim_selected}**.")
            else:
                saved_ids = {v["venueId"] for v in saved}
                st.markdown(f"**Venues similar to {sim_selected}:**")
                for v in similar:
                    vid = v["venueId"]
                    rating = safe_float(v.get("rating")) or 0.0
                    with st.container(border=True):
                        c1, c2 = st.columns([5, 1])
                        with c1:
                            st.markdown(f"**{v['name']}**  {stars_str(rating)} **{round(rating, 1)}**")
                            st.caption(f"📍 {v.get('city', '')}  {v.get('address', '')}")
                        with c2:
                            st.markdown("<br>", unsafe_allow_html=True)
                            if vid in saved_ids:
                                st.success("Saved")
                            else:
                                if st.button("🔖 Save", key=f"sim_save_{vid}", use_container_width=True, type="primary"):
                                    _, s_err = api_post(f"/users/{user_id}/saved", {"venueId": vid})
                                    if s_err and "Duplicate" not in s_err and "1062" not in s_err:
                                        st.error(s_err)
                                    else:
                                        st.success("Saved!")
                                        st.rerun()
