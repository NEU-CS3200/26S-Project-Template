# Bostonability

A community-powered accessibility reporting platform for the City of Boston. Residents, commuters, and city staff can report, track, and analyze accessibility barriers — potholes, missing ramps, steep inclines, unplowed bike lanes, and more — so that Boston can identify patterns, prioritize repairs, and measure progress over time.

Built as the Spring 2026 CS 3200 semester project by **The Ocelots**.

## Team

- Brendan Lam — `lam.bre@northeastern.edu`
- Bridget Swineford — `swineford.b@northeastern.edu`
- Allison Sy — `sy.al@northeastern.edu`
- Addison Apisarnthanarax — `Apisarnthanarax.a@northeastern.edu`
- Vanessa Fobid — `fobid.v@northeastern.edu`

## Demo Video

*Link to be added after recording — see `docs/` for submission artifacts.*

## Personas

Bostonability serves four distinct user roles:

| Persona | Role | Core needs |
|---|---|---|
| **Paul Baker** | Urban accessibility policy analyst | Dashboards, trends, neighborhood breakdowns, exports for City Council |
| **Wilson Lampisyobiford** | System administrator | User/role management, data quality review, aggregate stats, audit logs |
| **Sally Locke** | Wheelchair-using resident | Find and avoid obstructions (potholes, steep inclines, no-sidewalk stretches), tailored to her mobility profile |
| **John Marcus** | Daily cyclist commuter | Plowed-street map, submit snow-plow requests, manage his own hazard reports, find bike-lane coverage |

## Architecture

Three-tier app running in three Docker containers coordinated by Docker Compose:

```
┌────────────┐    HTTP    ┌────────────┐    MySQL    ┌────────────┐
│  Streamlit │ ─────────► │   Flask    │ ──────────► │   MySQL    │
│  (web-app) │            │ (web-api)  │             │    (db)    │
│   :8501    │            │   :4000    │             │  :3200     │
└────────────┘            └────────────┘             └────────────┘
```

- **`app/`** — Streamlit UI, one landing page + persona-specific feature pages
- **`api/`** — Flask REST API organized into 4 Blueprints (`users`, `reports`, `locations_tickets`, `analytics`)
- **`database-files/`** — SQL DDL + mock data, auto-executed on first MySQL container creation
- **`docs/`** — project documentation including the REST API matrix

## Quickstart

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) running
- Git
- Python 3.11 (optional — only needed if running the API or Streamlit outside Docker)

### 1. Clone the repo

```bash
git clone https://github.com/YuYongJu/26S-Project-Bostonability.git
cd 26S-Project-Bostonability
```

### 2. Create `api/.env`

Copy the template and fill in a password:

```bash
cp api/.env.template api/.env
```

Then open `api/.env` and set:

- `SECRET_KEY` — any random string (used by Flask for session signing)
- `MYSQL_ROOT_PASSWORD` — a strong password (do not reuse one from other services)

`DB_NAME` is already set to `bostonability`; leave the other DB_* values as-is.

### 3. Start all containers

```bash
docker compose up -d
```

This boots MySQL, runs every `.sql` file in `database-files/` in alphabetical order, builds the Flask API, and serves the Streamlit app.

| Service | URL |
|---|---|
| Streamlit UI | http://localhost:8501 |
| Flask REST API | http://localhost:4000 |
| MySQL | `localhost:3200` (external), `db:3306` (internal) |

### 4. Stopping / resetting

```bash
docker compose down          # stop and remove containers
docker compose stop          # stop but keep containers
docker compose up db -d      # start only the db container
```

### 5. Applying DDL or mock-data changes

MySQL only executes `database-files/*.sql` on **first container creation**. After any schema or mock-data change you must recreate the `db` container (the `-v` flag also drops the data volume):

```bash
docker compose down db -v && docker compose up db -d
```

## REST API overview

34 routes across 4 Flask Blueprints. Full matrix with user-story traceability: [`docs/rest-api-matrix.md`](docs/rest-api-matrix.md). Endpoint-level reference: [`docs/api-reference.md`](docs/api-reference.md).

| Blueprint | Prefix | Purpose |
|---|---|---|
| `users` | `/users` | User CRUD, role assignment, disability profile, action log (Wilson, Sally) |
| `reports` | `/reports` | Accessibility report CRUD, filtering, high-priority + invalid views (John, Wilson, Paul) |
| `locations_tickets` | (none — mixed prefixes) | `/tickets/*` ticket workflow + `/locations/*` + obstruction linking (Paul, Wilson, Sally, John) |
| `analytics` | `/analytics` | Read-only aggregates: neighborhoods, trends, resolution, high-priority, export (Paul, Wilson) |

## Development tips

- **Hot reload**: changes in `app/src/` and `api/` are live-reloaded. Click Streamlit's *Always Rerun* button the first time it prompts.
- **MySQL logs**: Docker Desktop → `mysql_db` container → Logs tab. Search for `Error` when SQL init fails.
- **Debugging the API locally**: `docker compose up api -d` then watch logs with `docker compose logs -f api`.

## Project phases

| Phase | Deliverable | Due |
|---|---|---|
| Phase 1 | Personas, wireframes, pitch video | Mar 30, 2026 (submitted) |
| Phase 2 | ER model, DDL, SQL queries, REST API matrix | Apr 6, 2026 (submitted) |
| Phase 3 | Working Flask API + Streamlit UI, demo video | Apr 20/21, 2026 |
