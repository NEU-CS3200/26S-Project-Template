DROP DATABASE IF EXISTS HoopSpot;
CREATE DATABASE HoopSpot;
USE HoopSpot;

CREATE TABLE Neighborhood (
    NeighborhoodId INT AUTO_INCREMENT PRIMARY KEY,
    NeighborhoodName VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL
);

CREATE TABLE Amenity (
    AmenityId INT AUTO_INCREMENT PRIMARY KEY,
    AmenityName VARCHAR(100) NOT NULL
);

CREATE TABLE Player (
    PlayerId INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    SkillRating DECIMAL(3,1) NOT NULL,
    Height DECIMAL(4,1) NOT NULL,
    Position VARCHAR(20) NOT NULL,
    PreferredCourtType VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL,
    RegistrationDate DATE NOT NULL,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    IsFlagged BOOLEAN NOT NULL DEFAULT FALSE,
    NeighborhoodId INT NOT NULL,
    CONSTRAINT fk_player_neighborhood
        FOREIGN KEY (NeighborhoodId) REFERENCES Neighborhood(NeighborhoodId)
);

CREATE TABLE Court (
    CourtId INT AUTO_INCREMENT PRIMARY KEY,
    CourtName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    Latitude DECIMAL(9,6) NOT NULL,
    Longitude DECIMAL(9,6) NOT NULL,
    SkillLevel VARCHAR(50) NOT NULL,
    CourtType VARCHAR(50) NOT NULL,
    SurfaceType VARCHAR(50) NOT NULL,
    HoopCount INT NOT NULL,
    Hours VARCHAR(100) NOT NULL,
    IsOpen BOOLEAN NOT NULL DEFAULT TRUE,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    NeighborhoodId INT NOT NULL,
    CONSTRAINT fk_court_neighborhood
        FOREIGN KEY (NeighborhoodId) REFERENCES Neighborhood(NeighborhoodId)
);

CREATE TABLE CourtAmenity (
    CourtId INT NOT NULL,
    AmenityId INT NOT NULL,
    PRIMARY KEY (CourtId, AmenityId),
    CONSTRAINT fk_courtamenity_court
        FOREIGN KEY (CourtId) REFERENCES Court(CourtId),
    CONSTRAINT fk_courtamenity_amenity
        FOREIGN KEY (AmenityId) REFERENCES Amenity(AmenityId)
);

CREATE TABLE CheckIn (
    CheckInId INT AUTO_INCREMENT PRIMARY KEY,
    CheckInTime DATETIME NOT NULL,
    CheckOutTime DATETIME NULL,
    PlayerId INT NOT NULL,
    CourtId INT NOT NULL,
    CONSTRAINT fk_checkin_player
        FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    CONSTRAINT fk_checkin_court
        FOREIGN KEY (CourtId) REFERENCES Court(CourtId)
);

CREATE TABLE CourtReview (
    ReviewId INT AUTO_INCREMENT PRIMARY KEY,
    Rating DECIMAL(2,1) NOT NULL,
    ConditionRating DECIMAL(2,1) NOT NULL,
    Comment TEXT,
    IsFlagged BOOLEAN NOT NULL DEFAULT FALSE,
    ReviewDate DATE NOT NULL,
    PlayerId INT NOT NULL,
    CourtId INT NOT NULL,
    CONSTRAINT fk_review_player
        FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    CONSTRAINT fk_review_court
        FOREIGN KEY (CourtId) REFERENCES Court(CourtId)
);

CREATE TABLE Game (
    GameId INT AUTO_INCREMENT PRIMARY KEY,
    GameDate DATETIME NOT NULL,
    GameType VARCHAR(50) NOT NULL,
    MinSkillRating DECIMAL(3,1) NOT NULL,
    CourtId INT NOT NULL,
    CONSTRAINT fk_game_court
        FOREIGN KEY (CourtId) REFERENCES Court(CourtId)
);

CREATE TABLE GameParticipation (
    GameId INT NOT NULL,
    PlayerId INT NOT NULL,
    Result VARCHAR(20) NOT NULL,
    Score INT NOT NULL,
    PRIMARY KEY (GameId, PlayerId),
    CONSTRAINT fk_gameparticipation_game
        FOREIGN KEY (GameId) REFERENCES Game(GameId),
    CONSTRAINT fk_gameparticipation_player
        FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId)
);

CREATE TABLE Tournament (
    TournamentId INT AUTO_INCREMENT PRIMARY KEY,
    TournamentName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status VARCHAR(30) NOT NULL,
    Winner VARCHAR(100),
    CourtId INT NOT NULL,
    CONSTRAINT fk_tournament_court
        FOREIGN KEY (CourtId) REFERENCES Court(CourtId)
);

CREATE TABLE TournamentRegistration (
    PlayerId INT NOT NULL,
    TournamentId INT NOT NULL,
    RegistrationDate DATE NOT NULL,
    PRIMARY KEY (PlayerId, TournamentId),
    CONSTRAINT fk_tournamentregistration_player
        FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    CONSTRAINT fk_tournamentregistration_tournament
        FOREIGN KEY (TournamentId) REFERENCES Tournament(TournamentId)
);

