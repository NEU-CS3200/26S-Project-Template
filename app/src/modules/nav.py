# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has functions to add links to the left sidebar based on the user's role.

import streamlit as st


# ---- General ----------------------------------------------------------------
def add_space():
    st.sidebar.markdown("<br>", unsafe_allow_html=True)  # adds space

def add_line_break():
    st.sidebar.markdown("""
        <hr style="margin: 4px 0;">
    """, unsafe_allow_html=True)

def home_nav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")

def player_persona_nav():
    st.sidebar.page_link("pages/player_browse_profile.py", label="My Profile", icon="🔎")
    st.sidebar.page_link("pages/player_browse_leagues.py", label="Browse Leagues", icon="🔎")
    st.sidebar.page_link("pages/player_browse_scheduled_games.py", label="Schedule", icon="🔎")

def coach_persona_nav():
    st.sidebar.page_link("pages/coach_team_dashboard.py", label="My Team", icon="🔎")
    st.sidebar.page_link("pages/coach_manage_team.py", label="Manage Team", icon="🔎")
    st.sidebar.page_link("pages/coach_form_team.py", label="Make New Team", icon="🔎")

def league_administrator_nav():
    st.sidebar.page_link("pages/league_admin_venue_schedule.py", label="Venue Schedule", icon="🔎")
    st.sidebar.page_link("pages/league_admin_manage_league.py", label="Manage Leagues", icon="🔎")
    st.sidebar.page_link("pages/league_admin_disputes.py", label="Manage Disputes", icon="🔎")

def analyst_nav():
    st.sidebar.page_link("pages/analyst_intramural_report.py", label="Intramural Report", icon="🔎")
    st.sidebar.page_link("pages/analyst_venue_report.py", label="Venue Report", icon="🔎")
    st.sidebar.page_link("pages/analyst_team_report.py", label="Team Report", icon="🔎")

def SideBarLinks(show_home=False, userAuthStatus=None):

    """ 
        Renders sidebar navigation links based on the logged-in user's role.
        The role is stored in st.session_state when the user logs in on Home.py.
    """

    # Logo appears at the top of the sidebar on every page
    st.sidebar.image("assets/logo.png", width=150)

    # If no one is logged in, send them to the Home (login) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")

    if show_home:
        add_space()
        home_nav()

    if userAuthStatus == "player_persona":
        add_space()
        home_nav()
        add_line_break()
        player_persona_nav()
        add_space()
        
    if userAuthStatus == "coach_persona":
        add_space()
        home_nav()
        add_line_break()
        coach_persona_nav()
        add_space()

    if userAuthStatus == "league_admin_persona":
        add_space()
        home_nav()
        add_line_break()
        league_administrator_nav()
        add_space() 
    
    if userAuthStatus == "analyst_persona":
        add_space()
        home_nav()
        add_line_break()
        analyst_nav()
        add_space() 
        

    if st.session_state["authenticated"]:
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
