import streamlit as st
import pandas as pd
from datetime import datetime

from modules.nav import SideBarLinks
from modules.api_client import api_get, show_api_error

st.set_page_config(layout="wide")
SideBarLinks(show_home=False)

st.title("Analytics Dashboard")
st.caption("Platform insights for the founding team — signups, venues, coverage, reviews, retention, and summary.")

tab1, tab2, tab3, tab4, tab5, tab6 = st.tabs([
    "📈 User Signups",
    "🏆 Venue Dashboard",
    "🗺️ Coverage Gaps",
    "🔍 Review Volume",
    "👥 User Retention",
    "📋 Summary Report",
])


# ══════════════════════════════════════════════════════════════════════════════
# TAB 1 — USER SIGNUPS
# ══════════════════════════════════════════════════════════════════════════════
with tab1:
    st.caption("Track new user registrations and identify growth trends driven by marketing campaigns.")
    st.caption("📌 Covers: Joey-1 (track user signups over time & marketing impact)")

    c1, c2 = st.columns(2)
    with c1:
        start_date = st.date_input("Start date", value=None, key="sig_start")
    with c2:
        end_date = st.date_input("End date", value=None, key="sig_end")

    params = {}
    if start_date:
        params["start"] = str(start_date)
    if end_date:
        params["end"] = str(end_date)

    data, err = api_get("/analytics/signups", params=params)
    if err:
        show_api_error(err)
    elif not data:
        st.info("No signup data found for the selected range.")
    else:
        df = pd.DataFrame(data)
        df["signupDate"] = pd.to_datetime(df["signupDate"])
        df["newSignups"] = df["newSignups"].astype(int)

        m1, m2, m3 = st.columns(3)
        m1.metric("Total Signups", int(df["newSignups"].sum()))
        m2.metric("Days with Signups", len(df))
        m3.metric("Peak Day", int(df["newSignups"].max()))

        st.divider()
        st.subheader("Daily Signups")
        st.line_chart(df.set_index("signupDate")["newSignups"])
        st.divider()
        df.columns = ["Date", "New Signups"]
        st.dataframe(df, use_container_width=True, hide_index=True)


# ══════════════════════════════════════════════════════════════════════════════
# TAB 2 — VENUE DASHBOARD
# ══════════════════════════════════════════════════════════════════════════════
with tab2:
    st.caption("Explore top-rated and most-saved venues, filtered by city or category.")
    st.caption("📌 Covers: Joey-2 (cohesive dashboard of top venues by city & category)")

    categories, _ = api_get("/categories")
    c1, c2 = st.columns(2)
    with c1:
        city = st.text_input("Filter by city", placeholder="e.g. Boston", key="vd_city")
    with c2:
        cat_map = {"All": None}
        if categories:
            cat_map.update({c["name"]: c["categoryId"] for c in categories})
        sel_cat = st.selectbox("Filter by category", list(cat_map.keys()), key="vd_cat")

    params = {}
    if city.strip():
        params["city"] = city.strip()
    if cat_map[sel_cat]:
        params["category_id"] = cat_map[sel_cat]

    data, err = api_get("/analytics/venues/top", params=params)
    if err:
        show_api_error(err)
    elif not data:
        st.info("No venues found for the selected filters.")
    else:
        df = pd.DataFrame(data)
        m1, m2, m3 = st.columns(3)
        m1.metric("Venues Found", len(df))
        m2.metric("Highest Avg Rating", f"{df['avgRating'].astype(float).max():.2f}")
        m3.metric("Most Saves", int(df["totalSaves"].astype(int).max()))
        st.divider()
        st.subheader("Top Venues by Rating")
        st.bar_chart(df.set_index("name")["avgRating"].astype(float).head(10))
        st.divider()
        display = df[["venueId", "name", "city", "avgRating", "totalReviews", "totalSaves"]].copy()
        display.columns = ["Venue ID", "Name", "City", "Avg Rating", "Reviews", "Saves"]
        st.dataframe(display, use_container_width=True, hide_index=True)


# ══════════════════════════════════════════════════════════════════════════════
# TAB 3 — COVERAGE GAPS
# ══════════════════════════════════════════════════════════════════════════════
with tab3:
    st.caption("Find cities with high user activity but low venue listings — opportunities to grow the platform.")
    st.caption("📌 Covers: Joey-3 (identify geographic coverage gaps to report to founders)")

    data, err = api_get("/analytics/coverage")
    if err:
        show_api_error(err)
    elif not data:
        st.info("No coverage data available.")
    else:
        df = pd.DataFrame(data)
        df["totalUsers"]   = df["totalUsers"].astype(int)
        df["totalVenues"]  = df["totalVenues"].astype(int)
        df["totalReviews"] = df["totalReviews"].astype(int)
        df["gapScore"]     = df["totalUsers"] + df["totalReviews"] - (df["totalVenues"] * 5)

        m1, m2, m3 = st.columns(3)
        m1.metric("Cities Tracked", len(df))
        m2.metric("Cities with 0 Venues", int((df["totalVenues"] == 0).sum()))
        m3.metric("Highest Gap Score", int(df["gapScore"].max()))

        st.divider()
        st.subheader("Users vs Venues by City")
        st.bar_chart(df.set_index("city")[["totalUsers", "totalVenues"]].head(15))
        st.divider()
        display = df.sort_values("gapScore", ascending=False)[
            ["city", "totalUsers", "totalVenues", "totalReviews", "gapScore"]
        ].copy()
        display.columns = ["City", "Users", "Venues", "Reviews", "Gap Score"]
        st.dataframe(display, use_container_width=True, hide_index=True)