CREATE TABLE TournamentMatch (
    MatchId INT AUTO_INCREMENT PRIMARY KEY,
    RoundNumber INT NOT NULL,
    MatchOrder INT NOT NULL,
    MatchStatus VARCHAR(30) NOT NULL,
    TournamentId INT NOT NULL,
    CONSTRAINT fk_match_tournament
        FOREIGN KEY (TournamentId) REFERENCES Tournament(TournamentId)
);

CREATE TABLE MatchParticipation (
    MatchId INT NOT NULL,
    PlayerId INT NOT NULL,
    IsWinner BOOLEAN NOT NULL,
    PRIMARY KEY (MatchId, PlayerId),
    CONSTRAINT fk_matchparticipation_match
        FOREIGN KEY (MatchId) REFERENCES TournamentMatch(MatchId),
    CONSTRAINT fk_matchparticipation_player
        FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId)
);

INSERT INTO Neighborhood (NeighborhoodId, NeighborhoodName, City, State, ZipCode) VALUES
    (1, 'Back Bay', 'Boston', 'MA', '02116'),
    (2, 'Mission Hill', 'Boston', 'MA', '02120'),
    (3, 'Fenway', 'Boston', 'MA', '02215'),
    (4, 'South End', 'Boston', 'MA', '02118'),
    (5, 'Dorchester', 'Boston', 'MA', '02124'),
    (6, 'Jamaica Plain', 'Boston', 'MA', '02130'),
    (7, 'Allston', 'Boston', 'MA', '02134'),
    (8, 'Brighton', 'Boston', 'MA', '02135'),
    (9, 'Roxbury', 'Boston', 'MA', '02119'),
    (10, 'Cambridgeport', 'Cambridge', 'MA', '02139'),
    (11, 'Union Square', 'Somerville', 'MA', '02143'),
    (12, 'Brookline Village', 'Brookline', 'MA', '02445'),
    (13, 'Charlestown', 'Boston', 'MA', '02129'),
    (14, 'East Boston', 'Boston', 'MA', '02128'),
    (15, 'South Boston', 'Boston', 'MA', '02127');

INSERT INTO Amenity (AmenityId, AmenityName) VALUES
    (1, 'Lights'),
    (2, 'Water Fountain'),
    (3, 'Bleachers'),
    (4, 'Parking'),
    (5, 'Restrooms'),
    (6, 'Bike Rack'),
    (7, 'Scoreboard'),
    (8, 'Covered Seating'),
    (9, 'Locker Room'),
    (10, 'Vending Machines');

