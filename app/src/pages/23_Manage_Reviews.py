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
 
# ── Load all flagged content ─────────────────────────────────────────────────
def fetch(endpoint):
    try:
        r = requests.get(f"{BASE_URL}{endpoint}", timeout=5)
        return r.json() if r.status_code == 200 else []
    except Exception:
        return []
 
reviews      = fetch("/admin/reviews/flagged")
court_reports = fetch("/admin/courts/flagged")
user_flags   = fetch("/admin/users/flagged")
 
total_pending = len(reviews) + len(court_reports) + len(user_flags)
 
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
tab1, tab2, tab3 = st.tabs([
    f"Reviews ({len(reviews)})",
    f"Court Reports ({len(court_reports)})",
    f"User Flags ({len(user_flags)})",
])
 
# ── Helper: Keep / Remove buttons ────────────────────────────────────────────
def keep_remove_buttons(item_id, keep_url, remove_url, key_prefix):
    col_keep, col_remove = st.columns([1, 1])
    with col_keep:
        if st.button("Keep", key=f"keep_{key_prefix}_{item_id}",
                     use_container_width=True):
            try:
                resp = requests.put(keep_url)
                if resp.status_code == 200:
                    st.toast("✅ Kept & unflagged.")
                    st.rerun()
                else:
                    st.error(f"Error: {resp.text}")
            except Exception as e:
                st.error(f"Could not reach API: {e}")
    with col_remove:
        if st.button("Remove", key=f"remove_{key_prefix}_{item_id}",
                     type="primary", use_container_width=True):
            try:
                resp = requests.delete(remove_url)
                if resp.status_code == 200:
                    st.toast("🗑️ Removed.")
                    st.rerun()
                else:
                    st.error(f"Error: {resp.text}")
            except Exception as e:
                st.error(f"Could not reach API: {e}")
 
# ── Tab 1: Flagged Reviews ────────────────────────────────────────────────────
with tab1:
    if not reviews:
        st.success("✅ No flagged reviews.")
    for r in reviews:
        rid = r.get("review_id")
        with st.container(border=True):
            top_left, top_right = st.columns([3, 1])
            with top_left:
                st.markdown(f"**{r.get('court_name', 'Unknown Court')}**")
                flag_reason = r.get("flag_reason", "Flagged")
                st.markdown(
                    f"<span style='background:rgba(239,68,68,0.15); color:#F87171; "
                    f"padding:2px 10px; border-radius:12px; font-size:0.75rem;'>"
                    f"{flag_reason}</span> &nbsp; {r.get('username', 'Unknown')}",
                    unsafe_allow_html=True,
                )
                st.caption(f'"{r.get("review_text", "")}"')
            with top_right:
                keep_remove_buttons(
                    rid,
                    f"{BASE_URL}/admin/reviews/{rid}/approve",
                    f"{BASE_URL}/admin/reviews/{rid}",
                    "review",
                )
 
# ── Tab 2: Court Reports ──────────────────────────────────────────────────────
with tab2:
    if not court_reports:
        st.success("✅ No flagged court reports.")
    for c in court_reports:
        cid = c.get("court_id")
        with st.container(border=True):
            top_left, top_right = st.columns([3, 1])
            with top_left:
                st.markdown(f"**{c.get('name', 'Unknown Court')}**")
                st.caption(f"Reported by: {c.get('reported_by', 'Unknown')}  · {c.get('reason', '')}")
            with top_right:
                keep_remove_buttons(
                    cid,
                    f"{BASE_URL}/admin/courts/{cid}/unflag",
                    f"{BASE_URL}/admin/courts/{cid}/deactivate",
                    "court",
                )
 
# ── Tab 3: User Flags ─────────────────────────────────────────────────────────
with tab3:
    if not user_flags:
        st.success("✅ No flagged users.")
    for u in user_flags:
        uid = u.get("user_id")
        with st.container(border=True):
            top_left, top_right = st.columns([3, 1])
            with top_left:
                st.markdown(f"**{u.get('username', 'Unknown')}**")
                st.caption(f"Email: {u.get('email', '—')}  · Reason: {u.get('flag_reason', '—')}")
            with top_right:
                keep_remove_buttons(
                    uid,
                    f"{BASE_URL}/admin/users/{uid}/unflag",
                    f"{BASE_URL}/admin/users/{uid}/deactivate",
                    "user",
                )
 