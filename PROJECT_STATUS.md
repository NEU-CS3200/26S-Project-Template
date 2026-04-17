# HuskyLeague — Project Status

## What's Done

**Backend API** — fully implemented (~2,200 lines, 55+ routes across 9 blueprints):

| Blueprint | Endpoints | Routes |
|---|---|---|
| `analytics.py` | 7 | participation, venues, forfeits, scoring trends, demand, reports |
| `games.py` | 9 | CRUD, scores, disputes |
| `leagues.py` | 8 | CRUD, free agents, teams, disputes |
| `players.py` | 4 | profile, schedule, stats, notifications |
| `teams.py` | 8 | CRUD, schedule, messaging |
| `team_members.py` | 4 | roster management |
| `venues.py` | 8 | CRUD, reviews, timeslots |
| `notifications.py` | 2 | send and retrieve league notifications |

**Database schema** — `database-files/01_HuskyLeague_DDL.sql` contains all 15 tables + seed data:
- League, Player, Team, Team_Membership, Team_Message
- Venue, Venue_Time_Slot, Venue_Review
- Game, Game_Result, Score_Submission, Player_Game_Stats
- Dispute, Notification, Free_Agent_Request, Analytics_Report

**Frontend UI** — 12 Streamlit pages for all 4 personas, all styled:

| Persona | Pages |
|---|---|
| Player (Maya) | Browse leagues, view schedule, manage profile |
| Coach/Captain (Allan) | Form team, manage roster, team dashboard |
| League Admin (Derrick) | Venue schedule, manage league, disputes |
| Analyst (Dr. Priya) | Intramural report, venue report, team report |

---

## What's Not Done / Broken

### Critical

| Issue | File | Detail |
|---|---|---|
| **Wrong DB name in `.env`** | `api/.env` | `DB_NAME=ngo_db` but DDL creates `HuskyLeague` — API connects to wrong database |
| **No frontend API calls** | `app/src/pages/*.py` | All 12 pages use hardcoded mock data; `requests` library is never called |

### Missing Endpoints

| Endpoint | Detail |
|---|---|
| `POST /players` | No way to create players via the API |

### Frontend Pages — Integration Status

| Page | Mock Data | Needs API Calls To |
|---|---|---|
| `player_browse_leagues.py` | Yes | `GET /leagues` |
| `player_browse_profile.py` | Yes | `GET /players/<id>` |
| `player_browse_scheduled_games.py` | Yes | `GET /players/<id>/schedule` |
| `coach_form_team.py` | Yes | `POST /teams`, `GET /leagues` |
| `coach_manage_team.py` | Yes | `GET /teams/<id>/members`, `PUT/DELETE /teams/<id>/members/<id>` |
| `coach_team_dashboard.py` | Yes | `GET /teams/<id>`, `GET /teams/<id>/schedule` |
| `league_admin_venue_schedule.py` | Yes | `GET /venues`, `GET/PUT /venue-slots/<id>` |
| `league_admin_manage_league.py` | Yes | `GET /leagues`, `PUT /leagues/<id>` |
| `league_admin_disputes.py` | Yes | `GET /leagues/<id>/disputes`, `PUT /games/<id>/disputes/<id>` |
| `analyst_intramural_report.py` | Yes | `GET /analytics/participation`, `GET /analytics/demand` |
| `analyst_venue_report.py` | Yes | `GET /analytics/venues`, `GET /venues/<id>/reviews` |
| `analyst_team_report.py` | Yes | `GET /analytics/<teamId>/pts-scored`, `GET /analytics/<teamId>/pts-allowed` |

---

## Priority Order to Finish

1. **Fix `.env`** — change `DB_NAME=ngo_db` → `DB_NAME=HuskyLeague`
2. **Add `POST /players`** endpoint to `api/backend/blueprints/players.py`
3. **Wire each frontend page** to the real API replacing mock data with `requests` calls