INSERT INTO Player (
    PlayerId, Username, Email, SkillRating, Height, Position, PreferredCourtType,
    ZipCode, RegistrationDate, IsActive, IsFlagged, NeighborhoodId
) VALUES
    (1, 'jcross', 'jcross@example.com', 4.5, 72.0, 'Guard', 'Outdoor', '02116', '2025-09-01', TRUE, FALSE, 1),
    (2, 'rimrunner22', 'rimrunner22@example.com', 3.8, 78.0, 'Center', 'Indoor', '02120', '2025-09-08', TRUE, FALSE, 2),
    (3, 'midrange_mia', 'mia@example.com', 4.1, 69.0, 'Forward', 'Outdoor', '02215', '2025-09-14', TRUE, FALSE, 3),
    (4, 'assistking', 'assistking@example.com', 3.5, 71.0, 'Guard', 'Indoor', '02120', '2025-10-01', TRUE, FALSE, 2),
    (5, 'postfade', 'postfade@example.com', 4.8, 80.0, 'Forward', 'Outdoor', '02116', '2025-10-11', FALSE, FALSE, 1),
    (6, 'southie_swish', 'southie_swish@example.com', 4.2, 74.0, 'Guard', 'Outdoor', '02127', '2025-10-18', TRUE, FALSE, 15),
    (7, 'paint_beast', 'paint_beast@example.com', 3.9, 79.0, 'Center', 'Indoor', '02124', '2025-10-23', TRUE, FALSE, 5),
    (8, 'fenway_floater', 'fenway_floater@example.com', 3.6, 68.0, 'Guard', 'Outdoor', '02215', '2025-11-02', TRUE, FALSE, 3),
    (9, 'jp_jumper', 'jp_jumper@example.com', 4.0, 73.0, 'Forward', 'Outdoor', '02130', '2025-11-08', TRUE, FALSE, 6),
    (10, 'allston_iso', 'allston_iso@example.com', 3.4, 71.0, 'Guard', 'Indoor', '02134', '2025-11-14', TRUE, FALSE, 7),
    (11, 'brighton_boardman', 'brighton_boardman@example.com', 3.7, 77.0, 'Center', 'Outdoor', '02135', '2025-11-20', TRUE, FALSE, 8),
    (12, 'charlestown_chip', 'charlestown_chip@example.com', 4.4, 72.0, 'Guard', 'Outdoor', '02129', '2025-11-26', TRUE, FALSE, 13),
    (13, 'eastie_fastbreak', 'eastie_fastbreak@example.com', 3.3, 70.0, 'Guard', 'Outdoor', '02128', '2025-12-01', TRUE, FALSE, 14),
    (14, 'southend_spin', 'southend_spin@example.com', 4.1, 75.0, 'Forward', 'Indoor', '02118', '2025-12-05', TRUE, FALSE, 4),
    (15, 'cambridge_handle', 'cambridge_handle@example.com', 4.6, 71.0, 'Guard', 'Indoor', '02139', '2025-12-11', TRUE, FALSE, 10),
    (16, 'unionsquare_dimes', 'unionsquare_dimes@example.com', 3.8, 69.0, 'Guard', 'Outdoor', '02143', '2025-12-18', TRUE, FALSE, 11),
    (17, 'brookline_bank', 'brookline_bank@example.com', 3.5, 74.0, 'Forward', 'Indoor', '02445', '2025-12-22', TRUE, FALSE, 12),
    (18, 'roxbury_rim', 'roxbury_rim@example.com', 4.3, 78.0, 'Center', 'Outdoor', '02119', '2026-01-03', TRUE, FALSE, 9),
    (19, 'backbay_baller', 'backbay_baller@example.com', 3.9, 72.0, 'Forward', 'Indoor', '02116', '2026-01-09', TRUE, FALSE, 1),
    (20, 'missionhill_hustle', 'missionhill_hustle@example.com', 3.2, 70.0, 'Guard', 'Outdoor', '02120', '2026-01-14', TRUE, FALSE, 2),
    (21, 'cornerthree_cara', 'cornerthree_cara@example.com', 4.7, 70.0, 'Guard', 'Indoor', '02118', '2026-01-19', TRUE, FALSE, 4),
    (22, 'glasscleaner_gio', 'glasscleaner_gio@example.com', 3.6, 80.0, 'Center', 'Outdoor', '02124', '2026-01-23', TRUE, FALSE, 5),
    (23, 'baseline_ben', 'baseline_ben@example.com', 4.0, 76.0, 'Forward', 'Outdoor', '02127', '2026-01-29', TRUE, FALSE, 15),
    (24, 'crossover_cee', 'crossover_cee@example.com', 3.1, 67.0, 'Guard', 'Indoor', '02134', '2026-02-03', TRUE, FALSE, 7),
    (25, 'postup_paulie', 'postup_paulie@example.com', 4.5, 79.0, 'Center', 'Indoor', '02135', '2026-02-08', TRUE, FALSE, 8),
    (26, 'handles_hana', 'handles_hana@example.com', 3.8, 66.0, 'Guard', 'Outdoor', '02139', '2026-02-14', TRUE, FALSE, 10),
    (27, 'skyhook_sam', 'skyhook_sam@example.com', 4.1, 81.0, 'Center', 'Outdoor', '02129', '2026-02-18', TRUE, FALSE, 13),
    (28, 'alleyoop_amy', 'alleyoop_amy@example.com', 3.7, 68.0, 'Forward', 'Indoor', '02128', '2026-02-22', TRUE, FALSE, 14),
    (29, 'clutch_kai', 'clutch_kai@example.com', 4.2, 73.0, 'Guard', 'Outdoor', '02130', '2026-02-27', TRUE, FALSE, 6),
    (30, 'zonebreaker_z', 'zonebreaker_z@example.com', 3.4, 75.0, 'Forward', 'Indoor', '02445', '2026-03-02', TRUE, FALSE, 12),
    (31, 'rebound_rae', 'rebound_rae@example.com', 3.0, 72.0, 'Forward', 'Outdoor', '02143', '2026-03-05', TRUE, FALSE, 11),
    (32, 'tempo_trey', 'tempo_trey@example.com', 4.8, 74.0, 'Guard', 'Outdoor', '02116', '2026-03-09', TRUE, FALSE, 1),
    (33, 'painttouch_tia', 'painttouch_tia@example.com', 3.5, 70.0, 'Forward', 'Indoor', '02120', '2026-03-12', FALSE, FALSE, 2),
    (34, 'hoopdreams_don', 'hoopdreams_don@example.com', 3.9, 77.0, 'Center', 'Outdoor', '02119', '2026-03-16', TRUE, FALSE, 9),
    (35, 'deeprange_dev', 'deeprange_dev@example.com', 4.4, 71.0, 'Guard', 'Indoor', '02215', '2026-03-19', TRUE, TRUE, 3),
    (36, 'fastbreak_fay', 'fastbreak_fay@example.com', 3.3, 69.0, 'Guard', 'Outdoor', '02127', '2026-03-22', TRUE, FALSE, 15);

