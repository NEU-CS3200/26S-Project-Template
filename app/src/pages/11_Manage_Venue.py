import streamlit as st

from modules.nav import SideBarLinks
from modules.api_client import api_get, api_put, api_post, api_delete, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

user_id = st.session_state.get("user_id", 4)

st.title("My Venue")

my_venues, err = api_get(f"/users/{user_id}/venues")
if err:
    show_api_error(err)
    st.stop()
if not my_venues:
    st.info("You don't have any venues listed yet. Submit an application to get started.")
    st.stop()

venue_options = {v["name"]: v for v in my_venues}
selected_name = st.selectbox("Select a venue", list(venue_options.keys()))
venue = venue_options[selected_name]
venue_id = venue["venueId"]

tab_manage, tab_tags, tab_posts = st.tabs(["✏️ Venue Details", "🏷️ Categories & Vibes", "📣 Posts & Events"])


# ══════════════════════════════════════════════════════════════════════════════
# TAB 1 — MANAGE VENUE
# ══════════════════════════════════════════════════════════════════════════════
with tab_manage:
    st.caption("Update your venue's core information so customers always see accurate details.")
    st.caption("📌 Covers: Marcus-1 (update venue info — phone, description, pricing)")

    col1, col2, col3 = st.columns(3)
    col1.metric("Rating", f"{float(venue.get('rating') or 0):.1f} / 5.0")
    col2.metric("Min Price", f"${float(venue.get('minPrice') or 0):.0f}")
    col3.metric("Max Price", f"${float(venue.get('maxPrice') or 0):.0f}")

    st.divider()
    with st.form("update_venue_form"):
        c1, c2 = st.columns(2)
        with c1:
            new_name    = st.text_input("Name",    value=venue.get("name", ""))
            new_address = st.text_input("Address", value=venue.get("address", ""))
            new_city    = st.text_input("City",    value=venue.get("city", ""))
            new_phone   = st.text_input("Phone",   value=venue.get("phoneNum") or "")
        with c2:
            new_min  = st.number_input("Min Price ($)", min_value=0.0, value=float(venue.get("minPrice") or 0), step=1.0)
            new_max  = st.number_input("Max Price ($)", min_value=0.0, value=float(venue.get("maxPrice") or 0), step=1.0)
            new_desc = st.text_area("Description", value=venue.get("description") or "", height=120)

        if st.form_submit_button("Save Changes", type="primary"):
            _, u_err = api_put(f"/venues/{venue_id}", {
                "name": new_name or None, "description": new_desc or None,
                "address": new_address or None, "city": new_city or None,
                "phoneNum": new_phone or None,
                "minPrice": new_min if new_min > 0 else None,
                "maxPrice": new_max if new_max > 0 else None,
            })
            if u_err:
                show_api_error(u_err)
            else:
                st.success("Venue updated!")
                st.rerun()


# ══════════════════════════════════════════════════════════════════════════════
# TAB 2 — CATEGORIES & VIBES
# ══════════════════════════════════════════════════════════════════════════════
with tab_tags:
    st.caption("Tag your venue so date seekers can find you when filtering by activity or atmosphere.")
    st.caption("📌 Covers: Marcus-2 (assign categories & vibes to venue)")

    all_cats, _  = api_get("/categories")
    all_vibes, _ = api_get("/vibes")
    cur_cats, _  = api_get(f"/venues/{venue_id}/categories")
    cur_vibes, _ = api_get(f"/venues/{venue_id}/vibes")

    cat_map  = {c["name"]: c["categoryId"] for c in (all_cats  or [])}
    vibe_map = {v["name"]: v["vibeId"]     for v in (all_vibes or [])}

    c1, c2 = st.columns(2)
    with c1:
        st.subheader("Categories")
        sel_cats = st.multiselect("Select all that apply", list(cat_map.keys()),
                                  default=[c["name"] for c in (cur_cats or [])])
        if st.button("Save Categories", type="primary"):
            _, err = api_put(f"/venues/{venue_id}/categories", {"categoryIds": [cat_map[n] for n in sel_cats]})
            if err:
                show_api_error(err)
            else:
                st.success("Categories updated!")
                st.rerun()
    with c2:
        st.subheader("Vibes")
        sel_vibes = st.multiselect("Select all that apply", list(vibe_map.keys()),
                                   default=[v["name"] for v in (cur_vibes or [])])
        if st.button("Save Vibes", type="primary"):
            _, err = api_put(f"/venues/{venue_id}/vibes", {"vibeIds": [vibe_map[n] for n in sel_vibes]})
            if err:
                show_api_error(err)
            else:
                st.success("Vibes updated!")
                st.rerun()


# ══════════════════════════════════════════════════════════════════════════════
# TAB 3 — POSTS & EVENTS
# ══════════════════════════════════════════════════════════════════════════════
with tab_posts:
    st.caption("Keep customers informed with updates, specials, and upcoming events.")
    st.caption("📌 Covers: Marcus-6 (create and manage venue posts & events)")

    posts, post_err = api_get(f"/venues/{venue_id}/posts")
    if post_err:
        show_api_error(post_err)
    elif not posts:
        st.info("No posts yet for this venue.")
    else:
        for p in posts:
            with st.container(border=True):
                left, right = st.columns([5, 1])
                with left:
                    st.write(p.get("content", ""))
                    st.caption(f"Post ID: {p['postId']} · {str(p.get('postDate', ''))[:10]}")
                with right:
                    if st.button("🗑 Delete", key=f"del_post_{p['postId']}", use_container_width=True):
                        _, d_err = api_delete(f"/posts/{p['postId']}")
                        if d_err:
                            show_api_error(d_err)
                        else:
                            st.success("Deleted.")
                            st.rerun()

    st.divider()
    st.subheader("Create a New Post")
    with st.form("create_post_form"):
        content = st.text_area("Content", placeholder="e.g. Wine tasting this Friday — 20% off all bottles!")
        if st.form_submit_button("Publish Post", type="primary"):
            if not content.strip():
                st.warning("Content cannot be empty.")
            else:
                _, c_err = api_post(f"/venues/{venue_id}/posts", {"ownerId": user_id, "content": content.strip()})
                if c_err:
                    show_api_error(c_err)
                else:
                    st.success("Post published!")
                    st.rerun()
