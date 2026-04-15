import streamlit as st
import plotly.graph_objects as go
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="analyst_persona")

# -------------------------------------------------------
# Mock Data — 3 semesters
# -------------------------------------------------------
REPORTS = {
    "Spring 2026": {
        "participation": {
            "Soccer": {"count": 400, "yoy": +5},
            "Basketball": {"count": 256, "yoy": +10},
            "Hockey": {"count": 110, "yoy": +1},
            "Volleyball": {"count": 279, "yoy": +21},
        },
        "no_show_rate": {
            "Soccer": 15,
            "Basketball": 20,
            "Volleyball": 11,
            "Hockey": 29,
        },
        "budget": {
            "Soccer": 8000,
            "Basketball": 5120,
            "Hockey": 2200,
            "Volleyball": 5580,
        },
        "budget_change_pct": +27,
    },
    "Fall 2025": {
        "participation": {
            "Soccer": {"count": 381, "yoy": -3},
            "Basketball": {"count": 233, "yoy": +6},
            "Hockey": {"count": 109, "yoy": -2},
            "Volleyball": {"count": 231, "yoy": +14},
        },
        "no_show_rate": {
            "Soccer": 18,
            "Basketball": 22,
            "Volleyball": 13,
            "Hockey": 25,
        },
        "budget": {
            "Soccer": 7600,
            "Basketball": 4800,
            "Hockey": 2100,
            "Volleyball": 4900,
        },
        "budget_change_pct": +12,
    },
    "Summer 2025": {
        "participation": {
            "Soccer": {"count": 392, "yoy": +2},
            "Basketball": {"count": 220, "yoy": -4},
            "Hockey": {"count": 112, "yoy": +5},
            "Volleyball": {"count": 202, "yoy": +8},
        },
        "no_show_rate": {
            "Soccer": 20,
            "Basketball": 17,
            "Volleyball": 9,
            "Hockey": 31,
        },
        "budget": {
            "Soccer": 7800,
            "Basketball": 4500,
            "Hockey": 2300,
            "Volleyball": 4200,
        },
        "budget_change_pct": -5,
    },
}

CHART_COLOR = "#a8c8e8"
CHART_BG = "white"
FONT_MONO = "Courier New, monospace"


# -------------------------------------------------------
# Chart helpers
# -------------------------------------------------------
def bar_chart(x, y, title, y_tickformat=None):
    fig = go.Figure(
        go.Bar(
            x=x,
            y=y,
            marker_color=CHART_COLOR,
            marker_line_color="#6699bb",
            marker_line_width=1,
        )
    )
    fig.update_layout(
        title=dict(
            text=title,
            font=dict(family=FONT_MONO, size=14, color="#111"),
            x=0.43,
            xref="paper",
        ),
        plot_bgcolor=CHART_BG,
        paper_bgcolor=CHART_BG,
        font=dict(family=FONT_MONO, size=12, color="#111"),
        margin=dict(l=40, r=20, t=40, b=40),
        height=280,
        xaxis=dict(showgrid=False),
        yaxis=dict(showgrid=True, gridcolor="#eee", tickformat=y_tickformat or ""),
    )
    return fig


def budget_chart(sports, budgets, total):
    max_budget = max(budgets)
    fig = go.Figure()
    for i, (sport, budget) in enumerate(zip(sports, budgets)):
        fig.add_trace(
            go.Bar(
                x=[budget],
                y=[sport],
                orientation="h",
                marker_color=CHART_COLOR,
                marker_line_color="#6699bb",
                marker_line_width=1,
                showlegend=False,
                text=[f"${budget:,}"],
                textposition="outside",
                textfont=dict(family=FONT_MONO, size=12, color="#111"),
            )
        )
    fig.update_layout(
        title=dict(
            text="Budget Allocation per Sport",
            font=dict(family=FONT_MONO, size=14, color="#111"),
            x=0.43,
            xref="paper",
        ),
        plot_bgcolor=CHART_BG,
        paper_bgcolor=CHART_BG,
        font=dict(family=FONT_MONO, size=12, color="#111"),
        margin=dict(l=80, r=80, t=40, b=40),
        height=220,
        barmode="overlay",
        xaxis=dict(
            range=[0, max_budget * 1.3],
            showgrid=True,
            gridcolor="#eee",
            showticklabels=False,
        ),
        yaxis=dict(showgrid=False),
    )
    return fig