INSERT INTO Court (
    CourtId, CourtName, Address, Latitude, Longitude, SkillLevel, CourtType,
    SurfaceType, HoopCount, Hours, IsOpen, IsActive, NeighborhoodId
) VALUES
    (1, 'Charles River Courts', '150 Charles St, Boston, MA', 42.361145, -71.070251, 'Intermediate', 'Outdoor', 'Asphalt', 4, '6 AM - 10 PM', TRUE, TRUE, 1),
    (2, 'Mission Hill Rec Center', '20 Smith St, Boston, MA', 42.330154, -71.103777, 'Beginner', 'Indoor', 'Hardwood', 2, '8 AM - 9 PM', TRUE, TRUE, 2),
    (3, 'Fenway Park Hoops', '55 Brookline Ave, Boston, MA', 42.346676, -71.097218, 'Advanced', 'Outdoor', 'Concrete', 2, '7 AM - 11 PM', TRUE, TRUE, 3),
    (4, 'Roxbury Community Gym', '120 Dudley St, Boston, MA', 42.328900, -71.083500, 'Intermediate', 'Indoor', 'Hardwood', 2, '9 AM - 8 PM', FALSE, TRUE, 2),
    (5, 'South End Playground', '410 Tremont St, Boston, MA', 42.342100, -71.073000, 'Intermediate', 'Outdoor', 'Asphalt', 2, '6 AM - 10 PM', TRUE, TRUE, 4),
    (6, 'Dorchester Fieldhouse', '200 Columbia Rd, Boston, MA', 42.317800, -71.065400, 'Beginner', 'Indoor', 'Hardwood', 2, '8 AM - 9 PM', TRUE, TRUE, 5),
    (7, 'Jamaica Pond Courts', '507 Jamaicaway, Jamaica Plain, MA', 42.311900, -71.114600, 'Intermediate', 'Outdoor', 'Concrete', 4, '6 AM - 9 PM', TRUE, TRUE, 6),
    (8, 'Allston Hoops Hub', '150 Harvard Ave, Boston, MA', 42.350800, -71.131200, 'Intermediate', 'Indoor', 'Sport Tile', 2, '9 AM - 10 PM', TRUE, TRUE, 7),
    (9, 'Brighton Common Courts', '30 Chestnut Hill Ave, Brighton, MA', 42.350000, -71.153500, 'Beginner', 'Outdoor', 'Asphalt', 4, '7 AM - 10 PM', TRUE, TRUE, 8),
    (10, 'Malcolm X Park Courts', '40 Martin Luther King Jr Blvd, Boston, MA', 42.324200, -71.091800, 'Advanced', 'Outdoor', 'Concrete', 2, '6 AM - 11 PM', TRUE, TRUE, 9),
    (11, 'Cambridgeport River House', '100 Memorial Dr, Cambridge, MA', 42.357900, -71.106000, 'Advanced', 'Indoor', 'Hardwood', 2, '8 AM - 10 PM', TRUE, TRUE, 10),
    (12, 'Union Square Blacktop', '66 Somerville Ave, Somerville, MA', 42.379400, -71.095200, 'Intermediate', 'Outdoor', 'Asphalt', 2, '7 AM - 10 PM', TRUE, TRUE, 11),
    (13, 'Brookline Village Gym', '100 Pearl St, Brookline, MA', 42.331500, -71.120300, 'Intermediate', 'Indoor', 'Hardwood', 2, '8 AM - 9 PM', TRUE, TRUE, 12),
    (14, 'Charlestown Navy Yard Courts', '1 First Ave, Boston, MA', 42.373900, -71.051200, 'Beginner', 'Outdoor', 'Concrete', 4, '6 AM - 10 PM', TRUE, TRUE, 13),
    (15, 'Eastie Harbor Courts', '212 Marginal St, Boston, MA', 42.367200, -71.035100, 'Intermediate', 'Outdoor', 'Asphalt', 2, '6 AM - 10 PM', TRUE, TRUE, 14),
    (16, 'Southie Seaport Hoops', '25 D St, Boston, MA', 42.344900, -71.044800, 'Advanced', 'Outdoor', 'Concrete', 4, '6 AM - 11 PM', TRUE, TRUE, 15),
    (17, 'Copley Night Lights', '560 Boylston St, Boston, MA', 42.349300, -71.081000, 'Advanced', 'Outdoor', 'Sport Tile', 2, '5 PM - 11 PM', TRUE, TRUE, 1),
    (18, 'Brigham Rec Gym', '80 Francis St, Boston, MA', 42.334200, -71.105300, 'Beginner', 'Indoor', 'Hardwood', 2, '7 AM - 8 PM', TRUE, TRUE, 2),
    (19, 'Fenway Victory Courts', '82 Jersey St, Boston, MA', 42.345000, -71.098400, 'Intermediate', 'Outdoor', 'Asphalt', 4, '6 AM - 10 PM', TRUE, TRUE, 3),
    (20, 'Peters Park Hoops', '230 Shawmut Ave, Boston, MA', 42.340700, -71.068500, 'Intermediate', 'Outdoor', 'Sport Tile', 2, '6 AM - 10 PM', TRUE, TRUE, 4),
    (21, 'Franklin Park Fieldhouse', '1 Franklin Park Rd, Boston, MA', 42.301700, -71.090200, 'Advanced', 'Indoor', 'Hardwood', 2, '8 AM - 9 PM', TRUE, TRUE, 5),
    (22, 'Stony Brook Courts', '350 Boylston St, Jamaica Plain, MA', 42.309100, -71.107400, 'Beginner', 'Outdoor', 'Asphalt', 2, '7 AM - 9 PM', TRUE, TRUE, 6),
    (23, 'Packard''s Corner Rec', '1235 Commonwealth Ave, Boston, MA', 42.352600, -71.125200, 'Intermediate', 'Indoor', 'Sport Tile', 2, '9 AM - 10 PM', TRUE, TRUE, 7),
    (24, 'Rogers Park Courts', '75 Faneuil St, Brighton, MA', 42.352400, -71.165100, 'All Levels', 'Outdoor', 'Concrete', 4, '6 AM - 9 PM', TRUE, TRUE, 8),
    (25, 'Madison Park Gym', '55 Malcolm X Blvd, Boston, MA', 42.325400, -71.084900, 'Advanced', 'Indoor', 'Hardwood', 2, '8 AM - 8 PM', TRUE, TRUE, 9),
    (26, 'Magazine Beach Hoops', '668 Memorial Dr, Cambridge, MA', 42.356200, -71.113300, 'Intermediate', 'Outdoor', 'Asphalt', 4, '6 AM - 10 PM', TRUE, TRUE, 10),
    (27, 'Conway Park Courts', '550 Somerville Ave, Somerville, MA', 42.381800, -71.102600, 'Beginner', 'Outdoor', 'Concrete', 2, '7 AM - 9 PM', TRUE, TRUE, 11),
    (28, 'Brookline Reservoir Gym', '1580 Beacon St, Brookline, MA', 42.335800, -71.141900, 'Intermediate', 'Indoor', 'Hardwood', 2, '8 AM - 9 PM', TRUE, TRUE, 12),
    (29, 'City Square Courts', '15 Austin St, Charlestown, MA', 42.373100, -71.061600, 'All Levels', 'Outdoor', 'Asphalt', 2, '6 AM - 10 PM', TRUE, FALSE, 13),
    (30, 'Bremen Street Courts', '200 Bremen St, Boston, MA', 42.377500, -71.032300, 'Beginner', 'Outdoor', 'Concrete', 4, '6 AM - 10 PM', TRUE, TRUE, 14),
    (31, 'Marine Park Courts', '10 Farragut Rd, South Boston, MA', 42.337600, -71.030500, 'Advanced', 'Outdoor', 'Asphalt', 2, '6 AM - 11 PM', TRUE, TRUE, 15),
    (32, 'Prudential Sky Gym', '800 Boylston St, Boston, MA', 42.347200, -71.082600, 'Advanced', 'Indoor', 'Sport Tile', 2, '6 AM - 10 PM', FALSE, TRUE, 1);

