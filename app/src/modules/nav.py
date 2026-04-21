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


# ---- Role: competitive_player -----------------------------------------------


def leaderboard_nav():
    st.sidebar.page_link("pages/11_Leaderboard.py", label="Leaderboard", icon="🏆")


def tournaments_nav():
    st.sidebar.page_link("pages/12_Tournaments.py", label="Tournaments", icon="🥇")


# ---- Role: administrator ----------------------------------------------------


def admin_home_nav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon="🖥️")


def manage_courts_nav():
    st.sidebar.page_link("pages/22_Manage_Courts.py", label="Manage Courts", icon="🏀")


def moderate_reviews_nav():
    st.sidebar.page_link(
        "pages/23_Manage_Reviews.py", label="Moderate Reviews", icon="⭐"
    )


# ---- Sidebar assembly -------------------------------------------------------


def SideBarLinks(show_home=False):
    """
    Renders sidebar navigation links based on the logged-in user's role.
    The role is stored in st.session_state when the user logs in on Home.py.
    """

    # If no one is logged in, send them to the Home (login) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        home_nav()

    if st.session_state["authenticated"]:
        if st.session_state["role"] == "pickup_player":
            pickup_home_nav()
            pickup_profile_nav()

        if st.session_state["role"] == "competitive_player":
            leaderboard_nav()
            tournaments_nav()

        if st.session_state["role"] == "administrator":
            admin_home_nav()
            manage_courts_nav()
            moderate_reviews_nav()

    if st.session_state["authenticated"]:
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
