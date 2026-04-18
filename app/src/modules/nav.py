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


# ---- Role: usaid_worker -----------------------------------------------------


def usaid_worker_home_nav():
    st.sidebar.page_link(
        "pages/10_USAID_Worker_Home.py", label="USAID Worker Home", icon="🏠"
    )


def ngo_directory_nav():
    st.sidebar.page_link("pages/14_NGO_Directory.py", label="NGO Directory", icon="📁")


def add_ngo_nav():
    st.sidebar.page_link("pages/15_Add_NGO.py", label="Add New NGO", icon="➕")


def prediction_nav():
    st.sidebar.page_link(
        "pages/11_Prediction.py", label="Regression Prediction", icon="📈"
    )


def api_test_nav():
    st.sidebar.page_link("pages/12_API_Test.py", label="Test the API", icon="🛜")


def classification_nav():
    st.sidebar.page_link(
        "pages/13_Classification.py", label="Classification Demo", icon="🌺"
    )


# ---- Role: administrator ----------------------------------------------------


def admin_home_nav():
    st.sidebar.page_link("pages/20_Admin_Home.py", label="System Admin", icon="🖥️")


def ml_model_mgmt_nav():
    st.sidebar.page_link(
        "pages/21_ML_Model_Mgmt.py", label="ML Model Management", icon="🏢"
    )


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

    # If no one is logged in, send them to the Home (login) page
    if "authenticated" not in st.session_state:
        st.session_state.authenticated = False
        st.switch_page("Home.py")
        st.stop

    if show_home:
        home_nav()

    st.sidebar.button("TEST BUTTON")  # ← totally outside any if block
    st.sidebar.write(f"DEBUG role: {st.session_state.get('role', 'MISSING')}")
    st.sidebar.write(f"DEBUG auth: {st.session_state.get('authenticated', 'MISSING')}")

    if st.session_state["authenticated"]:
        if st.session_state["role"] == "pickup_player":
            st.sidebar.write("DEBUG: role is data_analyst")
            pickup_home_nav()
            pickup_profile_nav()

        if st.session_state["role"] == "usaid_worker":
            usaid_worker_home_nav()
            ngo_directory_nav()
            add_ngo_nav()
            prediction_nav()
            api_test_nav()
            classification_nav()

        if st.session_state["role"] == "administrator":
            admin_home_nav()
            ml_model_mgmt_nav()

        
        if st.session_state["role"] == "data_analyst":
            st.sidebar.write("DEBUG: role is data_analyst")
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