INSERT INTO CourtAmenity (CourtId, AmenityId)
SELECT CourtId, ((CourtId - 1) MOD 10) + 1
FROM Court
UNION ALL
SELECT CourtId, ((CourtId + 1) MOD 10) + 1
FROM Court
UNION ALL
SELECT CourtId, ((CourtId + 3) MOD 10) + 1
FROM Court
UNION ALL
SELECT CourtId, ((CourtId + 5) MOD 10) + 1
FROM Court;

INSERT INTO CheckIn (CheckInId, CheckInTime, CheckOutTime, PlayerId, CourtId) VALUES
    (1, '2026-03-20 17:10:00', '2026-03-20 18:45:00', 1, 1),
    (2, '2026-03-20 17:15:00', '2026-03-20 18:30:00', 3, 1),
    (3, '2026-03-22 19:00:00', '2026-03-22 20:10:00', 2, 2),
    (4, '2026-03-22 19:05:00', '2026-03-22 20:00:00', 4, 2),
    (5, '2026-03-25 18:00:00', '2026-03-25 19:20:00', 5, 3),
    (6, '2026-03-26 16:40:00', NULL, 1, 3);

INSERT INTO CheckIn (CheckInId, CheckInTime, CheckOutTime, PlayerId, CourtId)
WITH RECURSIVE seq AS (
    SELECT 7 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 72
),
gen AS (
    SELECT n,
           DATE_ADD(
               DATE_ADD(
                   DATE_ADD('2026-03-01 00:00:00', INTERVAL ((n * 2 + 3) MOD 31) DAY),
                   INTERVAL (15 + (n MOD 7)) HOUR
               ),
               INTERVAL ((n * 11) MOD 60) MINUTE
           ) AS CheckInTime,
           ((n * 5) MOD 36) + 1 AS PlayerId,
           ((n * 3) MOD 32) + 1 AS CourtId
    FROM seq
)
SELECT n,
       CheckInTime,
       CASE
           WHEN n IN (13, 26, 39, 52, 65, 72) THEN NULL
           ELSE DATE_ADD(CheckInTime, INTERVAL (60 + ((n * 7) MOD 75)) MINUTE)
       END,
       PlayerId,
       CourtId
