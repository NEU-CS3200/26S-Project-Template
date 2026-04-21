import logging

import streamlit as st

st.set_page_config(layout="wide", page_title="HoopSpot Write a Review")

import requests

from modules.nav import SideBarLinks

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

API_BASE = "http://web-api:4000"

SideBarLinks(show_home=True)

player_id = st.session_state.get("player_id", 1)


def fetch_courts():
    try:
        resp = requests.get(f"{API_BASE}/court/courts", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch courts: {e}")
        return []


def fetch_reviews(court_id):
    try:
        resp = requests.get(f"{API_BASE}/court/courts/{court_id}/reviews", timeout=5)
        resp.raise_for_status()
        return resp.json()
    except requests.RequestException as e:
        logger.error(f"Failed to fetch reviews for court {court_id}: {e}")
        return []


st.title("Write a Review")
st.caption("Rate a court and share your experience with the community")

courts = fetch_courts()

if not courts:
    st.error("Could not load courts. Make sure the API is running.")
    st.stop()

court_names = [c.get("CourtName", "Unknown") for c in courts]
court_ids = {c.get("CourtName"): c.get("CourtId") for c in courts}

selected_name = st.selectbox("Select a Court", court_names)
selected_id = court_ids.get(selected_name)

st.markdown("---")

left_col, right_col = st.columns([3, 2])

with left_col:
    st.subheader(f"Reviews for {selected_name}")
    reviews = fetch_reviews(selected_id)

    if not reviews:
        st.info("No reviews yet for this court. Be the first!")
    else:
        for r in reviews[:6]:
            with st.container(border=True):
                top_row, star_row = st.columns([4, 1])
                with top_row:
                    st.write(f"**{r.get('Username', 'Anonymous')}**")
                    st.caption(str(r.get("ReviewDate", ""))[:10])
                    if r.get("Comment"):
                        st.caption(f"\"{r.get('Comment')}\"")
                with star_row:
                    st.write(f"⭐ {r.get('Rating', 0)}")

with right_col:
    st.subheader("Your Review")

    with st.form("review_form"):
        rating = st.slider("Overall Rating", min_value=1, max_value=5, value=4)
        condition = st.slider("Court Condition", min_value=1, max_value=5, value=4)
        comment = st.text_area("Comment (optional)", placeholder="How was the court?", max_chars=500)
        submitted = st.form_submit_button("Submit Review", type="primary", use_container_width=True)

    if submitted:
        payload = {
            "PlayerId": player_id,
            "Rating": rating,
            "ConditionRating": condition,
            "Comment": comment,
        }
        try:
            resp = requests.post(
                f"{API_BASE}/court/courts/{selected_id}/reviews",
                json=payload,
                timeout=5,
            )
            if resp.status_code == 201:
                st.success("Review submitted!")
                st.rerun()
            else:
                st.error(f"Error: {resp.text}")
        except Exception as e:
            st.error(f"Could not reach API: {e}")
