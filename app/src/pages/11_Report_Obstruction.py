import logging
logger = logging.getLogger(__name__)
import requests
import streamlit as st
from datetime import date
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.markdown("## Report an Obstruction")
st.write("Use this form to submit an accessibility issue in your neighborhood.")

API_BASE = "http://web-api:4000"

ISSUE_TYPE_MAP = {
    "Entrance issue": 1,
    "Ramp issue":     2,
    "Sidewalk issue": 3,
    "Transport issue": 4,
}

NEIGHBORHOODS = ["Roxbury", "Allston", "South End", "Back Bay", "Jamaica Plain", "Other"]

URGENCY_LABELS = {
    1: "1 – Very Low",
    2: "2 – Low",
    3: "3 – Medium",
    4: "4 – High",
    5: "5 – Critical",
}

REPORT_TYPES = ["Complaint", "Feedback", "Emergency"]


@st.cache_data(ttl=120)
def fetch_locations():
    try:
        r = requests.get(f"{API_BASE}/locations", timeout=10)
        r.raise_for_status()
        return r.json()
    except Exception:
        return []


def get_or_create_location(street_name, neighborhood):
    """Return existing location_id or create a new location and return its id."""
    try:
        r = requests.get(
            f"{API_BASE}/locations",
            params={"street_name_like": street_name, "neighborhood": neighborhood},
            timeout=10,
        )
        r.raise_for_status()
        for loc in r.json():
            if loc["street_name"].strip().lower() == street_name.strip().lower():
                return loc["location_id"]
        # Not found — create it
        r2 = requests.post(
            f"{API_BASE}/locations",
            json={"street_name": street_name, "neighborhood_name": neighborhood},
            timeout=10,
        )
        r2.raise_for_status()
        return r2.json()["location_id"]
    except Exception as e:
        logger.error(f"get_or_create_location failed: {e}")
        return None


user_id = st.session_state.get("user_id") or 1

st.divider()

with st.form("report_form", clear_on_submit=True):
    col1, col2 = st.columns(2)

    with col1:
        issue_type = st.selectbox("Issue Type *", list(ISSUE_TYPE_MAP.keys()))
        neighborhood = st.selectbox("Neighborhood *", NEIGHBORHOODS)
        report_type = st.selectbox("Report Type *", REPORT_TYPES)

    with col2:
        urgency = st.select_slider(
            "Urgency *",
            options=list(URGENCY_LABELS.keys()),
            format_func=lambda x: URGENCY_LABELS[x],
            value=3,
        )

        street_input = st.text_input("Street / Address *", placeholder="e.g. 123 Main St")

    description = st.text_area("Description *", placeholder="Describe the accessibility issue in detail…", height=120)

    submitted = st.form_submit_button("Submit Report", type="primary", use_container_width=True)

if submitted:
    if not description.strip():
        st.error("Please enter a description before submitting.")
    elif not street_input.strip():
        st.error("Please enter a street address before submitting.")
    else:
        with st.spinner("Saving address and submitting report…"):
            location_id = get_or_create_location(street_input.strip(), neighborhood)

        payload = {
            "report_date":   str(date.today()),
            "report_type":   report_type,
            "report_status": "Open",
            "user_id":       user_id,
            "urgency":       urgency,
            "description":   description.strip(),
            "location_id":   location_id,
            "issue_type_id": ISSUE_TYPE_MAP[issue_type],
        }

        try:
            r = requests.post(f"{API_BASE}/reports", json=payload, timeout=10)
            r.raise_for_status()
            report_id = r.json().get("report_id", "")
            st.success(f"Report submitted successfully! Your report ID is **{report_id}**.")
        except requests.exceptions.HTTPError as e:
            st.error(f"Submission failed: {e.response.status_code}")
            st.code(e.response.text, language="json")
        except Exception as e:
            st.error("Could not reach the API. Ensure all Docker containers are running.")
            st.code(str(e))
