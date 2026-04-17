import streamlit as st
import plotly.graph_objects as go
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="analyst_persona")

# -------------------------------------------------------
# Mock Data
# -------------------------------------------------------
MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
          "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

TEAM_DATA = {
    "Husky League": {
        "Team Alpha": {
            "record": {"W": 14, "L": 2, "Forfeits": 1},
            "avg_points_scored":   [45, 48, 52, 50, 55, 58, 60, 57, 54, 51, 49, 53],
            "avg_points_allowed":  [38, 40, 37, 42, 39, 41, 36, 43, 40, 38, 41, 39],
            "point_differential":  [7,  8, 15,  8, 16, 17, 24, 14, 14, 13,  8, 14],
            "forfeit_trend":       [0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0],
            "roster_size": 10,
            "avg_attendance_pct": 91,
        },
        "Team Beta": {
            "record": {"W": 9, "L": 7, "Forfeits": 2},
            "avg_points_scored":   [38, 42, 40, 44, 41, 46, 43, 47, 44, 40, 38, 42],
            "avg_points_allowed":  [40, 41, 43, 40, 44, 42, 45, 41, 43, 42, 40, 43],
            "point_differential":  [-2,  1, -3,  4, -3,  4, -2,  6,  1, -2, -2, -1],
            "forfeit_trend":       [0,  1,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0],
            "roster_size": 9,
            "avg_attendance_pct": 78,
        },
        "Team Gamma": {
            "record": {"W": 5, "L": 11, "Forfeits": 4},
            "avg_points_scored":   [30, 33, 28, 35, 31, 29, 34, 32, 30, 28, 31, 33],
            "avg_points_allowed":  [45, 48, 50, 44, 47, 52, 46, 49, 51, 47, 48, 50],
            "point_differential":  [-15,-15,-22, -9,-16,-23,-12,-17,-21,-19,-17,-17],
            "forfeit_trend":       [1,  0,  1,  0,  1,  0,  0,  1,  0,  0,  0,  0],
            "roster_size": 8,
            "avg_attendance_pct": 62,
        },
    },
    "Bull Games": {
        "Red Hawks": {
            "record": {"W": 12, "L": 4, "Forfeits": 0},
            "avg_points_scored":   [70, 74, 78, 72, 80, 82, 85, 79, 76, 73, 71, 75],
            "avg_points_allowed":  [60, 63, 58, 65, 61, 64, 59, 66, 62, 60, 63, 61],
            "point_differential":  [10, 11, 20,  7, 19, 18, 26, 13, 14, 13,  8, 14],
            "forfeit_trend":       [0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
            "roster_size": 12,
            "avg_attendance_pct": 95,
        },
        "Blue Bulls": {
            "record": {"W": 8, "L": 8, "Forfeits": 1},
            "avg_points_scored":   [62, 65, 60, 68, 63, 67, 64, 69, 65, 61, 63, 66],
            "avg_points_allowed":  [63, 66, 64, 65, 67, 63, 68, 64, 66, 65, 64, 67],
            "point_differential":  [-1, -1, -4,  3, -4,  4, -4,  5, -1, -4, -1, -1],
            "forfeit_trend":       [0,  0,  0,  1,  0,  0,  0,  0,  0,  0,  0,  0],
            "roster_size": 11,
            "avg_attendance_pct": 83,
        },
        "Gold Rush": {
            "record": {"W": 4, "L": 12, "Forfeits": 3},
            "avg_points_scored":   [50, 53, 48, 55, 51, 49, 54, 52, 50, 48, 51, 53],
            "avg_points_allowed":  [72, 75, 78, 70, 74, 79, 73, 76, 78, 74, 75, 77],
            "point_differential":  [-22,-22,-30,-15,-23,-30,-19,-24,-28,-26,-24,-24],
            "forfeit_trend":       [1,  0,  1,  0,  0,  1,  0,  0,  0,  0,  0,  0],
            "roster_size": 10,
            "avg_attendance_pct": 58,
        },
    },
    "Ivy League": {
        "Green Giants": {
            "record": {"W": 13, "L": 3, "Forfeits": 0},
            "avg_points_scored":   [22, 24, 28, 26, 30, 31, 33, 29, 27, 25, 23, 26],
            "avg_points_allowed":  [14, 15, 13, 17, 14, 16, 13, 18, 15, 14, 16, 14],
            "point_differential":  [8,  9, 15,  9, 16, 15, 20, 11, 12, 11,  7, 12],
            "forfeit_trend":       [0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0],
            "roster_size": 22,
            "avg_attendance_pct": 88,
        },
        "Silver Squad": {
            "record": {"W": 7, "L": 9, "Forfeits": 2},
            "avg_points_scored":   [17, 19, 16, 21, 18, 17, 20, 19, 17, 16, 18, 19],
            "avg_points_allowed":  [19, 20, 21, 18, 22, 20, 22, 19, 21, 20, 19, 21],
            "point_differential":  [-2, -1, -5,  3, -4, -3, -2,  0, -4, -4, -1, -2],
            "forfeit_trend":       [0,  1,  0,  0,  0,  1,  0,  0,  0,  0,  0,  0],
            "roster_size": 20,
            "avg_attendance_pct": 74,
        },
        "Gold Crew": {
            "record": {"W": 3, "L": 13, "Forfeits": 5},
            "avg_points_scored":   [10, 12,  9, 14, 11, 10, 13, 12, 10,  9, 11, 12],
            "avg_points_allowed":  [28, 30, 32, 26, 29, 33, 27, 31, 33, 29, 30, 31],
            "point_differential":  [-18,-18,-23,-12,-18,-23,-14,-19,-23,-20,-19,-19],
            "forfeit_trend":       [1,  0,  1,  1,  0,  1,  0,  0,  1,  0,  0,  0],
            "roster_size": 18,
            "avg_attendance_pct": 55,
        },
    },
}

CHART_BG  = "white"
FONT_MONO = "Courier New, monospace"
FONT_STYLE = dict(family=FONT_MONO, size=12, color="#111")

# -------------------------------------------------------
# Chart builders
# -------------------------------------------------------
def record_chart(record):
    fig = go.Figure(go.Bar(
        x=list(record.keys()),
        y=list(record.values()),
        marker_color=["#4a90c4", "#c61717", "#f4a261"],
        marker_line_color="#555",
        marker_line_width=1,
        text=list(record.values()),
        textposition="outside",
        textfont=dict(family=FONT_MONO, size=13, color="#111"),
    ))
    fig.update_layout(
        title=dict(text="Season Record", font=dict(family=FONT_MONO, size=14, color="#111"), x=0.5, xref="paper"),
        plot_bgcolor=CHART_BG, paper_bgcolor=CHART_BG,
        font=FONT_STYLE,
        margin=dict(l=30, r=20, t=50, b=40),
        height=260,
        yaxis=dict(showgrid=True, gridcolor="#eee"),
        xaxis=dict(showgrid=False),
    )
    return fig

def scoring_chart(months, scored, allowed):
    fig = go.Figure()
    fig.add_trace(go.Scatter(
        x=months, y=scored, name="Points Scored",
        mode="lines+markers",
        line=dict(color="#4a90c4", width=2),
        marker=dict(size=5),
    ))
    fig.add_trace(go.Scatter(
        x=months, y=allowed, name="Points Allowed",
        mode="lines+markers",
        line=dict(color="#c61717", width=2, dash="dash"),
        marker=dict(size=5),
    ))
    fig.update_layout(
        title=dict(text="Avg Points Scored vs Allowed", font=dict(family=FONT_MONO, size=14, color="#111"), x=0.5, xref="paper"),
        plot_bgcolor=CHART_BG, paper_bgcolor=CHART_BG,
        font=FONT_STYLE,
        margin=dict(l=40, r=20, t=50, b=40),
        height=280,
        legend=dict(font=dict(family=FONT_MONO, size=11, color="#111")),
        xaxis=dict(showgrid=False),
        yaxis=dict(showgrid=True, gridcolor="#eee"),
    )
    return fig

def differential_chart(months, diff):
    colors = ["#4a90c4" if d >= 0 else "#c61717" for d in diff]
    fig = go.Figure(go.Bar(
        x=months, y=diff,
        marker_color=colors,
        marker_line_width=0,
    ))
    fig.add_hline(y=0, line_color="#333", line_width=1)
    fig.update_layout(
        title=dict(text="Point Differential per Month", font=dict(family=FONT_MONO, size=14, color="#111"), x=0.4, xref="paper"),
        plot_bgcolor=CHART_BG, paper_bgcolor=CHART_BG,
        font=FONT_STYLE,
        margin=dict(l=40, r=20, t=50, b=40),
        height=260,
        xaxis=dict(showgrid=False),
        yaxis=dict(showgrid=True, gridcolor="#eee", zeroline=False),
    )
    return fig

def forfeit_chart(months, forfeits):
    fig = go.Figure(go.Bar(
        x=months, y=forfeits,
        marker_color="#f4a261",
        marker_line_color="#c96a00",
        marker_line_width=1,
    ))
    fig.update_layout(
        title=dict(text="Forfeits per Month", font=dict(family=FONT_MONO, size=14, color="#111"), x=0.5, xref="paper"),
        plot_bgcolor=CHART_BG, paper_bgcolor=CHART_BG,
        font=FONT_STYLE,
        margin=dict(l=30, r=20, t=50, b=40),
        height=220,
        xaxis=dict(showgrid=False),
        yaxis=dict(showgrid=True, gridcolor="#eee", dtick=1),
    )
    return fig

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            div[data-testid="stSelectbox"] label { display: none; }
            .kpi-row {
                display: flex;
                gap: 16px;
                margin-bottom: 16px;
            }
            .kpi-box {
                flex: 1;
                border: 1.5px solid #ccc;
                border-radius: 8px;
                padding: 14px 18px;
                font-family: monospace;
                background: #fafafa;
            }
            .kpi-value {
                font-size: 26px;
                font-weight: bold;
                color: #111;
            }
            .kpi-label {
                font-size: 13px;
                color: #555;
                margin-top: 2px;
            }
        </style>
    """, unsafe_allow_html=True)

# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    st.markdown("<h2 style='font-family:monospace; margin-bottom:4px;'>Team Report</h2>", unsafe_allow_html=True)

    c1, c2, _ = st.columns([2, 2, 4])
    with c1:
        league = st.selectbox("league", list(TEAM_DATA.keys()), label_visibility="collapsed")
    with c2:
        team = st.selectbox("team", list(TEAM_DATA[league].keys()), label_visibility="collapsed")

    st.markdown("<hr style='margin:8px 0 16px 0;'>", unsafe_allow_html=True)

    d = TEAM_DATA[league][team]
    record = d["record"]
    win_pct = round(record["W"] / (record["W"] + record["L"]) * 100)

    # ---- KPI Cards ----
    st.html(f"""
    <div class="kpi-row">
        <div class="kpi-box">
            <div class="kpi-value">{record['W']} - {record['L']}</div>
            <div class="kpi-label">Win / Loss Record</div>
        </div>
        <div class="kpi-box">
            <div class="kpi-value">{win_pct}%</div>
            <div class="kpi-label">Win Rate</div>
        </div>
        <div class="kpi-box">
            <div class="kpi-value">{record['Forfeits']}</div>
            <div class="kpi-label">Total Forfeits</div>
        </div>
        <div class="kpi-box">
            <div class="kpi-value">{d['roster_size']}</div>
            <div class="kpi-label">Roster Size</div>
        </div>
        <div class="kpi-box">
            <div class="kpi-value">{d['avg_attendance_pct']}%</div>
            <div class="kpi-label">Avg Game Attendance</div>
        </div>
    </div>
    """)

    # ---- Row 1: Record + Scoring ----
    col1, col2 = st.columns([1, 2])
    with col1:
        st.plotly_chart(record_chart(record), use_container_width=True)
    with col2:
        st.plotly_chart(scoring_chart(MONTHS, d["avg_points_scored"], d["avg_points_allowed"]), use_container_width=True)

    # ---- Row 2: Differential (full width) ----
    st.plotly_chart(differential_chart(MONTHS, d["point_differential"]), use_container_width=True)

show()