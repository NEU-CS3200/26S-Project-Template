DROP DATABASE IF EXISTS gamegoats_db;
CREATE DATABASE IF NOT EXISTS gamegoats_db;
USE gamegoats_db;

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(64) NOT NULL UNIQUE,
    email VARCHAR(120) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    region VARCHAR(32) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS roles (
    role_id TINYINT AUTO_INCREMENT PRIMARY KEY,
    role_name ENUM('player', 'recommender', 'developer', 'admin') NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS user_roles (
    user_id INT NOT NULL,
    role_id TINYINT NOT NULL,
    assigned_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role_id),
    CONSTRAINT fk_user_roles_user FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_roles_role FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS studios (
    studio_id INT AUTO_INCREMENT PRIMARY KEY,
    studio_name VARCHAR(120) NOT NULL UNIQUE,
    headquarters_region VARCHAR(32) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS developer_profiles (
    developer_id INT PRIMARY KEY,
    dev_handle VARCHAR(64) NOT NULL UNIQUE,
    portfolio_url VARCHAR(255) NULL,
    years_experience TINYINT NOT NULL DEFAULT 0,
    CONSTRAINT fk_developer_profiles_user FOREIGN KEY (developer_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS studio_memberships (
    studio_id INT NOT NULL,
    developer_id INT NOT NULL,
    is_owner BOOLEAN NOT NULL DEFAULT FALSE,
    joined_on DATE NOT NULL,
    PRIMARY KEY (studio_id, developer_id),
    CONSTRAINT fk_studio_memberships_studio FOREIGN KEY (studio_id) REFERENCES studios(studio_id) ON DELETE CASCADE,
    CONSTRAINT fk_studio_memberships_dev FOREIGN KEY (developer_id) REFERENCES developer_profiles(developer_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS games (
    game_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    description VARCHAR(500) NOT NULL,
    genre VARCHAR(48) NOT NULL,
    platform ENUM('PC', 'PlayStation', 'Xbox', 'Nintendo', 'Mobile') NOT NULL,
    release_year SMALLINT NOT NULL,
    average_rating DECIMAL(3, 2) NOT NULL DEFAULT 0.00,
    lifecycle_status ENUM('active', 'maintenance', 'sunset') NOT NULL DEFAULT 'active',
    published_by_studio_id INT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY uq_game_title_platform (title, platform),
    CONSTRAINT fk_games_publisher_studio FOREIGN KEY (published_by_studio_id) REFERENCES studios(studio_id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS game_developers (
    game_id INT NOT NULL,
    developer_id INT NOT NULL,
    contribution_role VARCHAR(64) NOT NULL,
    PRIMARY KEY (game_id, developer_id),
    CONSTRAINT fk_game_developers_game FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    CONSTRAINT fk_game_developers_dev FOREIGN KEY (developer_id) REFERENCES developer_profiles(developer_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    tag_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS game_tags (
    game_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (game_id, tag_id),
    CONSTRAINT fk_game_tags_game FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    CONSTRAINT fk_game_tags_tag FOREIGN KEY (tag_id) REFERENCES tags(tag_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    created_by_user_id INT NOT NULL,
    comment_text VARCHAR(500) NOT NULL,
    rating TINYINT NOT NULL DEFAULT 3,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_game FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user FOREIGN KEY (created_by_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_comments_game (game_id),
    INDEX idx_comments_user (created_by_user_id)
);

CREATE TABLE IF NOT EXISTS forum_threads (
    forum_id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    title VARCHAR(180) NOT NULL,
    thread_text VARCHAR(1000) NOT NULL,
    created_by_user_id INT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_forum_threads_game FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    CONSTRAINT fk_forum_threads_user FOREIGN KEY (created_by_user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS forum_thread_contributions (
    contribution_id INT AUTO_INCREMENT PRIMARY KEY,
    forum_id INT NOT NULL,
    contributed_by_user_id INT NOT NULL,
    contribution_text VARCHAR(500) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_forum_contrib_thread FOREIGN KEY (forum_id) REFERENCES forum_threads(forum_id) ON DELETE CASCADE,
    CONSTRAINT fk_forum_contrib_user FOREIGN KEY (contributed_by_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_forum_contrib_thread (forum_id),
    INDEX idx_forum_contrib_user (contributed_by_user_id)
);

CREATE TABLE IF NOT EXISTS user_follows (
    follower_user_id INT NOT NULL,
    followed_user_id INT NOT NULL,
    followed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_user_id, followed_user_id),
    CONSTRAINT fk_user_follows_follower FOREIGN KEY (follower_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_user_follows_followed FOREIGN KEY (followed_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_user_follows_self CHECK (follower_user_id <> followed_user_id)
);

CREATE TABLE IF NOT EXISTS favorites (
    favorite_id INT AUTO_INCREMENT PRIMARY KEY,
    player_user_id INT NOT NULL,
    game_id INT NOT NULL,
    priority TINYINT NOT NULL DEFAULT 3,
    added_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_favorites_player FOREIGN KEY (player_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_favorites_game FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    UNIQUE KEY uq_favorites_player_game (player_user_id, game_id),
    INDEX idx_favorites_game (game_id)
);

CREATE TABLE IF NOT EXISTS recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    player_user_id INT NOT NULL,
    game_id INT NOT NULL,
    recommender_user_id INT NULL,
    recommendation_reason VARCHAR(255) NOT NULL,
    match_score DECIMAL(5, 2) NOT NULL,
    is_saved BOOLEAN NOT NULL DEFAULT FALSE,
    recommendation_status ENUM('new', 'accepted', 'dismissed', 'hidden') NOT NULL DEFAULT 'new',
    generated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    refreshed_at TIMESTAMP NULL,
    CONSTRAINT fk_recommendations_player FOREIGN KEY (player_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_recommendations_game FOREIGN KEY (game_id) REFERENCES games(game_id) ON DELETE CASCADE,
    CONSTRAINT fk_recommendations_recommender FOREIGN KEY (recommender_user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    UNIQUE KEY uq_recommendation_player_game (player_user_id, game_id)
);

CREATE TABLE IF NOT EXISTS servers (
    server_id INT AUTO_INCREMENT PRIMARY KEY,
    server_name VARCHAR(64) NOT NULL UNIQUE,
    region VARCHAR(32) NOT NULL,
    environment ENUM('production', 'staging') NOT NULL DEFAULT 'production',
    status ENUM('healthy', 'degraded', 'down') NOT NULL DEFAULT 'healthy',
    capacity_percent DECIMAL(5, 2) NOT NULL DEFAULT 0.00,
    last_heartbeat TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS alerts (
    alert_id INT AUTO_INCREMENT PRIMARY KEY,
    server_id INT NOT NULL,
    alert_severity ENUM('low', 'medium', 'high', 'critical') NOT NULL,
    alert_type VARCHAR(80) NOT NULL,
    alert_message VARCHAR(255) NOT NULL,
    alert_status ENUM('active', 'acknowledged', 'resolved') NOT NULL DEFAULT 'active',
    recorded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    acknowledged_by_admin_id INT NULL,
    acknowledged_at TIMESTAMP NULL,
    resolved_at TIMESTAMP NULL,
    CONSTRAINT fk_alerts_server FOREIGN KEY (server_id) REFERENCES servers(server_id) ON DELETE CASCADE,
    CONSTRAINT fk_alerts_ack_admin FOREIGN KEY (acknowledged_by_admin_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_alerts_status (alert_status),
    INDEX idx_alerts_server (server_id)
);

CREATE TABLE IF NOT EXISTS reports (
    report_id INT AUTO_INCREMENT PRIMARY KEY,
    created_by_user_id INT NOT NULL,
    offender_user_id INT NULL,
    offender_type ENUM('user', 'game', 'comment', 'thread', 'server', 'studio', 'other') NOT NULL,
    offender_reference_id INT NULL,
    report_text VARCHAR(500) NOT NULL,
    report_status ENUM('open', 'in_review', 'resolved', 'rejected') NOT NULL DEFAULT 'open',
    handled_by_admin_id INT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    resolution_notes VARCHAR(255) NULL,
    CONSTRAINT fk_reports_creator FOREIGN KEY (created_by_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_reports_offender_user FOREIGN KEY (offender_user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    CONSTRAINT fk_reports_admin FOREIGN KEY (handled_by_admin_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_reports_status (report_status),
    INDEX idx_reports_offender_type (offender_type)
);
