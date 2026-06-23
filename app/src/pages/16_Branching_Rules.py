import streamlit as st

from modules.nav import SideBarLinks

st.set_page_config(layout="wide")
SideBarLinks()

st.title("Branching Rules")
st.write("Phase 1 collaboration policy to keep `main` stable.")

st.markdown(
    """
    - Every contributor works on a personal branch.
    - Open a pull request into `main` for all code changes.
    - No direct pushes to `main`.
    - Keep PRs small and tied to one task.
    - Merge only after at least one teammate review.

    Full policy: `docs/branching-strategy.md`
    """
)
