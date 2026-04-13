DROP DATABASE IF EXISTS HoopSpot;
CREATE DATABASE HoopSpot;
USE HoopSpot;

CREATE TABLE Neighborhood (
    NeighborhoodId INT PRIMARY KEY,
    NeighborhoodName VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(50) NOT NULL,
    ZipCode VARCHAR(10) NOT NULL
);

CREATE TABLE Amenity (
    AmenityId INT PRIMARY KEY,
    AmenityName VARCHAR(100) NOT NULL
);

CREATE TABLE Player (
    PlayerId INT PRIMARY KEY,
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
    CourtId INT PRIMARY KEY,
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
    CheckInId INT PRIMARY KEY,
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
    ReviewId INT PRIMARY KEY,
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
    GameId INT PRIMARY KEY,
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
    TournamentId INT PRIMARY KEY,
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
    MatchId INT PRIMARY KEY,
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
    (3, 'Fenway', 'Boston', 'MA', '02215');

INSERT INTO Amenity (AmenityId, AmenityName) VALUES
    (1, 'Lights'),
    (2, 'Water Fountain'),
    (3, 'Bleachers'),
    (4, 'Parking'),
    (5, 'Restrooms');

INSERT INTO Player (
    PlayerId, Username, Email, SkillRating, Height, Position, PreferredCourtType,
    ZipCode, RegistrationDate, IsActive, IsFlagged, NeighborhoodId
) VALUES
    (1, 'jcross', 'jcross@example.com', 4.5, 72.0, 'Guard', 'Outdoor', '02116', '2025-09-01', TRUE, FALSE, 1),
    (2, 'rimrunner22', 'rimrunner22@example.com', 3.8, 78.0, 'Center', 'Indoor', '02120', '2025-09-08', TRUE, FALSE, 2),
    (3, 'midrange_mia', 'mia@example.com', 4.1, 69.0, 'Forward', 'Outdoor', '02215', '2025-09-14', TRUE, FALSE, 3),
    (4, 'assistking', 'assistking@example.com', 3.5, 71.0, 'Guard', 'Indoor', '02120', '2025-10-01', TRUE, FALSE, 2),
    (5, 'postfade', 'postfade@example.com', 4.8, 80.0, 'Forward', 'Outdoor', '02116', '2025-10-11', FALSE, FALSE, 1);

INSERT INTO Court (
    CourtId, CourtName, Address, Latitude, Longitude, SkillLevel, CourtType,
    SurfaceType, HoopCount, Hours, IsOpen, IsActive, NeighborhoodId
) VALUES
    (1, 'Charles River Courts', '150 Charles St, Boston, MA', 42.361145, -71.070251, 'Intermediate', 'Outdoor', 'Asphalt', 4, '6 AM - 10 PM', TRUE, TRUE, 1),
    (2, 'Mission Hill Rec Center', '20 Smith St, Boston, MA', 42.330154, -71.103777, 'Beginner', 'Indoor', 'Hardwood', 2, '8 AM - 9 PM', TRUE, TRUE, 2),
    (3, 'Fenway Park Hoops', '55 Brookline Ave, Boston, MA', 42.346676, -71.097218, 'Advanced', 'Outdoor', 'Concrete', 2, '7 AM - 11 PM', TRUE, TRUE, 3),
    (4, 'Roxbury Community Gym', '120 Dudley St, Boston, MA', 42.328900, -71.083500, 'Intermediate', 'Indoor', 'Hardwood', 2, '9 AM - 8 PM', FALSE, TRUE, 2);

INSERT INTO CourtAmenity (CourtId, AmenityId) VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4),
    (2, 5),
    (3, 1),
    (3, 4),
    (4, 2),
    (4, 5);

INSERT INTO CheckIn (CheckInId, CheckInTime, CheckOutTime, PlayerId, CourtId) VALUES
    (1, '2026-03-20 17:10:00', '2026-03-20 18:45:00', 1, 1),
    (2, '2026-03-20 17:15:00', '2026-03-20 18:30:00', 3, 1),
    (3, '2026-03-22 19:00:00', '2026-03-22 20:10:00', 2, 2),
    (4, '2026-03-22 19:05:00', '2026-03-22 20:00:00', 4, 2),
    (5, '2026-03-25 18:00:00', '2026-03-25 19:20:00', 5, 3),
    (6, '2026-03-26 16:40:00', NULL, 1, 3);

INSERT INTO CourtReview (
    ReviewId, Rating, ConditionRating, Comment, IsFlagged, ReviewDate, PlayerId, CourtId
) VALUES
    (1, 4.5, 4.0, 'Great run in the evening and the rims were in solid shape.', FALSE, '2026-03-21', 1, 1),
    (2, 3.5, 3.0, 'Indoor court is clean but gets crowded fast.', FALSE, '2026-03-23', 2, 2),
    (3, 4.8, 4.7, 'Best competition in the area.', FALSE, '2026-03-26', 3, 3),
    (4, 2.5, 2.0, 'One hoop was down last week.', TRUE, '2026-03-27', 4, 4);

INSERT INTO Game (GameId, GameDate, GameType, MinSkillRating, CourtId) VALUES
    (1, '2026-03-28 18:00:00', 'Pickup 5v5', 3.5, 1),
    (2, '2026-03-29 19:30:00', '3v3 Half Court', 3.0, 2),
    (3, '2026-04-01 17:45:00', 'King of the Court', 4.0, 3);

INSERT INTO GameParticipation (GameId, PlayerId, Result, Score) VALUES
    (1, 1, 'Win', 11),
    (1, 3, 'Win', 9),
    (1, 4, 'Loss', 7),
    (2, 2, 'Win', 15),
    (2, 4, 'Win', 14),
    (3, 1, 'Loss', 8),
    (3, 3, 'Win', 12),
    (3, 5, 'Win', 10);

INSERT INTO Tournament (
    TournamentId, TournamentName, StartDate, EndDate, Status, Winner, CourtId
) VALUES
    (1, 'Spring Tip-Off', '2026-04-10', '2026-04-12', 'Scheduled', NULL, 1),
    (2, 'Fenway Shootout', '2026-03-15', '2026-03-16', 'Completed', 'midrange_mia', 3);

INSERT INTO TournamentRegistration (PlayerId, TournamentId, RegistrationDate) VALUES
    (1, 1, '2026-04-02'),
    (3, 1, '2026-04-02'),
    (2, 2, '2026-03-05'),
    (3, 2, '2026-03-05'),
    (4, 2, '2026-03-06'),
    (5, 2, '2026-03-06');

INSERT INTO TournamentMatch (MatchId, RoundNumber, MatchOrder, MatchStatus, TournamentId) VALUES
    (1, 1, 1, 'Completed', 2),
    (2, 1, 2, 'Completed', 2),
    (3, 1, 1, 'Scheduled', 1);

INSERT INTO MatchParticipation (MatchId, PlayerId, IsWinner) VALUES
    (1, 2, FALSE),
    (1, 3, TRUE),
    (2, 4, FALSE),
    (2, 5, TRUE),
    (3, 1, FALSE),
    (3, 3, FALSE);
