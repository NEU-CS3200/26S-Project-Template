-- =============================================================
-- NutriTracker — MySQL DDL
-- Run this file against a MySQL 8.0+ instance to initialize
-- the full NutriTracker relational schema.
-- =============================================================

CREATE DATABASE IF NOT EXISTS nutritracker
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE nutritracker;

-- =============================================================
-- ROLES
-- Stores permission profiles assigned to users.
-- permissions: JSON array of feature-level access strings.
-- =============================================================
CREATE TABLE roles (
  role_id      INT            NOT NULL AUTO_INCREMENT,
  role_name    VARCHAR(50)    NOT NULL,
  description  VARCHAR(255)       NULL,
  permissions  JSON               NULL,
  created_at   TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (role_id),
  UNIQUE KEY uq_roles_name (role_name)
) ENGINE=InnoDB;


-- =============================================================
-- DEMOGRAPHICS
-- Student profile metadata used for cohort-level analytics.
-- Kept separate from USERS to avoid bloating the identity table.
-- =============================================================
CREATE TABLE demographics (
  demographic_id  INT           NOT NULL AUTO_INCREMENT,
  student_type    VARCHAR(50)       NULL  COMMENT 'e.g. undergraduate, graduate, staff',
  major           VARCHAR(100)      NULL,
  college_year    VARCHAR(20)       NULL  COMMENT 'e.g. freshman, sophomore, junior, senior',
  athletic_team   VARCHAR(100)      NULL,
  dietary_label   VARCHAR(100)      NULL  COMMENT 'e.g. vegan, gluten-free, halal',

  PRIMARY KEY (demographic_id)
) ENGINE=InnoDB;


-- =============================================================
-- USERS
-- Core identity table. Links to a role and an optional
-- demographic profile.
-- =============================================================
CREATE TABLE users (
  user_id        INT            NOT NULL AUTO_INCREMENT,
  role_id        INT            NOT NULL,
  demographic_id INT                NULL,
  first_name     VARCHAR(100)   NOT NULL,
  last_name      VARCHAR(100)   NOT NULL,
  email          VARCHAR(255)   NOT NULL,
  password_hash  VARCHAR(255)   NOT NULL,
  is_active      BOOLEAN        NOT NULL DEFAULT TRUE,
  created_at     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_login     TIMESTAMP          NULL,

  PRIMARY KEY (user_id),
  UNIQUE KEY uq_users_email (email),
  CONSTRAINT fk_users_role
    FOREIGN KEY (role_id)       REFERENCES roles(role_id),
  CONSTRAINT fk_users_demographic
    FOREIGN KEY (demographic_id) REFERENCES demographics(demographic_id)
      ON DELETE SET NULL
) ENGINE=InnoDB;


-- =============================================================
-- DINING_HALLS
-- Campus dining locations with coordinates for proximity
-- filtering and JSON operating hours for scheduling flexibility.
-- =============================================================
CREATE TABLE dining_halls (
  hall_id          INT            NOT NULL AUTO_INCREMENT,
  name             VARCHAR(100)   NOT NULL,
  location         VARCHAR(255)       NULL  COMMENT 'Human-readable address or description',
  building_code    VARCHAR(20)        NULL,
  latitude         DECIMAL(9,6)       NULL,
  longitude        DECIMAL(9,6)       NULL,
  operating_hours  JSON               NULL  COMMENT 'Keyed by day-of-week with open/close times',
  is_active        BOOLEAN        NOT NULL DEFAULT TRUE,

  PRIMARY KEY (hall_id),
  UNIQUE KEY uq_dining_halls_name (name)
) ENGINE=InnoDB;


-- =============================================================
-- MENU_ITEMS
-- Individual food items served at a dining hall on a given date
-- and meal period. Soft-deleted via is_active.
-- =============================================================
CREATE TABLE menu_items (
  item_id         INT            NOT NULL AUTO_INCREMENT,
  hall_id         INT            NOT NULL,
  name            VARCHAR(150)   NOT NULL,
  description     TEXT               NULL,
  meal_period     ENUM('breakfast','lunch','dinner','all_day') NOT NULL DEFAULT 'all_day',
  available_date  DATE           NOT NULL,
  is_active       BOOLEAN        NOT NULL DEFAULT TRUE,

  PRIMARY KEY (item_id),
  CONSTRAINT fk_menu_items_hall
    FOREIGN KEY (hall_id) REFERENCES dining_halls(hall_id)
      ON DELETE CASCADE,
  INDEX idx_menu_items_hall_date (hall_id, available_date),
  INDEX idx_menu_items_period   (meal_period)
) ENGINE=InnoDB;


