# Database Files

The SQL files in this folder execute automatically when the `db` container is created.

## Execution Order

1. `01_gamegoats_bootstrap.sql`
   - creates `gamegoats_db`
   - creates schema for:
     - identity/roles: `users`, `roles`, `user_roles`
     - developer/studio domain: `developer_profiles`, `studios`, `studio_memberships`
     - game domain: `games`, `game_developers`, `tags`, `game_tags`
     - social/content: `comments`, `forum_threads`, `forum_thread_contributions`, `user_follows`
     - recommendation/review: `favorites`, `recommendations`, `reports`
     - operations: `servers`, `alerts`
2. `02_gamegoats_seed_data.sql`
   - inserts synthetic data for all tables

## Expected Seed Volumes

- Strong entities:
  - `users`: 40
  - `studios`: 32
  - `games`: 38
  - `servers`: 30
  - `tags`: 24
- Weak entities:
  - `comments`: 70
  - `forum_threads`: 60
  - `forum_thread_contributions`: 70
  - `recommendations`: 65
  - `reports`: 55
  - `alerts`: 60
- Bridge/entity-resolution tables:
  - `game_developers`: 130
  - `game_tags`: 140
  - `user_follows`: 130
  - `favorites`: 150

## Role Model

There is no separate moderator role in this version.
Administrative workflows use the `admin` role through `roles` + `user_roles`.

## Recreate Database Container

Use this after changing schema or seed data:

```bash
docker compose down db -v
docker compose up -d db
```

## Manual CRUD Validation (Phase 2)

Example transaction-based checks (safe, rolls back at the end):

```bash
docker compose exec db mysql -uroot -p<MYSQL_ROOT_PASSWORD> -D gamegoats_db -e "
START TRANSACTION;
INSERT INTO games (title, description, genre, platform, release_year, average_rating, lifecycle_status, published_by_studio_id)
VALUES ('ER Validation Arena', 'Temporary validation row', 'Strategy', 'PC', 2026, 4.20, 'active', 1);
UPDATE reports
SET report_status='in_review', handled_by_admin_id=39, resolution_notes='Validation update'
WHERE report_id=1;
DELETE FROM favorites WHERE favorite_id=1;
ROLLBACK;
"
```
