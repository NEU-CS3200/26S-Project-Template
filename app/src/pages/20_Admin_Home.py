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
 
# ── Page CSS ─────────────────────────────────────────────────────────────────
st.markdown("""
<style>
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&display=swap');
 
.admin-header {
    display: flex;
    align-items: center;
    gap: 1.5rem;
    padding: 2rem 0 1rem 0;
}
.admin-avatar {
    width: 72px;
    height: 72px;
    border-radius: 18px;
    background: linear-gradient(135deg, #F97316, #EA580C);
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: 'Outfit', sans-serif;
    font-size: 1.6rem;
    font-weight: 800;
    color: white;
    flex-shrink: 0;
    box-shadow: 0 8px 32px rgba(249, 115, 22, 0.35);
}
.admin-title {
    font-family: 'Outfit', sans-serif;
    font-size: 3.2rem;
    font-weight: 900;
    color: #FFFFFF;
    line-height: 1.05;
    letter-spacing: -0.03em;
    margin: 0;
}
.admin-subtitle {
    font-family: 'Outfit', sans-serif;
    font-size: 0.9rem;
    color: #64748B;
    margin: 4px 0 0 0;
    font-weight: 400;
}
.admin-sync {
    font-family: 'Outfit', sans-serif;
    font-size: 0.72rem;
    color: #334155;
    margin-top: 2rem;
    letter-spacing: 0.04em;
    text-transform: uppercase;
}
.section-label {
    font-family: 'Outfit', sans-serif;
    font-size: 0.75rem;
    font-weight: 700;
    color: #94A3B8;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    margin: 2rem 0 1rem 0;
}
.stat-card {
    background: linear-gradient(135deg, rgba(249,115,22,0.05) 0%, rgba(15,23,42,0.6) 100%);
    border: 1px solid rgba(249,115,22,0.1);
    border-radius: 18px;
    padding: 1.75rem 1.5rem;
    text-align: center;
    height: 100%;
}
.stat-icon {
    font-size: 2rem;
    margin-bottom: 0.5rem;
}
.stat-value {
    font-family: 'Outfit', sans-serif;
    font-size: 2.8rem;
    font-weight: 900;
    line-height: 1;
    letter-spacing: -0.03em;
    margin-bottom: 0.4rem;
}
.stat-label {
    font-family: 'Outfit', sans-serif;
    font-size: 0.7rem;
    font-weight: 600;
    color: #475569;
    text-transform: uppercase;
    letter-spacing: 0.1em;
}
.divider {
    border: none;
    border-top: 1px solid rgba(255,255,255,0.06);
    margin: 1.5rem 0;
}
</style>
""", unsafe_allow_html=True)
 
# ── Header ───────────────────────────────────────────────────────────────────
st.markdown(f"""
<div class="admin-header">
    <div class="admin-avatar">DW</div>
    <div>
        <div class="admin-title">Welcome, Devon 👋</div>
        <div class="admin-subtitle">System Administrator · HoopSpot Platform</div>
    </div>
</div>
<div class="admin-sync">⏱ Last synced: {now}</div>
<hr class="divider">
""", unsafe_allow_html=True)
 
# ── Stats ─────────────────────────────────────────────────────────────────────
st.markdown('<div class="section-label">Platform Overview</div>', unsafe_allow_html=True)
 
c1, c2, c3, c4 = st.columns(4)
 
def stat_card(col, icon, value, label, color):
    col.markdown(f"""
    <div class="stat-card">
        <div class="stat-icon">{icon}</div>
        <div class="stat-value" style="color:{color};">{value}</div>
        <div class="stat-label">{label}</div>
    </div>
    """, unsafe_allow_html=True)
 
stat_card(c1, "🏀", total_courts,    "Total Courts",    "#F97316")
stat_card(c2, "🟢", active_courts,   "Active Courts",   "#4ADE80")
stat_card(c3, "⭐", pending_reviews, "Pending Reviews", "#FACC15" if pending_reviews == 0 else "#F87171")
stat_card(c4, "👥", flagged_users,   "Flagged Users",   "#FACC15" if flagged_users == 0 else "#F87171")
 
# ── Quick Actions ─────────────────────────────────────────────────────────────
st.markdown('<hr class="divider">', unsafe_allow_html=True)
st.markdown('<div class="section-label">Quick Actions</div>', unsafe_allow_html=True)
 
col1, col2 = st.columns(2)
 
with col1:
    if st.button("🏀  Manage Courts", type="primary", use_container_width=True):
        st.switch_page("pages/22_Manage_Courts.py")
 
with col2:
    if st.button("⭐  Moderate Reviews", type="primary", use_container_width=True):
        st.switch_page("pages/23_Manage_Reviews.py")