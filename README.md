# HoopSpot

**Pick up. Check in. Run it back.**

HoopSpot is a court-finder and pickup-basketball companion app built for Dr. Fontenot's Spring 2026 CS 3200 project. It helps players discover nearby courts, check in to active runs, track games and leaderboards, and organize tournaments, while giving administrators tools to manage courts, reviews, and the underlying data.

## Project Overview

The app is organized around four user personas, each with a dedicated set of pages and workflows:

- **Marcus Reyes — Pickup Player.** Finds open courts, checks in to games, and manages a personal profile.
- **Aaliyah — Competitive Player.** Tracks leaderboards, joins tournaments, and follows competitive stats.
- **Devon Williams — System Administrator.** Manages courts, reviews, and ML model configuration.
- **Priya Nair — Parks and Rec Data Analyst.** Explores usage dashboards and heat maps, compares condition ratings against activity, and exports filtered data for city reporting.

### Architecture

HoopSpot runs as three containerized services orchestrated by Docker Compose:

| Service | Tech | Port | Purpose |
| --- | --- | --- | --- |
| `app` | Streamlit (Python) | `8501` | User-facing web app |
| `api` | Flask REST API (Python) | `4000` | Application/business logic |
| `db`  | MySQL 9 | `3200` | Persistent data store |

### Repo Layout

- `./app` — Streamlit frontend
- `./api` — Flask REST API
- `./database-files` — SQL scripts that initialize the MySQL database
- `./datasets` — sample data used for analysis and ML
- `./ml-src` — ML model development (notebooks, training scripts)
- `./docs` — additional project documentation
- `docker-compose.yaml` — service definitions for the full stack

## Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) (includes Docker Compose)
- Git
- Python 3.11

## Environment Setup

Before starting the containers, create the database environment file:

1. In `./api`, copy `.env.template` to `.env`.
2. Open the new `.env` and set a password on the last line (do not reuse personal passwords).

The `db` service reads this file at startup to initialize MySQL credentials.

## Running the Docker Containers

All commands below are run from the repository root.

Start the full stack (app, api, db) in the background:

```bash
docker compose up -d
```

Once the containers are up:

- Streamlit app → http://localhost:8501
- REST API → http://localhost:4000
- MySQL → `localhost:3200`

Stop and remove the containers:

```bash
docker compose down
```

Stop the containers without removing them:

```bash
docker compose stop
```

Start a single service (replace `db` with `api` or `app` as needed):

```bash
docker compose up db -d
```

### Rebuilding the Database

The MySQL container runs every `.sql` file in `./database-files` **in alphabetical order**, but only the first time it is created. If you change any SQL, you must recreate the container and its volume:

```bash
docker compose down db -v && docker compose up db -d
```

### Notes

- Code changes in `./app` and `./api` hot-reload inside the running containers.
- If a container exits due to a code error, fix the error and run `docker compose restart`.
- Container logs (especially MySQL's) are available in Docker Desktop and are the fastest way to diagnose startup issues.
