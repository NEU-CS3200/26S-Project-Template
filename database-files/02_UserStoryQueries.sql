USE HoopSpot;

-- =========================================================
-- Persona 1: Pickup Player
-- =========================================================

-- Story 1:
-- View courts with current player counts.
SELECT c.CourtId,
       c.CourtName,
       c.Address,
       n.NeighborhoodName,
       c.Latitude,
       c.Longitude,
       COUNT(ci.CheckInId) AS ActivePlayerCount
FROM Court c
         JOIN Neighborhood n
              ON n.NeighborhoodId = c.NeighborhoodId
         LEFT JOIN CheckIn ci
                   ON ci.CourtId = c.CourtId
                       AND ci.CheckOutTime IS NULL
WHERE c.IsActive = TRUE
  AND c.IsOpen = TRUE
GROUP BY c.CourtId,
         c.CourtName,
         c.Address,
         n.NeighborhoodName,
         c.Latitude,
         c.Longitude
ORDER BY ActivePlayerCount DESC;

-- Story 2:
-- Check in at a court.
INSERT INTO CheckIn (CheckInId, CheckInTime, CheckOutTime, PlayerId, CourtId)
VALUES (1001, '2026-04-06 18:10:00', NULL, 1, 1);

-- Story 3:
-- Filter courts by skill level.
SELECT CourtId,
       CourtName,
       SkillLevel,
       CourtType,
       SurfaceType,
       HoopCount,
       Hours
FROM Court
WHERE IsActive = TRUE
  AND SkillLevel = 'Intermediate'
ORDER BY CourtName;

-- Story 4:
-- View personal stats: games played, wins, and skill rank.
SELECT p.PlayerId,
       p.Username,
       COUNT(gp.GameId)                                   AS GamesPlayed,
       SUM(CASE WHEN gp.Result = 'Win' THEN 1 ELSE 0 END) AS Wins,
       p.SkillRating,
       (SELECT COUNT(*) + 1
        FROM Player p2
        WHERE p2.SkillRating > p.SkillRating
          AND p2.IsActive = TRUE)                         AS SkillRank
FROM Player p
         LEFT JOIN GameParticipation gp
                   ON gp.PlayerId = p.PlayerId
WHERE p.PlayerId = 1
GROUP BY p.PlayerId, p.Username, p.SkillRating;

-- Story 5:
-- Rate a court after playing there.
INSERT INTO CourtReview (ReviewId,
                         Rating,
                         ConditionRating,
                         Comment,
                         IsFlagged,
                         ReviewDate,
                         PlayerId,
                         CourtId)
VALUES (1001,
        4.2,
        4.0,
        'Solid court, good rims, and enough space for pickup games.',
        FALSE,
        '2026-04-06',
        1,
        3);

-- Story 6:
-- Check out of a court when leaving.
UPDATE CheckIn
SET CheckOutTime = '2026-04-06 19:45:00'
WHERE CheckInId = 6;

-- =========================================================
-- Persona 2: Competitive Player
-- =========================================================

-- Story 1:
-- View a public leaderboard ranked by skill rating.
SELECT PlayerId,
       Username,
       SkillRating,
       Position
FROM Player
WHERE IsActive = TRUE
ORDER BY SkillRating DESC, Username;

-- Story 2:
-- Log a game result and update skill rating.
INSERT INTO GameParticipation (GameId, PlayerId, Result, Score)
VALUES (1, 2, 'Loss', 8);

UPDATE Player
SET SkillRating = 3.6
WHERE PlayerId = 2;

-- Story 3:
-- Register for a community tournament.
INSERT INTO TournamentRegistration (PlayerId, TournamentId, RegistrationDate)
VALUES (4, 1, '2026-04-03');

-- Story 4:
-- Filter courts by minimum skill rating.
SELECT c.CourtId,
       c.CourtName,
       c.Address,
       g.GameId,
       g.GameDate,
       g.GameType,
       g.MinSkillRating
FROM Court c
         JOIN Game g
              ON g.CourtId = c.CourtId
WHERE c.IsActive = TRUE
  AND g.MinSkillRating >= 4.0
