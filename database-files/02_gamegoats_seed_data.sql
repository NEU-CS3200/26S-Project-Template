USE gamegoats_db;

INSERT INTO roles (role_name)
VALUES ('player'), ('recommender'), ('developer'), ('admin');

INSERT INTO users (username, email, password_hash, region, created_at)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 40
)
SELECT
    CONCAT('gg_user_', LPAD(n, 2, '0')) AS username,
    CONCAT('gg_user_', LPAD(n, 2, '0'), '@gamegoats.dev') AS email,
    CONCAT('hash_', LPAD(n, 3, '0')) AS password_hash,
    ELT(((n - 1) % 6) + 1, 'NA-East', 'NA-West', 'EU-Central', 'EU-West', 'AP-South', 'LATAM') AS region,
    DATE_SUB(NOW(), INTERVAL (240 - n) DAY) AS created_at
FROM seq;

INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
JOIN roles r ON r.role_name = 'player'
WHERE u.user_id BETWEEN 1 AND 30;

INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
JOIN roles r ON r.role_name = 'recommender'
WHERE u.user_id BETWEEN 15 AND 30;

INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
JOIN roles r ON r.role_name = 'developer'
WHERE u.user_id BETWEEN 31 AND 38;

INSERT INTO user_roles (user_id, role_id)
SELECT u.user_id, r.role_id
FROM users u
JOIN roles r ON r.role_name = 'admin'
WHERE u.user_id BETWEEN 39 AND 40;

INSERT INTO studios (studio_name, headquarters_region, created_at)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 32
)
SELECT
    CONCAT(
        ELT(((n - 1) % 8) + 1, 'Pixel', 'Iron', 'Neon', 'Echo', 'Nova', 'Titan', 'Lunar', 'Drift'),
        ' Studio ',
        LPAD(n, 2, '0')
    ) AS studio_name,
    ELT(((n - 1) % 6) + 1, 'NA-East', 'NA-West', 'EU-Central', 'EU-West', 'AP-South', 'LATAM') AS headquarters_region,
    DATE_SUB(NOW(), INTERVAL (360 - n) DAY) AS created_at
FROM seq;

INSERT INTO developer_profiles (developer_id, dev_handle, portfolio_url, years_experience)
SELECT
    u.user_id AS developer_id,
    CONCAT('dev_', LPAD(u.user_id, 2, '0')) AS dev_handle,
    CONCAT('https://portfolio.gamegoats.dev/dev_', LPAD(u.user_id, 2, '0')) AS portfolio_url,
    1 + (u.user_id % 11) AS years_experience
FROM users u
WHERE u.user_id BETWEEN 31 AND 38;

INSERT INTO studio_memberships (studio_id, developer_id, is_owner, joined_on)
SELECT
    (developer_id - 30) AS studio_id,
    developer_id,
    TRUE AS is_owner,
    DATE_SUB(CURDATE(), INTERVAL (developer_id * 40) DAY) AS joined_on
FROM developer_profiles;

INSERT INTO studio_memberships (studio_id, developer_id, is_owner, joined_on)
SELECT
    (developer_id - 22) AS studio_id,
    developer_id,
    FALSE AS is_owner,
    DATE_SUB(CURDATE(), INTERVAL (developer_id * 20) DAY) AS joined_on
FROM developer_profiles;

INSERT INTO games (
    title,
    description,
    genre,
    platform,
    release_year,
    average_rating,
    lifecycle_status,
    published_by_studio_id,
    created_at,
    updated_at
)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 38
)
SELECT
    CONCAT(
        ELT(((n - 1) % 7) + 1, 'Crimson', 'Neon', 'Mystic', 'Solar', 'Frost', 'Echo', 'Titan'),
        ' ',
        ELT(((n - 1) % 5) + 1, 'Frontier', 'Chronicles', 'Assault', 'Odyssey', 'Legends'),
        ' ',
        LPAD(n, 2, '0')
    ) AS title,
    CONCAT(
        'Synthetic description for gameplay feature set ',
        LPAD(n, 2, '0'),
        '.'
    ) AS description,
    ELT(((n - 1) % 7) + 1, 'Shooter', 'RPG', 'Strategy', 'Simulation', 'Sports', 'Adventure', 'Puzzle') AS genre,
    ELT(((n - 1) % 5) + 1, 'PC', 'PlayStation', 'Xbox', 'Nintendo', 'Mobile') AS platform,
    2010 + (n % 15) AS release_year,
    ROUND(2.80 + ((n % 18) * 0.11), 2) AS average_rating,
    CASE
        WHEN n % 12 = 0 THEN 'sunset'
        WHEN n % 7 = 0 THEN 'maintenance'
        ELSE 'active'
    END AS lifecycle_status,
    ((n - 1) % 32) + 1 AS published_by_studio_id,
    DATE_SUB(NOW(), INTERVAL (420 - n) DAY) AS created_at,
    DATE_SUB(NOW(), INTERVAL (140 - n) DAY) AS updated_at