FROM gen;

INSERT INTO CourtReview (
    ReviewId, Rating, ConditionRating, Comment, IsFlagged, ReviewDate, PlayerId, CourtId
) VALUES
    (1, 4.5, 4.0, 'Great run in the evening and the rims were in solid shape.', FALSE, '2026-03-21', 1, 1),
    (2, 3.5, 3.0, 'Indoor court is clean but gets crowded fast.', FALSE, '2026-03-23', 2, 2),
    (3, 4.8, 4.7, 'Best competition in the area.', FALSE, '2026-03-26', 3, 3),
    (4, 2.5, 2.0, 'One hoop was down last week.', TRUE, '2026-03-27', 4, 4);

INSERT INTO CourtReview (
    ReviewId, Rating, ConditionRating, Comment, IsFlagged, ReviewDate, PlayerId, CourtId
)
WITH RECURSIVE seq AS (
    SELECT 5 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 60
)
SELECT n,
       ROUND(3.0 + ((n MOD 18) * 0.1), 1),
       ROUND(2.8 + ((n MOD 20) * 0.1), 1),
       ELT(
           1 + (n MOD 8),
           'Crowd was competitive and the rims played clean.',
           'Good court for a weekday run, but the sidelines feel tight.',
           'Surface held up well and the games stayed organized.',
           'Solid neighborhood court with enough space to warm up.',
           'Best for early evening runs before the after-work rush.',
           'Backboards were in good shape and the lighting helped a lot.',
           'Fun atmosphere, though the benches filled up quickly.',
           'Great pickup spot when you want balanced competition.'
       ),
       CASE WHEN n IN (18, 39, 57) THEN TRUE ELSE FALSE END,
       DATE_ADD('2026-03-01', INTERVAL ((n * 3) MOD 40) DAY),
       ((n * 7) MOD 36) + 1,
       ((n * 5) MOD 32) + 1
FROM seq;

INSERT INTO Game (GameId, GameDate, GameType, MinSkillRating, CourtId) VALUES
    (1, '2026-03-28 18:00:00', 'Pickup 5v5', 3.5, 1),
    (2, '2026-03-29 19:30:00', '3v3 Half Court', 3.0, 2),
    (3, '2026-04-01 17:45:00', 'King of the Court', 4.0, 3);

INSERT INTO Game (GameId, GameDate, GameType, MinSkillRating, CourtId)
WITH RECURSIVE seq AS (
    SELECT 4 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 36
)
SELECT n,
       DATE_ADD(
           DATE_ADD(
               DATE_ADD('2026-03-01 00:00:00', INTERVAL ((n * 2) MOD 45) DAY),
               INTERVAL (17 + (n MOD 4)) HOUR
           ),
           INTERVAL ((n * 9) MOD 60) MINUTE
       ),
       ELT(1 + (n MOD 4), 'Pickup 5v5', '3v3 Half Court', 'King of the Court', 'Open Run'),
       ROUND(2.5 + ((n MOD 6) * 0.3), 1),
       ((n * 2 + 1) MOD 32) + 1
FROM seq;

INSERT INTO GameParticipation (GameId, PlayerId, Result, Score) VALUES
    (1, 1, 'Win', 11),
    (1, 3, 'Win', 9),
    (1, 4, 'Loss', 7),
    (1, 6, 'Loss', 8),
    (2, 2, 'Win', 15),
    (2, 4, 'Win', 14),
    (2, 7, 'Loss', 9),
    (2, 8, 'Loss', 8),
    (3, 1, 'Loss', 8),
    (3, 3, 'Win', 12),
    (3, 5, 'Win', 10),
    (3, 9, 'Loss', 7);

INSERT INTO GameParticipation (GameId, PlayerId, Result, Score)
WITH RECURSIVE games AS (
    SELECT 4 AS GameId
    UNION ALL
    SELECT GameId + 1
    FROM games
    WHERE GameId < 36
),
slots AS (
    SELECT 1 AS Slot
    UNION ALL
    SELECT Slot + 1
    FROM slots
    WHERE Slot < 4
)
SELECT g.GameId,
       (((g.GameId * 5) + (s.Slot * 7)) MOD 36) + 1 AS PlayerId,
       CASE WHEN s.Slot IN (1, 2) THEN 'Win' ELSE 'Loss' END,
       CASE
           WHEN s.Slot IN (1, 2) THEN 11 + ((g.GameId + s.Slot) MOD 5)
           ELSE 6 + ((g.GameId + s.Slot) MOD 5)
       END
FROM games g
CROSS JOIN slots s;

