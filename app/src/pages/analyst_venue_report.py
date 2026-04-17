import streamlit as st
import plotly.graph_objects as go
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="analyst_persona")

# -------------------------------------------------------
# Mock Data
# -------------------------------------------------------
MONTHS = ["Jan", "Feb", "Mar", "Apr", "May", "Jun",
          "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

VENUE_DATA = {
    "Matthew's Arena": {
        2025: {
            "utilization": {
                "Court 1": 52, "Court 2": 61, "Court 3": 23, "Court 4": 46,
            },
            "staff_turnover": [2, 1, 3, 0, 2, 4, 1, 2, 3, 1, 0, 2],
            "revenue_per_day": [1200, 1100, 1350, 1500, 1420, 1600,
                                1750, 1800, 1650, 1400, 1250, 1300],
            "foot_traffic":    [320, 290, 370, 410, 390, 450,
                                510, 530, 480, 400, 340, 360],
        },
        2024: {
            "utilization": {
                "Court 1": 45, "Court 2": 70, "Court 3": 18, "Court 4": 38,
            },
            "staff_turnover": [1, 2, 1, 3, 1, 2, 0, 3, 2, 1, 2, 1],
            "revenue_per_day": [1050, 980, 1200, 1350, 1280, 1450,
                                1600, 1700, 1500, 1250, 1100, 1150],
            "foot_traffic":    [280, 260, 330, 370, 350, 420,
                                470, 490, 440, 360, 300, 320],
        },
    },
    "Fenway Stadium": {
        2025: {
            "utilization": {
                "Field A": 40, "Field B": 76, "Field C": 55, "Field D": 62,
            },
            "staff_turnover": [0, 1, 2, 1, 3, 2, 4, 1, 2, 0, 1, 3],
            "revenue_per_day": [2100, 1950, 2300, 2600, 2500, 2800,
                                3100, 3200, 2900, 2500, 2200, 2300],
            "foot_traffic":    [540, 490, 610, 700, 670, 750,
                                860, 890, 800, 680, 570, 600],
        },
        2024: {
            "utilization": {
                "Field A": 35, "Field B": 68, "Field C": 48, "Field D": 57,
            },
            "staff_turnover": [1, 0, 2, 2, 1, 3, 2, 2, 1, 1, 0, 2],
            "revenue_per_day": [1900, 1750, 2100, 2350, 2200, 2550,
                                2800, 2950, 2650, 2300, 1950, 2050],
            "foot_traffic":    [490, 440, 560, 640, 610, 690,
                                780, 810, 730, 620, 510, 550],
        },
    },
}

CHART_COLOR  = "#a8c8e8"
UNDER_COLOR  = "#669fd9"   # orange for underutilized
OVER_COLOR   = "#669fd9"   # red for overbooked
NORMAL_COLOR = "#a8c8e8"
CHART_BG     = "white"
FONT_MONO    = "Courier New, monospace"
FONT_STYLE   = dict(family=FONT_MONO, size=12, color="#111")

UNDER_THRESH = 30   # below this = underutilized
OVER_THRESH  = 70   # above this = overbooked

# -------------------------------------------------------
# Chart builders
# -------------------------------------------------------
def utilization_chart(util_dict):
    courts  = list(util_dict.keys())
    values  = list(util_dict.values())
    colors  = []
    for v in values:
        if v < UNDER_THRESH:
            colors.append(UNDER_COLOR)
        elif v >= OVER_THRESH:
            colors.append(OVER_COLOR)
        else:
            colors.append(NORMAL_COLOR)

    avg = round(sum(values) / len(values))
    under = [(c, v) for c, v in zip(courts, values) if v < UNDER_THRESH]
    over  = [(c, v) for c, v in zip(courts, values) if v >= OVER_THRESH]

    fig = go.Figure(go.Bar(
        x=courts, y=values,
        marker_color=colors,
        marker_line_color="#555",
        marker_line_width=1,
        text=[f"{v}%" for v in values],
        textposition="outside",
        textfont=dict(family=FONT_MONO, size=11, color="#111"),
    ))
    fig.update_layout(
        title=dict(text="Venue Utilization", font=dict(family=FONT_MONO, size=14, color="#111"), x=0.44, xref="paper"),
        plot_bgcolor=CHART_BG, paper_bgcolor=CHART_BG,
        font=FONT_STYLE,
        margin=dict(l=40, r=20, t=50, b=60),
        height=300,
        yaxis=dict(ticksuffix="%", range=[0, 100], showgrid=True, gridcolor="#eee"),
        xaxis=dict(showgrid=False),
    )

    under_txt = ", ".join(f"{c} ({v}%)" for c, v in under) or "None"
    over_txt  = ", ".join(f"{c} ({v}%)" for c, v in over)  or "None"

    return fig, avg, under_txt, over_txt

def line_chart(x, y, title, y_prefix="", y_suffix=""):
    fig = go.Figure(go.Scatter(
        x=x, y=y,
        mode="lines+markers",
        line=dict(color="#4a90c4", width=2),
        marker=dict(size=6, color="#4a90c4"),
        fill="tozeroy",
        fillcolor="rgba(168,200,232,0.25)",
    ))
    fig.update_layout(
        title=dict(text=title, font=dict(family=FONT_MONO, size=14, color="#111"), x=0.35, xref="paper"),
        plot_bgcolor=CHART_BG, paper_bgcolor=CHART_BG,
        font=FONT_STYLE,
        margin=dict(l=60, r=20, t=50, b=40),
        height=280,
        xaxis=dict(showgrid=False),
        yaxis=dict(
            showgrid=True, gridcolor="#eee",
            tickprefix=y_prefix, ticksuffix=y_suffix,
        ),
    )
    return fig

def staff_turnover_chart(monthly):
    # Group into quarters
    quarters = ["Q1 (Jan-Mar)", "Q2 (Apr-Jun)", "Q3 (Jul-Sep)", "Q4 (Oct-Dec)"]
    qtotals  = [
        sum(monthly[0:3]),
        sum(monthly[3:6]),
        sum(monthly[6:9]),
        sum(monthly[9:12]),
    ]
    fig = go.Figure(go.Bar(
        x=quarters, y=qtotals,
        marker_color=CHART_COLOR,
        marker_line_color="#6699bb",
        marker_line_width=1,
        text=qtotals,
        textposition="outside",
        textfont=dict(family=FONT_MONO, size=12, color="#111"),
    ))
    fig.update_layout(
        title=dict(text="Staff Turnover by Quarter", font=dict(family=FONT_MONO, size=14, color="#111"), x=0.38, xref="paper"),
        plot_bgcolor=CHART_BG, paper_bgcolor=CHART_BG,
        font=FONT_STYLE,
        margin=dict(l=40, r=20, t=50, b=40),
        height=280,
        xaxis=dict(showgrid=False),
        yaxis=dict(showgrid=True, gridcolor="#eee", title="Staff Departures"),
    )
    return fig

# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown("""
        <style>
            div[data-testid="stSelectbox"] label { display: none; }
            .util-summary {
                font-family: monospace;
                font-size: 15px;
                padding: 12px 0 4px 0;
            }
            .util-divider {
                border: none;
                border-top: 2px solid #333;
                margin: 6px 0 10px 0;
            }
            .util-flags {
                font-family: monospace;
                font-size: 15px;
                line-height: 1.8;
            }
            .flag-under { color: #669fd9; font-weight: bold; }
            .flag-over  { color: #669fd9; font-weight: bold; }
        </style>
    """, unsafe_allow_html=True)

# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    st.markdown("<h2 style='font-family:monospace; margin-bottom:4px;'>Venue Report</h2>", unsafe_allow_html=True)

    # Selectors
    c1, c2, _ = st.columns([2, 2, 4])
    with c1:
        venue = st.selectbox("venue", list(VENUE_DATA.keys()), label_visibility="collapsed")
    with c2:
        year = st.selectbox("year", [2025, 2024], label_visibility="collapsed")

    st.markdown("<hr style='margin:8px 0 16px 0;'>", unsafe_allow_html=True)

    data = VENUE_DATA[venue][year]

    # ---- Venue Utilization ----
    fig_util, avg_util, under_txt, over_txt = utilization_chart(data["utilization"])
    st.plotly_chart(fig_util, use_container_width=True)
    st.html(f"""
    <div class="util-summary">Utilization Rate: {avg_util}%</div>
    <hr class="util-divider">
    <div class="util-flags">
        <div>Underutilized: <span class="flag-under">{under_txt}</span></div>
        <div>Overbooked: <span class="flag-over">{over_txt}</span></div>
    </div>
    """)

    st.markdown("<br>", unsafe_allow_html=True)

    # ---- Staff Turnover ----
    st.plotly_chart(
        staff_turnover_chart(data["staff_turnover"]),
        use_container_width=True,
    )

    st.markdown("<br>", unsafe_allow_html=True)

    # ---- Revenue & Foot Traffic side by side ----
    col_rev, col_ft = st.columns(2)
    with col_rev:
        st.plotly_chart(
            line_chart(MONTHS, data["revenue_per_day"],
                       "Avg Revenue per Day", y_prefix="$"),
            use_container_width=True,
        )
    with col_ft:
        st.plotly_chart(
            line_chart(MONTHS, data["foot_traffic"],
                       "Foot Traffic per Day"),
            use_container_width=True,
        )

show()