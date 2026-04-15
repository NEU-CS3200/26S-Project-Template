import streamlit as st
from modules.nav import SideBarLinks
SideBarLinks(show_home=False, userAuthStatus="coach_persona")

TEAM_NAME = "Huskies"

INIT_PLAYERS = [
    {"name": "Alex Johnson",  "role": "Player",      "age": 19,   "date_joined": "04/15/2026", "status": "Active"},
    {"name": "Jamie Lee",     "role": "Player",      "age": None, "date_joined": None,         "status": "Pending"},
    {"name": "Morgan Smith",  "role": "Player",      "age": 18,   "date_joined": "04/15/2026", "status": "Inactive"},
    {"name": "Taylor Brown",  "role": "Asst. Coach", "age": 21,   "date_joined": "04/15/2026", "status": "Declined"},
]
INIT_TRAININGS = [
    {"location": "Field 1",       "notes": "Legs workout, warm up with a 2 mile run beforehand", "coach": "Wade Clarke", "time": "3/06/2026 3:00 PM"},
    {"location": "Field 3",       "notes": "Very light workout, game tomorrow",                  "coach": "John Smith",  "time": "3/08/2026 3:00 PM"},
    {"location": "SquashBusters", "notes": "Chest and back",                                     "coach": "Wade Clarke", "time": "3/06/2026 3:00 PM"},
    {"location": "TBD",           "notes": "N/A",                                                "coach": "Wade Clarke", "time": "3/06/2026 3:00 PM"},
]
INIT_MEETINGS = [
    {"location": "Zoom",                 "notes": "Team Strategy", "time": "3/06/2026 3:00 PM"},
    {"location": "Curry Student Center", "notes": "N/A",           "time": "3/08/2026 3:00 PM"},
    {"location": "Ryder Hall",           "notes": "TBD",           "time": "3/06/2026 3:00 PM"},
]
ROLES = ["Player", "Asst. Coach", "Analyst"]

STATUS_COLORS = {"Active":"#2e7d32","Pending":"#888","Inactive":"#c96a00","Declined":"#c61717"}
BTN_COLORS    = {"remove":"#c61717","withdraw":"#888","deactivate":"#c96a00","activate":"#2e7d32"}
BTN_LABELS    = {"remove":"✕ Remove","withdraw":"↩ Withdraw","deactivate":"⊘ Deactivate","activate":"✓ Activate"}

def status_actions(status):
    if status == "Active":   return ["remove"]
    if status == "Pending":  return ["withdraw"]
    if status == "Inactive": return ["activate"]
    if status == "Declined": return ["withdraw"]
    return []

def init_state():
    if "players"           not in st.session_state: st.session_state["players"]           = [p.copy() for p in INIT_PLAYERS]
    if "trainings"         not in st.session_state: st.session_state["trainings"]         = [t.copy() for t in INIT_TRAININGS]
    if "meetings"          not in st.session_state: st.session_state["meetings"]          = [m.copy() for m in INIT_MEETINGS]
    if "player_actions"    not in st.session_state: st.session_state["player_actions"]    = {}
    if "training_removals" not in st.session_state: st.session_state["training_removals"] = set()
    if "meeting_removals"  not in st.session_state: st.session_state["meeting_removals"]  = set()

