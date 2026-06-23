import streamlit as st


def SideBarLinks(show_home=False):
    """
    Display the sidebar with links to different pages of the GameGoats application.

    This is just a simple implementation for now. Will expand it later to show different links based on the user stories and roles.

    Args:
        show_home (bool): Whether to show the Home link in the sidebar. Default is False
    
    Returns:
        None
    """
    st.sidebar.image("assets/logo.png", width=150)

    if show_home:
        st.sidebar.page_link("Home.py", label="Home")

    st.sidebar.page_link("pages/00_Player_Home.py", label="Player Home")
    st.sidebar.page_link("pages/10_Moderator_Home.py", label="Moderator Home")
    st.sidebar.page_link("pages/20_Admin_Home.py", label="Admin Home")
    st.sidebar.page_link("pages/14_Container_Status.py", label="Container Status")
    st.sidebar.page_link("pages/15_REST_API_Scope.py", label="REST API Scope")
    st.sidebar.page_link("pages/16_Branching_Rules.py", label="Branching Rules")
    st.sidebar.page_link("pages/21_Phase1_Checklist.py", label="Phase 1 Checklist")
    st.sidebar.page_link("pages/30_About.py", label="About")