# ══════════════════════════════════════════════════════════════════════════════
# TAB 4 — REVIEW VOLUME
# ══════════════════════════════════════════════════════════════════════════════
with tab4:
    st.caption("Track review submission volume per venue to detect unusual spikes or review bombing.")
    st.caption("📌 Covers: Joey-4 (monitor review volume per venue to detect data manipulation)")

    data, err = api_get("/analytics/reviews/volume")
    if err:
        show_api_error(err)
    elif not data:
        st.info("No review data available.")
    else:
        df = pd.DataFrame(data)
        df["reviewCount"] = df["reviewCount"].astype(int)
        df["avgRating"]   = df["avgRating"].astype(float)
        df["period"]      = df["reviewYear"].astype(str) + "-" + df["reviewMonth"].astype(str).str.zfill(2)

        mean_c = df["reviewCount"].mean()
        std_c  = df["reviewCount"].std()
        threshold = mean_c + (2 * std_c) if std_c > 0 else mean_c + 1
        df["anomaly"] = df["reviewCount"] > threshold
        anomalies = df[df["anomaly"]]

        m1, m2, m3 = st.columns(3)
        m1.metric("Total Records", len(df))
        m2.metric("Venues Tracked", df["venueId"].nunique())
        m3.metric("Anomalies Detected", len(anomalies))

        if not anomalies.empty:
            st.warning(f"**{len(anomalies)} anomalous month(s)** — unusually high review volume (>{threshold:.0f}/month).")
            anom = anomalies[["name", "period", "reviewCount", "avgRating"]].copy()
            anom.columns = ["Venue", "Period", "Reviews", "Avg Rating"]
            st.dataframe(anom, use_container_width=True, hide_index=True)

        st.divider()
        venue_names = ["All"] + sorted(df["name"].unique().tolist())
        sel_venue = st.selectbox("Filter by venue", venue_names, key="rv_venue")
        filtered = df if sel_venue == "All" else df[df["name"] == sel_venue]
        display = filtered[["name", "period", "reviewCount", "avgRating", "anomaly"]].copy()
        display.columns = ["Venue", "Period", "Review Count", "Avg Rating", "Anomaly"]
        st.dataframe(display, use_container_width=True, hide_index=True)


# ══════════════════════════════════════════════════════════════════════════════
# TAB 5 — USER RETENTION
# ══════════════════════════════════════════════════════════════════════════════
with tab5:
    st.caption("Identify active vs. inactive users to improve long-term retention strategies.")
    st.caption("📌 Covers: Joey-5 (track user retention & identify inactive users)")

    data, err = api_get("/analytics/retention")
    if err:
        show_api_error(err)
    elif not data:
        st.info("No retention data available.")
    else:
        df = pd.DataFrame(data)
        df["totalReviews"] = df["totalReviews"].astype(int)
        df["totalSaves"]   = df["totalSaves"].astype(int)

        def classify(row):
            if row["lastReview"] is None and row["lastSave"] is None:
                return "Never Active"
            last = max(
                pd.Timestamp(row["lastReview"]) if row["lastReview"] else pd.Timestamp.min,
                pd.Timestamp(row["lastSave"])   if row["lastSave"]   else pd.Timestamp.min,
            )
            days = (pd.Timestamp.now() - last).days
            return "Active" if days <= 30 else ("At Risk" if days <= 90 else "Inactive")

        df["status"] = df.apply(classify, axis=1)
        counts = df["status"].value_counts()

        m1, m2, m3, m4 = st.columns(4)
        m1.metric("Total Users", len(df))
        m2.metric("Active (≤30d)", int(counts.get("Active", 0)))
        m3.metric("At Risk (31–90d)", int(counts.get("At Risk", 0)))
        m4.metric("Inactive / Never", int(counts.get("Inactive", 0)) + int(counts.get("Never Active", 0)))

        st.divider()
        st.bar_chart(counts)
        st.divider()
        status_filter = st.selectbox("Filter by status", ["All", "Active", "At Risk", "Inactive", "Never Active"], key="ret_filter")
        filtered = df if status_filter == "All" else df[df["status"] == status_filter]
        display = filtered[["accountId", "username", "city", "lastReview", "lastSave", "totalReviews", "totalSaves", "status"]].copy()
        display.columns = ["User ID", "Username", "City", "Last Review", "Last Save", "Reviews", "Saves", "Status"]
        st.dataframe(display, use_container_width=True, hide_index=True)


# ══════════════════════════════════════════════════════════════════════════════
# TAB 6 — SUMMARY REPORT
# ══════════════════════════════════════════════════════════════════════════════
with tab6:
    st.caption("A snapshot of key platform statistics for the founding team to make business decisions.")
    st.caption("📌 Covers: Joey-6 (generate summary reports on venue popularity & platform health)")

    data, err = api_get("/analytics/summary")
    if err:
        show_api_error(err)
    elif not data:
        st.info("No summary data available.")
    else:
        st.subheader("Platform Health")
        c1, c2, c3 = st.columns(3)
        c1.metric("Total Users",   data.get("totalUsers", 0))
        c2.metric("Total Venues",  data.get("totalVenues", 0))
        c3.metric("Total Reviews", data.get("totalReviews", 0))

        c4, c5, c6 = st.columns(3)
        c4.metric("Platform Avg Rating", f"{float(data.get('platformAvgRating') or 0):.2f}")
        c5.metric("Total Saves",         data.get("totalSaves", 0))
        c6.metric("Total Customers",     data.get("totalCustomers", 0))

        st.divider()
        st.subheader("Pending Actions")
        c7, c8, c9 = st.columns(3)
        c7.metric("Pending Applications", data.get("pendingApplications", 0))
        c8.metric("Pending Tickets",      data.get("pendingTickets", 0))
        c9.metric("Venue Owners",         data.get("totalOwners", 0))

        st.divider()
        st.info("Live data from the PinDate database. Share with the founding team for business decisions.")