def apply_styles():
    st.markdown("""
        <style>
            div[data-testid="stTextInput"] label,
            div[data-testid="stSelectbox"] label,
            div[data-testid="stTextArea"] label { display: none; }

            .section-title { font-family:monospace; font-size:22px; font-weight:bold; margin-bottom:6px; }

            /* Table header rows */
            .th-players { display:grid; grid-template-columns:2fr 1.5fr 0.6fr 1.4fr 1.2fr 2.4fr; padding:10px 14px; font-family:monospace; font-size:14px; font-weight:bold; background:#f5f5f5; border:2px solid #333; border-bottom:2px solid #555; }
            .th-tr      { display:grid; grid-template-columns:1.4fr 3fr 1.4fr 1.8fr 1fr;         padding:10px 14px; font-family:monospace; font-size:14px; font-weight:bold; background:#f5f5f5; border:2px solid #333; border-bottom:2px solid #555; }
            .th-mr      { display:grid; grid-template-columns:1.8fr 3fr 1.8fr 1fr;               padding:10px 14px; font-family:monospace; font-size:14px; font-weight:bold; background:#f5f5f5; border:2px solid #333; border-bottom:2px solid #555; }

            /* Row borders */
            .row-border        { border-left:2px solid #333; border-right:2px solid #333; border-bottom:1px solid #ddd; }
            .row-border-last   { border-left:2px solid #333; border-right:2px solid #333; border-bottom:2px solid #333; }
            .row-border-marked { border-left:2px solid #333; border-right:2px solid #333; border-bottom:1px solid #ddd; background:#fff5f5; }

            /* Cell text */
            .cell { font-family:monospace; font-size:14px; display:flex; align-items:center; padding: 2px 0; min-height:38px; }

            /* Remove top gap on buttons so they align with cell text */
            div[data-testid="stColumns"] div[data-testid="stButton"] { margin-top:0 !important; padding-top:0 !important; }
            div[data-testid="stColumns"] div[data-testid="stButton"] > button { margin-top:0 !important; }

            /* Style real Streamlit buttons as action buttons */
            div[data-testid="stButton"].btn-remove   > button { color:#c61717 !important; border-color:#c61717 !important; background:white !important; font-family:monospace; font-size:12px; padding:4px 10px; }
            div[data-testid="stButton"].btn-remove   > button:hover, div[data-testid="stButton"].btn-remove.active   > button { background:#c61717 !important; color:white !important; }
            div[data-testid="stButton"].btn-withdraw > button { color:#888 !important;    border-color:#888 !important;    background:white !important; font-family:monospace; font-size:12px; padding:4px 10px; }
            div[data-testid="stButton"].btn-deact    > button { color:#c96a00 !important; border-color:#c96a00 !important; background:white !important; font-family:monospace; font-size:12px; padding:4px 10px; }
            div[data-testid="stButton"].btn-activate > button { color:#2e7d32 !important; border-color:#2e7d32 !important; background:white !important; font-family:monospace; font-size:12px; padding:4px 10px; }

            /* Active (clicked) state — filled */
            div[data-testid="stButton"].btn-remove-active   > button { background:#c61717 !important; color:white !important; border-color:#c61717 !important; font-family:monospace; font-size:12px; }
            div[data-testid="stButton"].btn-withdraw-active > button { background:#888    !important; color:white !important; border-color:#888    !important; font-family:monospace; font-size:12px; }
            div[data-testid="stButton"].btn-deact-active    > button { background:#c96a00 !important; color:white !important; border-color:#c96a00 !important; font-family:monospace; font-size:12px; }
            div[data-testid="stButton"].btn-activate-active > button { background:#2e7d32 !important; color:white !important; border-color:#2e7d32 !important; font-family:monospace; font-size:12px; }
        </style>
    """, unsafe_allow_html=True)

def inject_btn_class(css_class):
    """Inject a class onto the last-rendered stButton via JS."""
    st.markdown(f"""<script>
    (function(){{
        const btns = window.parent.document.querySelectorAll('[data-testid="stButton"]');
        if(btns.length) btns[btns.length-1].classList.add('{css_class}');
    }})();
    </script>""", unsafe_allow_html=True)

def section_header(title, show_fin, fin_key):
    c1, c2 = st.columns([6, 1])
    with c1: st.markdown(f"<div class='section-title'>{title}</div>", unsafe_allow_html=True)
    with c2:
        if show_fin:
            return st.button("Finalize", key=fin_key, type="primary")
    return False

def status_cell_html(status, pending=None):
    sc = STATUS_COLORS.get(status, "#333")
    html = f'<span style="color:{sc};font-weight:bold;font-family:monospace;font-size:14px;">{status}</span>'
    if pending:
        html += f' <span style="color:#bbb;font-size:11px;">→{pending}</span>'
    return html

