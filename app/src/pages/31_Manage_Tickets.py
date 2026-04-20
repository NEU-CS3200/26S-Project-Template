import streamlit as st
import pandas as pd

from modules.nav import SideBarLinks
from modules.api_client import api_get, api_put, api_delete, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

st.title("People & Tickets")
st.caption("Review report tickets, moderate users, and approve or reject venue applications.")

tab_tickets, tab_users, tab_apps = st.tabs(["🎫 Report Tickets", "👤 Moderate Users", "📝 Venue Applications"])


# ══════════════════════════════════════════════════════════════════════════════
# TAB 1 — TICKETS
# ══════════════════════════════════════════════════════════════════════════════
with tab_tickets:
    st.caption("Review and resolve tickets submitted by users and venue owners.")
    st.caption("📌 Covers: Josh-1 (review and close report tickets to keep platform clean)")

    STATUSES = ["PENDING", "UNDER REVIEW", "RESOLVED", "DISMISSED"]
    status_filter = st.selectbox("Filter by status", ["All"] + STATUSES, key="t_status")
    params = {} if status_filter == "All" else {"status": status_filter}

    tickets, err = api_get("/tickets", params=params)
    if err:
        show_api_error(err)
    elif not tickets:
        st.info("No tickets found.")
    else:
        df = pd.DataFrame(tickets)[["reportId", "reporterUsername", "reviewId", "reason", "status", "createdAt"]]
        df.columns = ["Ticket ID", "Reporter", "Review ID", "Reason", "Status", "Created"]
        st.dataframe(df, use_container_width=True, hide_index=True)

        st.divider()
        ticket_id = st.number_input("Ticket ID to view", min_value=1, value=1, step=1, key="t_view")
        if st.button("Load Ticket", key="t_load"):
            ticket, t_err = api_get(f"/tickets/{int(ticket_id)}")
            if t_err:
                show_api_error(t_err)
            elif ticket:
                with st.container(border=True):
                    st.markdown(f"**Reason:** {ticket.get('reason')}")
                    st.markdown(f"**Status:** {ticket.get('status')}")
                    st.markdown(f"**Description:** {ticket.get('description') or '—'}")
                    st.caption(f"Reporter: {ticket.get('reporterUsername','—')} · {str(ticket.get('createdAt',''))[:10]}")

        st.divider()
        st.subheader("Update Ticket Status")
        with st.form("update_ticket_form"):
            update_id  = st.number_input("Ticket ID", min_value=1, value=1, step=1)
            new_status = st.selectbox("New Status", STATUSES)
            if st.form_submit_button("Update", type="primary"):
                _, u_err = api_put(f"/tickets/{int(update_id)}", {"status": new_status})
                if u_err:
                    show_api_error(u_err)
                else:
                    st.success(f"Ticket {int(update_id)} updated to {new_status}.")
                    st.rerun()


# ══════════════════════════════════════════════════════════════════════════════
# TAB 2 — MODERATE USERS
# ══════════════════════════════════════════════════════════════════════════════
with tab_users:
    st.caption("Identify users with flagged reviews and take action to keep the platform safe.")
    st.caption("📌 Covers: Josh-2 (moderate users generating spam or malicious content)")

    users, err = api_get("/users")
    if err:
        show_api_error(err)
    elif not users:
        st.info("No users found.")
    else:
        df = pd.DataFrame(users)[["accountId", "username", "email", "city", "role", "createdAt"]]
        df.columns = ["User ID", "Username", "Email", "City", "Role", "Joined"]
        st.dataframe(df, use_container_width=True, hide_index=True)

        st.divider()
        st.subheader("Check Flagged Reviews")
        check_id = st.number_input("User ID", min_value=1, value=1, step=1, key="u_check")
        if st.button("Check", key="u_check_btn"):
            flagged, f_err = api_get(f"/users/{int(check_id)}/flagged-reviews")
            if f_err:
                show_api_error(f_err)
            elif not flagged:
                st.success("No flagged reviews for this user.")
            else:
                st.warning(f"{len(flagged)} flagged review(s) found.")
                fdf = pd.DataFrame(flagged)[["reviewId", "venueName", "rating", "comment", "createdAt"]]
                fdf.columns = ["Review ID", "Venue", "Rating", "Comment", "Date"]
                st.dataframe(fdf, use_container_width=True, hide_index=True)

        st.divider()
        st.subheader("Ban a User")
        with st.form("ban_user_form"):
            ban_id  = st.number_input("User ID to ban", min_value=1, value=1, step=1)
            confirm = st.checkbox("I confirm I want to permanently ban this user")
            if st.form_submit_button("Ban User", type="primary"):
                if not confirm:
                    st.warning("Please confirm before banning.")
                else:
                    _, b_err = api_delete(f"/users/{int(ban_id)}")
                    if b_err:
                        show_api_error(b_err)
                    else:
                        st.success(f"User {int(ban_id)} has been banned and removed.")
                        st.rerun()


# ══════════════════════════════════════════════════════════════════════════════
# TAB 3 — VENUE APPLICATIONS
# ══════════════════════════════════════════════════════════════════════════════
with tab_apps:
    st.caption("Approve or reject venue submissions to ensure only legitimate listings go live.")
    st.caption("📌 Covers: Josh-3 (approve or reject new venue submissions from owners)")

    status_filter_a = st.selectbox("Filter by status", ["All", "PENDING", "APPROVED", "REJECTED"], key="app_status")
    params_a = {} if status_filter_a == "All" else {"status": status_filter_a}

    apps, err = api_get("/applications", params=params_a)
    if err:
        show_api_error(err)
    elif not apps:
        st.info("No applications found.")
    else:
        df = pd.DataFrame(apps)[["applicationId", "ownerUsername", "name", "address", "status", "createdAt"]]
        df.columns = ["App ID", "Owner", "Venue Name", "Address", "Status", "Submitted"]
        st.dataframe(df, use_container_width=True, hide_index=True)

        st.divider()
        app_id = st.number_input("Application ID to view", min_value=1, value=1, step=1, key="app_view")
        if st.button("Load Application", key="app_load"):
            app, a_err = api_get(f"/applications/{int(app_id)}")
            if a_err:
                show_api_error(a_err)
            elif app:
                with st.container(border=True):
                    c1, c2 = st.columns(2)
                    with c1:
                        st.markdown(f"**Name:** {app.get('name')}")
                        st.markdown(f"**Address:** {app.get('address')}")
                        st.markdown(f"**Owner:** {app.get('ownerUsername','—')}")
                    with c2:
                        st.markdown(f"**Status:** {app.get('status')}")
                        st.markdown(f"**Price:** ${app.get('minPrice',0):.0f}–${app.get('maxPrice',0):.0f}")
                    if app.get("description"):
                        st.markdown(f"**Description:** {app['description']}")

        st.divider()
        st.subheader("Approve or Reject")
        with st.form("review_app_form"):
            review_id = st.number_input("Application ID", min_value=1, value=1, step=1)
            decision  = st.selectbox("Decision", ["APPROVED", "REJECTED", "PENDING"])
            if st.form_submit_button("Submit Decision", type="primary"):
                _, r_err = api_put(f"/applications/{int(review_id)}", {"status": decision})
                if r_err:
                    show_api_error(r_err)
                else:
                    st.success(f"Application {int(review_id)} marked as {decision}.")
                    st.rerun()
