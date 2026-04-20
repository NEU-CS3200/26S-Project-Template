# Navigation control for all roles in NutriTracker
# Role-based links are rendered based on st.session_state["role"] set in Home.py

import streamlit as st


# ---- General ----------------------------------------------------------------

def home_nav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


# ---- Role: performer --------------------------------------------------------

def performer_home_nav():
    st.sidebar.page_link("pages/10_Performer_Home.py", label="Jordan Home", icon="🎤")


def performer_location_nav():
    st.sidebar.page_link("pages/11_Performer_Location_Map.py", label="Dining Locations", icon="🍛")


def performer_menu_nav():
    st.sidebar.page_link("pages/12_Performer_Menu_Browse.py", label="Menu Browse", icon="📖")


def performer_saved_meals_nav():
    st.sidebar.page_link("pages/13_Performer_Saved_Meals.py", label="Saved Meals", icon="⭐")


# ---- Role: athlete ----------------------------------------------------------

def athlete_home_nav():
    st.sidebar.page_link("pages/20_Athlete_Home.py", label="Jason Home", icon="⚽")


def athlete_daily_nutrition_nav():
    st.sidebar.page_link("pages/21_Athlete_Daily_Nutrition.py", label="Daily Nutrition", icon="📊")


def athlete_log_meal_nav():
    st.sidebar.page_link("pages/22_Athlete_Log_Meal.py", label="Log Meal", icon="📝")


def athlete_weekly_history_nav():
    st.sidebar.page_link("pages/23_Athlete_Weekly_History.py", label="Weekly History", icon="📈")


# ---- Role: analyst ----------------------------------------------------------

def analyst_home_nav():
    st.sidebar.page_link("pages/30_Analyst_Home.py", label="Immanuel Home", icon="📊")


def analyst_filter_visualize_nav():
    st.sidebar.page_link("pages/31_Analyst_Filter_Visualize.py", label="Filter & Visualize", icon="📉")


def analyst_export_config_nav():
    st.sidebar.page_link("pages/32_Analyst_Export_Config.py", label="Export Config", icon="📁")


def analyst_outliers_nav():
    st.sidebar.page_link("pages/33_Analyst_Outliers.py", label="Outlier Detection", icon="🎯")


# ---- Role: administrator ----------------------------------------------------

def admin_home_nav():
    st.sidebar.page_link("pages/40_Admin_Home.py", label="Laura Home", icon="🔐")


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

        # Performer persona (Jordan Carter)
        if st.session_state["role"] == "performer":
            performer_home_nav()
            performer_location_nav()
            performer_menu_nav()
            performer_saved_meals_nav()

        # Athlete persona (Jason Batum)
        elif st.session_state["role"] == "athlete":
            athlete_home_nav()
            athlete_daily_nutrition_nav()
            athlete_log_meal_nav()
            athlete_weekly_history_nav()

        # Analyst persona (Immanuel Hoffborne)
        elif st.session_state["role"] == "analyst":
            analyst_home_nav()
            analyst_filter_visualize_nav()
            analyst_export_config_nav()
            analyst_outliers_nav()

        # Administrator persona (Laura Smith)
        elif st.session_state["role"] == "administrator":
            admin_home_nav()

    if st.session_state["authenticated"]:
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            del st.session_state.get("user_id", None)
            del st.session_state.get("first_name", None)
            st.switch_page("Home.py")
