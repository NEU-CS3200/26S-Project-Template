# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has functions to add links to the left sidebar based on the user's role.

import streamlit as st

# ---- General ----------------------------------------------------------------


def home_nav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def about_page_nav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="🧠")


# ---- Role: pickup_player ----------------------------------------------------


def pickup_home_nav():
    st.sidebar.page_link("pages/00_Pickup_Home.py", label="Court Finder", icon="🏀")


def pickup_profile_nav():
    st.sidebar.page_link("pages/01_Pickup_Profile.py", label="Profile", icon="👤")


def write_review_nav():
    st.sidebar.page_link("pages/02_Write_Review.py", label="Write Review", icon="⭐")


def log_game_nav():
    st.sidebar.page_link("pages/03_Log_Game.py", label="Log Game", icon="📝")


# ---- Role: competitive_player -----------------------------------------------


def competitive_home_nav():
    st.sidebar.page_link("pages/10_Competitive_Home.py", label="Dashboard", icon="🏠")


def leaderboard_nav():
    st.sidebar.page_link("pages/11_Leaderboard.py", label="Leaderboard", icon="🏆")


def tournaments_nav():
    st.sidebar.page_link("pages/12_Tournaments.py", label="Tournaments", icon="🥇")


def my_games_nav():
    st.sidebar.page_link("pages/13_My_Games.py", label="My Games", icon="🎮")


# ---- Role: administrator ----------------------------------------------------


def admin_home_nav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon="🖥️")


def manage_courts_nav():
    st.sidebar.page_link("pages/22_Manage_Courts.py", label="Manage Courts", icon="🏀")


def moderate_reviews_nav():
    st.sidebar.page_link("pages/23_Manage_Reviews.py", label="Moderate Reviews", icon="⭐")


def manage_players_nav():
    st.sidebar.page_link("pages/24_Manage_Players.py", label="Manage Players", icon="👥")


# ---- Role: data_analyst -----------------------------------------------------


def analyst_overview_nav():
    st.sidebar.page_link("pages/40_Analyst_Profile.py", label="Overview", icon="📊")


def analyst_dashboard_nav():
    st.sidebar.page_link("pages/41_Analyst_Dashboard.py", label="Dashboards", icon="📈")


def analyst_heatmap_nav():
    st.sidebar.page_link("pages/42_Analyst_Heatmap.py", label="Heatmap", icon="🗺️")


def analyst_courts_nav():
    st.sidebar.page_link("pages/43_Analyst_Courts.py", label="Court Details", icon="🏀")


def analyst_csv_nav():
    st.sidebar.page_link("pages/44_Analyst_CSV.py", label="CSV Export", icon="📥")


# ---- Role: data_analyst -----------------------------------------------------

def analyst_overview_nav():
    st.sidebar.page_link("pages/03_Analyst_Profile.py", label="Overview", icon="📊")

def analyst_dashboard_nav():
    st.sidebar.page_link("pages/04_Analyst_Dashboard.py", label="Dashboards", icon="📈")

def analyst_heatmap_nav():
    st.sidebar.page_link("pages/05_Analyst_Heatmap.py", label="Heatmap", icon="🗺️")

def analyst_courts_nav():
    st.sidebar.page_link("pages/06_Analyst_Courts.py", label="Court Details", icon="🏀")

def analyst_csv_nav():
    st.sidebar.page_link("pages/07_Analyst_CSV.py", label="CSV Export", icon="📥")

# ---- Sidebar assembly -------------------------------------------------------


def SideBarLinks(show_home=False):
    """
    Renders sidebar navigation links based on the logged-in user's role.
    The role is stored in st.session_state when the user logs in on Home.py.
    """

    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")
        st.stop

    if show_home:
        home_nav()


    if st.session_state["authenticated"]:
        if st.session_state["role"] == "pickup_player":
            pickup_home_nav()
            pickup_profile_nav()
            write_review_nav()
            log_game_nav()

        if st.session_state["role"] == "competitive_player":
            competitive_home_nav()
            leaderboard_nav()
            tournaments_nav()
            my_games_nav()

        if st.session_state["role"] == "administrator":
            admin_home_nav()
            manage_courts_nav()
            moderate_reviews_nav()
            manage_players_nav()

        if st.session_state["role"] == "data_analyst":
            analyst_overview_nav()
            analyst_dashboard_nav()
            analyst_heatmap_nav()
            analyst_courts_nav()
            analyst_csv_nav()

        
        if st.session_state["role"] == "data_analyst":
            analyst_overview_nav()
            analyst_dashboard_nav()
            analyst_heatmap_nav()
            analyst_courts_nav()
            analyst_csv_nav()

    if st.session_state["authenticated"]:
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
