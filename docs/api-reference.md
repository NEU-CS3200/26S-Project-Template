# Bostonability REST API Reference

Endpoint-level reference for the Flask API. All routes return JSON unless noted. Base URL in development: `http://localhost:4000`.

Persona tags in brackets (e.g. `[Wilson-1]`) trace each route back to a user story from Phase 2. Full route-to-user-story matrix lives in [`rest-api-matrix.md`](rest-api-matrix.md).

---

## `users` blueprint — `/users`

### `GET /users`
List all users. `[Wilson-1]`
- Query params: `?role_id=`, `?email=`
- Response: `[{user_id, first_name, last_name, user_email, phone_number, preferred_language, demographics_age, demographics_gender, demographics_ethinicity}, ...]`

### `POST /users`
Create a user. `[Wilson-1]`
- Body (required): `first_name`, `last_name`, `user_email`
- Body (optional): `phone_number`, `preferred_language`, `demographics_age`, `demographics_gender`, `demographics_ethinicity`
- Response: `{"message": "User created", "user_id": 123}` (201)

### `GET /users/{id}`
View user with embedded roles + disabilities. `[Wilson-1][Sally-5]`
- Response: user object plus `roles: [...]` and `disabilities: [...]`

### `PUT /users/{id}`
Update any subset of fields. `[Wilson-1][Sally-5]`
- Body: any of the creatable fields

### `DELETE /users/{id}`
`[Wilson-1]`

### `GET /users/{id}/roles`
List a user's roles. `[Wilson-1]`

### `PUT /users/{id}/roles`
Replace the user's full role set. `[Wilson-1]`
- Body: `{"role_ids": [1, 2, 3]}`

### `GET /users/{id}/disabilities`
`[Sally-5]`

### `POST /users/{id}/disabilities`
Add one disability. `[Sally-5]`
- Body: `{"disability_id": 1}`

### `PUT /users/{id}/disabilities`
Replace the full disability set. `[Sally-5]`
- Body: `{"disability_ids": [1, 2]}`

### `DELETE /users/{id}/disabilities/{disability_id}`
Remove a single disability. `[Sally-5]`

### `GET /users/{id}/actions`
View a user's action log. `[Wilson-2]`
- Query params: `?limit=` (default 50)
- **Depends on `action_log` table** (not yet in DDL).

---

## `reports` blueprint — `/reports`

### `GET /reports`
List and filter reports. `[Paul-2][Wilson-3][John-1][John-5]`
- Query params: `?type=`, `?status=`, `?date_from=`, `?date_to=`, `?issue_type=`, `?urgency=`
- Response includes joined location + issue_type data.

### `POST /reports`
Create a report. If `issue_type_id` is in the body, also creates a matching `accessibility_report` row. `[John-2]`
- Body (required): `report_date`, `report_type`, `report_status`, `user_id`
- Body (optional): `urgency`, `description`, `location_id`, `issue_type_id`, `photo_url`
- Response: `{"message": "Report created", "report_id": 45}` (201)

### `GET /reports/{id}`
View one report with location, user, issue type, and linked tickets. `[Wilson-4][John-3]`

### `PUT /reports/{id}`
Update any subset of fields. `[Wilson-4][John-3]`
- Body: any of `report_date, report_type, report_status, urgency, description, location_id`

### `DELETE /reports/{id}`
`[Wilson-4][John-4]`

### `GET /reports/mine/{user_id}`
A user's own reports, most recent first. `[John-3][John-4]`

### `GET /reports/high-priority`
Reports whose ticket is flagged `high_priority`. `[Paul-6]`

### `GET /reports/invalid`
Reports with missing required fields (description, type, status, or location). `[Wilson-3]`

---

## `locations_tickets` blueprint

Spans two resource roots; no URL prefix.

### Tickets — `/tickets`

| Method | Path | User stories |
|---|---|---|
| GET | `/tickets` | `[Paul-3][Wilson-5]` — filters: `?status=`, `?user_id=` |
| POST | `/tickets` | `[Wilson-4]` — body: `ticket_status`, `ticket_date` (required); `ticket_time`, `report_id`, `issue_type_id` (optional) |
| GET | `/tickets/{id}` | `[Paul-3][Wilson-5]` — includes joined issue_type + report + location |
| PUT | `/tickets/{id}` | `[Paul-3][Paul-6]` — any of `ticket_status, ticket_date, ticket_time, report_id, issue_type_id` |
| DELETE | `/tickets/{id}` | `[Wilson-4]` |

### Locations — `/locations`

| Method | Path | User stories |
|---|---|---|
| GET | `/locations` | `[Sally-1][John-6]` — filters: `?neighborhood=`, `?zip_code=`, `?street_name_like=` |
| GET | `/locations/{id}` | `[Sally-2][John-6]` — includes `obstructions: [...]` |

### Obstructions at a location

| Method | Path | User stories |
|---|---|---|
| GET | `/locations/{id}/obstructions` | `[Sally-1..6]` — filter: `?name=` (exact match) |
| POST | `/locations/{id}/obstructions` | `[Wilson-4]` — body: `{"obstruction_id": 5}` |
| DELETE | `/locations/{id}/obstructions/{obstruction_id}` | `[Wilson-4]` |

---

## `analytics` blueprint — `/analytics`

All read-only (GET).

### `GET /analytics/issues-by-neighborhood`
Counts per neighborhood × issue type. `[Paul-1][Wilson-5]`
- Response: `[{neighborhood_name, issue_type_name, report_count}, ...]`

### `GET /analytics/trends`
Monthly trend of new reports per issue type. `[Paul-5]`
- Query params: `?from=YYYY-MM-DD`, `?to=YYYY-MM-DD`
- Response: `[{report_month: "2026-01", issue_type_name, new_reports}, ...]`

### `GET /analytics/resolution-summary`
Resolved vs unresolved ticket counts. `[Paul-3][Wilson-5]`
- Query params: `?groupby=neighborhood|issue_type` (optional — default is overall counts per status)

### `GET /analytics/high-priority`
High-priority reports summary for policy dashboards. `[Paul-6]`
- Response: counts grouped by neighborhood × issue type.

### `GET /analytics/export`
Export aggregated report+ticket data. `[Paul-4][Wilson-6]`
- Query params: `?format=csv|json` (default csv), `?from=`, `?to=`
- Response: file download (`Content-Disposition: attachment`)

---

## Error shape

All routes return one of these:

| Status | Shape |
|---|---|
| 4xx | `{"error": "<human-readable message>"}` |
| 5xx | `{"error": "<SQL or server error string>"}` |

## Quick curl examples

```bash
# List all users
curl http://localhost:4000/users

# Create a report
curl -X POST http://localhost:4000/reports \
  -H 'Content-Type: application/json' \
  -d '{"report_date":"2026-04-18","report_type":"accessibility","report_status":"open","user_id":3,"description":"Large pothole on Tremont","location_id":1,"issue_type_id":1,"urgency":"High"}'

# Filter reports
curl "http://localhost:4000/reports?type=bike_theft&status=open"

# Export analytics as CSV
curl -O -J "http://localhost:4000/analytics/export?format=csv&from=2026-01-01"
```
