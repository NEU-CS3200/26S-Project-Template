import logging
logger = logging.getLogger(__name__)
import requests
import pandas as pd
import streamlit as st
import plotly.express as px
from modules.nav import SideBarLinks

st.set_page_config(layout='wide')
SideBarLinks()

st.markdown("""
<style>
.metric-card {
    background: #1e1e2e;
    border-radius: 14px;
    padding: 24px 20px;
    text-align: center;
    border: 1px solid #2e2e3e;
}
.metric-card .label {
    font-size: 0.85rem;
    color: #aaa;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    margin-bottom: 8px;
}
.metric-card .value {
    font-size: 2.2rem;
    font-weight: 700;
    color: #ffffff;
}
.metric-card.open   .value { color: #f97316; }
.metric-card.resolved .value { color: #22c55e; }
.metric-card.priority .value { color: #ef4444; }
.metric-card.rate   .value { color: #3b82f6; }
.section-title {
    font-size: 1.1rem;
    font-weight: 600;
    color: #e2e8f0;
    margin: 0 0 12px 0;
}
</style>
""", unsafe_allow_html=True)

st.markdown(f"## Accessibility Dashboard")
st.markdown(f"Welcome back, **{st.session_state['first_name']}**.")

API_BASE = "http://web-api:4000"


@st.cache_data(ttl=60)
def fetch_reports():
    r = requests.get(f"{API_BASE}/reports", timeout=10)
    r.raise_for_status()
    return pd.DataFrame(r.json())


try:
    df = fetch_reports()
except requests.exceptions.ConnectionError:
    st.error(f"Cannot reach API at `{API_BASE}`. Is the `api` container running?")
    st.stop()
except requests.exceptions.HTTPError as e:
    st.error(f"API error {e.response.status_code}")
    st.code(e.response.text, language="json")
    st.stop()
except Exception as e:
    st.error("Unexpected error loading reports.")
    st.code(str(e))
    st.stop()

if df.empty:
    st.warning("No reports found in the database.")
    st.stop()

# --- Compute metrics ---
total = len(df)
open_count = df[df['report_status'].isin(['Open', 'In Progress'])].shape[0]
resolved_count = df[df['report_status'].isin(['Resolved', 'Closed'])].shape[0]
high_priority_count = df[df['urgency'] >= 4].shape[0] if 'urgency' in df.columns else 0
resolution_rate = (resolved_count / total * 100) if total > 0 else 0.0

# --- Metric cards ---
st.markdown("<br>", unsafe_allow_html=True)
c1, c2, c3, c4 = st.columns(4)

with c1:
    st.markdown(f"""
    <div class="metric-card open">
        <div class="label">Open Reports</div>
        <div class="value">{open_count}</div>
    </div>""", unsafe_allow_html=True)

with c2:
    st.markdown(f"""
    <div class="metric-card resolved">
        <div class="label">Resolved Reports</div>
        <div class="value">{resolved_count}</div>
    </div>""", unsafe_allow_html=True)

with c3:
    st.markdown(f"""
    <div class="metric-card priority">
        <div class="label">High Priority</div>
        <div class="value">{high_priority_count}</div>
    </div>""", unsafe_allow_html=True)

with c4:
    st.markdown(f"""
    <div class="metric-card rate">
        <div class="label">Resolution Rate</div>
        <div class="value">{resolution_rate:.1f}%</div>
    </div>""", unsafe_allow_html=True)

st.markdown("<br>", unsafe_allow_html=True)
st.divider()

# --- Charts ---
chart_left, chart_right = st.columns(2)

with chart_left:
    st.markdown('<p class="section-title">Reports by Status</p>', unsafe_allow_html=True)
    if 'report_status' in df.columns:
        status_counts = df['report_status'].value_counts().reset_index()
        status_counts.columns = ['Status', 'Count']
        fig_status = px.pie(
            status_counts,
            names='Status',
            values='Count',
            hole=0.5,
            color_discrete_sequence=px.colors.qualitative.Pastel,
        )
        fig_status.update_layout(
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font_color='#e2e8f0',
            legend=dict(orientation='h', yanchor='bottom', y=-0.2),
            margin=dict(t=10, b=10, l=10, r=10),
            showlegend=True,
        )
        fig_status.update_traces(textposition='inside', textinfo='percent+label')
        st.plotly_chart(fig_status, use_container_width=True)

with chart_right:
    st.markdown('<p class="section-title">Reports by Neighborhood</p>', unsafe_allow_html=True)
    if 'neighborhood_name' in df.columns:
        neighborhood_counts = (
            df['neighborhood_name']
            .fillna('Unknown')
            .value_counts()
            .reset_index()
        )
        neighborhood_counts.columns = ['Neighborhood', 'Count']
        fig_neigh = px.bar(
            neighborhood_counts,
            x='Count',
            y='Neighborhood',
            orientation='h',
            color='Count',
            color_continuous_scale='Blues',
        )
        fig_neigh.update_layout(
            paper_bgcolor='rgba(0,0,0,0)',
            plot_bgcolor='rgba(0,0,0,0)',
            font_color='#e2e8f0',
            coloraxis_showscale=False,
            yaxis=dict(categoryorder='total ascending'),
            margin=dict(t=10, b=10, l=10, r=10),
            xaxis_title='',
            yaxis_title='',
        )
        st.plotly_chart(fig_neigh, use_container_width=True)

st.divider()

# --- Reports table ---
st.markdown('<p class="section-title">All Reports</p>', unsafe_allow_html=True)

col_map = {
    'report_id': 'ID',
    'issue_type_name': 'Issue Type',
    'neighborhood_name': 'Neighborhood',
    'report_date': 'Date',
    'urgency': 'Priority',
    'report_status': 'Status',
}

available = [c for c in col_map if c in df.columns]
table_df = df[available].rename(columns=col_map).copy()

# Map numeric priority to labels
if 'Priority' in table_df.columns:
    priority_labels = {1: '1 – Very Low', 2: '2 – Low', 3: '3 – Medium', 4: '4 – High', 5: '5 – Critical'}
    table_df['Priority'] = table_df['Priority'].map(priority_labels).fillna(table_df['Priority'])

column_config = {
    'ID': st.column_config.NumberColumn('ID', width='small'),
    'Issue Type': st.column_config.TextColumn('Issue Type', width='medium'),
    'Neighborhood': st.column_config.TextColumn('Neighborhood', width='medium'),
    'Date': st.column_config.DatetimeColumn('Date', format='YYYY-MM-DD', width='medium'),
    'Priority': st.column_config.TextColumn('Priority', width='medium'),
    'Status': st.column_config.TextColumn('Status', width='small'),
}

st.dataframe(
    table_df,
    use_container_width=True,
    hide_index=True,
    column_config=column_config,
)