-- =============================================================
-- NUTRIENTS
-- Canonical nutrient reference table (calories, protein, etc.).
-- category groups nutrients for display (macros, vitamins, etc.)
-- =============================================================
CREATE TABLE nutrients (
  nutrient_id  INT           NOT NULL AUTO_INCREMENT,
  name         VARCHAR(100)  NOT NULL,
  unit         VARCHAR(20)   NOT NULL  COMMENT 'e.g. g, mg, kcal, IU',
  category     VARCHAR(50)       NULL  COMMENT 'e.g. macronutrient, vitamin, mineral',

  PRIMARY KEY (nutrient_id),
  UNIQUE KEY uq_nutrients_name (name)
) ENGINE=InnoDB;


-- =============================================================
-- MENU_ITEM_NUTRIENTS
-- Junction table: amount of each nutrient per serving of a
-- menu item.
-- =============================================================
CREATE TABLE menu_item_nutrients (
  id           INT            NOT NULL AUTO_INCREMENT,
  item_id      INT            NOT NULL,
  nutrient_id  INT            NOT NULL,
  amount       DECIMAL(10,3)  NOT NULL  COMMENT 'Amount per one serving',

  PRIMARY KEY (id),
  UNIQUE KEY uq_item_nutrient (item_id, nutrient_id),
  CONSTRAINT fk_min_item
    FOREIGN KEY (item_id)     REFERENCES menu_items(item_id)
      ON DELETE CASCADE,
  CONSTRAINT fk_min_nutrient
    FOREIGN KEY (nutrient_id) REFERENCES nutrients(nutrient_id)
) ENGINE=InnoDB;


-- =============================================================
-- MEAL_LOGS
-- Groups a user's eating session by date and meal period.
-- Individual items are stored in MEAL_LOG_ITEMS.
-- =============================================================
CREATE TABLE meal_logs (
  log_id       INT       NOT NULL AUTO_INCREMENT,
  user_id      INT       NOT NULL,
  log_date     DATE      NOT NULL,
  meal_period  ENUM('breakfast','lunch','dinner','snack') NOT NULL,
  logged_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (log_id),
  CONSTRAINT fk_meal_logs_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
      ON DELETE CASCADE,
  INDEX idx_meal_logs_user_date (user_id, log_date)
) ENGINE=InnoDB;


-- =============================================================
-- MEAL_LOG_ITEMS
-- Line items within a meal log. servings allows fractional or
-- multiple portions of the same menu item.
-- =============================================================
CREATE TABLE meal_log_items (
  log_item_id  INT            NOT NULL AUTO_INCREMENT,
  log_id       INT            NOT NULL,
  item_id      INT            NOT NULL,
  servings     DECIMAL(5,2)   NOT NULL DEFAULT 1.00,

  PRIMARY KEY (log_item_id),
  CONSTRAINT fk_mli_log
    FOREIGN KEY (log_id)  REFERENCES meal_logs(log_id)
      ON DELETE CASCADE,
  CONSTRAINT fk_mli_item
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id),
  INDEX idx_mli_log (log_id)
) ENGINE=InnoDB;


-- =============================================================
-- NUTRITION_GOALS
-- Per-user, per-nutrient dietary targets with optional date
-- range. min_value or max_value may be NULL for open-ended
-- bounds (e.g. "at least 150g protein" has no max).
-- period controls whether the goal is evaluated daily/weekly.
-- =============================================================
CREATE TABLE nutrition_goals (
  goal_id        INT            NOT NULL AUTO_INCREMENT,
  user_id        INT            NOT NULL,
  nutrient_id    INT            NOT NULL,
  min_value      DECIMAL(10,3)      NULL,
  max_value      DECIMAL(10,3)      NULL,
  effective_from DATE           NOT NULL,
  effective_to   DATE               NULL  COMMENT 'NULL means goal is ongoing',
  period         ENUM('daily','weekly') NOT NULL DEFAULT 'daily',

  PRIMARY KEY (goal_id),
  CONSTRAINT chk_goals_period CHECK (period IN ('daily', 'weekly')),
    FOREIGN KEY (user_id)     REFERENCES users(user_id)
      ON DELETE CASCADE,
  CONSTRAINT fk_goals_nutrient
    FOREIGN KEY (nutrient_id) REFERENCES nutrients(nutrient_id),
  INDEX idx_goals_user_nutrient (user_id, nutrient_id)
) ENGINE=InnoDB;


