import streamlit as st
import pandas as pd

from modules.nav import SideBarLinks
from modules.api_client import api_get, api_post, api_put, api_delete, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

st.title("Platform Tools")
st.caption("Manage duplicate venues, categories & vibes, and review the admin action log.")

tab_dupes, tab_tags, tab_log = st.tabs(["🔁 Duplicate Venues", "🏷️ Categories & Vibes", "📜 Admin Log"])


# ══════════════════════════════════════════════════════════════════════════════
# TAB 1 — DUPLICATE VENUES
# ══════════════════════════════════════════════════════════════════════════════
with tab_dupes:
    st.caption("Detect venues with the same name and remove confirmed duplicates.")
    st.caption("📌 Covers: Josh-4 (detect and remove duplicate venue listings)")

    dupes, err = api_get("/venues/duplicates")
    if err:
        show_api_error(err)
    elif not dupes:
        st.success("No duplicate venue names detected.")
    else:
        df = pd.DataFrame(dupes)
        dupe_names = df["name"].unique()
        st.warning(f"**{len(dupe_names)} venue name(s)** appear more than once across {len(df)} listings.")

        for name in dupe_names:
            group = df[df["name"] == name][["venueId", "name", "city", "address", "rating", "ownerId"]].copy()
            group.columns = ["Venue ID", "Name", "City", "Address", "Rating", "Owner ID"]
            with st.expander(f"**{name}** — {len(group)} listings"):
                st.dataframe(group, use_container_width=True, hide_index=True)

        st.divider()
        st.subheader("Delete a Duplicate")
        with st.form("delete_venue_form"):
            del_id  = st.number_input("Venue ID to delete", min_value=1, value=1, step=1)
            confirm = st.checkbox("I confirm this venue is a duplicate and should be removed")
            if st.form_submit_button("Delete Venue", type="primary"):
                if not confirm:
                    st.warning("Please confirm before deleting.")
                else:
                    _, d_err = api_delete(f"/venues/{int(del_id)}")
                    if d_err:
                        show_api_error(d_err)
                    else:
                        st.success(f"Venue {int(del_id)} deleted.")
                        st.rerun()


