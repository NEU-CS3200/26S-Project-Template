DROP DATABASE IF EXISTS `CommunEvent`;
CREATE DATABASE `CommunEvent`;
USE `CommunEvent`;
CREATE TABLE Owner (
   OwnerID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   FName VARCHAR(255),
   LName VARCHAR(255),
   DOB DATE,
   Email VARCHAR(255),
   INDEX(Email)
);


CREATE TABLE Organizer (
   OrganizerID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   FName VARCHAR(255),
   LName VARCHAR(255),
   Email VARCHAR(255),
   Location VARCHAR(255),
   INDEX(Email)
);


CREATE TABLE Performer (
   PerformerID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   FName VARCHAR(255) NOT NULL,
   LName VARCHAR(255) NOT NULL,
   Genre VARCHAR(255),
   Bio TEXT,
   MediaLinks TEXT,
   Availability VARCHAR(255),
   Views INT,
   Ranking DECIMAL(10,2)
);


CREATE TABLE Venue (
   VenueID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   Name VARCHAR(255) NOT NULL,
   Capacity INT,
   Location VARCHAR(255),
   OwnerID INT NOT NULL,
   INDEX(OwnerID),
   FOREIGN KEY(OwnerID) REFERENCES Owner(OwnerID)
);


CREATE TABLE Event (
   EventID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   Name VARCHAR(255) NOT NULL,
   Date DATETIME,
   Location VARCHAR(255),
   Description TEXT,
   Size INT,
   Category VARCHAR(255)
);


CREATE TABLE Requests (
   RequestID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   RequestName VARCHAR(255),
   Status VARCHAR(255),
   OrganizerID INT NOT NULL,
   VenueID INT NOT NULL,
   INDEX(OrganizerID),
   INDEX(VenueID),
   FOREIGN KEY(OrganizerID) REFERENCES Organizer(OrganizerID),
   FOREIGN KEY(VenueID) REFERENCES Venue(VenueID)
);


CREATE TABLE Hosts (
   VenueID INT NOT NULL,
   EventID INT NOT NULL,
   PRIMARY KEY(VenueID, EventID),
   FOREIGN KEY(VenueID) REFERENCES Venue(VenueID),
   FOREIGN KEY(EventID) REFERENCES Event(EventID)
);


CREATE TABLE Attendee (
   AttendeeID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   FName VARCHAR(255) NOT NULL,
   LName VARCHAR(255) NOT NULL,
   Email VARCHAR(255),
   DOB DATE,
   Location VARCHAR(255),
   INDEX(Email)
);


CREATE TABLE Interests (
   InterestID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   Interest VARCHAR(255) NOT NULL,
   AttendeeID INT NOT NULL,
   INDEX(AttendeeID),
   FOREIGN KEY(AttendeeID) REFERENCES Attendee(AttendeeID)
);


CREATE TABLE Favorites (
   EventID INT NOT NULL,
   AttendeeID INT NOT NULL,
   PRIMARY KEY(EventID, AttendeeID),
   FOREIGN KEY(EventID) REFERENCES Event(EventID),
   FOREIGN KEY(AttendeeID) REFERENCES Attendee(AttendeeID)
);


CREATE TABLE Attends (
   AttendeeID INT NOT NULL,
   EventID INT NOT NULL,
   Status VARCHAR(255),
   PRIMARY KEY(AttendeeID, EventID),
   FOREIGN KEY(AttendeeID) REFERENCES Attendee(AttendeeID),
   FOREIGN KEY(EventID) REFERENCES Event(EventID)
);


CREATE TABLE PreformsAt (
   Status VARCHAR(255),
   PerformerID INT NOT NULL,
   EventID INT NOT NULL,
   PRIMARY KEY(PerformerID, EventID),
   FOREIGN KEY(PerformerID) REFERENCES Performer(PerformerID),
   FOREIGN KEY(EventID) REFERENCES Event(EventID)
);


CREATE TABLE MatchedWith (
   MatchScore DECIMAL(10,4),
   Relevance DECIMAL(10,4),
   PerformerID INT NOT NULL,
   EventID INT NOT NULL,
   PRIMARY KEY(PerformerID, EventID),
   FOREIGN KEY(PerformerID) REFERENCES Performer(PerformerID),
   FOREIGN KEY(EventID) REFERENCES Event(EventID)
);


CREATE TABLE RecievedBooking (
   BookingID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   Compensation DECIMAL(10,2),
   Status VARCHAR(255),
   RequestDate DATE,
   OrganizerID INT NOT NULL,
   PerformerID INT NOT NULL,
   INDEX(OrganizerID),
   INDEX(PerformerID),
   FOREIGN KEY(OrganizerID) REFERENCES Organizer(OrganizerID),
   FOREIGN KEY(PerformerID) REFERENCES Performer(PerformerID)
);


CREATE TABLE Review (
   ReviewID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
   Rating DECIMAL(3,1),
   Comment TEXT,
   Date DATETIME,
   EventID INT NOT NULL,
   AttendeeID INT NOT NULL,
   INDEX(EventID),
   INDEX(AttendeeID),
   FOREIGN KEY(EventID) REFERENCES Event(EventID),
    FOREIGN KEY(AttendeeID) REFERENCES Attendee(AttendeeID)
);
