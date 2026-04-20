import streamlit as st

from modules.nav import SideBarLinks
from modules.api_client import api_get, api_post, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

user_id = st.session_state.get("user_id", 4)

st.title("Reviews & Reports")

my_venues, err = api_get(f"/users/{user_id}/venues")
if err:
    show_api_error(err)
    st.stop()
if not my_venues:
    st.info("You have no venues listed yet.")
    st.stop()

venue_options = {v["name"]: v["venueId"] for v in my_venues}
selected_name = st.selectbox("Select a venue", list(venue_options.keys()))
venue_id = venue_options[selected_name]

tab_reviews, tab_flag = st.tabs(["💬 Customer Reviews", "🚩 Flag & Report"])


# ══════════════════════════════════════════════════════════════════════════════
# TAB 1 — MY VENUE REVIEWS
# ══════════════════════════════════════════════════════════════════════════════
with tab_reviews:
    st.caption("Read customer feedback to understand what's working and what isn't.")
    st.caption("📌 Covers: Marcus-4 (read and monitor reviews for your venue)")

    reviews, rev_err = api_get(f"/venues/{venue_id}/reviews")
    if rev_err:
        show_api_error(rev_err)
        st.stop()

    if not reviews:
        st.info("No reviews yet for this venue.")
    else:
        import pandas as pd
        df = pd.DataFrame(reviews)

        col1, col2, col3 = st.columns(3)
        col1.metric("Total Reviews", len(df))
        col2.metric("Average Rating", f"{df['rating'].astype(float).mean():.2f}")
        col3.metric("Flagged", int(df["isFlagged"].sum()))

        st.divider()
        min_r, max_r = st.slider("Filter by rating", 0.0, 5.0, (0.0, 5.0), 0.1)
        show_flagged = st.checkbox("Flagged only")

        filtered = [r for r in reviews
                    if min_r <= float(r["rating"]) <= max_r
                    and (not show_flagged or r["isFlagged"])]

        if not filtered:
            st.info("No reviews match the current filters.")
        else:
            for r in filtered:
                rating = float(r.get("rating", 0))
                stars = "★" * int(round(rating)) + "☆" * (5 - int(round(rating)))
                badge = "  🚩 *Flagged*" if r.get("isFlagged") else ""
                with st.container(border=True):
                    c1, c2 = st.columns([4, 1])
                    with c1:
                        st.markdown(f"**{r.get('username', 'Anonymous')}**{badge}  {stars}")
                        st.write(r.get("comment") or "_No comment._")
                        st.caption(str(r.get("createdAt", ""))[:10])
                    with c2:
                        st.metric("Rating", f"{rating:.1f}")


# ══════════════════════════════════════════════════════════════════════════════
# TAB 2 — FLAG & REPORT
# ══════════════════════════════════════════════════════════════════════════════
with tab_flag:
    st.caption("Flag inaccurate or inappropriate reviews and submit tickets for admin review.")
    st.caption("📌 Covers: Marcus-3 (flag reviews & submit report tickets to admin)")

    reviews_for_flag, _ = api_get(f"/venues/{venue_id}/reviews")
    if reviews_for_flag:
        import pandas as pd
        df2 = pd.DataFrame(reviews_for_flag)[["reviewId", "username", "rating", "comment", "isFlagged"]]
        df2.columns = ["Review ID", "User", "Rating", "Comment", "Flagged"]
        st.dataframe(df2, use_container_width=True, hide_index=True)
    else:
        st.info("No reviews yet for this venue.")

    st.divider()
    st.subheader("Flag a Review")
    with st.form("flag_form"):
        flag_id = st.number_input("Review ID to flag", min_value=1, value=1, step=1)
        if st.form_submit_button("Flag Review", type="primary"):
            _, flag_err = api_post(f"/reviews/{int(flag_id)}/flag", {})
            if flag_err:
                show_api_error(flag_err)
            else:
                st.success(f"Review {int(flag_id)} flagged.")
                st.rerun()

    st.divider()
    st.subheader("Submit a Report Ticket")
    REASONS = ["Inaccurate Review", "Inappropriate Content", "Spam", "Fake Review", "Harassment", "Other"]
    with st.form("ticket_form"):
        ticket_review_id = st.number_input("Review ID", min_value=1, value=1, step=1)
        reason           = st.selectbox("Reason", REASONS)
        description      = st.text_area("Description", placeholder="Describe why this review should be investigated...")
        if st.form_submit_button("Submit Ticket", type="primary"):
            if not description.strip():
                st.warning("Please add a description.")
            else:
                _, t_err = api_post("/tickets", {
                    "reporterId": user_id, "reviewId": int(ticket_review_id),
                    "reason": reason, "description": description.strip(),
                })
                if t_err:
                    show_api_error(t_err)
                else:
                    st.success("Report ticket submitted. The admin will review it shortly.")
