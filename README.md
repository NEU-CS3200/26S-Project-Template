# communevent

**CS 3200 — Spring 2026 | Marky Mark and the Funky Bunch**

A data-driven local event discovery and management platform that connects attendees, event organizers, performers, and venue owners in one place.

## Team Members

| Name | Email |
|------|-------|
| Matthew Garcia (Point Person) | garcia.matt@northeastern.edu |
| Janie Lu | lu.jan@northeastern.edu |
| Eoin Collette | collette.e@northeastern.edu |
| Jacob Yu | yu.jaco@northeastern.edu |
| Nevin Kannalath | kannalath.n@northeastern.edu |

## About

Finding and organizing local events is fragmented — people rely on Instagram, word of mouth, and a dozen different apps. communevent brings everyone to the same table:

- **Attendees** browse a personalized feed based on their interests and location, RSVP to events, save favorites, and leave reviews
- **Event Organizers** post events, find and book performers, and request venue bookings
- **Performers** manage their profile, receive booking requests from organizers, and track upcoming gigs
- **Venue Owners** review booking requests, manage their calendar, and track weekly revenue

Key features include an ML-powered interest-matching feed, a performer discovery system, and an end-to-end venue booking workflow.

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Frontend | Streamlit (Python 3.11) |
| Backend | Flask 2.3.3 (Python 3.11) |
| Database | MySQL 9 |
| Containerization | Docker & Docker Compose |
| ML / Recommendations | scikit-learn, pandas |

## User Personas

| Persona | Role | Key Needs |
|---------|------|-----------|
| **Sarah Chen** | Attendee | Personalized event feed, RSVP, favorites, reviews |
| **Jason Ming** | Venue Owner | Booking request management, calendar view, revenue tracking |
| **Ron Krant** | Event Organizer | Post events, find venues & performers, attendee management |
| **Caleb Kim** | Performer | Profile visibility, booking requests, performance tracking |

## Setup & Running

### Prerequisites
- Docker Desktop installed and running

### Steps

1. **Clone the repo**
   ```bash
   git clone <repo-url>
   cd <repo-folder>
   ```

2. **Create `api/.env`** with the following contents (fill in your own password and secret key):
   ```
   DB_USER=root
   DB_PASSWORD=<your-password>
   DB_HOST=db
   DB_PORT=3306
   DB_NAME=CommunEvent
   SECRET_KEY=<your-secret-key>
   MYSQL_ROOT_PASSWORD=<your-password>
   ```

3. **Start all services**
   ```bash
   docker compose up -d
   ```
   This starts three containers:
   - `db` — MySQL on port 3200
   - `web-api` — Flask REST API on port 4000
   - `app` — Streamlit UI on port 8501

4. **Open the app** at [http://localhost:8501](http://localhost:8501)

### Resetting the database

If you change SQL files in `database-files/`, tear down and recreate the database volume:
```bash
docker compose down
docker volume rm 26s-project-template-funky-bunch_db_data
docker compose up -d
```

## Project Structure

```
├── app/                  # Streamlit frontend
│   └── src/
│       ├── Home.py               # Login / role selector
│       ├── pages/                # Per-persona feature pages
│       └── modules/nav.py        # Sidebar navigation helper
├── api/                  # Flask REST API (port 4000)
│   └── backend/
│       ├── attendee/             # /attendee routes
│       ├── event/                # /event routes
│       ├── organizer/            # /organizer routes
│       ├── owner/                # /owner routes
│       ├── performer/            # /performer routes
│       ├── venue/                # /venue routes
│       └── review/               # /review routes
├── database-files/       # MySQL schema + seed data (auto-executed on container create)
├── ml-src/               # Machine learning source code (recommendation engine)
└── datasets/             # Training / reference data for ML models
```

## API Overview

The Flask API is organized into 7 blueprints, all served on **port 4000**:

| Blueprint | Prefix | Description |
|-----------|--------|-------------|
| Attendee | `/attendee` | Feed, RSVPs, favorites |
| Event | `/event` | Event CRUD, reviews, attendee lists |
| Organizer | `/organizer` | Organizer profile, event management |
| Owner | `/owner` | Venue owner dashboard |
| Performer | `/performer` | Performer profiles, bookings, performances |
| Venue | `/venue` | Venue listings, booking requests, revenue |
| Review | `/review` | Event reviews and ratings |
