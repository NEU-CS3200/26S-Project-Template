import logging
logger = logging.getLogger(__name__)

import requests
import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(page_title="Manage Users | Bostonability", layout="wide")
SideBarLinks()

st.markdown("## Manage Users")
st.caption("View, edit roles, manage access, and monitor user activity.")

API_BASE = "http://web-api:4000"
ROLES = ["user", "analyst", "admin"]


def fetch_users():
    r = requests.get(f"{API_BASE}/users", timeout=10)
    r.raise_for_status()
    return r.json()


try:
    users = fetch_users()
except Exception as e:
    st.error("Cannot reach API.")
    st.code(str(e))
    st.stop()

if not users:
    st.info("No users found.")
    st.stop()

col_s, col_r = st.columns([3, 1])
with col_s:
    search = st.text_input("Search or Filter for Users", placeholder="Name, email, role")
with col_r:
    role_filter = st.selectbox("Role", ["All"] + ROLES)

st.divider()

filtered_users = users
if search.strip():
    q = search.strip().lower()
    filtered_users = [
        u for u in filtered_users
        if q in (u.get("first_name", "") + " " + u.get("last_name", "")).lower()
        or q in str(u.get("email", "")).lower()
        or q in str(u.get("role", "")).lower()
    ]
if role_filter != "All":
    filtered_users = [u for u in filtered_users if u.get("role") == role_filter]

st.markdown(f"**{len(filtered_users)} user{'s' if len(filtered_users) != 1 else ''} found**")

list_col, log_col = st.columns([3, 2])

with log_col:
    st.markdown("#### Console Log")
    if "console_log" not in st.session_state:
        st.session_state["console_log"] = []
    log_text = "\n".join(st.session_state["console_log"][-20:]) or "No actions yet."
    st.text_area("Activity", value=log_text, height=400,
                 disabled=True, label_visibility="collapsed")

with list_col:
    st.markdown("#### Users")

    for u in filtered_users:
        uid       = u.get("user_id")
        full_name = f"{u.get('first_name', '')} {u.get('last_name', '')}".strip()
        role      = u.get("role", "user")
        email     = u.get("email", "N/A")
        phone     = u.get("phone", "N/A")
        is_active = u.get("is_active", True)

        status_label = "Active" if is_active else "Suspended"

        with st.expander(f"{full_name}  |  Role: {role}  |  {status_label}"):
            st.markdown("**Information**")
            st.write(f"Full Name: {full_name}")
            st.write(f"Email: {email}")
            st.write(f"Phone: {phone}")
            st.write(f"User ID: {uid}")

            st.markdown("**Permissions**")
            edit_tab, role_tab, suspend_tab = st.tabs(["Edit Info", "Change Role", "Suspend/Ban"])

            with edit_tab:
                with st.form(f"edit_user_{uid}"):
                    nc1, nc2 = st.columns(2)
                    with nc1:
                        nf = st.text_input("First Name", value=u.get("first_name", ""), key=f"fn_{uid}")
                    with nc2:
                        nl = st.text_input("Last Name", value=u.get("last_name", ""), key=f"ln_{uid}")
                    ne = st.text_input("Email", value=email, key=f"em_{uid}")
                    np = st.text_input("Phone", value=phone if phone != "N/A" else "", key=f"ph_{uid}")
                    save = st.form_submit_button("Save", type="primary")

                if save:
                    payload = {"first_name": nf, "last_name": nl, "email": ne, "phone": np}
                    try:
                        r = requests.put(f"{API_BASE}/users/{uid}", json=payload, timeout=10)
                        r.raise_for_status()
                        st.success("User updated!")
                        st.session_state["console_log"].append(
                            f"[EDIT] User {uid} ({full_name}) info updated."
                        )
                        st.rerun()
                    except Exception as e:
                        st.error(f"Update failed: {e}")

            with role_tab:
                new_role = st.selectbox("Assign Role", ROLES,
                                        index=ROLES.index(role) if role in ROLES else 0,
                                        key=f"role_{uid}")
                if st.button("Apply Role Change", key=f"rc_{uid}", type="primary"):
                    try:
                        r = requests.put(f"{API_BASE}/users/{uid}",
                                         json={"role": new_role}, timeout=10)
                        r.raise_for_status()
                        st.success(f"Role updated to {new_role}.")
                        st.session_state["console_log"].append(
                            f"[ROLE] User {uid} ({full_name}) role changed to {new_role}."
                        )
                        st.rerun()
                    except Exception as e:
                        st.error(f"Role update failed: {e}")

            with suspend_tab:
                if is_active:
                    st.warning("Suspending will revoke this user's login access.")
                    if st.button("Suspend User", key=f"sus_{uid}", type="primary"):
                        try:
                            r = requests.put(f"{API_BASE}/users/{uid}",
                                             json={"is_active": False}, timeout=10)
                            r.raise_for_status()
                            st.success("User suspended.")
                            st.session_state["console_log"].append(
                                f"[SUSPEND] User {uid} ({full_name}) suspended."
                            )
                            st.rerun()
                        except Exception as e:
                            st.error(f"Failed: {e}")
                else:
                    if st.button("Reactivate User", key=f"react_{uid}", type="primary"):
                        try:
                            r = requests.put(f"{API_BASE}/users/{uid}",
                                             json={"is_active": True}, timeout=10)
                            r.raise_for_status()
                            st.success("User reactivated.")
                            st.session_state["console_log"].append(
                                f"[REACTIVATE] User {uid} ({full_name}) reactivated."
                            )
                            st.rerun()
                        except Exception as e:
                            st.error(f"Failed: {e}")

                st.markdown("---")
                st.error("Permanent deletion cannot be undone.")
                if st.button(f"Delete User {uid}", key=f"del_{uid}"):
                    try:
                        r = requests.delete(f"{API_BASE}/users/{uid}", timeout=10)
                        r.raise_for_status()
                        st.success(f"User {uid} deleted.")
                        st.session_state["console_log"].append(
                            f"[DELETE] User {uid} ({full_name}) permanently deleted."
                        )
                        st.rerun()
                    except Exception as e:
                        st.error(f"Delete failed: {e}")

st.divider()
st.markdown("#### Quick Navigation")
qn1, qn2, qn3 = st.columns(3)
with qn1:
    if st.button("Manage Reports", use_container_width=True, key="nav_reports"):
        st.switch_page("pages/22_Manage_Reports.py")
with qn2:
    if st.button("Accessibility Info", use_container_width=True, key="nav_acc"):
        st.switch_page("pages/24_Admin_Accessibility_Info.py")
with qn3:
    if st.button("Manage Tickets", use_container_width=True, key="nav_tickets"):
        st.switch_page("pages/23_Manage_Tickets.py")
