import streamlit as st

def apply_bold_button_styles():
    st.markdown("""
        <style>
            .stButton > button[kind="primary"] {
                font-weight: bold;
                font-size: 16px;
            }
        </style>
    """, unsafe_allow_html=True)