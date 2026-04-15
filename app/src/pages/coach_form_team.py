import streamlit as st
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="coach_persona")

# -------------------------------------------------------
# Enums / Mock Data
# -------------------------------------------------------
LEAGUES = [
    "Mens Basketball",
    "Mens Volleyball",
    "Women's Tennis",
    "Co-ed Soccer",
    "Women's Softball",
    "Mens Hockey",
]

SKILL_LEVELS = [
    "Beginner",
    "Recreational",
    "Intermediate",
    "Competitive",
]

ROLES = [
    "Player",
    "Asst. Coach",
    "Analyst",
]

NUM_INVITE_ROWS = 4

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            .invite-label {
                font-family: monospace;
                font-size: 15px;
                margin-bottom: 12px;
                color: #333;
            }
            div[data-testid="stTextInput"] label,
            div[data-testid="stSelectbox"] label {
                display: none;
            }
            div[data-testid="stButton"] {
                margin-top: 4px;
            }
        </style>
    """, unsafe_allow_html=True)


# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()
    st.markdown("<h1 style='font-family:monospace; text-align:center;'>Form Team</h1>", unsafe_allow_html=True)

    col_name, _ = st.columns([2, 5])
    with col_name:
        st.text_input("team_name", placeholder="Team Name", label_visibility="collapsed")

    # Top action row
    col1, col2, col3, spacer, col4 = st.columns([2, 2, 2, 3, 2])
    with col1:
        st.selectbox("League", LEAGUES, label_visibility="collapsed")
    with col2:
        st.selectbox("Skill Level", SKILL_LEVELS, label_visibility="collapsed")
    with col3:
        st.button("Upload Team Logo", use_container_width=True)
    with col4:
        st.button("Finalize", type="primary", use_container_width=True)

    st.markdown("<br>", unsafe_allow_html=True)

    # Invite Players section
    st.markdown('<div class="invite-label">Invite Players</div>', unsafe_allow_html=True)

    if "invite_rows" not in st.session_state:
        st.session_state["invite_rows"] = [
            {"name": "", "email": "", "role": ROLES[0]} for _ in range(NUM_INVITE_ROWS)
        ]

    for i, row in enumerate(st.session_state["invite_rows"]):
        c1, c2, c3 = st.columns([3, 5, 2])
        with c1:
            st.session_state["invite_rows"][i]["name"] = st.text_input(
                f"name_{i}",
                value=row["name"],
                placeholder="Name",
                label_visibility="collapsed",
            )
        with c2:
            st.session_state["invite_rows"][i]["email"] = st.text_input(
                f"email_{i}",
                value=row["email"],
                placeholder="Enter Email",
                label_visibility="collapsed",
            )
        with c3:
            st.session_state["invite_rows"][i]["role"] = st.selectbox(
                f"role_{i}",
                ROLES,
                index=ROLES.index(row["role"]),
                label_visibility="collapsed",
            )

    st.markdown("<br>", unsafe_allow_html=True)
    if st.button("+ Add Player"):
        st.session_state["invite_rows"].append({"name": "", "email": "", "role": ROLES[0]})
        st.rerun()


show()