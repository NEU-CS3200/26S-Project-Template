"""Shared CSS styling for HoopSpot."""

FONT_IMPORT = (
    "@import url('https://fonts.googleapis.com/css2?family=Outfit:"
    "wght@300;400;500;600;700;800&display=swap');"
)

BASE_CSS = """
/* ---- Typography ---- */
html, body, .stApp,
.stMarkdown, .stMarkdown p, .stMarkdown li, .stMarkdown span,
.stMarkdown strong, .stMarkdown em,
[data-testid="stMarkdownContainer"],
[data-testid="stMetricValue"], [data-testid="stMetricLabel"],
.stSelectbox label, .stTextInput label, .stNumberInput label,
.stCheckbox label, .stRadio label, .stTextArea label {
    font-family: 'Outfit', -apple-system, BlinkMacSystemFont,
                 'Segoe UI', sans-serif !important;
}
h1, h2, h3, h4, h5, h6 {
    font-family: 'Outfit', -apple-system, BlinkMacSystemFont,
                 sans-serif !important;
    letter-spacing: -0.025em !important;
}
h1 { font-weight: 800 !important; }

/* ---- Chrome ---- */
#MainMenu {visibility: hidden;}
footer {visibility: hidden;}
header[data-testid="stHeader"] {
    background: rgba(12, 18, 34, 0.85) !important;
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
}

/* ---- Sidebar ---- */
section[data-testid="stSidebar"] {
    background: linear-gradient(180deg, #080d1a 0%, #0C1222 100%) !important;
    border-right: 1px solid rgba(255,255,255,0.04) !important;
}

/* ---- Cards ---- */
[data-testid="stVerticalBlockBorderWrapper"] {
    border-radius: 14px !important;
    border-color: rgba(255,255,255,0.06) !important;
    transition: border-color 0.2s ease, box-shadow 0.2s ease;
}
[data-testid="stVerticalBlockBorderWrapper"]:hover {
    border-color: rgba(249, 115, 22, 0.2) !important;
    box-shadow: 0 4px 20px rgba(0,0,0,0.25);
}

/* ---- Metrics ---- */
[data-testid="stMetric"] {
    background: rgba(255,255,255,0.02);
    border: 1px solid rgba(255,255,255,0.05);
    border-radius: 10px;
    padding: 0.75rem 1rem;
}
[data-testid="stMetricValue"] { font-weight: 700 !important; }

/* ---- Buttons ---- */
.stButton > button {
    border-radius: 10px !important;
    font-weight: 600 !important;
    font-family: 'Outfit', sans-serif !important;
    transition: all 0.15s cubic-bezier(0.4, 0, 0.2, 1) !important;
}
.stButton > button:hover {
    transform: translateY(-1px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.25);
}
.stButton > button[kind="primary"] {
    background: linear-gradient(135deg, #F97316 0%, #EA580C 100%) !important;
    border: none !important;
}
.stButton > button[kind="primary"]:hover {
    background: linear-gradient(135deg, #FB923C 0%, #F97316 100%) !important;
}

/* ---- Form elements ---- */
[data-testid="stSelectbox"] > div > div { border-radius: 10px !important; }
[data-testid="stTextInput"] input { border-radius: 10px !important; }

/* ---- Dialog ---- */
[data-testid="stDialog"] > div {
    border-radius: 18px !important;
    border: 1px solid rgba(255,255,255,0.06) !important;
}

/* ---- Scrollbar ---- */
::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb {
    background: rgba(255,255,255,0.1);
    border-radius: 3px;
}
::-webkit-scrollbar-thumb:hover { background: rgba(255,255,255,0.2); }
"""


def inject_css(extra_css: str = "") -> str:
    """Return full HTML string (font link + style tag) for st.markdown injection."""
    return f"<style>\n{FONT_IMPORT}\n{BASE_CSS}\n{extra_css}\n</style>"
