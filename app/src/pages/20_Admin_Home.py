import logging
import streamlit as st
import requests
from datetime import datetime
from modules.nav import SideBarLinks
 
logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)
 
st.set_page_config(layout="wide")
 
SideBarLinks(show_home=True)
 
BASE_URL = "http://web-api:4000"
 
# ── Quick stats fetch ────────────────────────────────────────────────────────
def safe_fetch(endpoint):
    try:
        r = requests.get(f"{BASE_URL}{endpoint}", timeout=3)
        return r.json() if r.status_code == 200 else []
    except Exception:
        return []
 
courts        = safe_fetch("/admin/courts")
flagged       = safe_fetch("/admin/reviews/flagged")
user_flags    = safe_fetch("/admin/users/flagged")
 
total_courts    = len(courts) if isinstance(courts, list) else 0
active_courts   = len([c for c in courts if isinstance(courts, list) and c.get("status") == "Active"]) if isinstance(courts, list) else 0
pending_reviews = len(flagged) if isinstance(flagged, list) else 0
flagged_users   = len(user_flags) if isinstance(user_flags, list) else 0
 
now = datetime.now().strftime("%B %d, %Y at %I:%M %p")
 
# ── Avatar + greeting ────────────────────────────────────────────────────────
st.markdown(
    f"""
    <div style="display:flex; align-items:center; gap:1.25rem; margin-bottom:0.5rem;">
        <div style="
            width:60px; height:60px; border-radius:14px;
            background: linear-gradient(135deg, #F97316, #EA580C);
            display:flex; align-items:center; justify-content:center;
            font-family:'Outfit',sans-serif; font-size:1.4rem;
            font-weight:700; color:white; flex-shrink:0;
        ">DW</div>
        <div>
            <div style="font-family:'Outfit',sans-serif; font-size:1.9rem;
                font-weight:800; color:#F1F5F9; line-height:1.1;">
                Welcome, Devon 👋
            </div>
            <div style="font-family:'Outfit',sans-serif; font-size:0.85rem;
                color:#64748B;">
                System Administrator · HoopSpot Platform
            </div>
        </div>
    </div>
    <div style="font-family:'Outfit',sans-serif; font-size:0.75rem;
        color:#475569; margin-bottom:1.5rem;">
        Last synced: {now}
    </div>
    """,
    unsafe_allow_html=True,
)
 
st.markdown("---")
 
# ── Stats cards ───────────────────────────────────────────────────────────────
st.markdown("##### Platform Overview")
c1, c2, c3, c4 = st.columns(4)
 
def stat_card(col, label, value, icon, color="#F97316"):
    col.markdown(
        f"""
        <div style="
            background: linear-gradient(135deg, rgba(249,115,22,0.06), rgba(22,32,50,0.6));
            border: 1px solid rgba(249,115,22,0.12);
            border-radius: 14px;
            padding: 1.25rem;
            text-align: center;
        ">
            <div style="font-size:1.75rem;">{icon}</div>
            <div style="font-family:'Outfit',sans-serif; font-size:2rem;
                font-weight:800; color:{color}; line-height:1.1;">
                {value}
            </div>
            <div style="font-family:'Outfit',sans-serif; font-size:0.75rem;
                color:#64748B; text-transform:uppercase; letter-spacing:0.06em;">
                {label}
            </div>
        </div>
        """,
        unsafe_allow_html=True,
    )
 
stat_card(c1, "Total Courts",     total_courts,    "🏀")
stat_card(c2, "Active Courts",    active_courts,   "🟢", "#4ADE80")
stat_card(c3, "Pending Reviews",  pending_reviews, "⭐", "#FACC15" if pending_reviews == 0 else "#F87171")
stat_card(c4, "Flagged Users",    flagged_users,   "👥", "#FACC15" if flagged_users == 0 else "#F87171")
 
st.markdown("---")
 
# ── Navigation buttons ────────────────────────────────────────────────────────
st.markdown("##### Quick Actions")
 
_, col1, col2, _ = st.columns([1, 2, 2, 1])
 
with col1:
    if st.button("🏀  Manage Courts", type="primary", use_container_width=True):
        st.switch_page("pages/22_Manage_Courts.py")
 
with col2:
    if st.button("⭐  Moderate Reviews", type="primary", use_container_width=True):
        st.switch_page("pages/23_Manage_Reviews.py")