import logging
logger = logging.getLogger(__name__)

import requests
import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(page_title="My Profile | Bostonability", layout="wide")
SideBarLinks()

st.markdown("## My Profile")
st.caption("Manage your account information and accessibility preferences.")

API_BASE = "http://web-api:4000"
user_id  = st.session_state.get("user_id", 1)
first    = st.session_state.get("first_name", "User")


def fetch_user(uid):
    r = requests.get(f"{API_BASE}/users/{uid}", timeout=10)
    r.raise_for_status()
    return r.json()


try:
    user = fetch_user(user_id)
except Exception:
    user = {
        "first_name": first,
        "last_name": "",
        "email": "",
        "phone": "",
        "disability_types": [],
        "wheelchair_width": 24,
        "wheelchair_electric": False,
        "uses_white_cane": False,
    }

st.divider()

DISABILITY_OPTIONS = [
    "Wheelchair",
    "Sight impairment",
    "Walking stick / cane",
    "None / prefer not to say",
]

stored = user.get("disability_types") or user.get("disability_type") or []
if isinstance(stored, str):
    stored = [stored] if stored else []
current_disabilities = [d for d in stored if d in DISABILITY_OPTIONS]

left_col, right_col = st.columns([1, 2])

with left_col:
    st.markdown(
        f"""
        <div style="background:#f0f4ff;border-radius:14px;padding:24px 20px;
                    border:1.5px solid #6550e6;">
            <div style="text-align:center;font-weight:700;font-size:1.1rem;
                        margin-top:8px;">
                {user.get('first_name', '')} {user.get('last_name', '')}
            </div>
            <div style="text-align:center;color:#888;font-size:0.85rem;">
                Member - ID {user_id}
            </div>
        </div>
        """,
        unsafe_allow_html=True,
    )

    st.markdown("<br>", unsafe_allow_html=True)

    st.markdown("**Disability / Mobility Profile**")
    st.caption("Select all that apply.")
    selected_disabilities = st.multiselect(
        "Disability types",
        DISABILITY_OPTIONS,
        default=current_disabilities,
        label_visibility="collapsed",
    )

with right_col:
    st.markdown("#### Account Information")
    with st.form("profile_form"):
        c1, c2 = st.columns(2)
        with c1:
            new_first = st.text_input("First Name", value=user.get("first_name", ""))
        with c2:
            new_last = st.text_input("Last Name", value=user.get("last_name", ""))

        new_email = st.text_input("Email", value=user.get("email", ""),
                                  placeholder="your@email.com")
        new_phone = st.text_input("Phone", value=user.get("phone", ""),
                                  placeholder="617-555-0000")

        st.markdown("---")
        st.markdown("#### Accessibility Preferences")

        if "Wheelchair" in selected_disabilities:
            st.markdown("**Wheelchair details**")
            wc1, wc2 = st.columns(2)
            with wc1:
                wheel_diameter = st.number_input("Wheel diameter (in)",
                                                 value=int(user.get("wheel_diameter", 24)),
                                                 min_value=10, max_value=40, step=1)
                chair_width = st.number_input("Chair width (in)",
                                              value=int(user.get("wheelchair_width", 24)),
                                              min_value=10, max_value=40, step=1)
            with wc2:
                electric = st.checkbox("Electric wheelchair",
                                       value=bool(user.get("wheelchair_electric", False)))

        if "Sight impairment" in selected_disabilities:
            st.markdown("**Sight impairment details**")
            white_cane = st.checkbox("Uses white cane",
                                     value=bool(user.get("uses_white_cane", False)))

        if "Walking stick / cane" in selected_disabilities:
            st.markdown("**Mobility aid details**")
            st.checkbox("Uses walking stick", value=True, disabled=True)

        if not selected_disabilities or selected_disabilities == ["None / prefer not to say"]:
            st.info("No accessibility-specific preferences needed.")

        save_btn = st.form_submit_button("Save Profile", type="primary",
                                         use_container_width=True)

    if save_btn:
        payload = {
            "first_name": new_first.strip(),
            "last_name": new_last.strip(),
            "email": new_email.strip(),
            "phone": new_phone.strip(),
            "disability_types": selected_disabilities,
        }
        if "Wheelchair" in selected_disabilities:
            payload["wheelchair_width"] = chair_width
            payload["wheelchair_electric"] = electric
        if "Sight impairment" in selected_disabilities:
            payload["uses_white_cane"] = white_cane

        try:
            r = requests.put(f"{API_BASE}/users/{user_id}", json=payload, timeout=10)
            r.raise_for_status()
            st.success("Profile updated successfully!")
            st.session_state["first_name"] = new_first.strip()
            st.cache_data.clear()
        except Exception as e:
            st.error(f"Update failed: {e}")

st.divider()
st.markdown("#### Quick Navigation")
qn1, qn2, qn3 = st.columns(3)
with qn1:
    if st.button("Find Accessibility Info", use_container_width=True, key="nav_acc"):
        st.switch_page("pages/12_Find_Accessibility_Info.py")
with qn2:
    if st.button("Report an Issue", use_container_width=True, key="nav_rep"):
        st.switch_page("pages/11_Report_Obstruction.py")
with qn3:
    if st.button("My Reports", use_container_width=True, key="nav_myrep"):
        st.switch_page("pages/13_My_Reports.py")