FROM seq;

INSERT INTO game_developers (game_id, developer_id, contribution_role)
SELECT
    seeded.game_id,
    seeded.developer_id,
    ELT(((seeded.rn - 1) % 5) + 1, 'Gameplay', 'Backend', 'UI', 'QA', 'Tools') AS contribution_role
FROM (
    SELECT
        g.game_id,
        d.developer_id,
        ROW_NUMBER() OVER (ORDER BY g.game_id, d.developer_id) AS rn
    FROM games g
    CROSS JOIN developer_profiles d
) AS seeded
WHERE seeded.rn <= 130;

INSERT INTO tags (tag_name)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 24
)
SELECT CONCAT('tag_', LPAD(n, 2, '0')) AS tag_name
FROM seq;

INSERT INTO game_tags (game_id, tag_id)
SELECT
    seeded.game_id,
    seeded.tag_id
FROM (
    SELECT
        g.game_id,
        t.tag_id,
        ROW_NUMBER() OVER (ORDER BY g.game_id, t.tag_id) AS rn
    FROM games g
    CROSS JOIN tags t
) AS seeded
WHERE seeded.rn <= 140;

INSERT INTO comments (game_id, created_by_user_id, comment_text, rating, created_at, updated_at)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 70
)
SELECT
    ((n - 1) % 38) + 1 AS game_id,
    ((n - 1) % 30) + 1 AS created_by_user_id,
    CONCAT(
        'Comment ', LPAD(n, 3, '0'), ': ',
        ELT(((n - 1) % 6) + 1,
            'Gameplay loop feels polished.',
            'Patch improved matchmaking quality.',
            'UI needs better inventory sorting.',
            'Performance was stable this session.',
            'Co-op mode had occasional desync.',
            'Difficulty curve feels balanced overall.'
        )
    ) AS comment_text,
    ((n - 1) % 5) + 1 AS rating,
    DATE_SUB(NOW(), INTERVAL (180 - n) HOUR) AS created_at,
    DATE_SUB(NOW(), INTERVAL (180 - n) HOUR) AS updated_at
FROM seq;

INSERT INTO forum_threads (game_id, title, thread_text, created_by_user_id, created_at, updated_at)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 60
)
SELECT
    ((n - 1) % 38) + 1 AS game_id,
    CONCAT('Thread ', LPAD(n, 3, '0'), ': ', ELT(((n - 1) % 4) + 1, 'Patch Notes', 'Build Ideas', 'Match Feedback', 'Meta Discussion')) AS title,
    CONCAT('Forum starter text for thread ', LPAD(n, 3, '0'), '.') AS thread_text,
    15 + ((n - 1) % 16) AS created_by_user_id,
    DATE_SUB(NOW(), INTERVAL (120 - n) HOUR) AS created_at,
    DATE_SUB(NOW(), INTERVAL (120 - n) HOUR) AS updated_at
FROM seq;

INSERT INTO forum_thread_contributions (forum_id, contributed_by_user_id, contribution_text, created_at)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 70
)
SELECT
    ((n - 1) % 60) + 1 AS forum_id,
    ((n + 3) % 30) + 1 AS contributed_by_user_id,
    CONCAT('Contribution ', LPAD(n, 3, '0'), ' in thread discussion.') AS contribution_text,
    DATE_SUB(NOW(), INTERVAL (90 - n) HOUR) AS created_at
FROM seq;

INSERT INTO user_follows (follower_user_id, followed_user_id, followed_at)
SELECT
    seeded.follower_user_id,
    seeded.followed_user_id,
    DATE_SUB(NOW(), INTERVAL seeded.rn DAY) AS followed_at