-- ---------------------------------------------------------------------------
-- Mock data: Marcus Reyes (PlayerId 1) for the Pickup Profile dashboard.
-- The profile page defaults to PlayerId=1 / first_name="Marcus" and expects
-- rich history. Rebrand seed player 1 to Marcus Reyes (Roxbury), then insert
-- 42 additional games across Jan-Apr 2026 so stat cards, skill-trend chart,
-- and recent-games list all render with meaningful data. Loss positions are
-- tuned so Marcus lands on 29W / 18L (47 games total, matches wireframe).
-- ---------------------------------------------------------------------------
UPDATE Player
SET Username = 'marcus.reyes',
    Email = 'marcus.reyes@example.com',
    NeighborhoodId = 9,
    ZipCode = '02119',
    RegistrationDate = '2025-10-15'
WHERE PlayerId = 1;

INSERT INTO Game (GameId, GameDate, GameType, MinSkillRating, CourtId)
WITH RECURSIVE seq AS (
    SELECT 37 AS n
    UNION ALL
    SELECT n + 1
    FROM seq
    WHERE n < 78
)
SELECT n,
       DATE_ADD(
           DATE_ADD('2026-01-03 00:00:00', INTERVAL (n - 37) * 60 HOUR),
           INTERVAL (17 + (n MOD 4)) HOUR
       ),
       ELT(1 + (n MOD 4), 'Pickup 5v5', '3v3 Half Court', 'King of the Court', 'Open Run'),
       ROUND(3.0 + ((n MOD 5) * 0.3), 1),
       ((n * 3) MOD 32) + 1
FROM seq;

-- Marcus's participation across the new games. Losses cluster earlier so the
-- synthesized skill-score chart trends upward: 26 wins + 16 losses here, plus
-- the 3W / 2L from earlier seeded rows, lands at 29W / 18L over 47 games.
INSERT INTO GameParticipation (GameId, PlayerId, Result, Score)
WITH RECURSIVE seq AS (
    SELECT 37 AS GameId
    UNION ALL
    SELECT GameId + 1
    FROM seq
    WHERE GameId < 78
)
SELECT GameId,
       1,
       CASE
           WHEN GameId IN (38, 41, 43, 45, 47, 49, 50,
                           52, 55, 58, 61, 64,
                           67, 71, 74, 78) THEN 'Loss'
           ELSE 'Win'
       END,
       CASE
           WHEN GameId IN (38, 41, 43, 45, 47, 49, 50,
                           52, 55, 58, 61, 64,
                           67, 71, 74, 78) THEN 6 + (GameId MOD 5)
           ELSE 10 + (GameId MOD 5)
       END
FROM seq;

-- Fill each of Marcus's new games with a teammate + two opponents so the
-- participation rows aren't lopsided. PlayerId formula never collides with
-- Marcus (lands in [2, 36]) and produces distinct players within each game.
INSERT INTO GameParticipation (GameId, PlayerId, Result, Score)
WITH RECURSIVE seq AS (
    SELECT 37 AS GameId
    UNION ALL
    SELECT GameId + 1
    FROM seq
    WHERE GameId < 78
),
roster AS (
    SELECT 1 AS Slot
    UNION ALL
    SELECT Slot + 1
    FROM roster
    WHERE Slot < 3
)
SELECT s.GameId,
       ((s.GameId * 7 + r.Slot * 5) MOD 35) + 2,
       CASE
           WHEN s.GameId IN (38, 41, 43, 45, 47, 49, 50,
                             52, 55, 58, 61, 64,
                             67, 71, 74, 78)
                THEN CASE WHEN r.Slot = 1 THEN 'Loss' ELSE 'Win' END
           ELSE CASE WHEN r.Slot = 1 THEN 'Win' ELSE 'Loss' END
       END,
       5 + ((s.GameId + r.Slot) MOD 8)
FROM seq s
CROSS JOIN roster r;

INSERT INTO Tournament (
    TournamentId, TournamentName, StartDate, EndDate, Status, Winner, CourtId
) VALUES
    (1, 'Spring Tip-Off', '2026-04-10', '2026-04-12', 'Scheduled', NULL, 1),
    (2, 'Fenway Shootout', '2026-03-15', '2026-03-16', 'Completed', 'midrange_mia', 3),
    (3, 'South End Saturday Classic', '2026-04-17', '2026-04-18', 'Scheduled', NULL, 20),
    (4, 'Dorchester Spring League', '2026-04-24', '2026-04-26', 'Open Registration', NULL, 6),
    (5, 'JP Sunset Showdown', '2026-05-01', '2026-05-02', 'Scheduled', NULL, 7),
    (6, 'Allston 3v3 Cup', '2026-05-08', '2026-05-09', 'Scheduled', NULL, 8),
    (7, 'Brighton Blacktop Bash', '2026-05-15', '2026-05-16', 'Scheduled', NULL, 9),
    (8, 'Roxbury Elite Run', '2026-03-20', '2026-03-22', 'Completed', 'rebound_rae', 10),
    (9, 'Cambridge Night League', '2026-04-03', '2026-04-05', 'In Progress', NULL, 11),
    (10, 'Union Square Open', '2026-04-30', '2026-05-01', 'Scheduled', NULL, 12),
    (11, 'Brookline Gym Invitational', '2026-05-21', '2026-05-22', 'Scheduled', NULL, 13),
    (12, 'Harbor Hoops Challenge', '2026-03-27', '2026-03-28', 'Completed', 'eastie_fastbreak', 15),
    (13, 'Seaport Summer Qualifier', '2026-06-04', '2026-06-06', 'Open Registration', NULL, 16),
    (14, 'Copley Skills Showcase', '2026-04-08', '2026-04-08', 'Completed', 'tempo_trey', 17),
    (15, 'Franklin Park Playoffs', '2026-06-11', '2026-06-13', 'Scheduled', NULL, 21),
    (16, 'Charles River Finals', '2026-06-18', '2026-06-20', 'Invalid Draft', NULL, 26);