ORDER BY g.MinSkillRating DESC, g.GameDate;

-- Story 5:
-- Update player profile information.
UPDATE Player
SET Position           = 'Forward',
    Height             = 79.0,
    PreferredCourtType = 'Outdoor'
WHERE PlayerId = 2;

-- Story 6:
-- View tournament bracket standings.
SELECT t.TournamentName,
       tm.MatchId,
       tm.RoundNumber,
       tm.MatchOrder,
       tm.MatchStatus,
       p1.Username AS PlayerName,
       p2.Username AS OpponentName,
       mp1.IsWinner
FROM Tournament t
         JOIN TournamentMatch tm
              ON tm.TournamentId = t.TournamentId
         JOIN MatchParticipation mp1
              ON mp1.MatchId = tm.MatchId
         JOIN Player p1
              ON p1.PlayerId = mp1.PlayerId
         LEFT JOIN MatchParticipation mp2
                   ON mp2.MatchId = tm.MatchId
                       AND mp2.PlayerId <> mp1.PlayerId
         LEFT JOIN Player p2
                   ON p2.PlayerId = mp2.PlayerId
WHERE t.TournamentId = 2
  AND p1.PlayerId = 3
ORDER BY tm.RoundNumber, tm.MatchOrder;

-- =========================================================
-- Persona 3: System Administrator
-- =========================================================

-- Story 1:
-- Add a new court and its amenities.
INSERT INTO Court (CourtId,
                   CourtName,
                   Address,
                   Latitude,
                   Longitude,
                   SkillLevel,
                   CourtType,
                   SurfaceType,
                   HoopCount,
                   Hours,
                   IsOpen,
                   IsActive,
                   NeighborhoodId)
VALUES (33,
        'South End Community Courts',
        '75 Tremont St, Boston, MA',
        42.342100,
        -71.076000,
        'Intermediate',
        'Outdoor',
        'Asphalt',
        2,
        '7 AM - 10 PM',
        TRUE,
        TRUE,
        4);

INSERT INTO CourtAmenity (CourtId, AmenityId)
VALUES (33, 1);

INSERT INTO CourtAmenity (CourtId, AmenityId)
VALUES (33, 2);

INSERT INTO CourtAmenity (CourtId, AmenityId)
VALUES (33, 4);

-- Story 2:
-- Mark a court as inactive.
UPDATE Court
SET IsActive = FALSE
WHERE CourtId = 4;

-- Story 3:
-- Review and remove flagged court reviews.
SELECT cr.ReviewId,
       p.Username,
       c.CourtName,
       cr.Rating,
       cr.ConditionRating,
       cr.Comment,
       cr.ReviewDate
FROM CourtReview cr
         JOIN Player p
              ON p.PlayerId = cr.PlayerId
         JOIN Court c
              ON c.CourtId = cr.CourtId
WHERE cr.IsFlagged = TRUE
ORDER BY cr.ReviewDate DESC;

DELETE
FROM CourtReview
WHERE ReviewId = 4
  AND IsFlagged = TRUE;

-- Story 4:
-- Edit court details.
UPDATE Court
SET Hours       = '6 AM - 9 PM',
    SurfaceType = 'Sport Tile',
    HoopCount   = 4
WHERE CourtId = 2;

-- Story 5:
-- View all users and deactivate a violating account.
SELECT PlayerId,
       Username,
       Email,
       SkillRating,
       RegistrationDate,
       IsActive,
       IsFlagged
FROM Player
ORDER BY RegistrationDate DESC, Username;

UPDATE Player
SET IsActive = FALSE
WHERE PlayerId = 5;

-- Story 6:
-- Remove an invalid tournament listing.
DELETE
FROM MatchParticipation
WHERE MatchId IN (SELECT MatchId
                  FROM TournamentMatch
                  WHERE TournamentId = 16);

DELETE
FROM TournamentMatch
WHERE TournamentId = 16;

DELETE
FROM TournamentRegistration
WHERE TournamentId = 16;

DELETE
FROM Tournament
WHERE TournamentId = 16;

-- =========================================================
-- Persona 4: Data Analyst
-- =========================================================

