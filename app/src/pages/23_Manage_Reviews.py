import logging
import streamlit as st
import requests
from modules.nav import SideBarLinks

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)

SideBarLinks(show_home=True)

BASE_URL = "http://web-api:4000"


# ── Load flagged content ─────────────────────────────────────────────────────
def fetch(endpoint):
    try:
        r = requests.get(f"{BASE_URL}{endpoint}", timeout=5)
        return r.json() if r.status_code == 200 else []
    except Exception:
        return []


# GET /court/reviews/flagged  — returns ReviewId, Username, CourtName,
#                               Rating, ConditionRating, Comment, ReviewDate
reviews    = fetch("/court/reviews/flagged")

# GET /player/players?flagged=true — returns PlayerId, Username, Email,
#                                    SkillRating, IsActive, IsFlagged, …
user_flags = fetch("/player/players?flagged=true")

total_pending = len(reviews) + len(user_flags)

# ── Header ───────────────────────────────────────────────────────────────────
head_left, head_right = st.columns([4, 1])
with head_left:
    st.markdown("## Moderation Panel")
with head_right:
    if total_pending > 0:
        st.markdown(
            f"<div style='text-align:right; color:#F97316; font-weight:700; "
            f"font-size:1rem; padding-top:12px;'>{total_pending} pending</div>",
            unsafe_allow_html=True,
        )

# ── Tabs ─────────────────────────────────────────────────────────────────────
tab1, tab2 = st.tabs([
    f"Flagged Reviews ({len(reviews)})",
    f"Flagged Users ({len(user_flags)})",
])

# ── Tab 1: Flagged Reviews ────────────────────────────────────────────────────
with tab1:
    if not reviews:
        st.success("No flagged reviews.")
    for r in reviews:
        rid         = r.get("ReviewId")
        court_name  = r.get("CourtName", "Unknown Court")
        username    = r.get("Username", "Unknown")
        rating      = r.get("Rating", "?")
        comment     = r.get("Comment", "")
        review_date = r.get("ReviewDate", "")

        with st.container(border=True):
            top_left, top_right = st.columns([3, 1])
            with top_left:
                st.markdown(f"**{court_name}**")
                st.markdown(
                    f"<span style='background:rgba(239,68,68,0.15); color:#F87171; "
                    f"padding:2px 10px; border-radius:12px; font-size:0.75rem;'>"
                    f"Flagged</span> &nbsp; {username} · {review_date} · ⭐ {rating}",
                    unsafe_allow_html=True,
                )
                if comment:
                    st.caption(f'"{comment}"')
            with top_right:
                col_remove = st.columns(1)[0]
                with col_remove:
                    # DELETE /court/reviews/{id} — removes the flagged review
                    if st.button("Remove", key=f"remove_review_{rid}",
                                 type="primary", use_container_width=True):
                        try:
                            resp = requests.delete(
                                f"{BASE_URL}/court/reviews/{rid}", timeout=5
                            )
                            if resp.status_code == 200:
                                st.toast("Review removed.")
                                st.rerun()
                            else:
                                st.error(f"Error: {resp.text}")
                        except Exception as e:
                            st.error(f"Could not reach API: {e}")

# ── Tab 2: Flagged Users ──────────────────────────────────────────────────────
with tab2:
    if not user_flags:
        st.success("No flagged users.")
    for u in user_flags:
        uid      = u.get("PlayerId")
        username = u.get("Username", "Unknown")
        email    = u.get("Email", "—")
        rating   = u.get("SkillRating", "—")

        with st.container(border=True):
            top_left, top_right = st.columns([3, 1])
            with top_left:
                st.markdown(f"**{username}**")
                st.caption(f"Email: {email}  ·  Skill Rating: {rating}")
            with top_right:
                col_unflag, col_deactivate = st.columns(2)

                with col_unflag:
                    # PUT /player/players/{id} with IsFlagged=False — clears the flag
                    if st.button("Unflag", key=f"unflag_{uid}", use_container_width=True):
                        try:
                            resp = requests.put(
                                f"{BASE_URL}/player/players/{uid}",
                                json={"IsFlagged": False},
                                timeout=5,
                            )
                            if resp.status_code == 200:
                                st.toast(f"{username} unflagged.")
                                st.rerun()
                            else:
                                st.error(f"Error: {resp.text}")
                        except Exception as e:
                            st.error(f"Could not reach API: {e}")

                with col_deactivate:
                    # DELETE /player/players/{id} — soft-deactivates the account
                    if st.button("Deactivate", key=f"deactivate_{uid}",
                                 type="primary", use_container_width=True):
                        try:
                            resp = requests.delete(
                                f"{BASE_URL}/player/players/{uid}", timeout=5
                            )
                            if resp.status_code == 200:
                                st.toast(f"{username} deactivated.")
                                st.rerun()
                            else:
                                st.error(f"Error: {resp.text}")
                        except Exception as e:
                            st.error(f"Could not reach API: {e}")
