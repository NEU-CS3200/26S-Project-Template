# HoopSpot

Streamlit (`app/src/`) + Flask (`api/backend/`) + MySQL 9 (`database-files/`), orchestrated via `docker-compose.yaml`. MySQL auto-runs `database-files/*.sql` only on **fresh** volumes — schema/seed edits require `docker compose down -v && docker compose up -d`.

## MySQL 9 gotchas

- **Reserved words as identifiers**: MySQL 9 rejects reserved words used as CTE names, table aliases, or columns without backticks. Avoid `generated`, `window`, `rank`, `system`, `lateral`, `role`, `groups`, `cume_dist` — use `gen`, `win_cte`, etc. instead. Full list: https://dev.mysql.com/doc/refman/9.0/en/keywords.html
- When writing a recursive CTE for seed data, sanity-check CTE names against the reserved list before committing.
