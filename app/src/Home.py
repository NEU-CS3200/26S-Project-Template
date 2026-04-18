
import streamlit as st
st.set_page_config(layout="wide", page_title="HoopSpot")

import logging

logging.basicConfig(
    format="%(filename)s:%(lineno)s:%(levelname)s -- %(message)s", level=logging.INFO
)
logger = logging.getLogger(__name__)


from modules.nav import SideBarLinks
from modules.styles import inject_css



if "authenticated" not in st.session_state:
    st.session_state["authenticated"] = False

SideBarLinks(show_home=True)

# ---------------------------------------------------------------------------
# Page-specific CSS
# ---------------------------------------------------------------------------
HERO_CSS = """
.stApp {
    background: radial-gradient(
        ellipse at 50% 0%,
        rgba(249, 115, 22, 0.06) 0%,
        transparent 50%
    );
}
.block-container {
    max-width: 540px !important;
    padding-top: 16vh !important;
}
.hero-badge {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 6px 14px;
    border-radius: 20px;
    background: rgba(249, 115, 22, 0.1);
    border: 1px solid rgba(249, 115, 22, 0.2);
    color: #FB923C;
    font-size: 0.8rem;
    font-weight: 500;
    font-family: 'Outfit', sans-serif;
    margin-bottom: 1.5rem;
}
.hero-title {
    font-family: 'Outfit', sans-serif;
    font-size: 3.5rem;
    font-weight: 800;
    letter-spacing: -0.04em;
    line-height: 1.05;
    color: #F1F5F9;
    margin-bottom: 0.5rem;
}
.hero-accent {
    background: linear-gradient(135deg, #F97316, #FB923C);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    background-clip: text;
}
.hero-tagline {
    font-family: 'Outfit', sans-serif;
    font-size: 1.15rem;
    color: #64748B;
    margin-bottom: 3rem;
    font-weight: 400;
}
.persona-card {
    background: linear-gradient(
        135deg,
        rgba(249, 115, 22, 0.06) 0%,
        rgba(22, 32, 50, 0.8) 100%
    );
    border: 1px solid rgba(249, 115, 22, 0.12);
    border-radius: 16px;
    padding: 1.25rem 1.5rem;
    margin-bottom: 1.25rem;
    display: flex;
    align-items: center;
    gap: 1rem;
}
.persona-avatar {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    background: linear-gradient(135deg, #F97316, #EA580C);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.4rem;
    flex-shrink: 0;
}
.persona-info { flex: 1; }
.persona-name {
    font-family: 'Outfit', sans-serif;
    font-size: 1.1rem;
    font-weight: 700;
    color: #F1F5F9;
    margin: 0;
    line-height: 1.2;
}
.persona-role {
    font-family: 'Outfit', sans-serif;
    font-size: 0.8rem;
    color: #94A3B8;
    font-weight: 400;
    margin: 2px 0 0 0;
}
"""

st.markdown(inject_css(HERO_CSS), unsafe_allow_html=True)

logger.info("Loading the Home page of the app")

# ---------------------------------------------------------------------------
# Hero section
# ---------------------------------------------------------------------------
st.markdown(
    """
    <div class="hero-badge">Court Finder</div>
    <div class="hero-title">Hoop<span class="hero-accent">Spot</span></div>
    <div class="hero-tagline">Pick up. Check in. Run it back.</div>
    """,
    unsafe_allow_html=True,
)

# ---------------------------------------------------------------------------
# Persona selection
# ---------------------------------------------------------------------------
st.markdown("##### Choose a persona")

st.markdown(
    """
    <div class="persona-card">
        <div class="persona-avatar">MR</div>
        <div class="persona-info">
            <p class="persona-name">Marcus Reyes</p>
            <p class="persona-role">Pickup Player</p>
        </div>
    </div>
    """,
    unsafe_allow_html=True,
)

if st.button("Enter as Marcus", type="primary", use_container_width=True):
    st.session_state["authenticated"] = True
    st.session_state["role"] = "pickup_player"
    st.session_state["first_name"] = "Marcus"
    st.session_state["player_id"] = 1
    logger.info("Logging in as Pickup Player Persona")
    st.switch_page("pages/00_Pickup_Home.py")


st.markdown(
    """
    <div class="persona-card">
        <div class="persona-avatar">PN</div>
        <div class="persona-info">
            <p class="persona-name">Priya Nair</p>
            <p class="persona-role">Courts Data Analyst</p>
        </div>
    </div>
    """,
    unsafe_allow_html=True,
)

if st.button("Enter as Priya", type="primary", use_container_width=True):
    st.session_state["authenticated"] = True
    st.session_state["role"] = "data_analyst"
    st.session_state["first_name"] = "Priya"
    st.session_state["player_id"] = 4
    logger.info("Logging in as Data Analyst Persona")
    st.switch_page("pages/03_Analyst_Profile.py")