FROM (
    SELECT
        u1.user_id AS follower_user_id,
        u2.user_id AS followed_user_id,
        ROW_NUMBER() OVER (ORDER BY u1.user_id, u2.user_id) AS rn
    FROM users u1
    JOIN users u2 ON u1.user_id <> u2.user_id
    WHERE u1.user_id BETWEEN 1 AND 30
      AND u2.user_id BETWEEN 1 AND 30
) AS seeded
WHERE seeded.rn <= 130;

INSERT INTO favorites (player_user_id, game_id, priority, added_at)
SELECT
    seeded.player_user_id,
    seeded.game_id,
    1 + ((seeded.rn - 1) % 5) AS priority,
    DATE_SUB(NOW(), INTERVAL seeded.rn DAY) AS added_at
FROM (
    SELECT
        p.user_id AS player_user_id,
        g.game_id,
        ROW_NUMBER() OVER (ORDER BY p.user_id, g.game_id) AS rn
    FROM users p
    CROSS JOIN games g
    WHERE p.user_id BETWEEN 1 AND 30
) AS seeded
WHERE seeded.rn <= 150;

INSERT INTO recommendations (
    player_user_id,
    game_id,
    recommender_user_id,
    recommendation_reason,
    match_score,
    is_saved,
    recommendation_status,
    generated_at,
    refreshed_at
)
SELECT
    seeded.player_user_id,
    seeded.game_id,
    15 + ((seeded.rn - 1) % 16) AS recommender_user_id,
    ELT(((seeded.rn - 1) % 5) + 1,
        'Similar to your high-rated favorites.',
        'Popular among players you follow.',
        'Matches your preferred genre profile.',
        'Recommended from recent discussion threads.',
        'High retention among comparable players.'
    ) AS recommendation_reason,
    ROUND(55 + ((seeded.rn * 1.9) % 45), 2) AS match_score,
    CASE WHEN seeded.rn % 5 = 0 THEN TRUE ELSE FALSE END AS is_saved,
    CASE
        WHEN seeded.rn % 9 = 0 THEN 'dismissed'
        WHEN seeded.rn % 7 = 0 THEN 'accepted'
        WHEN seeded.rn % 13 = 0 THEN 'hidden'
        ELSE 'new'
    END AS recommendation_status,
    DATE_SUB(NOW(), INTERVAL (70 - seeded.rn) HOUR) AS generated_at,
    DATE_SUB(NOW(), INTERVAL (65 - seeded.rn) HOUR) AS refreshed_at
FROM (
    SELECT
        p.user_id AS player_user_id,
        g.game_id,
        ROW_NUMBER() OVER (ORDER BY p.user_id, g.game_id) AS rn
    FROM users p
    JOIN games g ON ((p.user_id + g.game_id) % 4 = 0)
    WHERE p.user_id BETWEEN 1 AND 30
) AS seeded
WHERE seeded.rn <= 65;

INSERT INTO servers (server_name, region, environment, status, capacity_percent, last_heartbeat, created_at)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 30
)
SELECT
    CASE
        WHEN n <= 24 THEN CONCAT('gg-prod-', LPAD(n, 2, '0'))
        ELSE CONCAT('gg-stage-', LPAD(n - 24, 2, '0'))
    END AS server_name,
    ELT(((n - 1) % 6) + 1, 'NA-East', 'NA-West', 'EU-Central', 'EU-West', 'AP-South', 'LATAM') AS region,
    CASE WHEN n <= 24 THEN 'production' ELSE 'staging' END AS environment,
    CASE
        WHEN n % 17 = 0 THEN 'down'
        WHEN n % 5 = 0 THEN 'degraded'
        ELSE 'healthy'
    END AS status,
    ROUND(35 + ((n * 7) % 61), 2) AS capacity_percent,
    DATE_SUB(NOW(), INTERVAL (n * 3) MINUTE) AS last_heartbeat,
    DATE_SUB(NOW(), INTERVAL (80 - n) DAY) AS created_at
FROM seq;

