# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has functions to add links to the left sidebar based on the user's role.

import streamlit as st


# ---- General ----------------------------------------------------------------

def home_nav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def about_page_nav():
    st.sidebar.page_link("pages/30_About.py", label="About", icon="ℹ️")


# ---- Role: analyst ------------------------------------------------

def analyst_home_nav():
    st.sidebar.page_link(
        "pages/00_Analyst_Home.py", label="Home", icon="🏠"
    )


def analyst_dashboard_nav():
    st.sidebar.page_link(
        "pages/01_Accessibility_Dashboard.py", label="Dashboard", icon="📊"
    )


def analyst_reports_nav():
    st.sidebar.page_link(
        "pages/03_View_Reports.py", label="Reports", icon="📋"
    )


def analyst_trends_nav():
    st.sidebar.page_link("pages/02_Analyst_Trends_Exports.py", label="Trends", icon="📈")


# ---- Role: user -----------------------------------------------------

def user_home_nav():
    st.sidebar.page_link(
        "pages/10_Basic_User_Home.py", label="Home", icon="🏠"
    )

def report_obstruction_nav():
    st.sidebar.page_link(
        "pages/11_Report_Obstruction.py", label="Report", icon="📝"
    )

def find_accessibility_info_nav():
    st.sidebar.page_link("pages/12_Find_Accessibility_Info.py", label="Accessibility Info", icon="♿")

def user_profile_nav():
    st.sidebar.page_link("pages/16_User_View_Profile.py", label="Profile", icon="👤")



# ---- Role: admin ----------------------------------------------------

def admin_home_nav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="Home", icon="🏠")


def manage_users_nav():
    st.sidebar.page_link(
        "pages/21_Manage_Users.py", label="Manage Users", icon="👥"
    )


def manage_reports_nav():
    st.sidebar.page_link(
        "pages/03_View_Reports.py", label="Manage Reports", icon="🗂️"
    )


# ---- Sidebar assembly -------------------------------------------------------

def SideBarLinks(show_home=False):
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
        home_nav()

    if st.session_state["authenticated"]:

        if st.session_state["role"] == "analyst":
            analyst_home_nav()
            analyst_dashboard_nav()
            analyst_reports_nav()
            analyst_trends_nav()

        if st.session_state["role"] == "user":
            user_home_nav()
            report_obstruction_nav()
            find_accessibility_info_nav()
            user_profile_nav()

        if st.session_state["role"] == "admin":
            admin_home_nav()
            analyst_dashboard_nav()
            analyst_reports_nav()
            analyst_trends_nav()
            manage_users_nav()
            manage_reports_nav()

    # About link appears at the bottom for all roles
    about_page_nav()

    if st.session_state["authenticated"]:
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
