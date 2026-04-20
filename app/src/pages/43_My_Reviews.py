# Persona: Maya Chen (CUSTOMER)
# Maya-3: Write, edit, and delete reviews for venues    [My Reviews tab]
# Maya-4: Read and browse reviews for any venue         [Browse Reviews tab]
import streamlit as st

from modules.nav import SideBarLinks
from modules.api_client import api_get, api_post, api_put, api_delete, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

user_id = st.session_state.get("user_id", 1)

st.title("Reviews")

tab_mine, tab_browse = st.tabs(["⭐ My Reviews", "💬 Browse Reviews"])


# ══════════════════════════════════════════════════════════════════════════════
# TAB 1 — MY REVIEWS
# ══════════════════════════════════════════════════════════════════════════════
with tab_mine:
    st.caption("Write, edit, or delete your reviews for date spots you've visited.")
    st.caption("📌 Covers: Maya-3 (write & manage reviews)")

    reviews, err = api_get(f"/users/{user_id}/reviews")
    if err:
        show_api_error(err)
    elif not reviews:
        st.info("You haven't written any reviews yet.")
    else:
        for r in reviews:
            rating = float(r.get("rating") or 0)
            stars = "★" * int(round(rating)) + "☆" * (5 - int(round(rating)))
            with st.container(border=True):
                left, right = st.columns([5, 1])
                with left:
                    st.markdown(f"**{r.get('venueName', 'Unknown Venue')}**  {stars} **{round(rating, 1)}**")
                    st.write(r.get("comment") or "_No comment._")
                    st.caption(str(r.get("createdAt", ""))[:10])
                with right:
                    rid = r["reviewId"]
                    if st.button("✏️ Edit", key=f"edit_btn_{rid}", use_container_width=True):
                        st.session_state[f"editing_{rid}"] = True
                    if st.button("🗑 Delete", key=f"del_btn_{rid}", use_container_width=True):
                        _, d_err = api_delete(f"/reviews/{rid}")
                        if d_err:
                            show_api_error(d_err)
                        else:
                            st.success("Review deleted.")
                            st.rerun()

                if st.session_state.get(f"editing_{rid}"):
                    with st.form(f"edit_form_{rid}"):
                        new_rating = st.slider("New Rating", 0.0, 5.0, rating, 0.5)
                        new_comment = st.text_area("New Comment", value=r.get("comment") or "")
                        if st.form_submit_button("Save Changes", type="primary"):
                            _, e_err = api_put(f"/reviews/{rid}", {"rating": new_rating, "comment": new_comment})
                            if e_err:
                                show_api_error(e_err)
                            else:
                                del st.session_state[f"editing_{rid}"]
                                st.success("Updated!")
                                st.rerun()

    st.divider()
    st.subheader("Write a New Review")

    venues_list, _ = api_get("/venues/")
    venue_options = {}
    if venues_list:
        venue_options = {f"{v['name']} ({v['city']})": v["venueId"] for v in venues_list}

    with st.form("write_review_form"):
        if venue_options:
            selected = st.selectbox("Choose a Venue", list(venue_options.keys()))
            chosen_venue_id = venue_options[selected]
        else:
            chosen_venue_id = st.number_input("Venue ID", min_value=1, value=1, step=1)
        rating_new = st.slider("Rating", 0.0, 5.0, 4.0, 0.5)
        comment_new = st.text_area("Comment", placeholder="Share your experience...")
        if st.form_submit_button("Submit Review", type="primary"):
            _, w_err = api_post(
                f"/venues/{chosen_venue_id}/reviews",
                {"userId": user_id, "rating": rating_new, "comment": comment_new},
            )
            if w_err:
                show_api_error(w_err)
            else:
                st.success("Review submitted!")
                st.rerun()


# ══════════════════════════════════════════════════════════════════════════════
# TAB 2 — BROWSE REVIEWS
# ══════════════════════════════════════════════════════════════════════════════
with tab_browse:
    st.caption("Read reviews and see what a spot is really like before you go.")
    st.caption("📌 Covers: Maya-4 (browse venue reviews)")

    venues_list, _ = api_get("/venues/")
    browse_options = {}
    if venues_list:
        browse_options = {f"{v['name']} ({v['city']})": v["venueId"] for v in venues_list}

    selected_browse = st.selectbox("Choose a Venue", list(browse_options.keys()) if browse_options else [], key="browse_select")

    if selected_browse:
        vid = browse_options[selected_browse]

        venue, v_err = api_get(f"/venues/{vid}")
        if v_err:
            show_api_error(v_err)
            st.stop()

        st.divider()
        col1, col2 = st.columns([3, 1])
        with col1:
            st.subheader(venue.get("name", ""))
            st.caption(f"{venue.get('address', '')} · {venue.get('city', '')}")
            if venue.get("description"):
                st.write(venue["description"])
            vibes = venue.get("vibes")
            categories = venue.get("categories")
            if vibes:
                st.markdown("**Vibes:** " + "  ".join(f"`{v.strip()}`" for v in vibes.split(",")))
            if categories:
                st.markdown("**Categories:** " + "  ".join(f"`{c.strip()}`" for c in categories.split(",")))
        with col2:
            avg = venue.get("avgReviewRating") or venue.get("rating")
            if avg:
                st.metric("Avg Rating", f"{float(avg):.1f} / 5.0")
            min_p = venue.get("minPrice")
            max_p = venue.get("maxPrice")
            if min_p and max_p:
                st.metric("Price Range", f"${float(min_p):.0f} – ${float(max_p):.0f}")

        st.divider()
        st.subheader("What People Are Saying")

        reviews, rev_err = api_get(f"/venues/{vid}/reviews")
        if rev_err:
            show_api_error(rev_err)
        elif not reviews:
            st.info("No reviews yet for this venue.")
        else:
            for r in reviews:
                rating = float(r.get("rating", 0))
                stars = "★" * int(round(rating)) + "☆" * (5 - int(round(rating)))
                with st.container(border=True):
                    c1, c2 = st.columns([4, 1])
                    with c1:
                        st.markdown(f"**{r.get('username', 'Anonymous')}**  {stars} **{round(rating, 1)}**")
                        st.write(r.get("comment") or "_No comment left._")
                        st.caption(str(r.get("createdAt", ""))[:10])
                    with c2:
                        if r.get("isFlagged"):
                            st.warning("Flagged")

        st.divider()
        st.subheader("Upcoming Events & Updates")
        posts, post_err = api_get(f"/venues/{vid}/posts")
        if post_err:
            show_api_error(post_err)
        elif not posts:
            st.info("No events or updates posted for this venue.")
        else:
            for p in posts:
                with st.container(border=True):
                    st.write(p.get("content", ""))
                    st.caption(f"Posted by {p.get('ownerUsername', 'owner')} · {str(p.get('postDate', ''))[:10]}")
