import streamlit as st
from datetime import datetime, timezone
from modules.nav import SideBarLinks
from modules.api_client import api_get, api_post, api_put, api_delete, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

user_id = st.session_state.get("user_id", 4)


def time_ago(dt_str):
    if not dt_str:
        return ""
    try:
        s = str(dt_str).replace("Z", "+00:00")
        dt = datetime.fromisoformat(s)
        if dt.tzinfo is None:
            dt = dt.replace(tzinfo=timezone.utc)
        diff = datetime.now(timezone.utc) - dt
        d, secs = diff.days, diff.seconds
        if d >= 30:
            n = d // 30
            return f"{n} month{'s' if n > 1 else ''} ago"
        if d >= 1:
            return f"{d} day{'s' if d > 1 else ''} ago"
        if secs >= 3600:
            n = secs // 3600
            return f"{n} hour{'s' if n > 1 else ''} ago"
        n = max(1, secs // 60)
        return f"{n} minute{'s' if n > 1 else ''} ago"
    except Exception:
        return str(dt_str)[:10]


def days_since(dt_str):
    if not dt_str:
        return 9999
    try:
        s = str(dt_str).replace("Z", "+00:00")
        dt = datetime.fromisoformat(s)
        if dt.tzinfo is None:
            dt = dt.replace(tzinfo=timezone.utc)
        return (datetime.now(timezone.utc) - dt).days
    except Exception:
        return 9999


# ── LOAD DATA ─────────────────────────────────────────────────────────────────
my_venues, v_err = api_get(f"/users/{user_id}/venues")
if v_err:
    show_api_error(v_err)
    st.stop()
if not my_venues:
    st.info("You don't have any venues listed yet.")
    if st.button("Submit an Application"):
        st.switch_page("pages/15_New_Application.py")
    st.stop()

venue = my_venues[0]
if len(my_venues) > 1:
    name_map = {v["name"]: v for v in my_venues}
    venue = name_map[st.selectbox("Select venue", list(name_map.keys()))]

venue_id = venue["venueId"]
saves_data, _ = api_get(f"/venues/{venue_id}/saves")
reviews, _    = api_get(f"/venues/{venue_id}/reviews")
posts, _      = api_get(f"/venues/{venue_id}/posts")

saves_count = (saves_data or {}).get("count", 0)
reviews     = reviews or []
posts       = posts   or []

# ── VENUE INFO CARD ───────────────────────────────────────────────────────────
with st.container(border=True):
    col_info, col_btn = st.columns([5, 1])
    with col_info:
        st.subheader(venue.get("name", "My Venue"))
        addr_parts = [venue.get("address"), venue.get("city")]
        st.caption(", ".join(p for p in addr_parts if p))
        rating = float(venue.get("rating") or 0)
        stars_str = "★" * int(round(rating)) + "☆" * (5 - int(round(rating)))
        st.write(f"{stars_str} {rating:.1f} / 5 ({len(reviews)} reviews)  ·  {saves_count} saves")
    with col_btn:
        if st.button("Edit Listing", use_container_width=True):
            st.switch_page("pages/11_Manage_Venue.py")

# ── STATS ROW ─────────────────────────────────────────────────────────────────
recent_reviews = [r for r in reviews if days_since(r.get("createdAt", "")) <= 30]
avg_rating = sum(float(r["rating"]) for r in reviews) / len(reviews) if reviews else 0.0

c1, c2, c3, c4 = st.columns(4)
with c1:
    with st.container(border=True):
        st.caption("Saves")
        st.subheader(str(saves_count))
with c2:
    with st.container(border=True):
        st.caption("Reviews")
        st.subheader(str(len(reviews)))
with c3:
    with st.container(border=True):
        st.caption("New Reviews")
        st.subheader(f"{len(recent_reviews)} new")
        st.caption("Last 30 days")
with c4:
    with st.container(border=True):
        st.caption("Rating")
        st.subheader(f"{avg_rating:.1f}")

# ── RECENT REVIEWS ────────────────────────────────────────────────────────────
st.divider()
rh_left, rh_right = st.columns([6, 1])
with rh_left:
    st.subheader("Recent Reviews")
with rh_right:
    if st.button(f"View All ({len(reviews)})", use_container_width=True):
        st.switch_page("pages/13_Flag_Reviews.py")

if not reviews:
    st.info("No reviews yet.")
else:
    for r in reviews[:3]:
        rev_rating  = float(r.get("rating", 0))
        stars       = "★" * int(round(rev_rating)) + "☆" * (5 - int(round(rev_rating)))
        is_flagged  = bool(r.get("isFlagged"))
        username    = r.get("username") or "Anonymous"
        ago         = time_ago(r.get("createdAt"))

        with st.container(border=True):
            if is_flagged:
                st.markdown("🚨 **FLAGGED FOR REVIEW**")

            rc_left, rc_right = st.columns([5, 1])
            with rc_left:
                st.markdown(f"**{username}**")
                st.caption(f"{stars} {rev_rating:.0f}/5  ·  {ago}")
            with rc_right:
                if is_flagged:
                    if st.button("Contest", key=f"contest_{r['reviewId']}", use_container_width=True):
                        st.switch_page("pages/13_Flag_Reviews.py")
                    if st.button("Remove", key=f"remove_{r['reviewId']}", use_container_width=True):
                        _, del_err = api_delete(f"/reviews/{r['reviewId']}")
                        if del_err:
                            show_api_error(del_err)
                        else:
                            st.success("Review removed.")
                            st.rerun()
                else:
                    if st.button("Flag", key=f"flag_{r['reviewId']}", use_container_width=True):
                        _, flag_err = api_post(f"/reviews/{r['reviewId']}/flag", {})
                        if flag_err:
                            show_api_error(flag_err)
                        else:
                            st.success("Review flagged.")
                            st.rerun()

            if is_flagged:
                st.markdown("_[ Review hidden — inappropriate content ]_")
            else:
                st.write(r.get("comment") or "_No comment._")

# ── UPDATES & EVENTS ──────────────────────────────────────────────────────────
st.divider()
ph_left, ph_right = st.columns([6, 1])
with ph_left:
    st.subheader("Updates & Events")
with ph_right:
    if st.button("+ Post Update", use_container_width=True, type="primary"):
        st.session_state["show_create_post"] = not st.session_state.get("show_create_post", False)

if st.session_state.get("show_create_post", False):
    with st.container(border=True):
        with st.form("create_post_form"):
            new_content = st.text_area("Content", placeholder="Share an update or upcoming event...")
            sub_col, _ = st.columns([1, 4])
            with sub_col:
                submitted = st.form_submit_button("Publish", type="primary")
        if submitted:
            if not new_content.strip():
                st.warning("Content cannot be empty.")
            else:
                _, c_err = api_post(f"/venues/{venue_id}/posts", {"ownerId": user_id, "content": new_content.strip()})
                if c_err:
                    show_api_error(c_err)
                else:
                    st.session_state.pop("show_create_post", None)
                    st.success("Post published!")
                    st.rerun()

if not posts:
    st.info("No posts yet. Share an update or upcoming event!")
else:
    for p in posts:
        content_full = p.get("content", "")
        lines        = content_full.split("\n", 1)
        title        = lines[0][:80]
        body         = lines[1].strip() if len(lines) > 1 else content_full
        preview      = body[:120] + ("..." if len(body) > 120 else "")
        post_date    = str(p.get("postDate", ""))[:10]
        pid          = p["postId"]

        with st.container(border=True):
            pc_left, pc_right = st.columns([5, 1])
            with pc_left:
                st.markdown(f"**{title}**")
                st.caption(f"Posted {post_date}")
            with pc_right:
                pe_col, pd_col = st.columns(2)
                with pe_col:
                    edit_clicked = st.button("Edit", key=f"edit_btn_{pid}", use_container_width=True)
                with pd_col:
                    del_clicked = st.button("Delete", key=f"del_btn_{pid}", use_container_width=True)

            if del_clicked:
                _, d_err = api_delete(f"/posts/{pid}")
                if d_err:
                    show_api_error(d_err)
                else:
                    st.success("Post deleted.")
                    st.rerun()

            if edit_clicked:
                st.session_state[f"edit_{pid}"] = not st.session_state.get(f"edit_{pid}", False)

            if st.session_state.get(f"edit_{pid}", False):
                with st.form(f"edit_form_{pid}"):
                    updated = st.text_area("Edit content", value=content_full)
                    sf1, sf2, _ = st.columns([1, 1, 4])
                    with sf1:
                        save_clicked = st.form_submit_button("Save", type="primary")
                    with sf2:
                        cancel_clicked = st.form_submit_button("Cancel")
                if save_clicked:
                    _, e_err = api_put(f"/posts/{pid}", {"content": updated.strip()})
                    if e_err:
                        show_api_error(e_err)
                    else:
                        st.session_state.pop(f"edit_{pid}", None)
                        st.success("Post updated.")
                        st.rerun()
                if cancel_clicked:
                    st.session_state.pop(f"edit_{pid}", None)
                    st.rerun()
            else:
                st.write(preview)