# -------------------------------------------------------
# Styles
# -------------------------------------------------------
def apply_styles():
    st.markdown(
        """
        <style>
            div[data-testid="stSelectbox"] label { display: none; }
            .report-table {
                width: 100%;
                border-collapse: collapse;
                font-family: monospace;
                font-size: 14px;
                border: 2px solid #333;
                margin-bottom: 16px;
            }
            .report-table th {
                border: 1px solid #555;
                padding: 8px 14px;
                text-align: center;
                background: #f5f5f5;
            }
            .report-table td {
                border: 1px solid #aaa;
                padding: 8px 14px;
                text-align: center;
            }
            .yoy-pos { color: #2e7d32; font-weight: bold; }
            .yoy-neg { color: #c61717; font-weight: bold; }
            .budget-footer {
                display: flex;
                justify-content: space-between;
                padding: 10px 16px;
                font-family: monospace;
                font-size: 15px;
                font-weight: bold;
                background: #f9f9f9;
            }
        </style>
    """,
        unsafe_allow_html=True,
    )


# -------------------------------------------------------
# Page
# -------------------------------------------------------
def show():
    apply_styles()

    st.markdown(
        "<h2 style='font-family:monospace; margin-bottom:2px;'>Intramural Activity Report</h2>",
        unsafe_allow_html=True,
    )
    col_label, col_select, _ = st.columns([0.01, 2, 3])

    with col_select:
        selected = st.selectbox(
            "report_select", list(REPORTS.keys()), label_visibility="collapsed"
        )
    st.markdown("<br>", unsafe_allow_html=True)
    st.markdown(
        f"<div style='font-family:monospace; color:#555; margin-bottom:16px;'>{selected} Report</div>",
        unsafe_allow_html=True,
    )

    data = REPORTS[selected]
    sports = list(data["participation"].keys())
    counts = [data["participation"][s]["count"] for s in sports]
    yoys = [data["participation"][s]["yoy"] for s in sports]
    no_show_rates = [data["no_show_rate"][s] for s in sports]
    budgets = [data["budget"][s] for s in sports]
    total_budget = sum(budgets)
    budget_chg = data["budget_change_pct"]

    # ---- Participation Overview Table ----
    rows_html = ""
    for sport, count, yoy in zip(sports, counts, yoys):
        sign = "+" if yoy >= 0 else ""
        cls = "yoy-pos" if yoy >= 0 else "yoy-neg"
        rows_html += f"""
        <tr>
            <td>{sport}</td>
            <td>{count}</td>
            <td><span class="{cls}">{sign}{yoy}%</span></td>
        </tr>"""

    st.html(
        f"""
    <table class="report-table">
        <thead>
            <tr><th colspan="3" style="text-align:left; padding:10px 14px;">Participation Overview</th></tr>
            <tr><th>Sport</th><th>Participants</th><th>% Change YoY</th></tr>
        </thead>
        <tbody>{rows_html}</tbody>
    </table>
    """
    )

    # ---- Total Participation Bar Chart ----
    st.plotly_chart(
        bar_chart(sports, counts, "Total Participation per Sport"),
        use_container_width=True,
    )

    # ---- No Show Rate Bar Chart ----
    st.plotly_chart(
        bar_chart(sports, no_show_rates, "No Show Rate per Sport", y_tickformat=".0f"),
        use_container_width=True,
    )

    # ---- Budget Allocation Horizontal Bar + Footer ----
    st.plotly_chart(
        budget_chart(sports, budgets, total_budget),
        use_container_width=True,
    )

    chg_sign = "+" if budget_chg >= 0 else ""
    chg_color = "#2e7d32" if budget_chg >= 0 else "#c61717"
    st.html(
        f"""
    <div class="budget-footer">
        <span>${total_budget:,}</span>
        <span>Total Budget Allocated</span>
        <span style="color:{chg_color};">{chg_sign}{budget_chg}% From Last Semester</span>
    </div>
    """
    )


show()