INSERT INTO TournamentRegistration (PlayerId, TournamentId, RegistrationDate) VALUES
    (1, 1, '2026-04-02'),
    (3, 1, '2026-04-02'),
    (2, 2, '2026-03-05'),
    (3, 2, '2026-03-05'),
    (4, 2, '2026-03-06'),
    (5, 2, '2026-03-06');

INSERT INTO TournamentRegistration (PlayerId, TournamentId, RegistrationDate)
WITH RECURSIVE tournaments AS (
    SELECT 3 AS TournamentId
    UNION ALL
    SELECT TournamentId + 1
    FROM tournaments
    WHERE TournamentId < 15
),
slots AS (
    SELECT 1 AS Slot
    UNION ALL
    SELECT Slot + 1
    FROM slots
    WHERE Slot < 10
)
SELECT ((((t.TournamentId - 3) * 7) + (s.Slot * 5) - 1) MOD 36) + 1,
       t.TournamentId,
       DATE_SUB(tr.StartDate, INTERVAL (18 - s.Slot) DAY)
FROM tournaments t
JOIN Tournament tr
    ON tr.TournamentId = t.TournamentId
CROSS JOIN slots s;

INSERT INTO TournamentMatch (MatchId, RoundNumber, MatchOrder, MatchStatus, TournamentId) VALUES
    (1, 1, 1, 'Completed', 2),
    (2, 1, 2, 'Completed', 2),
    (3, 1, 1, 'Scheduled', 1);

INSERT INTO TournamentMatch (MatchId, RoundNumber, MatchOrder, MatchStatus, TournamentId)
WITH RECURSIVE seq AS (
    SELECT 4 AS MatchId
    UNION ALL
    SELECT MatchId + 1
    FROM seq
    WHERE MatchId < 64
),
gen AS (
    SELECT MatchId,
           ((MatchId - 4) MOD 15) + 1 AS TournamentId,
           CASE ((MatchId - 4) MOD 4)
               WHEN 0 THEN 1
               WHEN 1 THEN 1
               WHEN 2 THEN 2
               ELSE 3
           END AS RoundNumber,
           CASE ((MatchId - 4) MOD 4)
               WHEN 0 THEN 1
               WHEN 1 THEN 2
               ELSE 1
           END AS MatchOrder
    FROM seq
)
SELECT g.MatchId,
       g.RoundNumber,
       g.MatchOrder,
       CASE t.Status
           WHEN 'Completed' THEN 'Completed'
           WHEN 'In Progress' THEN CASE WHEN (g.MatchId MOD 2) = 0 THEN 'Completed' ELSE 'In Progress' END
           ELSE 'Scheduled'
       END,
       g.TournamentId
FROM gen g
JOIN Tournament t
    ON t.TournamentId = g.TournamentId;

INSERT INTO MatchParticipation (MatchId, PlayerId, IsWinner) VALUES
    (1, 2, FALSE),
    (1, 3, TRUE),
    (2, 4, FALSE),
    (2, 5, TRUE),
    (3, 1, FALSE),
    (3, 3, FALSE);

INSERT INTO MatchParticipation (MatchId, PlayerId, IsWinner)
SELECT tm.MatchId,
       ((tm.TournamentId * 7 + tm.MatchId * 3) MOD 36) + 1,
       CASE
           WHEN tm.MatchStatus = 'Scheduled' THEN FALSE
           WHEN (tm.MatchId MOD 2) = 0 THEN TRUE
           ELSE FALSE
       END
FROM TournamentMatch tm
WHERE tm.MatchId BETWEEN 4 AND 64
UNION ALL
SELECT tm.MatchId,
       ((tm.TournamentId * 7 + tm.MatchId * 3 + 11) MOD 36) + 1,
       CASE
           WHEN tm.MatchStatus = 'Scheduled' THEN FALSE
           WHEN (tm.MatchId MOD 2) = 0 THEN FALSE
           ELSE TRUE
       END
FROM TournamentMatch tm
WHERE tm.MatchId BETWEEN 4 AND 64;