# ══════════════════════════════════════════════════════════════════════════════
# TAB 2 — CATEGORIES & VIBES
# ══════════════════════════════════════════════════════════════════════════════
with tab_tags:
    st.caption("Add, rename, or remove the tags that help users discover date spots.")
    st.caption("📌 Covers: Josh-5 (add, edit, or remove categories and vibes)")

    categories, c_err = api_get("/categories")
    vibes,      v_err = api_get("/vibes")

    c1, c2 = st.columns(2)

    with c1:
        st.subheader("Categories")
        if c_err:
            show_api_error(c_err)
        elif categories:
            df_c = pd.DataFrame(categories)
            df_c.columns = ["Category ID", "Name"]
            st.dataframe(df_c, use_container_width=True, hide_index=True)

        with st.form("add_cat_form"):
            new_cat = st.text_input("New category name")
            if st.form_submit_button("Add Category", type="primary"):
                if not new_cat.strip():
                    st.warning("Name is required.")
                else:
                    _, err = api_post("/categories", {"name": new_cat.strip()})
                    if err:
                        show_api_error(err)
                    else:
                        st.success(f"Category '{new_cat}' added.")
                        st.rerun()

        with st.expander("Rename a Category"):
            with st.form("rename_cat_form"):
                r_cat_id   = st.number_input("Category ID", min_value=1, value=1, step=1, key="rc_id")
                r_cat_name = st.text_input("New name", key="rc_name")
                if st.form_submit_button("Rename", type="primary"):
                    _, err = api_put(f"/categories/{int(r_cat_id)}", {"name": r_cat_name.strip()})
                    if err:
                        show_api_error(err)
                    else:
                        st.success("Category renamed.")
                        st.rerun()

        with st.expander("Delete a Category"):
            with st.form("del_cat_form"):
                d_cat_id = st.number_input("Category ID to delete", min_value=1, value=1, step=1, key="dc_id")
                if st.form_submit_button("Delete Category", type="primary"):
                    _, err = api_delete(f"/categories/{int(d_cat_id)}")
                    if err:
                        show_api_error(err)
                    else:
                        st.success("Category deleted.")
                        st.rerun()

    with c2:
        st.subheader("Vibes")
        if v_err:
            show_api_error(v_err)
        elif vibes:
            df_v = pd.DataFrame(vibes)
            df_v.columns = ["Vibe ID", "Name"]
            st.dataframe(df_v, use_container_width=True, hide_index=True)

        with st.form("add_vibe_form"):
            new_vibe = st.text_input("New vibe name")
            if st.form_submit_button("Add Vibe", type="primary"):
                if not new_vibe.strip():
                    st.warning("Name is required.")
                else:
                    _, err = api_post("/vibes", {"name": new_vibe.strip()})
                    if err:
                        show_api_error(err)
                    else:
                        st.success(f"Vibe '{new_vibe}' added.")
                        st.rerun()

        with st.expander("Rename a Vibe"):
            with st.form("rename_vibe_form"):
                r_vibe_id   = st.number_input("Vibe ID", min_value=1, value=1, step=1, key="rv_id")
                r_vibe_name = st.text_input("New name", key="rv_name")
                if st.form_submit_button("Rename", type="primary"):
                    _, err = api_put(f"/vibes/{int(r_vibe_id)}", {"name": r_vibe_name.strip()})
                    if err:
                        show_api_error(err)
                    else:
                        st.success("Vibe renamed.")
                        st.rerun()

        with st.expander("Delete a Vibe"):
            with st.form("del_vibe_form"):
                d_vibe_id = st.number_input("Vibe ID to delete", min_value=1, value=1, step=1, key="dv_id")
                if st.form_submit_button("Delete Vibe", type="primary"):
                    _, err = api_delete(f"/vibes/{int(d_vibe_id)}")
                    if err:
                        show_api_error(err)
                    else:
                        st.success("Vibe deleted.")
                        st.rerun()


# ══════════════════════════════════════════════════════════════════════════════
# TAB 3 — ADMIN LOG
# ══════════════════════════════════════════════════════════════════════════════
with tab_log:
    st.caption("Track every admin action taken on the platform for accountability and traceability.")
    st.caption("📌 Covers: Josh-6 (track all admin actions for accountability)")

    logs, err = api_get("/log")
    if err:
        show_api_error(err)
    elif not logs:
        st.info("No admin actions logged yet.")
    else:
        df = pd.DataFrame(logs)
        c1, c2 = st.columns(2)
        c1.metric("Total Actions Logged", len(df))
        c2.metric("Admins Active", df["adminId"].nunique())

        st.divider()
        action_filter = st.selectbox("Filter by action type", ["All"] + sorted(df["action"].unique().tolist()), key="log_filter")
        filtered = df if action_filter == "All" else df[df["action"] == action_filter]
        display = filtered[["logId", "adminName", "action", "targetTable", "targetId", "performedAt", "notes"]].copy()
        display.columns = ["Log ID", "Admin", "Action", "Target Table", "Target ID", "Performed At", "Notes"]
        st.dataframe(display, use_container_width=True, hide_index=True)

        st.divider()
        log_id = st.number_input("Log ID to view", min_value=1, value=1, step=1, key="log_id")
        if st.button("Load Entry", key="log_load"):
            entry, l_err = api_get(f"/log/{int(log_id)}")
            if l_err:
                show_api_error(l_err)
            elif entry:
                with st.container(border=True):
                    st.markdown(f"**Admin:** {entry.get('adminName')}")
                    st.markdown(f"**Action:** {entry.get('action')}")
                    st.markdown(f"**Target:** {entry.get('targetTable')} ID {entry.get('targetId')}")
                    st.markdown(f"**Notes:** {entry.get('notes') or '—'}")
                    st.caption(f"Performed at: {str(entry.get('performedAt',''))[:19]}")