def show():
    init_state()
    apply_styles()

    st.markdown(f"<h1 style='font-family:monospace;'>{TEAM_NAME}</h1>", unsafe_allow_html=True)

    # ================================================================
    # MANAGE PLAYERS
    # ================================================================
    has_pa = len(st.session_state["player_actions"]) > 0
    if section_header("Manage Players", has_pa, "fin_players"):
        actions = st.session_state["player_actions"]
        players = st.session_state["players"]
        to_remove = []
        for idx, action in actions.items():
            if action in ("remove","withdraw"): to_remove.append(idx)
            elif action == "deactivate": players[idx]["status"] = "Inactive"
            elif action == "activate":   players[idx]["status"] = "Active"
        for idx in sorted(to_remove, reverse=True): players.pop(idx)
        st.session_state["player_actions"] = {}
        st.rerun()

    # Header
    st.html('<div class="th-players"><span>Name</span><span>Role</span><span>Age</span><span>Date Joined</span><span>Status</span><span>Actions</span></div>')

    players = st.session_state["players"]
    for i, p in enumerate(players):
        pending = st.session_state["player_actions"].get(i)
        acts = status_actions(p["status"])
        is_last = (i == len(players) - 1)
        border_cls = "row-border-last" if is_last else "row-border"

        # 6-column grid row: name | role | age | date | status | actions
        # actions col split further into sub-columns
        cols = st.columns([2, 1.5, 0.6, 1.4, 1.2, 2.4])
        with cols[0]: st.markdown(f'<div class="cell">{p["name"]}</div>', unsafe_allow_html=True)
        with cols[1]: st.markdown(f'<div class="cell">{p["role"]}</div>', unsafe_allow_html=True)
        with cols[2]: st.markdown(f'<div class="cell">{p["age"] or ""}</div>', unsafe_allow_html=True)
        with cols[3]: st.markdown(f'<div class="cell">{p["date_joined"] or ""}</div>', unsafe_allow_html=True)
        with cols[4]: st.markdown(f'<div class="cell">{status_cell_html(p["status"], pending)}</div>', unsafe_allow_html=True)
        with cols[5]:
            if len(acts) == 2:
                bc1, bc2 = st.columns(2)
                with bc1:
                    active = pending == acts[0]
                    css = f"btn-{acts[0]}-active" if active else f"btn-{acts[0]}"
                    label = BTN_LABELS[acts[0]] + (" ✓" if active else "")
                    st.markdown(f'<div data-btn-class="{css}">', unsafe_allow_html=True)
                    if st.button(label, key=f"p_{i}_{acts[0]}"):
                        if active: del st.session_state["player_actions"][i]
                        else: st.session_state["player_actions"][i] = acts[0]
                        st.rerun()
                with bc2:
                    active = pending == acts[1]
                    css = f"btn-{acts[1]}-active" if active else f"btn-{acts[1]}"
                    label = BTN_LABELS[acts[1]] + (" ✓" if active else "")
                    if st.button(label, key=f"p_{i}_{acts[1]}"):
                        if active: del st.session_state["player_actions"][i]
                        else: st.session_state["player_actions"][i] = acts[1]
                        st.rerun()
            elif len(acts) == 1:
                active = pending == acts[0]
                label = BTN_LABELS[acts[0]] + (" ✓" if active else "")
                if st.button(label, key=f"p_{i}_{acts[0]}"):
                    if active: del st.session_state["player_actions"][i]
                    else: st.session_state["player_actions"][i] = acts[0]
                    st.rerun()

        # Bottom border line
        border_color = "#333" if is_last else "#ddd"
        st.markdown(f'<div style="border-bottom:{"2px" if is_last else "1px"} solid {border_color};"></div>', unsafe_allow_html=True)

    st.markdown("<br>", unsafe_allow_html=True)

    # ================================================================
    # INVITE PLAYER
    # ================================================================
    inv_name  = st.session_state.get("inv_name",  "")
    inv_email = st.session_state.get("inv_email", "")
    has_inv = bool(inv_name.strip() or inv_email.strip())
    if section_header("Invite Player", has_inv, "fin_invite"):
        st.session_state["inv_name"] = st.session_state["inv_email"] = ""
        st.rerun()
    c1,c2,c3 = st.columns([3,5,2])
    with c1: st.text_input("_",  placeholder="Name",        label_visibility="collapsed", key="inv_name")
    with c2: st.text_input("__", placeholder="Enter Email", label_visibility="collapsed", key="inv_email")
    with c3: st.selectbox("___", ROLES, label_visibility="collapsed", key="inv_role")

    st.markdown("<br>", unsafe_allow_html=True)

    # ================================================================
    # MANAGE TRAININGS
    # ================================================================
    has_tr = len(st.session_state["training_removals"]) > 0
    if section_header("Manage Trainings", has_tr, "fin_tr"):
        for idx in sorted(st.session_state["training_removals"], reverse=True):
            st.session_state["trainings"].pop(idx)
        st.session_state["training_removals"] = set()
        st.rerun()

    st.html('<div class="th-tr"><span>Location</span><span>Notes</span><span>Coach</span><span>Time</span><span>Actions</span></div>')

    trainings = st.session_state["trainings"]
    for i, t in enumerate(trainings):
        marked = i in st.session_state["training_removals"]
        is_last = (i == len(trainings) - 1)
        bg = "background:#fff5f5;" if marked else ""
        cols = st.columns([1.4, 3, 1.4, 1.8, 1])
        with cols[0]: st.markdown(f'<div class="cell" style="{bg}">{t["location"]}</div>', unsafe_allow_html=True)
        with cols[1]: st.markdown(f'<div class="cell" style="{bg}">{t["notes"]}</div>', unsafe_allow_html=True)
        with cols[2]: st.markdown(f'<div class="cell" style="{bg}">{t["coach"]}</div>', unsafe_allow_html=True)
        with cols[3]: st.markdown(f'<div class="cell" style="{bg}">{t["time"]}</div>', unsafe_allow_html=True)
        with cols[4]:
            label = "✕ Remove ✓" if marked else "✕ Remove"
            if st.button(label, key=f"tr_{i}"):
                if marked: st.session_state["training_removals"].discard(i)
                else: st.session_state["training_removals"].add(i)
                st.rerun()
        border_color = "#333" if is_last else "#ddd"
        st.markdown(f'<div style="border-bottom:{"2px" if is_last else "1px"} solid {border_color};"></div>', unsafe_allow_html=True)

    st.markdown("<br>", unsafe_allow_html=True)

    # ================================================================
    # ADD TRAINING
    # ================================================================
    at_loc=st.session_state.get("at_loc",""); at_time=st.session_state.get("at_time",""); at_notes=st.session_state.get("at_notes","")
    has_at = bool(at_loc.strip() or at_time.strip() or at_notes.strip())
    if section_header("Add Training", has_at, "fin_at"):
        st.session_state["at_loc"]=st.session_state["at_time"]=st.session_state["at_notes"]=""
        st.rerun()
    c1,c2=st.columns([2,4])
    with c1:
        st.text_input("a1", placeholder="Location",                label_visibility="collapsed", key="at_loc")
        st.text_input("a2", placeholder="Time (MM/DD/YYYY HH:MM)", label_visibility="collapsed", key="at_time")
    with c2:
        st.text_area("a3", placeholder="Notes", label_visibility="collapsed", key="at_notes", height=100)

    st.markdown("<br>", unsafe_allow_html=True)

    # ================================================================
    # MANAGE MEETINGS
    # ================================================================
    has_mr = len(st.session_state["meeting_removals"]) > 0
    if section_header("Manage Meetings", has_mr, "fin_mr"):
        for idx in sorted(st.session_state["meeting_removals"], reverse=True):
            st.session_state["meetings"].pop(idx)
        st.session_state["meeting_removals"] = set()
        st.rerun()

    st.html('<div class="th-mr"><span>Location</span><span>Notes</span><span>Time</span><span>Actions</span></div>')

    meetings = st.session_state["meetings"]
    for i, m in enumerate(meetings):
        marked = i in st.session_state["meeting_removals"]
        is_last = (i == len(meetings) - 1)
        bg = "background:#fff5f5;" if marked else ""
        cols = st.columns([1.8, 3, 1.8, 1])
        with cols[0]: st.markdown(f'<div class="cell" style="{bg}">{m["location"]}</div>', unsafe_allow_html=True)
        with cols[1]: st.markdown(f'<div class="cell" style="{bg}">{m["notes"]}</div>', unsafe_allow_html=True)
        with cols[2]: st.markdown(f'<div class="cell" style="{bg}">{m["time"]}</div>', unsafe_allow_html=True)
        with cols[3]:
            label = "✕ Remove ✓" if marked else "✕ Remove"
            if st.button(label, key=f"mr_{i}"):
                if marked: st.session_state["meeting_removals"].discard(i)
                else: st.session_state["meeting_removals"].add(i)
                st.rerun()
        border_color = "#333" if is_last else "#ddd"
        st.markdown(f'<div style="border-bottom:{"2px" if is_last else "1px"} solid {border_color};"></div>', unsafe_allow_html=True)

    st.markdown("<br>", unsafe_allow_html=True)

    # ================================================================
    # ADD MEETING
    # ================================================================
    am_loc=st.session_state.get("am_loc",""); am_time=st.session_state.get("am_time",""); am_notes=st.session_state.get("am_notes","")
    has_am = bool(am_loc.strip() or am_time.strip() or am_notes.strip())
    if section_header("Add Meeting", has_am, "fin_am"):
        st.session_state["am_loc"]=st.session_state["am_time"]=st.session_state["am_notes"]=""
        st.rerun()
    c1,c2=st.columns([2,4])
    with c1:
        st.text_input("b1", placeholder="Location",                label_visibility="collapsed", key="am_loc")
        st.text_input("b2", placeholder="Time (MM/DD/YYYY HH:MM)", label_visibility="collapsed", key="am_time")
    with c2:
        st.text_area("b3", placeholder="Notes", label_visibility="collapsed", key="am_notes", height=100)

show()