-- Story 1:
-- View total check-ins per court over a date range.
SELECT c.CourtId,
       c.CourtName,
       COUNT(ci.CheckInId) AS TotalCheckIns
FROM Court c
         LEFT JOIN CheckIn ci
                   ON ci.CourtId = c.CourtId
WHERE ci.CheckInTime >= '2026-03-01'
  AND ci.CheckInTime <= '2026-03-31 23:59:59'
GROUP BY c.CourtId, c.CourtName
ORDER BY TotalCheckIns DESC, c.CourtName;

-- Story 2:
-- View a heat map dataset of court activity by neighborhood.
SELECT n.NeighborhoodName,
       c.CourtId,
       c.CourtName,
       c.Latitude,
       c.Longitude,
       COUNT(ci.CheckInId) AS ActivityCount
FROM Court c
         JOIN Neighborhood n
              ON n.NeighborhoodId = c.NeighborhoodId
         LEFT JOIN CheckIn ci
                   ON ci.CourtId = c.CourtId
WHERE ci.CheckInTime >= '2026-03-01'
  AND ci.CheckInTime <= '2026-03-31 23:59:59'
GROUP BY n.NeighborhoodName,
         c.CourtId,
         c.CourtName,
         c.Latitude,
         c.Longitude
ORDER BY ActivityCount DESC, n.NeighborhoodName, c.CourtName;

-- Story 3:
-- View peak usage hours for each court by day of week.
SELECT c.CourtName,
       DAYNAME(ci.CheckInTime) AS DayOfWeek,
       HOUR(ci.CheckInTime)    AS HourOfDay,
       COUNT(*)                AS CheckInCount
FROM CheckIn ci
         JOIN Court c
              ON c.CourtId = ci.CourtId
WHERE ci.CheckInTime >= '2026-03-01'
  AND ci.CheckInTime <= '2026-03-31 23:59:59'
GROUP BY c.CourtName,
         DAYNAME(ci.CheckInTime),
         HOUR(ci.CheckInTime)
ORDER BY c.CourtName, CheckInCount DESC;

-- Story 4:
-- View average condition ratings with usage totals.
SELECT c.CourtId,
       c.CourtName,
       ROUND(AVG(cr.ConditionRating), 2)               AS AvgConditionRating,
       COUNT(cr.ReviewId)                              AS ReviewCount,
       (SELECT COUNT(*)
        FROM CheckIn ci
        WHERE ci.CourtId = c.CourtId
          AND ci.CheckInTime >= '2026-03-01'
          AND ci.CheckInTime <= '2026-03-31 23:59:59') AS CheckInCount
FROM Court c
         LEFT JOIN CourtReview cr
                   ON cr.CourtId = c.CourtId
WHERE cr.ReviewDate >= '2026-03-01'
   OR cr.ReviewDate IS NULL
GROUP BY c.CourtId, c.CourtName
ORDER BY CheckInCount DESC, AvgConditionRating ASC;

-- Story 5:
-- Export check-in data by running this query and saving the results.
SELECT ci.CheckInId,
       ci.CheckInTime,
       ci.CheckOutTime,
       p.PlayerId,
       p.Username,
       c.CourtId,
       c.CourtName,
       n.NeighborhoodName
FROM CheckIn ci
         JOIN Player p
              ON p.PlayerId = ci.PlayerId
         JOIN Court c
              ON c.CourtId = ci.CourtId
         JOIN Neighborhood n
              ON n.NeighborhoodId = c.NeighborhoodId
WHERE ci.CheckInTime >= '2026-03-01'
  AND ci.CheckInTime <= '2026-03-31 23:59:59'
  AND n.NeighborhoodName = 'Mission Hill'
ORDER BY ci.CheckInTime;

-- Story 6:
-- View a summary of active users by ZIP code.
SELECT ZipCode,
       COUNT(*)                   AS ActiveUserCount,
       ROUND(AVG(SkillRating), 2) AS AvgSkillRating
FROM Player
WHERE IsActive = TRUE
GROUP BY ZipCode
ORDER BY ActiveUserCount DESC, ZipCode;
