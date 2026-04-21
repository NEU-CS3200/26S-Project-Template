import streamlit as st
import requests
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')

SideBarLinks()

st.title("Event Reviews & Ratings")

attendee_id = st.session_state.get('user_id', 1)
BASE_URL = "http://web-api:4000/review"

# Fetch all events to let attendee pick one
events_res = requests.get("http://web-api:4000/event/events", timeout=5)
if events_res.status_code != 200:
    st.error("Could not load events.")
    st.stop()

events = events_res.json()
event_options = {e['Name']: e['EventID'] for e in events}

selected_name = st.selectbox("Select an Event", list(event_options.keys()))
event_id = event_options[selected_name]

# --- Show existing reviews ---
st.subheader(f"Reviews for: {selected_name}")

reviews_res = requests.get(f"{BASE_URL}/reviews/event/{event_id}", timeout=5)
reviews = []
avg_rating = None

if reviews_res.status_code == 200:
    data = reviews_res.json()
    reviews = data.get('reviews', [])
    avg_rating = data.get('average_rating')

if avg_rating is not None:
    st.metric("Average Rating", f"⭐ {float(avg_rating):.1f} / 5.0")

if reviews:
    for r in reviews:
        with st.expander(f"⭐ {r['Rating']} — {r.get('AttendeeFirstName', 'Attendee')} {r.get('AttendeeLastName', '')}"):
            st.write(f"**Comment:** {r.get('Comment', '')}")
            st.write(f"**Date:** {r.get('Date', '')}")

            if r.get('AttendeeID') == attendee_id:
                col_edit, col_del = st.columns(2)
                with col_edit:
                    with st.form(f"edit_{r['ReviewID']}"):
                        new_rating = st.slider("New Rating", 1.0, 5.0, float(r['Rating']), 0.5)
                        new_comment = st.text_area("New Comment", value=r.get('Comment', ''))
                        if st.form_submit_button("Save Changes"):
                            put_res = requests.put(
                                f"{BASE_URL}/reviews/{r['ReviewID']}",
                                json={"rating": new_rating, "comment": new_comment}
                            )
                            if put_res.status_code == 200:
                                st.success("Review updated!")
                                st.rerun()
                            else:
                                st.error("Failed to update review.")
                with col_del:
                    if st.button("Delete Review", key=f"del_{r['ReviewID']}"):
                        del_res = requests.delete(f"{BASE_URL}/reviews/{r['ReviewID']}")
                        if del_res.status_code == 200:
                            st.success("Review deleted.")
                            st.rerun()
                        else:
                            st.error("Failed to delete review.")
else:
    st.info("No reviews yet for this event. Be the first!")

# --- Submit new review ---
st.divider()
st.subheader("Write a Review")

with st.form("new_review_form"):
    rating = st.slider("Rating", 1.0, 5.0, 4.0, 0.5)
    comment = st.text_area("Comment")
    submitted = st.form_submit_button("Submit Review")

    if submitted:
        if not comment.strip():
            st.error("Please write a comment before submitting.")
        else:
            payload = {
                "rating": rating,
                "comment": comment,
                "event_id": event_id,
                "attendee_id": attendee_id
            }
            res = requests.post(f"{BASE_URL}/reviews", json=payload)
            if res.status_code == 201:
                st.success("Review submitted!")
                st.rerun()
            else:
                st.error(f"Failed to submit review: {res.json().get('error', 'Unknown error')}")
