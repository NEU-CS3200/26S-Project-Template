<div align="center">

<h1>NutriTracker</h1>

**Assisting Northeastern's diet, one step at a time.**

Track your dietary needs on campus!

<br />

[![Streamlit](https://img.shields.io/badge/Frontend-Streamlit-FF4B4B?style=for-the-badge)](http://localhost:8501)
[![Flask](https://img.shields.io/badge/API-Flask-000000?style=for-the-badge)](http://localhost:4000)
[![MySQL](https://img.shields.io/badge/Database-MySQL%209-4479A1?style=for-the-badge)](http://localhost:3200)

</div>

---

## The Problem

Starting a diet is difficult, especially with the poorly designed system DineOnCampus provides. Missing items on menus, inaccurate data, and overall student business makes it hard to stay healthy.

**NutriTracker fixes that.**

NutriTracker stores data on food and tracks your daily intake with minimalistic design. Visualize your diet and needs instantly with our program!

---

## Team AJJR

| Name | Persona |
|---|---|
| **Andrew Dickerson** | Jordan Carter (Performer) |
| **Jasmine O'Brien** | Jason Batum (Student-Athlete) |
| **Joshua Barrera** | Laura Smith (System Admin) |
| **Ryan Sinha** | Immanuel Hoffborne (Data Analyst) |

---

## Features

### For Students & Performers (Jordan): *Andrew Dickerson*
- Find dining halls based on location and current wait times
- Browse menu items with nutritional filters (meal period, dietary labels)
- Save 'go-to' meals for quick access between performances

### For Athletes (Jason): *Jasmine O'Brien*
[WRITE: 3-4 bullet points — Jasmine's features]

### For Data Analysts (Immanuel): *Ryan Sinha*
- Filter and visualize nutritional information by dining hall, type of student, and date range.
- Compare average intake between students and student athletes
- Create, update, and delete data export configurations
- Detect outliers for student diets
- Generate and queue summary reports
  
### For System Admins (Laura): *Joshua Barrera*
[WRITE: 3-4 bullet points — Joshua's features]

---

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | Streamlit (Python) |
| API | Flask (Python) |
| Database | MySQL 9 |
| Containerization | Docker Compose |

---

## Getting Started

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running

### Setup

1. **Clone the repo**
   ```bash
   git clone https://github.com/dickersonal-nu/26S-NutriTracker.git
   cd 26S-NutriTracker
   ```

2. **Create the `.env` file** in the `api/` folder:
   ```bash
   cat > api/.env << 'EOF'
   SECRET_KEY=your-secret-key-here
   DB_USER=root
   DB_HOST=db
   DB_PORT=3306
   DB_NAME=nutritracker
   MYSQL_ROOT_PASSWORD=your-password-here
   EOF
   ```
   Replace `your-secret-key-here` and `your-password-here` with any values you choose.

3. **Start all containers**
   ```bash
   docker compose up -d
   ```

4. **Open the app**
   - Streamlit UI: [http://localhost:8501](http://localhost:8501)
   - Flask API: [http://localhost:4000](http://localhost:4000)

5. **Log in** by selecting a persona from the home page

### Rebuilding the Database

If you change any SQL files, recreate the database container:
```bash
docker compose down db -v
docker compose up db -d
```

---

## Project Structure

```
26S-NutriTracker/
├── api/
│   ├── backend/
│   │   ├── analytics/          # Immanuel's routes — filter, trends, compare, outliers, reports, exports
│   │   ├── nutrition/          # Shared nutrition routes:
│   │   │                        #  - (Jasmine/Jason): daily, logs, goals, alerts
│   │   │                        #  - (Andrew/Jordan): dining-halls, menu-browse, wait-times, saved-meals
│   │   ├── db_connection/      # MySQL connection helper
│   │   └── rest_entry.py       # Flask app factory + blueprint registration
│   ├── .env                    # Database credentials (not committed)
│   └── Dockerfile
├── app/
│   └── src/
│       ├── Home.py             # Landing page with persona selection
│       ├── pages/              # Streamlit pages organized by persona:
│       │                        #  - 10-13: Performer (Andrew/Jordan)
│       │                        #  - 20-23: Athlete (Jasmine/Jason)
│       │                        #  - 30-33: Analyst (Ryan/Immanuel)
│       │                        #  - 40+: Admin (Joshua/Laura)
│       └── modules/nav.py      # Sidebar navigation (role-based)
├── database-files/
│   ├── 01_nutritracker_ddl.sql             # Schema (includes saved_meals tables)
│   ├── 02_nutritracker_data.sql            # Seed data (menu items, saved meals, nutrition data)
│   └── 03_nutritracker_mock_analytics.sql  # Mock data for reports, exports, system metrics, audit logs
└── docker-compose.yaml
```

---

## Demo Video

[PASTE VIDEO LINK HERE — must be publicly accessible, no permission required]

---

<div align="center">

Created by Ryan Sinha, Joshua Barrera, Jasmine O'Brien, and Andrew Dickerson for CS3200 Spring '26

</div>
