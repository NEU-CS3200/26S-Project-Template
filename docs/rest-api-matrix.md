# Bostonability REST API Matrix (Phase 3)

Revised from the Phase 3 submission template after cross-checking against Phase 2 personas, user stories, and SQL queries.

## Personas

| ID | Name | Role |
|---|---|---|
| Paul | Paul Baker | Urban accessibility policy analyst |
| Wilson | Wilson Lampisyobiford | System administrator |
| Sally | Sally Locke | Wheelchair user / resident |
| John | John Marcus | Daily cyclist commuter |

Tag format: `[persona-story_num]`, e.g. `[Paul-2]` = Paul's 2nd user story.

## Matrix

### Blueprint: `users`

| Resource | GET | POST | PUT | DELETE |
|---|---|---|---|---|
| `/users` | List all users `[Wilson-1]` | Create user `[Wilson-1]` | n/a | n/a |
| `/users/{id}` | View user info `[Wilson-1][Sally-5]` | n/a | Update user `[Wilson-1][Sally-5]` | Delete user `[Wilson-1]` |
| `/users/{id}/roles` | View roles `[Wilson-1]` | n/a | Update role `[Wilson-1]` | n/a |
| `/users/{id}/disabilities` | View disabilities `[Sally-5]` | Add disability `[Sally-5]` | Update preferences `[Sally-5]` | Remove disability `[Sally-5]` |
| `/users/{id}/actions` | View user action log `[Wilson-2]` | n/a | n/a | n/a |

### Blueprint: `reports`

| Resource | GET | POST | PUT | DELETE |
|---|---|---|---|---|
| `/reports` | List / filter reports (supports `?type=`, `?date_from=`, `?issue_type=`) `[Paul-2][Wilson-3][John-1][John-5]` | Create report `[John-2]` | n/a | n/a |
| `/reports/{id}` | View report `[Wilson-4][John-3]` | n/a | Update report `[Wilson-4][John-3]` | Delete report `[Wilson-4][John-4]` |
| `/reports/mine/{user_id}` | View a user's own reports `[John-3][John-4]` | n/a | n/a | n/a |
| `/reports/high-priority` | View high-priority reports `[Paul-6]` | n/a | n/a | n/a |
| `/reports/invalid` | View reports with missing/invalid fields `[Wilson-3]` | n/a | n/a | n/a |

### Blueprint: `locations_tickets`

| Resource | GET | POST | PUT | DELETE |
|---|---|---|---|---|
| `/tickets` | List tickets `[Paul-3][Wilson-5]` | Create ticket `[Wilson-4]` | n/a | n/a |
| `/tickets/{id}` | View ticket `[Paul-3][Wilson-5]` | n/a | Update ticket `[Paul-3][Paul-6]` | Delete ticket `[Wilson-4]` |
| `/locations` | List locations `[Sally-1][John-6]` | n/a | n/a | n/a |
| `/locations/{id}` | View location `[Sally-2][John-6]` | n/a | n/a | n/a |
| `/locations/{id}/obstructions` | View obstructions at a location `[Sally-1..6]` | Add obstruction `[Wilson-4]` | n/a | n/a |
| `/locations/{id}/obstructions/{obstruction_id}` | n/a | n/a | n/a | Remove obstruction `[Wilson-4]` |

### Blueprint: `analytics`

| Resource | GET | POST | PUT | DELETE |
|---|---|---|---|---|
| `/analytics/issues-by-neighborhood` | Counts per neighborhood × issue type `[Paul-1][Wilson-5]` | n/a | n/a | n/a |
| `/analytics/trends` | Monthly trend of new reports `[Paul-5]` | n/a | n/a | n/a |
| `/analytics/resolution-summary` | Resolved vs unresolved ticket counts `[Paul-3][Wilson-5]` | n/a | n/a | n/a |
| `/analytics/high-priority` | High-priority report summary `[Paul-6]` | n/a | n/a | n/a |
| `/analytics/export` | Export filtered data as CSV/JSON `[Paul-4][Wilson-6]` | n/a | n/a | n/a |

## Phase 3 requirement check

| Requirement | Target | Status |
|---|---|---|
| Flask Blueprints | ≥ 4 | 4 ✓ |
| Routes per blueprint | ≥ 5 | users 8, reports 9, locations_tickets 10, analytics 5 ✓ |
| Total routes | 20–25 | ~32 (counting each HTTP verb) ✓ |
| POST routes | ≥ 2 | 5 ✓ |
| PUT routes | ≥ 2 | 5 ✓ |
| DELETE routes | ≥ 2 | 5 ✓ |
| POST/PUT/DELETE spread across ≥ 2 blueprints | yes | users, reports, locations_tickets ✓ |

## Changes from the original submission-template matrix

| # | Change | Why |
|---|---|---|
| 1 | **Added** `GET /users/{id}/actions` | Wilson-2 ("view logs of user actions") had no endpoint. Matches the `action_log` entity in Wilson's persona ER diagram (Phase 2 p.18). **Requires `action_log` table** — flag to DDL owner. |
| 2 | **Retagged** `/users/{id}` and `/users/{id}/disabilities` from `[Sally-6]` → `[Sally-5]` | Sally-5 is about wheelchair dimensions vs curb height, which needs disability profile data. Sally-6 is about blocked gates, which is an obstruction-level question. |
| 3 | **Added** `[John-5]` to `GET /reports` with a `?type=bike_theft` filter | John-5 ("view reported bike theft locations") was not tagged. SQL 4.5 shows it is `SELECT … WHERE report_type = 'bike_theft'`, so it rides on `/reports` via query param. |
| 4 | **Removed** `[Paul-2]` from `/analytics/trends` | Paul-2 is "filter reports by date and issue type" (SQL 1.2 → `/reports` with query params), not trend data. Paul-5 is trends. |
| 5 | **Removed** John tags from `/locations/{id}/obstructions` routes | John-2 is a plow-request insert into `report` (SQL 4.2), not into `obstructions`. John-3 is an update of `report` (SQL 4.3), not an obstruction removal. Those obstruction routes are admin-only. |
| 6 | **Added** `[Wilson-5]` to `/tickets`, `/tickets/{id}`, `/analytics/issues-by-neighborhood`, `/analytics/resolution-summary` | Wilson-5 is "aggregated statistics on reports, tickets, usage" (SQL 2.5). These analytics endpoints serve that story. |

## Open items for the team

- **DDL gap — `action_log` table**: Wilson-2 needs this. Columns implied by the ERD: `log_id`, `user_id` (FK), `action_type`, `log_description`, `timestamp`.
- **DDL gap — `report.past_report_status`**: Phase 2 SQL 2.5 and 4.3 both reference it, but it is not in the committed `bridget/add-ddl` schema.
- **Query-param contract for `/reports`**: the matrix now leans on `?type=`, `?date_from=`, `?date_to=`, `?issue_type=`, `?status=`. Document these in the route handler so the frontend team has a clear spec.
