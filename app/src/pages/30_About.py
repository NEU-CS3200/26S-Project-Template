import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.markdown("# About Bostonability")
st.divider()

st.markdown("""
**Bostonability** is an accessibility reporting and analytics platform for the city of Boston.
Our mission is to make Boston more navigable for everyone — especially individuals with
disabilities — by surfacing accessibility issues, tracking their resolution, and empowering
residents and city analysts with real-time data.

---

### What We Do

- **Report Obstructions** — Residents can submit accessibility reports for issues like broken
  ramps, inaccessible entrances, blocked sidewalks, and transport barriers across Boston neighborhoods.

- **Track & Resolve** — Every report is tracked through a full lifecycle: Open → In Progress →
  Resolved/Closed. High-priority issues are flagged for immediate attention.

- **Analyze Trends** — Data analysts can explore reports over time, filter by neighborhood and
  issue type, and identify where accessibility problems are most concentrated.

- **Manage the System** — Administrators can oversee all reports and users, ensuring data
  quality and operational efficiency.

---

### Who Uses Bostonability?

| Role | Description |
|------|-------------|
| **Residents / Daily Users** | Submit reports, find accessibility info, and track their own submissions. |
| **Data Analysts** | Explore dashboards, trends, and detailed report data across the city. |
| **System Administrators** | Manage users, review all reports, and maintain platform integrity. |

---

### Neighborhoods Covered
Roxbury · Allston · South End · Back Bay · Jamaica Plain · and more

---

*Built for CS 3200 — Northeastern University, Spring 2026*
""")

st.divider()

# Return home based on login state and role
role_home = {
    "analyst": "pages/00_Analyst_Home.py",
    "user":    "pages/10_Basic_User_Home.py",
    "admin":   "pages/20_Admin_Home.py",
}

if st.button("Return Home", type="primary"):
    if st.session_state.get("authenticated") and st.session_state.get("role") in role_home:
        st.switch_page(role_home[st.session_state["role"]])
    else:
        st.switch_page("Home.py")