-- =============================================================
-- ALERTS
-- System-generated notifications when a user's logged intake
-- violates a nutrition goal. is_read supports inbox-style UX.
-- =============================================================
CREATE TABLE alerts (
  alert_id      INT           NOT NULL AUTO_INCREMENT,
  user_id       INT           NOT NULL,
  goal_id       INT               NULL  COMMENT 'NULL if alert is not goal-related',
  alert_type    VARCHAR(50)   NOT NULL  COMMENT 'e.g. exceeded_max, below_min, system',
  message       TEXT          NOT NULL,
  is_read       BOOLEAN       NOT NULL DEFAULT FALSE,
  triggered_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (alert_id),
  CONSTRAINT fk_alerts_user
    FOREIGN KEY (user_id)  REFERENCES users(user_id)
      ON DELETE CASCADE,
  CONSTRAINT fk_alerts_goal
    FOREIGN KEY (goal_id)  REFERENCES nutrition_goals(goal_id)
      ON DELETE SET NULL,
  INDEX idx_alerts_user_read (user_id, is_read)
) ENGINE=InnoDB;


-- =============================================================
-- SAVED_MEALS
-- User-created meal templates. Users can save favorite meal
-- combinations for quick retrieval and tracking.
-- =============================================================
CREATE TABLE saved_meals (
  saved_meal_id  INT           NOT NULL AUTO_INCREMENT,
  user_id        INT           NOT NULL,
  name           VARCHAR(150)  NOT NULL,
  description    TEXT              NULL,
  created_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at     TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

  PRIMARY KEY (saved_meal_id),
  UNIQUE KEY uq_saved_meals_user_name (user_id, name),
  CONSTRAINT fk_saved_meals_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
      ON DELETE CASCADE,
  INDEX idx_saved_meals_user (user_id)
) ENGINE=InnoDB;


-- =============================================================
-- SAVED_MEAL_ITEMS
-- Line items within a saved meal. Links saved meals to menu
-- items with optional serving size override.
-- =============================================================
CREATE TABLE saved_meal_items (
  saved_item_id  INT           NOT NULL AUTO_INCREMENT,
  saved_meal_id  INT           NOT NULL,
  item_id        INT           NOT NULL,
  servings       DECIMAL(5,2)  NOT NULL DEFAULT 1.00,

  PRIMARY KEY (saved_item_id),
  CONSTRAINT fk_smi_saved_meal
    FOREIGN KEY (saved_meal_id) REFERENCES saved_meals(saved_meal_id)
      ON DELETE CASCADE,
  CONSTRAINT fk_smi_item
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id),
  INDEX idx_smi_saved_meal (saved_meal_id)
) ENGINE=InnoDB;


-- =============================================================
-- AUDIT_LOGS
-- Immutable change log for every data mutation in the system.
-- old_values / new_values store row snapshots as JSON.
-- No FK on user_id so records survive account deletion.
-- =============================================================
CREATE TABLE audit_logs (
  audit_id      BIGINT        NOT NULL AUTO_INCREMENT,
  user_id       INT               NULL  COMMENT 'NULL for system-initiated changes',
  table_name    VARCHAR(100)  NOT NULL,
  action        ENUM('INSERT','UPDATE','DELETE') NOT NULL,
  old_values    JSON              NULL,
  new_values    JSON              NULL,
  performed_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  ip_address    VARCHAR(45)       NULL  COMMENT 'Supports IPv4 and IPv6',

  PRIMARY KEY (audit_id),
  INDEX idx_audit_table    (table_name),
  INDEX idx_audit_user     (user_id),
  INDEX idx_audit_time     (performed_at)
) ENGINE=InnoDB;


