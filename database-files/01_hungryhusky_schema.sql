DROP DATABASE IF EXISTS `HungryHusky`;
CREATE DATABASE `HungryHusky`;
USE `HungryHusky`;


CREATE TABLE Student(
StudentId int unsigned auto_increment,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Email varchar(50) not null,
CampusId int,
GradYear int,
University varchar(50),
PRIMARY KEY (StudentId),
INDEX idx_email (Email)
);


CREATE TABLE Restaurant(
RestaurantId int unsigned auto_increment,
Name varchar(50) not null,
Address varchar(50) not null,
PriceRange varchar(50),
Cuisine enum('Italian', 'Chinese', 'Mexican', 'Mediterranean', 'Indian', 'Fusion', 'American', 'Other') not null,
DistFromCampus float,
PRIMARY KEY (RestaurantId),
INDEX (PriceRange)
);




CREATE TABLE DiningHall(
HallId     int unsigned auto_increment,
Name       varchar(50) not null,
Location   varchar(50),
CampusArea varchar(50),
Capacity   int not null,
PRIMARY KEY (HallId),
INDEX (Name)
);




CREATE TABLE Tag(
TagId int unsigned auto_increment,
Name varchar(50) not null,
Category enum('cuisine preference', 'food type', 'allergen', 'other') not null,
PRIMARY KEY (TagId)
);




CREATE TABLE SavedSpot(
SavedId int unsigned auto_increment,
StudentId int unsigned,
HallId int unsigned,
RestaurantId int unsigned,
TagId int unsigned,
DateAdded date NOT NULL,
Notes tinytext,
PRIMARY KEY (SavedId),
CONSTRAINT fk1
                FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
                    ON UPDATE RESTRICT
                    ON DELETE CASCADE,
CONSTRAINT fk2
                  FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
CONSTRAINT fk3
                  FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE,
CONSTRAINT fk4
                  FOREIGN KEY (TagId) REFERENCES Tag(TagId)
                    ON UPDATE CASCADE
                    ON DELETE CASCADE
);




CREATE TABLE Review(
ReviewId int unsigned auto_increment,
StudentId int unsigned,
HallId int unsigned,
RestaurantId int unsigned,
Rating int not null check(Rating in (1, 2, 3, 4, 5)),
Comment varchar(150),
AllergenFlag varchar(50),
PriceRating int,
ReviewDate date not null,
PRIMARY KEY (ReviewId),
INDEX (Rating),
INDEX (PriceRating),
CONSTRAINT fk5
               FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
                 ON UPDATE CASCADE
                 ON DELETE SET NULL,
CONSTRAINT fk6
                FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                 ON UPDATE CASCADE
                 ON DELETE CASCADE,
CONSTRAINT fk7
               FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
                 ON UPDATE CASCADE
                 ON DELETE CASCADE
);




CREATE TABLE WaitTime(
RestaurantId int unsigned,
EstimatedMin int unsigned not null,
TimeStamp timestamp not null,
PRIMARY KEY (RestaurantId, TimeStamp),
INDEX (EstimatedMin),
CONSTRAINT fk8
                 FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
                   ON UPDATE CASCADE
                   ON DELETE CASCADE
);




CREATE TABLE OperatingHours(
HallId int unsigned,
DayOfWeek enum('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') not null,
OpenTime timestamp not null,
CloseTime timestamp not null,
Note tinytext,
PRIMARY KEY (HallId, DayOfWeek),
CONSTRAINT fk9
                FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                         ON UPDATE CASCADE
                         ON DELETE CASCADE
);


CREATE TABLE Allergen(
AllergenId int unsigned not null,
AllergyName varchar(30) UNIQUE,
Severity enum('mild', 'moderate', 'severe') not null,
PRIMARY KEY (AllergenId)
);


CREATE TABLE UsageStats(
HallId int unsigned,
TimeStamp timestamp not null,
VisitorCount int not null,
PeakHour time,
DayOfWeek enum('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') not null,
PRIMARY KEY (HallId, TimeStamp),
INDEX (DayOfWeek),
CONSTRAINT fk10
                   FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                     ON UPDATE CASCADE
                     ON DELETE CASCADE
);




