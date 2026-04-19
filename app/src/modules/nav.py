import streamlit as st

# ---- General ------------------------------------------------------------

def home_nav():
    st.sidebar.page_link("Home.py", label="Home", icon="🏠")

def about_page_nav():
    st.sidebar.page_link("pages/99_About.py", label="About", icon="🧠")


# ---- Role: Student ------------------------------------------------------

def student_home_nav():
    st.sidebar.page_link("pages/00_Student_Home.py", label="Student Home", icon="🎓")

def student_applications_nav():
    st.sidebar.page_link("pages/01_Student_Applications.py", label="Student Applications", icon="📄")

def student_offers_nav():
    st.sidebar.page_link("pages/02_Student_Offers.py", label="Student Offers", icon="💼")

def student_reminders_nav():
    st.sidebar.page_link("pages/03_Student_Reminders.py", label="Student Reminders", icon="⏰")


# ---- Role: Analyst ------------------------------------------------------

def analyst_home_nav():
    st.sidebar.page_link("pages/10_Analyst_Home.py", label="Analyst Home", icon="📊")

def analytics_dashboard_nav():
    st.sidebar.page_link("pages/17_Analytics_Dashboard.py", label="Analytics Dashboard", icon="📈")

def trends_nav():
    st.sidebar.page_link("pages/12_Trends.py", label="Trends", icon="📉")

def salary_nav():
    st.sidebar.page_link("pages/13_Salary_Insights.py", label="Salary Insights", icon="💰")


# ---- Role: Recruiter ----------------------------------------------------

def recruiter_home_nav():
    st.sidebar.page_link("pages/20_Recruiter_Home.py", label="Recruiter Home", icon="🤝")

def candidates_nav():
    st.sidebar.page_link("pages/21_Candidates.py", label="Candidates", icon="🧑‍💼")

def candidate_profile_nav():
    st.sidebar.page_link("pages/22_Candidate_Profile.py", label="Candidate Profile", icon="👤")

def recruiter_notes_nav():
    st.sidebar.page_link("pages/23_Recruiter_Notes.py", label="Recruiter Notes", icon="📝")


# <<<<<<< HEAD
# # ---- Role: Administrator -----------------------------------------------

# def admin_home_nav():
#     st.sidebar.page_link("pages/30_Admin_Home.py", label="Admin Home", icon="🖥️")

# def system_logs_nav():
#     st.sidebar.page_link("pages/31_System_Logs.py", label="System Logs", icon="📋")

# def health_metrics_nav():
#     st.sidebar.page_link("pages/32_Health_Metrics.py", label="Health Metrics", icon="❤️")

# def user_management_nav():
#     st.sidebar.page_link("pages/33_User_Management.py", label="User Management", icon="👥")


# # ---- Sidebar Builder ----------------------------------------------------

# def SideBarLinks(show_home=False):
#     st.sidebar.image("assets/logo.png", width=150)
# =======
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


# ---- Role: recruiter --------------------------------------------------------

def recruiter_home_nav():
    st.sidebar.page_link("pages/90_Recruiter_Home.py", label="Recruiter Home", icon="👔")


def candidate_pipeline_nav():
    st.sidebar.page_link("pages/91_Candidate_Pipeline.py", label="Candidate Pipeline", icon="📋")


def candidate_profile_nav():
    st.sidebar.page_link("pages/92_Candidate_Profile.py", label="Candidate Profile", icon="👤")


def pipeline_stats_nav():
    st.sidebar.page_link("pages/93_Pipeline_Stats.py", label="Pipeline Stats", icon="📊")


# ---- Role: Administrator -----------------------------------------------

# def admin_home_nav():
#     st.sidebar.page_link("pages/30_Admin_Home.py", label="Admin Home", icon="🖥️")

# def ml_model_mgmt_nav():
#     st.sidebar.page_link(
#         "pages/21_ML_Model_Mgmt.py", label="ML Model Management", icon="🏢"
#     )

def admin_dashboard_nav():
    st.sidebar.page_link("pages/30_Admin_Dashboard.py", label="Dashboard", icon="🖥️")

def admin_users_nav():
    st.sidebar.page_link("pages/31_User_Management_.py", label="User Management", icon="🖥️")

def admin_errors_nav():
    st.sidebar.page_link("pages/32_Error_Logs.py", label="Error Logs", icon="🖥️")

def admin_cleanup_nav():
    st.sidebar.page_link("pages/33_Data_Cleanup.py", label="Data Cleanup", icon="🖥️")


# ---- Role: job_seeker -------------------------------------------------------

def job_seeker_home_nav():
    st.sidebar.page_link(
        "pages/40_Job_Seeker_Home.py", label="Job Seeker Home", icon="🏠"
    )


def my_applications_nav():
    st.sidebar.page_link(
        "pages/41_My_Applications.py", label="My Applications", icon="📋"
    )


def reminders_nav():
    st.sidebar.page_link(
        "pages/42_Reminders.py", label="Reminders", icon="⏰"
    )


def offers_nav():
    st.sidebar.page_link(
        "pages/43_Offers.py", label="Compare Offers", icon="💼"
    )


# ---- Sidebar Builder ----------------------------------------------------

def SideBarLinks(show_home=False):
    # st.sidebar.image("assets/logo.png", width=150)
    if "authenticated" in st.session_state and st.session_state.get("role") == "administrator":
        st.sidebar.image("assets/OfferWatchAdminLogo.png", width=150)
    else:
        st.sidebar.image("assets/logo.png", width=150)

    if "authenticated" not in st.session_state:
        st.session_state["authenticated"] = False
        st.switch_page("Home.py")

    if show_home:
        home_nav()


    if st.session_state["authenticated"]:

        if st.session_state["role"] == "analyst":
            analyst_home_nav()
            analytics_dashboard_nav()
            trends_nav()
            salary_nav()

        if st.session_state["role"] == "administrator":
            admin_dashboard_nav()
            admin_users_nav()
            admin_errors_nav()
            admin_cleanup_nav()

        if st.session_state["role"] == "job_seeker":
            job_seeker_home_nav()
            my_applications_nav()
            reminders_nav()
            offers_nav()

        if st.session_state["role"] == "recruiter":
            recruiter_home_nav()
            candidate_pipeline_nav()
            pipeline_stats_nav()

    about_page_nav()

    if st.session_state["authenticated"]:
        if st.sidebar.button("Logout"):
            del st.session_state["role"]
            del st.session_state["authenticated"]
            st.switch_page("Home.py")