-- =============================================================
-- REPORTS
-- Stores metadata for generated analytics reports.
-- filter_params captures the query configuration so reports
-- can be reproduced. file_path points to the exported artifact.
-- =============================================================
CREATE TABLE reports (
  report_id      INT           NOT NULL AUTO_INCREMENT,
  created_by     INT               NULL  COMMENT 'FK to users; NULL if system-generated',
  title          VARCHAR(255)  NOT NULL,
  report_type    VARCHAR(100)  NOT NULL  COMMENT 'e.g. nutrition_summary, trend_analysis',
  filter_params  JSON              NULL,
  status         ENUM('pending','processing','complete','failed') NOT NULL DEFAULT 'pending',
  generated_at   TIMESTAMP         NULL,
  file_path      VARCHAR(500)      NULL,

  PRIMARY KEY (report_id),
  CONSTRAINT fk_reports_user
    FOREIGN KEY (created_by) REFERENCES users(user_id)
      ON DELETE SET NULL,
  INDEX idx_reports_user   (created_by),
  INDEX idx_reports_status (status)
) ENGINE=InnoDB;


-- =============================================================
-- EXPORT_CONFIGS
-- Saved export configurations for analysts and admins.
-- is_scheduled + cron_expression enable recurring auto-exports.
-- field_selections and filter_params stored as JSON for
-- flexibility without schema changes.
-- =============================================================
CREATE TABLE export_configs (
  config_id        INT            NOT NULL AUTO_INCREMENT,
  user_id          INT            NOT NULL,
  name             VARCHAR(150)   NOT NULL,
  format           ENUM('csv','xlsx','json','pdf') NOT NULL DEFAULT 'csv',
  field_selections JSON               NULL,
  filter_params    JSON               NULL,
  is_scheduled     BOOLEAN        NOT NULL DEFAULT FALSE,
  cron_expression  VARCHAR(100)       NULL  COMMENT 'Standard cron syntax; NULL if not scheduled',

  PRIMARY KEY (config_id),
  CONSTRAINT fk_export_configs_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
      ON DELETE CASCADE,
  INDEX idx_export_configs_user (user_id)
) ENGINE=InnoDB;


-- =============================================================
-- SYSTEM_METRICS
-- General-purpose timeseries table for platform health data
-- (latency, error rates, active sessions, etc.).
-- metadata stores additional context as JSON.
-- =============================================================
CREATE TABLE system_metrics (
  metric_id    BIGINT        NOT NULL AUTO_INCREMENT,
  metric_type  VARCHAR(100)  NOT NULL  COMMENT 'e.g. response_time_ms, error_rate, active_users',
  value        DECIMAL(18,4) NOT NULL,
  unit         VARCHAR(50)       NULL  COMMENT 'e.g. ms, percent, count',
  recorded_at  TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  metadata     JSON              NULL,

  PRIMARY KEY (metric_id),
  INDEX idx_system_metrics_type (metric_type),
  INDEX idx_system_metrics_time (recorded_at)
) ENGINE=InnoDB;


-- =============================================================
-- SEED: Default roles
-- =============================================================
INSERT INTO roles (role_name, description, permissions) VALUES
  ('student',       'General student user',                   '["meal_log","dining_browser","goal_tracker"]'),
  ('athlete',       'Student-athlete with strict diet needs', '["meal_log","dining_browser","goal_tracker","alerts"]'),
  ('analyst',       'Nutritional data analyst',               '["analytics_dashboard","export","reports"]'),
  ('administrator', 'System administrator',                   '["user_management","audit_logs","system_metrics","export","reports","data_push"]');


-- =============================================================
-- SEED: Core nutrients
-- =============================================================
INSERT INTO nutrients (name, unit, category) VALUES
  ('Calories',          'kcal', 'macronutrient'),
  ('Total Fat',         'g',    'macronutrient'),
  ('Saturated Fat',     'g',    'macronutrient'),
  ('Trans Fat',         'g',    'macronutrient'),
  ('Cholesterol',       'mg',   'macronutrient'),
  ('Sodium',            'mg',   'mineral'),
  ('Total Carbohydrate','g',    'macronutrient'),
  ('Dietary Fiber',     'g',    'macronutrient'),
  ('Total Sugars',      'g',    'macronutrient'),
  ('Protein',           'g',    'macronutrient'),
  ('Vitamin D',         'mcg',  'vitamin'),
  ('Calcium',           'mg',   'mineral'),
  ('Iron',              'mg',   'mineral'),
  ('Potassium',         'mg',   'mineral'),
  ('Vitamin A',         'mcg',  'vitamin'),
  ('Vitamin C',         'mg',   'vitamin'),
  ('Vitamin B12',       'mcg',  'vitamin'),
  ('Magnesium',         'mg',   'mineral'),
  ('Zinc',              'mg',   'mineral');