CREATE TABLE MenuItem(
ItemId int unsigned not null,
HallId int unsigned,
ItemName varchar(30) not null,
Description tinytext,
Category enum('Breakfast', 'Lunch', 'Dinner', 'Snack', 'Dessert', 'Other') not null,
IsAvailable boolean not null,
PRIMARY KEY (ItemId),
INDEX (ItemName),
INDEX (IsAvailable),
CONSTRAINT fk13
                 FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                   ON UPDATE CASCADE
                   ON DELETE CASCADE
);


CREATE TABLE Admin(
AdminId int unsigned not null,
HallId int unsigned,
FirstName varchar(50) not null,
LastName varchar(50) not null,
Email varchar(50),
Role varchar(50),
Department varchar(50),
PRIMARY KEY (AdminId),
CONSTRAINT fk15
              FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                ON UPDATE CASCADE
                ON DELETE SET NULL
);




CREATE TABLE Report(
ReportId int unsigned not null,
AdminId int unsigned,
Title varchar(30),
ExportDate date,
Format enum('PDF', 'CSV', 'Excel') not null,
StartDate date not null,
EndDate date not null,
PRIMARY KEY (ReportId),
CONSTRAINT fk16
               FOREIGN KEY (AdminId) REFERENCES Admin(AdminId)
                 ON UPDATE CASCADE
                 ON DELETE SET NULL
);




CREATE TABLE StudentFeedback(
FeedbackSubmissionId int unsigned not null,
DietaryRestriction enum('vegan','vegetarian','pescatarian', 'gluten-free', 'halal','kosher','dairy-free','nut-free','egg-free'),
HallId int unsigned,
Content mediumtext,
SubmittedDate date not null,
Status enum('positive', 'negative', 'neutral') not null,
CuisinePref enum('Italian', 'Chinese', 'Mexican', 'Mediterranean', 'Indian', 'Fusion', 'American', 'Other') not null,
StudentId int unsigned,
PRIMARY KEY (FeedbackSubmissionId),
INDEX (SubmittedDate),
INDEX (Status),
CONSTRAINT fk17
                 FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                          ON UPDATE CASCADE
                          ON DELETE CASCADE,
CONSTRAINT fk19
                 FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
                          ON UPDATE CASCADE
                          ON DELETE SET NULL
);




CREATE TABLE DiningStation(
StationId int unsigned not null,
HallId int unsigned,
ItemId int unsigned,
Name varchar(30) not null,
WaitMinutes int unsigned not null,
UpdatedAt datetime default current_timestamp not null,
PRIMARY KEY (StationId),
CONSTRAINT fk20
                FOREIGN KEY (HallId) REFERENCES DiningHall(HallId)
                        ON UPDATE CASCADE
                        ON DELETE CASCADE,
CONSTRAINT fk21
                FOREIGN KEY (ItemId) REFERENCES MenuItem(ItemId)
                        ON UPDATE CASCADE
                        ON DELETE CASCADE
);




CREATE TABLE MenuItemAllergen(
ItemId int unsigned not null,
AllergenId int unsigned not null,
PRIMARY KEY (ItemId, AllergenId),
CONSTRAINT fk22
                FOREIGN KEY (ItemId) REFERENCES MenuItem(ItemId)
                           ON UPDATE CASCADE
                           ON DELETE CASCADE,
CONSTRAINT fk23
                FOREIGN KEY (AllergenId) REFERENCES Allergen(AllergenId)
                           ON UPDATE CASCADE
                           ON DELETE RESTRICT
);


CREATE TABLE StudentAllergen(
   StudentId int unsigned not null,
   AllergenId int unsigned not null,
   PRIMARY KEY (StudentId, AllergenId),
   CONSTRAINT fk24
       FOREIGN KEY (StudentId) REFERENCES Student(StudentId)
                ON UPDATE CASCADE
                ON DELETE RESTRICT,
   CONSTRAINT fk25
                FOREIGN KEY (AllergenId) REFERENCES Allergen(AllergenId)
                           ON UPDATE CASCADE
                           ON DELETE RESTRICT
);
