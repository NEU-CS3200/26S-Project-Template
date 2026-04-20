import os
import requests
import streamlit as st


API_BASE_URLS = [
    os.getenv("PIN_API_BASE_URL"),
    "http://api:4000",
    "http://web-api:4000",
    "http://localhost:4000",
    "http://127.0.0.1:4000",
]


def _iter_base_urls():
    for base_url in API_BASE_URLS:
        if base_url:
            yield base_url.rstrip("/")


def _request(method, path: str, body: dict | None = None, params: dict | None = None):
    last_error = None
    for base_url in _iter_base_urls():
        url = f"{base_url}{path}"
        try:
            response = requests.request(method, url, json=body, params=params, timeout=8)
        except requests.RequestException as exc:
            last_error = str(exc)
            continue

        if response.status_code >= 400:
            error_message = response.text.strip()
            try:
                payload = response.json()
                if isinstance(payload, dict) and payload.get("error"):
                    error_message = payload["error"]
            except ValueError:
                pass
            return None, f"{response.status_code} {error_message}".strip()

        try:
            return response.json(), None
        except ValueError:
            return None, f"{response.status_code} Invalid JSON response from API"
    return None, last_error


def api_get(path: str, params: dict | None = None):
    """Small helper to keep API calls consistent across pages."""
    return _request("GET", path, params=params)


def api_post(path: str, body: dict):
    return _request("POST", path, body=body)


def api_put(path: str, body: dict):
    return _request("PUT", path, body=body)


def api_delete(path: str, body: dict | None = None):
    return _request("DELETE", path, body=body)


def show_api_error(err: str):
    st.error("Could not connect to API or request failed.")
    st.caption(err)
