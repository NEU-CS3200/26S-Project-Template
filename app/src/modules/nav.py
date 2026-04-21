# Idea borrowed from https://github.com/fsmosca/sample-streamlit-authenticator

# This file has functions to add links to the left sidebar based on the user's role.

import streamlit as st


# ---- General ----------------------------------------------------------------

def home_nav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")


def about_page_nav():
    st.sidebar.page_link("pages/about.py", label="About", icon="🧠")



# example---- Role: usaid_worker -----------------------------------------------------

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


# ---- Role: attendee ------------------------------------------------

def attendee_home_nav():
    st.sidebar.page_link("pages/attendee.py", label="Attendee Home", icon="🏠")

def view_events_nav():
    st.sidebar.page_link("pages/view_events.py", label="Browse Events", icon="🔎")

def view_feed_nav():
    st.sidebar.page_link("pages/view_feed.py", label="My Feed", icon="📰")

def view_attendee_events_nav():
    st.sidebar.page_link("pages/view_attendee_events.py", label="My RSVPs", icon="📅")

def view_events_list_nav():
    st.sidebar.page_link("pages/view_events_list.py", label="Saved Events", icon="⭐")

def view_event_reviews_nav():
    st.sidebar.page_link("pages/view_event_reviews.py", label="Reviews", icon="✍️")

#---- Role: performer ------------------------------------------------

def performer_home_nav():
    st.sidebar.page_link("pages/40_performer_home.py", label="Performer Home", icon="🏠")

def performer_profile_nav():
    st.sidebar.page_link("pages/41_performer_profile.py", label="My Profile", icon="👤")

def performer_bookings_nav():
    st.sidebar.page_link("pages/42_performer_bookings.py", label="My Bookings", icon="📋")

def performer_performances_nav():
    st.sidebar.page_link("pages/43_Performer_Performances.py", label="My Performances", icon="🎤")


#---- Role: organizer ------------------------------------------------

def organizer_home_nav():
    st.sidebar.page_link("pages/organizer.py", label="Organizer Home", icon="🏠")

def organizer_profile_nav():
    st.sidebar.page_link("pages/organizer_profile.py", label="My Profile", icon="👤")

def post_event_nav():
    st.sidebar.page_link("pages/post_event.py", label="Post Event", icon="➕")

def update_event_nav():
    st.sidebar.page_link("pages/update_event.py", label="Update Event", icon="✏️")

def delete_event_nav():
    st.sidebar.page_link("pages/delete_event.py", label="Delete Event", icon="🗑️")

def get_events_nav():
    st.sidebar.page_link("pages/get_events.py", label="View Your Events", icon="🔎")

def get_performers_nav():
    st.sidebar.page_link("pages/get_performers.py", label="Browse Performers", icon="🎭")

def get_venues_organizer_nav():
    st.sidebar.page_link("pages/get_venues.py", label="Browse Venues", icon="🏟️")


# ---- Role: Venue Owner ------------------------------------------------

def venue_owner_home_nav():
    st.sidebar.page_link("pages/venue_owner.py", label="Venue Owner Home", icon="🏠")

def owner_nav():
    st.sidebar.page_link("pages/owner.py", label="My Venues", icon="🏟️")

def get_venues_nav():
    st.sidebar.page_link("pages/get_venues.py", label="Browse Venues", icon="🔎")

def post_venue_request_nav():
    st.sidebar.page_link("pages/post_venue_request.py", label="Post Venue Request", icon="➕")

def view_request_nav():
    st.sidebar.page_link("pages/view_request.py", label="View Requests", icon="📋")


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
        #example
        if st.session_state["role"] == "pol_strat_advisor":
            pol_strat_home_nav()
            world_bank_viz_nav()
            map_demo_nav()

        if st.session_state["role"] == "attendee":
            attendee_home_nav()
            view_events_nav()
            view_feed_nav()
            view_attendee_events_nav()
            view_events_list_nav()
            view_event_reviews_nav()
           
        if st.session_state["role"] == "performer":
            performer_home_nav()
            performer_profile_nav()
            performer_bookings_nav()
            performer_performances_nav()

        if st.session_state["role"] == "organizer":
            organizer_home_nav()
            organizer_profile_nav()
            post_event_nav()
            update_event_nav()
            delete_event_nav()
            get_events_nav()
            get_performers_nav()
            get_venues_organizer_nav()

        if st.session_state["role"] == "venue_owner":
            venue_owner_home_nav()
            owner_nav()
            get_venues_nav()
            post_venue_request_nav()
            view_request_nav()
         

    # About link appears at the bottom for all roles
    about_page_nav()

    if st.session_state["authenticated"]:
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")