INSERT INTO alerts (
    server_id,
    alert_severity,
    alert_type,
    alert_message,
    alert_status,
    recorded_at,
    acknowledged_by_admin_id,
    acknowledged_at,
    resolved_at
)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 60
)
SELECT
    ((n - 1) % 30) + 1 AS server_id,
    CASE
        WHEN n % 11 = 0 THEN 'critical'
        WHEN n % 6 = 0 THEN 'high'
        WHEN n % 4 = 0 THEN 'medium'
        ELSE 'low'
    END AS alert_severity,
    ELT(((n - 1) % 5) + 1, 'latency', 'cpu', 'memory', 'disk', 'matchmaking') AS alert_type,
    ELT(((n - 1) % 5) + 1,
        'Latency exceeded threshold.',
        'CPU saturation above target.',
        'Memory pressure detected.',
        'Disk watermark exceeded.',
        'Matchmaking queue delay above SLA.'
    ) AS alert_message,
    CASE
        WHEN n % 9 = 0 THEN 'resolved'
        WHEN n % 4 = 0 THEN 'acknowledged'
        ELSE 'active'
    END AS alert_status,
    DATE_SUB(NOW(), INTERVAL (140 - n) HOUR) AS recorded_at,
    CASE
        WHEN n % 9 = 0 OR n % 4 = 0 THEN 39 + ((n - 1) % 2)
        ELSE NULL
    END AS acknowledged_by_admin_id,
    CASE
        WHEN n % 9 = 0 OR n % 4 = 0 THEN DATE_SUB(NOW(), INTERVAL (138 - n) HOUR)
        ELSE NULL
    END AS acknowledged_at,
    CASE
        WHEN n % 9 = 0 THEN DATE_SUB(NOW(), INTERVAL (136 - n) HOUR)
        ELSE NULL
    END AS resolved_at
FROM seq;

INSERT INTO reports (
    created_by_user_id,
    offender_user_id,
    offender_type,
    offender_reference_id,
    report_text,
    report_status,
    handled_by_admin_id,
    created_at,
    resolved_at,
    resolution_notes
)
WITH RECURSIVE seq AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM seq WHERE n < 55
)
SELECT
    ((n - 1) % 30) + 1 AS created_by_user_id,
    CASE
        WHEN (n % 7) IN (1, 2) THEN ((n + 5) % 30) + 1
        ELSE NULL
    END AS offender_user_id,
    ELT(((n - 1) % 7) + 1, 'user', 'game', 'comment', 'thread', 'server', 'studio', 'other') AS offender_type,
    CASE
        WHEN ((n - 1) % 7) + 1 = 1 THEN ((n + 5) % 30) + 1
        WHEN ((n - 1) % 7) + 1 = 2 THEN ((n - 1) % 38) + 1
        WHEN ((n - 1) % 7) + 1 = 3 THEN ((n - 1) % 70) + 1
        WHEN ((n - 1) % 7) + 1 = 4 THEN ((n - 1) % 60) + 1
        WHEN ((n - 1) % 7) + 1 = 5 THEN ((n - 1) % 30) + 1
        WHEN ((n - 1) % 7) + 1 = 6 THEN ((n - 1) % 32) + 1
        ELSE NULL
    END AS offender_reference_id,
    ELT(((n - 1) % 5) + 1,
        'Potential abuse detected in activity.',
        'Suspicious gameplay pattern reported.',
        'Spam content appears repeatedly.',
        'Harassment behavior reported by players.',
        'Policy concern requiring admin review.'
    ) AS report_text,
    CASE
        WHEN n % 8 = 0 THEN 'resolved'
        WHEN n % 10 = 0 THEN 'rejected'
        WHEN n % 3 = 0 THEN 'in_review'
        ELSE 'open'
    END AS report_status,
    CASE
        WHEN n % 8 = 0 OR n % 10 = 0 OR n % 3 = 0 THEN 39 + ((n - 1) % 2)
        ELSE NULL
    END AS handled_by_admin_id,
    DATE_SUB(NOW(), INTERVAL (75 - n) DAY) AS created_at,
    CASE
        WHEN n % 8 = 0 OR n % 10 = 0 THEN DATE_SUB(NOW(), INTERVAL (70 - n) DAY)
        ELSE NULL
    END AS resolved_at,
    CASE
        WHEN n % 8 = 0 THEN 'Action completed by admin.'
        WHEN n % 10 = 0 THEN 'Rejected after investigation.'
        ELSE NULL
    END AS resolution_notes
FROM seq;
