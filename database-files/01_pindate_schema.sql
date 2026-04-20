DROP DATABASE IF EXISTS pindate;
CREATE DATABASE IF NOT EXISTS pindate;
USE pindate;


CREATE TABLE Users (
   accountId   INT             NOT NULL AUTO_INCREMENT,
   email       VARCHAR(255)    NOT NULL UNIQUE,
   pwdHash     VARCHAR(255)    NOT NULL,
   firstName   VARCHAR(100)    NOT NULL,
   lastName    VARCHAR(100)    NOT NULL,
   username    VARCHAR(100)    NOT NULL UNIQUE,
   phoneNum    VARCHAR(20),
   city        VARCHAR(100),
   role        VARCHAR(50)     NOT NULL DEFAULT 'CUSTOMER',
   createdAt   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (accountId),
   CONSTRAINT chk_account_role CHECK (role IN ('CUSTOMER', 'VENUE_OWNER', 'ADMIN', 'DATA_ANALYST'))
);




CREATE TABLE Category (
   categoryId  INT             NOT NULL AUTO_INCREMENT,
   name        VARCHAR(100)    NOT NULL UNIQUE,
   PRIMARY KEY (categoryId)
);





CREATE TABLE Vibe (
   vibeId      INT             NOT NULL AUTO_INCREMENT,
   name        VARCHAR(100)    NOT NULL UNIQUE,
   PRIMARY KEY (vibeId)
);







CREATE TABLE Venues (
   venueId     INT             NOT NULL AUTO_INCREMENT,
   ownerId     INT,
   name        VARCHAR(255)    NOT NULL,
   description TEXT,
   address     VARCHAR(255)    NOT NULL,
   city        VARCHAR(100)    NOT NULL,
   phoneNum    VARCHAR(20),
   rating      NUMERIC(3, 2),
   minPrice    NUMERIC(10, 2),
   maxPrice    NUMERIC(10, 2),
   PRIMARY KEY (venueId),
   CONSTRAINT chk_venue_rating CHECK (rating >= 0 AND rating <= 5),
   CONSTRAINT chk_venue_price  CHECK (minPrice <= maxPrice),
   CONSTRAINT fk_venue_owner   FOREIGN KEY (ownerId) REFERENCES Users(accountId)
);




CREATE TABLE VenueCategory (
   venueId     INT             NOT NULL,
   categoryId  INT             NOT NULL,
   PRIMARY KEY (venueId, categoryId),
   CONSTRAINT fk_venuecategory_venue     FOREIGN KEY (venueId)    REFERENCES Venues(venueId),
   CONSTRAINT fk_venuecategory_category  FOREIGN KEY (categoryId) REFERENCES Category(categoryId)
);




CREATE TABLE VenueVibe (
   venueId     INT             NOT NULL,
   vibeId      INT             NOT NULL,
   PRIMARY KEY (venueId, vibeId),
   CONSTRAINT fk_venuevibe_venue FOREIGN KEY (venueId) REFERENCES Venues(venueId),
   CONSTRAINT fk_venuevibe_vibe  FOREIGN KEY (vibeId)  REFERENCES Vibe(vibeId)
);




CREATE TABLE Reviews (
   reviewId    INT             NOT NULL AUTO_INCREMENT,
   userId      INT             NOT NULL,
   venueId     INT             NOT NULL,
   comment     TEXT,
   rating      NUMERIC(3, 2)   NOT NULL,
   isFlagged   BOOLEAN         NOT NULL DEFAULT FALSE,
   createdAt   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (reviewId),
   CONSTRAINT chk_review_rating CHECK (rating >= 0 AND rating <= 5),
   CONSTRAINT fk_review_user    FOREIGN KEY (userId)  REFERENCES Users(accountId),
   CONSTRAINT fk_review_venue   FOREIGN KEY (venueId) REFERENCES Venues(venueId)
);




CREATE TABLE Posts (
   postId      INT             NOT NULL AUTO_INCREMENT,
   ownerId     INT             NOT NULL,
   venueId     INT             NOT NULL,
   content     TEXT            NOT NULL,
   postDate    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (postId),
   CONSTRAINT fk_post_owner FOREIGN KEY (ownerId) REFERENCES Users(accountId),
   CONSTRAINT fk_post_venue FOREIGN KEY (venueId) REFERENCES Venues(venueId)
);




CREATE TABLE Lists (
   listId      INT             NOT NULL AUTO_INCREMENT,
   userId      INT             NOT NULL,
   name        VARCHAR(255)    NOT NULL,
   PRIMARY KEY (listId),
   CONSTRAINT fk_list_user FOREIGN KEY (userId) REFERENCES Users(accountId)
);




CREATE TABLE ListVenue (
   listId      INT             NOT NULL,
   venueId     INT             NOT NULL,
   PRIMARY KEY (listId, venueId),
   CONSTRAINT fk_listvenue_list  FOREIGN KEY (listId)  REFERENCES Lists(listId),
   CONSTRAINT fk_listvenue_venue FOREIGN KEY (venueId) REFERENCES Venues(venueId)
);




CREATE TABLE SavedVenues (
   userId      INT             NOT NULL,
   venueId     INT             NOT NULL,
   savedAt     TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (userId, venueId),
   CONSTRAINT fk_savedvenues_user  FOREIGN KEY (userId)  REFERENCES Users(accountId),
   CONSTRAINT fk_savedvenues_venue FOREIGN KEY (venueId) REFERENCES Venues(venueId)
);




CREATE TABLE VenueApplications (
   applicationId   INT             NOT NULL AUTO_INCREMENT,
   ownerId         INT,
   name            VARCHAR(255)    NOT NULL,
   description     TEXT,
   address         VARCHAR(255)    NOT NULL,
   phone           VARCHAR(20),
   minPrice        NUMERIC(10, 2),
   maxPrice        NUMERIC(10, 2),
   createdAt       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
   status          VARCHAR(50)     NOT NULL DEFAULT 'PENDING',
   PRIMARY KEY (applicationId),
   CONSTRAINT chk_app_status CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
   CONSTRAINT chk_app_price  CHECK (minPrice <= maxPrice),
   CONSTRAINT fk_app_owner   FOREIGN KEY (ownerId) REFERENCES Users(accountId)
);




CREATE TABLE ReportTickets (
   reportId    INT             NOT NULL AUTO_INCREMENT,
   reporterId  INT,
   reviewId    INT,
   description TEXT,
   reason      VARCHAR(255)    NOT NULL,
   createdAt   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
   status      VARCHAR(50)     NOT NULL DEFAULT 'PENDING',
   PRIMARY KEY (reportId),
   CONSTRAINT chk_ticket_status  CHECK (status IN ('PENDING', 'UNDER REVIEW', 'RESOLVED', 'DISMISSED')),
   CONSTRAINT fk_report_reporter FOREIGN KEY (reporterId) REFERENCES Users(accountId),
   CONSTRAINT fk_report_review   FOREIGN KEY (reviewId)   REFERENCES Reviews(reviewId)
);




CREATE TABLE AdminLog (
   logId       INT             NOT NULL AUTO_INCREMENT,
   appId       INT,
   reportId    INT,
   adminId     INT             NOT NULL,
   action      VARCHAR(255)    NOT NULL,
   targetTable VARCHAR(100),
   targetId    INT,
   performedAt TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
   notes       TEXT,
   PRIMARY KEY (logId),
   CONSTRAINT fk_adminlog_app    FOREIGN KEY (appId)    REFERENCES VenueApplications(applicationId),
   CONSTRAINT fk_adminlog_report FOREIGN KEY (reportId) REFERENCES ReportTickets(reportId),
   CONSTRAINT fk_adminlog_admin  FOREIGN KEY (adminId)  REFERENCES Users(accountId)
);


-- INSERT INTO Users (email, pwdHash, firstName, lastName, username, phoneNum, city, role) VALUES
--    ('maya.chen@email.com',   'password', 'Maya',  'Chen',  'mayac',   '617-555-0101', 'Boston',    'CUSTOMER'),
--    ('james.park@email.com',  'password', 'James', 'Park',  'jpark99', '617-555-0102', 'Cambridge', 'CUSTOMER'),
--    ('sofia.reyes@email.com', 'password', 'Sofia', 'Reyes', 'sofiaar', '617-555-0103', 'Somerville','CUSTOMER');


-- -- Venue Owners (role = 'VENUE_OWNER')
-- INSERT INTO Users (email, pwdHash, firstName, lastName, username, phoneNum, role) VALUES
--    ('marcus.r@venues.com',    'password', 'Marcus', 'Rivera', 'marcusr_owner', '617-555-0201', 'VENUE_OWNER'),
--    ('priya.sharma@venues.com','password', 'Priya',  'Sharma', 'priyas_owner',  '617-555-0202', 'VENUE_OWNER'),
--    ('carlos.m@venues.com',    'password', 'Carlos', 'Mendez', 'carlosm_owner', '617-555-0203', 'VENUE_OWNER');


-- -- Admins (role = 'ADMIN')
-- INSERT INTO Users (email, pwdHash, firstName, lastName, username, role) VALUES
--    ('admin1@pindate.com', 'password', 'Josh', 'Doe',    'joshd_admin', 'ADMIN'),
--    ('admin2@pindate.com', 'password', 'Tom',  'Nguyen', 'tomn_admin',  'ADMIN');


-- -- Data Analysts (role = 'DATA_ANALYST')
-- INSERT INTO Users (email, pwdHash, firstName, lastName, username, phoneNum, city, role) VALUES
--    ('analyst1@pindate.com', 'password', 'Nadia',  'Patel', 'nadiap_data', '617-555-0501', 'Boston',    'DATA_ANALYST'),
--    ('analyst2@pindate.com', 'password', 'Marcus', 'Owens', 'marcuso_da',  '617-555-0502', 'Cambridge', 'DATA_ANALYST');




-- INSERT INTO Venues (ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) VALUES
--    (4, 'Rooftop Lantern',    'A rooftop bar with stunning Boston skyline views.',        '123 High St', 'Boston',    '617-555-0301', 4.50, 20.00, 80.00),
--    (5, 'The Cozy Corner',    'A warm cafe perfect for intimate dates and great coffee.', '456 Elm Ave',  'Cambridge', '617-555-0302', 4.20,  5.00, 30.00),
--    (6, 'Neon Arcade Lounge', 'Retro arcade games paired with craft cocktails.',          '789 Main St', 'Somerville','617-555-0303', 4.70, 10.00, 50.00),
--    (4, 'Harbor House Rooftop', 'Waterfront dining with skyline views and date-night menus.', '18 Seaport Blvd', 'Boston', '617-555-0304', 4.80, 25.00, 90.00),
--    (5, 'Velvet Hour',          'A moody lounge with craft drinks, live music, and plush seating.', '27 Brattle St', 'Cambridge', '617-555-0305', 4.60, 15.00, 75.00),
--    (6, 'Greenline Garden',     'A laid-back park cafe for coffee walks, picnics, and sunset hangs.', '91 Somerville Ave', 'Somerville', '617-555-0306', 4.30,  8.00, 35.00);


-- INSERT INTO VenueCategory (venueId, categoryId) VALUES
--    (1, 2), (1, 10), (2, 3), (3, 9), (3, 4),
--    (4, 1), (4, 10), (5, 2), (5, 4), (6, 3), (6, 6);


-- INSERT INTO VenueVibe (venueId, vibeId) VALUES
--    (1, 1), (1, 3), (2, 4), (2, 10), (3, 5), (3, 7),
--    (4, 1), (4, 3), (5, 9), (5, 10), (6, 2), (6, 6);


-- INSERT INTO Reviews (userId, venueId, comment, rating, isFlagged) VALUES
--    (1, 1, 'Absolutely stunning views, perfect for a date night!',        4.80, FALSE),
--    (2, 2, 'Such a cozy spot. The lattes are amazing.',                   4.20, FALSE),
--    (3, 3, 'So much fun — the retro games made the night unforgettable.', 4.70, FALSE),
--    (1, 4, 'The waterfront view and menu make this an easy yes for a special night out.', 4.60, FALSE),
--    (2, 5, 'A polished lounge with great cocktails and just enough energy for a first date.', 4.40, FALSE),
--    (3, 6, 'Relaxed, walkable, and perfect for a coffee date that can turn into a picnic.', 4.10, FALSE);


-- INSERT INTO Posts (ownerId, venueId, content) VALUES
--    (4, 1, 'Join us this Friday for live jazz under the stars! Reserve your table now.'),
--    (5, 2, 'New seasonal menu is here — try our maple oat latte while it lasts!'),
--    (6, 3, 'Double tokens every Tuesday night. Bring your date for double the fun!'),
--    (4, 4, 'Sunset seating is now open on the rooftop patio.'),
--    (5, 5, 'Live acoustic sets every Thursday at Velvet Hour.'),
--    (6, 6, 'Morning coffee and weekend picnic baskets are back.');


-- INSERT INTO Lists (userId, name) VALUES
--    (1, 'Dream Date Spots'),
--    (2, 'Boston Favorites'),
--    (3, 'Weekend Plans');


-- INSERT INTO ListVenue (listId, venueId) VALUES
--    (1, 1), (1, 2), (1, 4), (2, 3), (2, 5), (3, 1), (3, 6);


-- INSERT INTO SavedVenues (userId, venueId) VALUES
--    (1, 3), (1, 4), (2, 1), (2, 5), (3, 2), (3, 6);


-- INSERT INTO VenueApplications (ownerId, name, description, address, phone, minPrice, maxPrice, status) VALUES
--    (4, 'Sky Garden',   'An outdoor terrace dining experience.',     '321 Cloud Blvd, Boston, MA',     '617-555-0401', 30.00, 100.00, 'PENDING'),
--    (5, 'Brew & Books', 'A bookstore cafe hybrid with craft beers.', '654 Page St, Cambridge, MA',     '617-555-0402',  8.00,  40.00, 'APPROVED'),
--    (6, 'Pixel Palace', 'Next-gen VR arcade and bar.',               '987 Circuit Ave, Somerville, MA','617-555-0403', 15.00,  60.00, 'REJECTED');


-- INSERT INTO ReportTickets (reporterId, reviewId, description, reason, status) VALUES
--    (2, 1,    'This review seems fake and overly promotional.', 'Suspected fake review', 'PENDING'),
--    (3, 2,    'Review contains inappropriate language.',        'Inappropriate content', 'RESOLVED'),
--    (1, NULL, 'Venue owner sent unsolicited messages.',         'Harassment',            'RESOLVED');


-- INSERT INTO AdminLog (appId, reportId, adminId, action, targetTable, targetId, notes) VALUES
--    (2,    NULL, 7, 'APPROVED_APPLICATION', 'VenueApplications', 2, 'All documents verified, application looks legitimate.'),
--    (3,    NULL, 8, 'REJECTED_APPLICATION', 'VenueApplications', 3, 'Location not within supported service area.'),
--    (NULL, 1,    7, 'FLAGGED_REVIEW',       'Reviews',           1, 'Flagged for further investigation by moderation team.');




-- USER DATA --
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (1, 'veric0@instagram.com', '$2a$04$icstuqnvYDwVmkemvHN7.OUfy8mW.42lUK7VIfmhXcCbIuE342XM.', 'Veriee', 'Eric', 'veric0', '796-286-1692', 'Monastirákion', 'CUSTOMER', '2026-04-10 04:14:03');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (2, 'plahive1@tripod.com', '$2a$04$9QKRMvijogpjoeq0zavkheiAaAqWNftewgKbpwtQvAcnsCCcuGzEC', 'Pegeen', 'Lahive', 'plahive1', '938-290-4027', 'Sitovo', 'CUSTOMER', '2025-08-18 09:53:11');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (3, 'nwither2@simplemachines.org', '$2a$04$tHRzagJtZHnaufmHqLOv0e0rBiZJwZ8bIw/AhroWabNeMmvz4qo7e', 'Nikolia', 'Wither', 'nwither2', '536-888-1022', 'Matamey', 'VENUE_OWNER', '2025-05-31 10:33:58');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (4, 'bcolwill3@ftc.gov', '$2a$04$UDCNQPm7Bw60Ur8rkiHchuSgZA/I14PUWPLr1Q6Vrrd.IVOmxxmy2', 'Barb', 'Colwill', 'bcolwill3', '386-830-9850', 'Villa Carlos Paz', 'ADMIN', '2026-03-22 11:16:38');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (5, 'kwillden4@intel.com', '$2a$04$lHK0Gu.6Bi14hP..fwaicundjxovk3BjS8xR7Z0LY1K0XguYWYzkC', 'Kearney', 'Willden', 'kwillden4', '254-489-6701', 'Sūrīān', 'DATA_ANALYST', '2025-09-27 08:24:16');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (6, 'rpolglase5@hexun.com', '$2a$04$ef3yRYeW9LUsMlKY712STeXW7bHBysvBavQHlMPQ3./PgLDqXiFQa', 'Ricky', 'Polglase', 'rpolglase5', '386-636-8927', 'Sindangrasa', 'CUSTOMER', '2025-11-04 01:59:30');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (7, 'dpeskin6@cargocollective.com', '$2a$04$e7o4isGFE38KKxFKcp9.7u0o.1LoLkoBlJ1H7ltidrOJGk.zvnmPa', 'Dominica', 'Peskin', 'dpeskin6', '467-136-9548', 'Novaya Tavolzhanka', 'CUSTOMER', '2025-11-22 18:14:15');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (8, 'nmoline7@washingtonpost.com', '$2a$04$V352ubh2MjozIf5r.GSBKeuwJZ8XsbCdR89gXndny8k9esruQPl8y', 'Newton', 'Moline', 'nmoline7', '100-634-2979', 'San Luis Ixcán', 'VENUE_OWNER', '2026-01-19 15:42:02');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (9, 'hflea8@oracle.com', '$2a$04$D38ICjqjA5j9kIet2oPYx.2GZ/hSCYA4Kg.4f3xOBHySGlvi5v6pG', 'Horatius', 'Flea', 'hflea8', '251-497-4732', 'Sipoholon', 'ADMIN', '2025-06-22 03:57:37');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (10, 'achester9@examiner.com', '$2a$04$yw0IbVE64/Fv/QLdoD9LKOm62YLN1k3gRTCpUE.vNY7swhopl2PP2', 'Audi', 'Chester', 'achester9', '552-285-6727', 'Gandorhun', 'DATA_ANALYST', '2026-03-29 13:17:11');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (11, 'tnenda@tiny.cc', '$2a$04$MilI.2Tzq0dBchECYGf7KewAtsQyEGpDPfYGWyRBEaRMY.F3gw.w2', 'Thomasina', 'Nend', 'tnenda', '519-978-0026', 'Namwala', 'CUSTOMER', '2025-04-26 05:05:42');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (12, 'smckelveyb@hubpages.com', '$2a$04$ohwY8z8A73i0LvmXlcV0JeD52ENGFLKHh4NbK2nzYnE1/aYa7DCmG', 'Shaw', 'McKelvey', 'smckelveyb', '394-867-2925', 'Grigoropolisskaya', 'CUSTOMER', '2025-05-16 10:00:47');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (13, 'fentisslec@microsoft.com', '$2a$04$L30dx4/TRRNt7zh.rLepQ.tSLgSahWLOVbpryOiA/sNCKCM97o3li', 'Field', 'Entissle', 'fentisslec', '896-868-7424', 'Gataivai', 'VENUE_OWNER', '2025-12-06 10:56:11');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (14, 'kresund@amazon.de', '$2a$04$bGJyABrzvrkM5l96yN1mEu8Orm0g461HJW75fcoFag7D6jbwOl48G', 'Kial', 'Resun', 'kresund', '614-393-9012', 'Jesenice', 'ADMIN', '2025-09-19 14:35:17');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (15, 'bcrockleye@freewebs.com', '$2a$04$F5UdrMzyiX0E4FJ04T/6ZeNXvfC2e5Kv5p1pllmRLzwYJ7aOTZcJm', 'Bobbie', 'Crockley', 'bcrockleye', '910-250-3583', 'Gambang', 'DATA_ANALYST', '2025-09-16 21:18:08');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (16, 'jminorsf@tuttocitta.it', '$2a$04$MMGtjxY7ODHKtrVtvwc8ZeQeGx5/IYnmTIPrLLcam4l0mPPG9HEam', 'Juli', 'Minors', 'jminorsf', '497-932-9355', 'Del Pilar', 'CUSTOMER', '2025-12-05 13:18:35');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (17, 'bzanicchig@phoca.cz', '$2a$04$2KDmnRzilEdgVpowpUfX0eqtHf2OS.AePgaOeulAQ2dsKgJjUvXeK', 'Bathsheba', 'Zanicchi', 'bzanicchig', '414-129-9491', 'Hukeng', 'CUSTOMER', '2025-07-14 00:47:27');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (18, 'ldonisih@technorati.com', '$2a$04$aqcujjkD/8jhVTjOy8L19..OSMHHJOFzDjt3SDZJHC0Z0QDWwFNhu', 'Libbi', 'Donisi', 'ldonisih', '364-765-3080', 'Darband', 'VENUE_OWNER', '2025-09-27 08:54:39');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (19, 'kshowelli@aol.com', '$2a$04$GQTSNxeUK.7bGd4TKBZnn.8Spkwc21pDYkwZtQRPyncWolNQDFW.e', 'Konrad', 'Showell', 'kshowelli', '444-379-5476', 'Oetuke', 'ADMIN', '2025-04-22 15:50:52');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (20, 'fmadginj@example.com', '$2a$04$Q4QFEMvDv1HAbNMulTIf8uWY7IYi.s7ES/HHMdBmbSCmx.Il0buQW', 'Ferdy', 'Madgin', 'fmadginj', '296-164-4655', 'Gunungkendeng', 'DATA_ANALYST', '2025-10-14 11:49:11');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (21, 'bbroddlek@youku.com', '$2a$04$T1GtnXLTxEZF.XQLcJJ9m.gWwB5LJUv4EB6FCSdFbyMQ9MAp06eoK', 'Bendix', 'Broddle', 'bbroddlek', '156-543-6522', 'Fenglin', 'CUSTOMER', '2025-09-04 23:27:46');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (22, 'cderingl@yelp.com', '$2a$04$EE.KSULwb4eFQwMpShUeYOw8K.MH.u8zMZBWEs4K/KJqkWlOJHT96', 'Charmion', 'Dering', 'cderingl', '994-579-6851', 'Sikur', 'CUSTOMER', '2026-02-10 13:18:44');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (23, 'ptuttiettm@amazon.de', '$2a$04$HSXG7Tu1UblQ50N.C4yprOMwHW8x6BK8dIXjkZrBCRcshVlv0gQY6', 'Pedro', 'Tuttiett', 'ptuttiettm', '364-458-7806', 'Wangi', 'VENUE_OWNER', '2025-06-27 07:47:52');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (24, 'pwoolfootn@wiley.com', '$2a$04$8ZfnpcxsYjAUdjnFmpobZew/swVrXBNUvZKVbsmoVzUbr4oCOVd0G', 'Prudence', 'Woolfoot', 'pwoolfootn', '843-208-2921', 'Xianyuan', 'ADMIN', '2026-02-05 19:26:22');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (25, 'ctrowsdallo@smugmug.com', '$2a$04$TDOr3hQoaI48TuZt.1KmjOxba1e3rJzccYOJAzJQnK7D6gpe89AQO', 'Constance', 'Trowsdall', 'ctrowsdallo', '739-891-3582', 'Shīnḏanḏ', 'DATA_ANALYST', '2025-08-04 20:34:06');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (26, 'jhouseleyp@exblog.jp', '$2a$04$lohO0oab5xCKgsIo4xRGiOYe.M20/PBqHMPIpEM9qowAtgRpqmCgy', 'Jenifer', 'Houseley', 'jhouseleyp', '479-782-9927', 'Hucun', 'CUSTOMER', '2025-08-05 20:10:21');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (27, 'idunsireq@ucoz.ru', '$2a$04$lOk07SoFlRq/HT8FDSs5z.Bj0oMrecqwia4Ei7JGqg.H1gGhVKvXy', 'Ira', 'Dunsire', 'idunsireq', '658-290-3339', 'Gumalang', 'CUSTOMER', '2026-01-14 06:12:14');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (28, 'htwiddyr@nydailynews.com', '$2a$04$bRYLW.fBHqxTUzsTauVQc.6.vJ1/CYKeTh6suR6HYfPzt/h8QKQW.', 'Haleigh', 'Twiddy', 'htwiddyr', '529-893-0958', 'Kamień Pomorski', 'VENUE_OWNER', '2025-06-27 09:50:04');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (29, 'usemerads@wisc.edu', '$2a$04$QS4N.jIDxMWkeLyWvzyE.OSqZHVgdwvQi9Oh1QuduusKIj6ih7oQm', 'Ulla', 'Semerad', 'usemerads', '404-481-2440', 'Gorē', 'ADMIN', '2026-02-19 04:01:37');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (30, 'esmallmant@cnbc.com', '$2a$04$vmp7jsBsrZdhhtmK6SYRUu5TBr6QvIyT0Espblj6T/pU5XZhMYy66', 'Elyssa', 'Smallman', 'esmallmant', '702-756-2687', 'Velké Meziříčí', 'DATA_ANALYST', '2026-03-29 21:50:35');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (31, 'calcornu@npr.org', '$2a$04$vORG2q0DRUCyD8gYTXPrU.3VZcyJflZvULpKAQ.JzxzyWqMq0q8gG', 'Chariot', 'Alcorn', 'calcornu', '345-154-2180', 'Dahu', 'CUSTOMER', '2025-07-05 13:51:57');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (32, 'rmorganv@netscape.com', '$2a$04$dPh3LMbha.9S2ovPbvZTee79mNV47neheTrMNVRdPBfiH3PaWGQ1u', 'Roderick', 'Morgan', 'rmorganv', '667-704-6994', 'Bali', 'CUSTOMER', '2026-02-07 14:33:46');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (33, 'mjoistw@webs.com', '$2a$04$HIN0Kjb7HsNa8iQyU6WUi.075W9PLZe1JF1/8c68fOfZOys/CTBeC', 'Melli', 'Joist', 'mjoistw', '797-284-7488', 'Arjona', 'VENUE_OWNER', '2025-08-21 15:30:25');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (34, 'mhearfieldx@oaic.gov.au', '$2a$04$/W3eRBYTmXedqaDOUqlK/OAivPZye7WfIetT194V4yyRmSfnlkkLG', 'Moselle', 'Hearfield', 'mhearfieldx', '705-732-2837', 'Lyon', 'ADMIN', '2025-07-11 21:41:00');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (35, 'dmcilwainy@baidu.com', '$2a$04$GoeHWOiAaZWIQJWPfEZyde4I1HwtNVNSdQzawPsFvUnPeWe8n0b2e', 'Delcine', 'McIlwain', 'dmcilwainy', '421-699-5499', 'Carpina', 'DATA_ANALYST', '2025-07-07 13:20:28');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (36, 'apyburnz@hc360.com', '$2a$04$sZdK.30aklnOQQDKOryUh.N5j71BAHRJqhyjlBBN1KzVJDGvA94zu', 'Anatola', 'Pyburn', 'apyburnz', '532-216-4148', 'Andrézieux-Bouthéon', 'CUSTOMER', '2026-03-22 20:52:18');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (37, 'rstreather10@bloomberg.com', '$2a$04$sNsbS2kVQAeaIQp9Y//6teBd95bg5vOxlwFq5/RUJvjM2xEAxtvJi', 'Rolando', 'Streather', 'rstreather10', '373-734-3767', 'Anār Darah', 'CUSTOMER', '2025-08-17 09:25:08');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (38, 'wconklin11@army.mil', '$2a$04$O3jzhsht8InOs1.a8ThcMui2AFlfKoM2vnYalieQA4BF01kcsRBVK', 'Waylen', 'Conklin', 'wconklin11', '539-475-8425', 'Oslo', 'VENUE_OWNER', '2026-01-16 02:01:34');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (39, 'gcay12@wikimedia.org', '$2a$04$TI.cmlzRP0cz/m6buGo3l.jPXw6O4plxn/ZaCaPgKJ92oh3ghqB82', 'Garnet', 'Cay', 'gcay12', '786-115-5517', 'Stare Miasto', 'ADMIN', '2026-04-07 20:17:22');
insert into Users (accountId, email, pwdHash, firstName, lastName, username, phoneNum, city, role, createdAt) values (40, 'ddallewater13@a8.net', '$2a$04$mBROQMNgrwAs9Hm4SfF44en3xraH1DOMiuvKBtEOaIB4R9fM97eqm', 'Denni', 'Dallewater', 'ddallewater13', '321-941-9351', 'Turets-Bayary', 'DATA_ANALYST', '2025-07-13 06:35:06');

-- Venues -- 
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (1, 18, 'Heathcote and Sons', null, '191 Ridgeway Circle', 'Renhe', '872-217-3617', 0, 5, 62);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (2, 2, 'Denesik, Lemke and Bruen', 'Fusce consequat. Nulla nisl. Nunc nisl.', '5330 Sachs Pass', 'Sydney', '803-339-0586', 0, 18, 80);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (3, 18, 'Lindgren LLC', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '022 Arrowood Junction', 'Boden', null, 5, 50, 125);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (4, 40, 'White-Lang', 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', '45275 Crest Line Trail', 'Cipadung', '375-483-8048', 2, 9, 94);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (5, 1, 'Rippin-Koss', 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '1824 Eliot Trail', 'Pahārpur', '535-173-8096', 1, 29, 98);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (6, 36, 'Wiegand LLC', null, '678 Northfield Junction', 'Hehe', '334-420-1331', 3, 83, 181);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (7, 19, 'Kulas Inc', 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '0275 Buena Vista Circle', 'Lianhua', null, 4, 53, 146);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (8, 37, 'Romaguera, Leuschke and Bergnaum', null, '78 Oriole Hill', 'San Nicolás', '571-504-8501', 2, 48, 129);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (9, 11, 'Hayes Inc', null, '9 Forest Dale Circle', 'Xiongchi', '727-883-3941', 5, 48, 134);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (10, 8, 'Schuster, Kovacek and Wyman', 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '98 Moland Circle', 'Slantsy', '642-503-8369', 5, 72, 126);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (11, 35, 'Gleichner Group', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '204 Heath Parkway', 'Jiangdulu', '283-266-5271', 0, 92, 112);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (12, 30, 'Bergnaum Inc', 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '39 Oxford Junction', 'Balangiga', '686-618-5160', 0, 15, 111);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (13, 9, 'Goodwin Group', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '115 Sundown Point', 'Sekarjalak', '936-451-9776', 4, 90, 121);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (14, 31, 'Bogan Group', null, '2809 Blackbird Point', 'Matou', '599-928-0631', 0, 28, 60);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (15, 28, 'Walsh and Sons', null, '326 Lake View Park', 'Santo António da Charneca', null, 5, 62, 84);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (16, 4, 'Flatley and Sons', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '3 Schiller Alley', 'Cẩm Phả Mines', null, 5, 53, 69);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (17, 20, 'Lubowitz-Gulgowski', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '02 Johnson Street', 'Köln', null, 3, 68, 95);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (18, 3, 'Jacobson, O''Kon and Lueilwitz', null, '33834 Hollow Ridge Place', 'Poitiers', '339-100-9761', 5, 19, 109);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (19, 28, 'Labadie-Leffler', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '90858 International Street', 'Saratak', '411-225-4451', 2, 36, 54);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (20, 10, 'Turcotte Inc', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '1309 Arrowood Street', 'Parada de Pinhão', null, 2, 79, 96);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (21, 21, 'Lind Inc', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '09 Leroy Center', 'Xuanbao', '896-714-2980', 3, 6, 87);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (22, 14, 'Krajcik Inc', null, '016 Brown Crossing', 'Armanāz', '761-676-6839', 0, 81, 154);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (23, 33, 'Wolf Inc', null, '672 Mariners Cove Street', 'Qixia', '346-991-6812', 1, 36, 77);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (24, 34, 'Parisian-VonRueden', null, '33717 Dottie Plaza', 'Beberibe', '699-675-3840', 1, 50, 98);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (25, 22, 'Sawayn and Sons', null, '92426 Corry Junction', 'Fort Pierce', '772-758-1833', 4, 16, 97);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (26, 29, 'Heaney-Bogan', 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', '5570 Corben Place', 'Pakokku', '511-139-2209', 1, 85, 130);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (27, 38, 'Denesik, Grant and Hand', null, '09559 Hanson Terrace', 'Yishui', '295-195-4815', 0, 54, 90);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (28, 32, 'Botsford and Sons', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '28 Declaration Lane', 'Long Beach', '310-950-8251', 5, 67, 118);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (29, 15, 'Schultz-Moore', 'Duis bibendum. Morbi non quam nec dui luctus rutrum. Nulla tellus.', '78942 Warrior Lane', 'Starcevica', '869-417-0778', 0, 24, 94);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (30, 5, 'Breitenberg and Sons', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', '35 Farmco Alley', 'Lautoka', '329-771-2870', 0, 62, 76);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (31, 8, 'Streich-Grimes', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '871 Maryland Crossing', 'Taoyuan', null, 0, 27, 70);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (32, 11, 'Jacobs, Frami and Oberbrunner', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '4030 Corry Avenue', 'Duqiao', '509-664-7565', 4, 62, 151);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (33, 23, 'Hirthe, Jacobs and Johnson', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', '6 Summit Way', 'Pudoc', '588-513-9276', 1, 38, 89);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (34, 31, 'Reilly Group', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2087 Barby Court', 'Quivilla', null, 2, 60, 142);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (35, 10, 'O''Keefe-Russel', null, '3760 Holmberg Parkway', 'Dmitriyevka', '547-471-0893', 4, 72, 112);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (36, 10, 'Kessler, Leffler and Rogahn', 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', '84 Summit Terrace', 'Tarqūmyā', '161-275-1904', 1, 40, 65);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (37, 12, 'Lind-Blick', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '9850 Johnson Street', 'Kilinochchi', '123-949-9388', 0, 8, 17);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (38, 8, 'Kertzmann LLC', null, '300 Kings Junction', 'Linchen', '886-562-3211', 1, 47, 100);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (39, 28, 'Lynch Inc', null, '1 Sugar Parkway', 'Wyszków', null, 3, 92, 175);
insert into Venues (venueId, ownerId, name, description, address, city, phoneNum, rating, minPrice, maxPrice) values (40, 27, 'Wiza Inc', null, '3328 Cordelia Plaza', 'Maloye Verevo', null, 4, 88, 102);

-- Categories --
INSERT INTO Category (name) VALUES
   ('Restaurant'), ('Bar'), ('Cafe'), ('Lounge'), ('Club'),
   ('Park'), ('Museum'), ('Theater'), ('Arcade'), ('Rooftop');

-- Vibes --
INSERT INTO Vibe (name) VALUES
   ('Romantic'), ('Casual'), ('Upscale'), ('Cozy'), ('Lively'),
   ('Chill'), ('Adventurous'), ('Artsy'), ('Trendy'), ('Intimate');

-- Venue Categories --
insert into VenueCategory (venueId, categoryId) values (36, 4);
insert into VenueCategory (venueId, categoryId) values (24, 9);
insert into VenueCategory (venueId, categoryId) values (20, 1);
insert into VenueCategory (venueId, categoryId) values (14, 4);
insert into VenueCategory (venueId, categoryId) values (14, 2);
insert into VenueCategory (venueId, categoryId) values (10, 9);
insert into VenueCategory (venueId, categoryId) values (26, 1);
insert into VenueCategory (venueId, categoryId) values (2, 2);
insert into VenueCategory (venueId, categoryId) values (13, 8);
insert into VenueCategory (venueId, categoryId) values (27, 6);
insert into VenueCategory (venueId, categoryId) values (36, 8);
insert into VenueCategory (venueId, categoryId) values (30, 9);
insert into VenueCategory (venueId, categoryId) values (3, 1);
insert into VenueCategory (venueId, categoryId) values (18, 2);
insert into VenueCategory (venueId, categoryId) values (30, 3);
insert into VenueCategory (venueId, categoryId) values (15, 3);
insert into VenueCategory (venueId, categoryId) values (11, 2);
insert into VenueCategory (venueId, categoryId) values (37, 6);
insert into VenueCategory (venueId, categoryId) values (29, 4);
insert into VenueCategory (venueId, categoryId) values (3, 10);
insert into VenueCategory (venueId, categoryId) values (40, 10);
insert into VenueCategory (venueId, categoryId) values (11, 10);
insert into VenueCategory (venueId, categoryId) values (33, 2);
insert into VenueCategory (venueId, categoryId) values (4, 6);
insert into VenueCategory (venueId, categoryId) values (6, 10);
insert into VenueCategory (venueId, categoryId) values (38, 5);
insert into VenueCategory (venueId, categoryId) values (32, 5);
insert into VenueCategory (venueId, categoryId) values (9, 8);
insert into VenueCategory (venueId, categoryId) values (18, 5);
insert into VenueCategory (venueId, categoryId) values (11, 1);
insert into VenueCategory (venueId, categoryId) values (26, 10);
insert into VenueCategory (venueId, categoryId) values (18, 6);
insert into VenueCategory (venueId, categoryId) values (21, 3);
insert into VenueCategory (venueId, categoryId) values (1, 9);
insert into VenueCategory (venueId, categoryId) values (25, 4);
insert into VenueCategory (venueId, categoryId) values (36, 10);
insert into VenueCategory (venueId, categoryId) values (33, 9);
insert into VenueCategory (venueId, categoryId) values (18, 7);
insert into VenueCategory (venueId, categoryId) values (27, 10);
insert into VenueCategory (venueId, categoryId) values (34, 9);
insert into VenueCategory (venueId, categoryId) values (34, 8);
insert into VenueCategory (venueId, categoryId) values (32, 4);
insert into VenueCategory (venueId, categoryId) values (38, 3);
insert into VenueCategory (venueId, categoryId) values (3, 9);
insert into VenueCategory (venueId, categoryId) values (17, 4);
insert into VenueCategory (venueId, categoryId) values (35, 5);
insert into VenueCategory (venueId, categoryId) values (38, 8);
insert into VenueCategory (venueId, categoryId) values (37, 2);
insert into VenueCategory (venueId, categoryId) values (33, 10);
insert into VenueCategory (venueId, categoryId) values (23, 10);
insert into VenueCategory (venueId, categoryId) values (23, 6);
insert into VenueCategory (venueId, categoryId) values (20, 4);
insert into VenueCategory (venueId, categoryId) values (32, 1);
insert into VenueCategory (venueId, categoryId) values (13, 1);
insert into VenueCategory (venueId, categoryId) values (28, 1);
insert into VenueCategory (venueId, categoryId) values (31, 10);
insert into VenueCategory (venueId, categoryId) values (38, 2);
insert into VenueCategory (venueId, categoryId) values (6, 9);
insert into VenueCategory (venueId, categoryId) values (14, 1);
insert into VenueCategory (venueId, categoryId) values (20, 8);
insert into VenueCategory (venueId, categoryId) values (16, 7);
insert into VenueCategory (venueId, categoryId) values (31, 9);
insert into VenueCategory (venueId, categoryId) values (6, 3);
insert into VenueCategory (venueId, categoryId) values (20, 3);
insert into VenueCategory (venueId, categoryId) values (3, 3);
insert into VenueCategory (venueId, categoryId) values (3, 6);
insert into VenueCategory (venueId, categoryId) values (8, 8);
insert into VenueCategory (venueId, categoryId) values (9, 3);
insert into VenueCategory (venueId, categoryId) values (20, 10);
insert into VenueCategory (venueId, categoryId) values (19, 6);
insert into VenueCategory (venueId, categoryId) values (35, 2);
insert into VenueCategory (venueId, categoryId) values (35, 9);
insert into VenueCategory (venueId, categoryId) values (5, 7);
insert into VenueCategory (venueId, categoryId) values (11, 9);
insert into VenueCategory (venueId, categoryId) values (22, 1);
insert into VenueCategory (venueId, categoryId) values (16, 4);
insert into VenueCategory (venueId, categoryId) values (27, 4);
insert into VenueCategory (venueId, categoryId) values (40, 1);
insert into VenueCategory (venueId, categoryId) values (12, 10);
insert into VenueCategory (venueId, categoryId) values (33, 6);
insert into VenueCategory (venueId, categoryId) values (37, 1);
insert into VenueCategory (venueId, categoryId) values (21, 1);
insert into VenueCategory (venueId, categoryId) values (5, 1);
insert into VenueCategory (venueId, categoryId) values (34, 2);
insert into VenueCategory (venueId, categoryId) values (5, 8);
insert into VenueCategory (venueId, categoryId) values (36, 7);
insert into VenueCategory (venueId, categoryId) values (3, 5);
insert into VenueCategory (venueId, categoryId) values (14, 9);
insert into VenueCategory (venueId, categoryId) values (8, 4);
insert into VenueCategory (venueId, categoryId) values (34, 1);
insert into VenueCategory (venueId, categoryId) values (17, 10);
insert into VenueCategory (venueId, categoryId) values (4, 5);
insert into VenueCategory (venueId, categoryId) values (30, 2);
insert into VenueCategory (venueId, categoryId) values (25, 6);
insert into VenueCategory (venueId, categoryId) values (22, 5);
insert into VenueCategory (venueId, categoryId) values (26, 2);
insert into VenueCategory (venueId, categoryId) values (27, 8);
insert into VenueCategory (venueId, categoryId) values (35, 7);
insert into VenueCategory (venueId, categoryId) values (8, 3);
insert into VenueCategory (venueId, categoryId) values (30, 8);
insert into VenueCategory (venueId, categoryId) values (6, 1);
insert into VenueCategory (venueId, categoryId) values (31, 1);
insert into VenueCategory (venueId, categoryId) values (1, 5);
insert into VenueCategory (venueId, categoryId) values (34, 5);
insert into VenueCategory (venueId, categoryId) values (18, 10);
insert into VenueCategory (venueId, categoryId) values (10, 1);
insert into VenueCategory (venueId, categoryId) values (16, 10);
insert into VenueCategory (venueId, categoryId) values (2, 1);
insert into VenueCategory (venueId, categoryId) values (5, 3);
insert into VenueCategory (venueId, categoryId) values (9, 4);
insert into VenueCategory (venueId, categoryId) values (30, 5);
insert into VenueCategory (venueId, categoryId) values (40, 5);
insert into VenueCategory (venueId, categoryId) values (4, 1);
insert into VenueCategory (venueId, categoryId) values (18, 3);
insert into VenueCategory (venueId, categoryId) values (31, 4);
insert into VenueCategory (venueId, categoryId) values (7, 8);
insert into VenueCategory (venueId, categoryId) values (24, 4);
insert into VenueCategory (venueId, categoryId) values (39, 1);
insert into VenueCategory (venueId, categoryId) values (36, 2);
insert into VenueCategory (venueId, categoryId) values (23, 5);
insert into VenueCategory (venueId, categoryId) values (4, 8);
insert into VenueCategory (venueId, categoryId) values (19, 7);
insert into VenueCategory (venueId, categoryId) values (28, 9);
insert into VenueCategory (venueId, categoryId) values (4, 4);
insert into VenueCategory (venueId, categoryId) values (21, 10);
insert into VenueCategory (venueId, categoryId) values (24, 5);
insert into VenueCategory (venueId, categoryId) values (13, 2);

-- Venue Vibes --
insert into VenueVibe (venueId, vibeId) values (30, 7);
insert into VenueVibe (venueId, vibeId) values (38, 9);
insert into VenueVibe (venueId, vibeId) values (16, 9);
insert into VenueVibe (venueId, vibeId) values (23, 6);
insert into VenueVibe (venueId, vibeId) values (19, 1);
insert into VenueVibe (venueId, vibeId) values (12, 7);
insert into VenueVibe (venueId, vibeId) values (16, 4);
insert into VenueVibe (venueId, vibeId) values (27, 8);
insert into VenueVibe (venueId, vibeId) values (17, 4);
insert into VenueVibe (venueId, vibeId) values (13, 4);
insert into VenueVibe (venueId, vibeId) values (12, 5);
insert into VenueVibe (venueId, vibeId) values (13, 7);
insert into VenueVibe (venueId, vibeId) values (22, 4);
insert into VenueVibe (venueId, vibeId) values (3, 4);
insert into VenueVibe (venueId, vibeId) values (27, 3);
insert into VenueVibe (venueId, vibeId) values (22, 3);
insert into VenueVibe (venueId, vibeId) values (11, 7);
insert into VenueVibe (venueId, vibeId) values (23, 3);
insert into VenueVibe (venueId, vibeId) values (32, 6);
insert into VenueVibe (venueId, vibeId) values (31, 2);
insert into VenueVibe (venueId, vibeId) values (34, 8);
insert into VenueVibe (venueId, vibeId) values (28, 4);
insert into VenueVibe (venueId, vibeId) values (36, 4);
insert into VenueVibe (venueId, vibeId) values (29, 4);
insert into VenueVibe (venueId, vibeId) values (4, 8);
insert into VenueVibe (venueId, vibeId) values (35, 2);
insert into VenueVibe (venueId, vibeId) values (30, 6);
insert into VenueVibe (venueId, vibeId) values (6, 10);
insert into VenueVibe (venueId, vibeId) values (28, 2);
insert into VenueVibe (venueId, vibeId) values (33, 1);
insert into VenueVibe (venueId, vibeId) values (20, 5);
insert into VenueVibe (venueId, vibeId) values (40, 4);
insert into VenueVibe (venueId, vibeId) values (26, 5);
insert into VenueVibe (venueId, vibeId) values (16, 7);
insert into VenueVibe (venueId, vibeId) values (31, 1);
insert into VenueVibe (venueId, vibeId) values (2, 3);
insert into VenueVibe (venueId, vibeId) values (23, 8);
insert into VenueVibe (venueId, vibeId) values (5, 9);
insert into VenueVibe (venueId, vibeId) values (33, 9);
insert into VenueVibe (venueId, vibeId) values (39, 5);
insert into VenueVibe (venueId, vibeId) values (2, 8);
insert into VenueVibe (venueId, vibeId) values (35, 10);
insert into VenueVibe (venueId, vibeId) values (18, 7);
insert into VenueVibe (venueId, vibeId) values (22, 9);
insert into VenueVibe (venueId, vibeId) values (21, 9);
insert into VenueVibe (venueId, vibeId) values (11, 4);
insert into VenueVibe (venueId, vibeId) values (19, 9);
insert into VenueVibe (venueId, vibeId) values (6, 5);
insert into VenueVibe (venueId, vibeId) values (16, 2);
insert into VenueVibe (venueId, vibeId) values (26, 6);
insert into VenueVibe (venueId, vibeId) values (38, 3);
insert into VenueVibe (venueId, vibeId) values (23, 5);
insert into VenueVibe (venueId, vibeId) values (1, 5);
insert into VenueVibe (venueId, vibeId) values (21, 8);
insert into VenueVibe (venueId, vibeId) values (31, 3);
insert into VenueVibe (venueId, vibeId) values (16, 6);
insert into VenueVibe (venueId, vibeId) values (11, 6);
insert into VenueVibe (venueId, vibeId) values (15, 3);
insert into VenueVibe (venueId, vibeId) values (13, 10);
insert into VenueVibe (venueId, vibeId) values (22, 1);
insert into VenueVibe (venueId, vibeId) values (9, 7);
insert into VenueVibe (venueId, vibeId) values (34, 1);
insert into VenueVibe (venueId, vibeId) values (28, 7);
insert into VenueVibe (venueId, vibeId) values (16, 1);
insert into VenueVibe (venueId, vibeId) values (31, 9);
insert into VenueVibe (venueId, vibeId) values (5, 3);
insert into VenueVibe (venueId, vibeId) values (21, 3);
insert into VenueVibe (venueId, vibeId) values (3, 1);
insert into VenueVibe (venueId, vibeId) values (29, 9);
insert into VenueVibe (venueId, vibeId) values (28, 6);
insert into VenueVibe (venueId, vibeId) values (31, 10);
insert into VenueVibe (venueId, vibeId) values (11, 3);
insert into VenueVibe (venueId, vibeId) values (24, 3);
insert into VenueVibe (venueId, vibeId) values (25, 8);
insert into VenueVibe (venueId, vibeId) values (5, 6);
insert into VenueVibe (venueId, vibeId) values (8, 8);
insert into VenueVibe (venueId, vibeId) values (39, 2);
insert into VenueVibe (venueId, vibeId) values (39, 4);
insert into VenueVibe (venueId, vibeId) values (16, 5);
insert into VenueVibe (venueId, vibeId) values (1, 1);
insert into VenueVibe (venueId, vibeId) values (17, 9);
insert into VenueVibe (venueId, vibeId) values (35, 6);
insert into VenueVibe (venueId, vibeId) values (1, 7);
insert into VenueVibe (venueId, vibeId) values (30, 5);
insert into VenueVibe (venueId, vibeId) values (35, 4);
insert into VenueVibe (venueId, vibeId) values (36, 2);
insert into VenueVibe (venueId, vibeId) values (23, 10);
insert into VenueVibe (venueId, vibeId) values (3, 8);
insert into VenueVibe (venueId, vibeId) values (8, 3);
insert into VenueVibe (venueId, vibeId) values (38, 6);
insert into VenueVibe (venueId, vibeId) values (38, 4);
insert into VenueVibe (venueId, vibeId) values (5, 7);
insert into VenueVibe (venueId, vibeId) values (14, 9);
insert into VenueVibe (venueId, vibeId) values (24, 4);
insert into VenueVibe (venueId, vibeId) values (35, 5);
insert into VenueVibe (venueId, vibeId) values (25, 5);
insert into VenueVibe (venueId, vibeId) values (11, 9);
insert into VenueVibe (venueId, vibeId) values (37, 7);
insert into VenueVibe (venueId, vibeId) values (31, 7);
insert into VenueVibe (venueId, vibeId) values (29, 2);
insert into VenueVibe (venueId, vibeId) values (19, 8);
insert into VenueVibe (venueId, vibeId) values (5, 1);
insert into VenueVibe (venueId, vibeId) values (1, 2);
insert into VenueVibe (venueId, vibeId) values (30, 8);
insert into VenueVibe (venueId, vibeId) values (17, 10);
insert into VenueVibe (venueId, vibeId) values (9, 3);
insert into VenueVibe (venueId, vibeId) values (4, 10);
insert into VenueVibe (venueId, vibeId) values (27, 7);
insert into VenueVibe (venueId, vibeId) values (38, 10);
insert into VenueVibe (venueId, vibeId) values (19, 5);
insert into VenueVibe (venueId, vibeId) values (34, 6);
insert into VenueVibe (venueId, vibeId) values (5, 2);
insert into VenueVibe (venueId, vibeId) values (10, 2);
insert into VenueVibe (venueId, vibeId) values (35, 8);
insert into VenueVibe (venueId, vibeId) values (10, 5);
insert into VenueVibe (venueId, vibeId) values (10, 4);
insert into VenueVibe (venueId, vibeId) values (5, 10);
insert into VenueVibe (venueId, vibeId) values (12, 8);
insert into VenueVibe (venueId, vibeId) values (9, 8);
insert into VenueVibe (venueId, vibeId) values (11, 1);
insert into VenueVibe (venueId, vibeId) values (40, 9);
insert into VenueVibe (venueId, vibeId) values (6, 4);
insert into VenueVibe (venueId, vibeId) values (19, 2);
insert into VenueVibe (venueId, vibeId) values (34, 2);
insert into VenueVibe (venueId, vibeId) values (17, 5);
insert into VenueVibe (venueId, vibeId) values (38, 7);
insert into VenueVibe (venueId, vibeId) values (32, 4);
insert into VenueVibe (venueId, vibeId) values (1, 9);
insert into VenueVibe (venueId, vibeId) values (20, 8);
insert into VenueVibe (venueId, vibeId) values (22, 7);

-- Reviews --
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (1, 23, 3, null, 1, true, '2025-11-28 23:20:10');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (2, 34, 16, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 0, false, '2025-08-23 03:58:08');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (3, 39, 36, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 0, false, '2025-07-10 00:47:33');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (4, 29, 27, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 1, true, '2026-04-05 08:44:07');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (5, 34, 32, null, 0, false, '2025-12-21 01:44:00');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (6, 35, 5, null, 2, true, '2025-07-05 14:06:41');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (7, 17, 35, null, 3, true, '2025-09-02 21:34:38');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (8, 16, 14, null, 2, true, '2026-03-01 01:39:23');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (9, 8, 38, null, 3, false, '2025-06-10 10:44:30');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (10, 5, 10, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 5, true, '2025-07-07 06:38:20');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (11, 17, 40, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 1, true, '2025-06-22 06:12:01');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (12, 30, 35, null, 5, false, '2025-08-12 23:23:53');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (13, 29, 20, null, 4, true, '2025-08-28 14:27:13');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (14, 4, 15, null, 3, true, '2025-12-29 11:28:09');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (15, 15, 40, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 3, false, '2025-09-18 12:04:57');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (16, 3, 6, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 0, true, '2025-10-13 20:16:19');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (17, 4, 21, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 1, true, '2025-06-28 04:35:36');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (18, 1, 4, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', 2, true, '2026-01-13 08:18:41');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (19, 21, 24, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 3, true, '2025-07-05 07:01:49');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (20, 6, 39, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 2, true, '2026-04-07 04:18:40');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (21, 11, 8, null, 5, false, '2026-03-15 09:05:45');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (22, 2, 29, null, 3, true, '2025-04-23 21:48:02');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (23, 16, 14, null, 4, false, '2025-08-23 12:45:36');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (24, 32, 15, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 1, false, '2026-04-16 07:54:19');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (25, 22, 17, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', 4, true, '2025-11-27 04:00:55');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (26, 13, 40, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', 4, true, '2025-06-30 11:11:23');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (27, 40, 8, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 5, true, '2025-10-12 08:31:10');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (28, 20, 2, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 3, false, '2025-05-05 01:38:09');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (29, 36, 26, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 3, false, '2026-02-21 04:36:03');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (30, 4, 22, null, 2, true, '2025-10-19 01:59:19');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (31, 9, 20, null, 0, true, '2025-08-05 23:12:47');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (32, 38, 22, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', 4, true, '2025-05-22 11:31:28');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (33, 25, 22, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 3, false, '2025-12-05 23:28:49');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (34, 10, 39, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 5, false, '2026-03-14 03:08:33');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (35, 26, 27, null, 3, false, '2026-03-16 17:24:55');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (36, 31, 15, 'Fusce consequat. Nulla nisl. Nunc nisl.', 2, true, '2025-07-24 18:58:33');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (37, 40, 38, null, 1, true, '2025-06-10 00:31:48');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (38, 2, 25, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', 5, true, '2025-06-07 19:10:07');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (39, 40, 14, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', 4, false, '2025-05-12 02:33:57');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (40, 22, 25, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', 4, true, '2025-10-19 12:51:46');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (41, 33, 18, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', 2, false, '2025-08-12 03:30:50');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (42, 23, 30, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 2, true, '2026-01-29 16:06:04');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (43, 31, 38, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 4, false, '2025-12-21 04:12:20');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (44, 26, 29, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', 5, false, '2025-06-10 13:30:21');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (45, 36, 34, null, 2, false, '2026-01-17 21:04:28');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (46, 14, 28, null, 3, false, '2026-01-26 12:24:39');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (47, 7, 12, null, 1, true, '2025-05-14 23:21:44');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (48, 37, 11, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', 1, false, '2025-09-08 13:37:15');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (49, 29, 29, null, 0, false, '2025-06-15 13:36:55');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (50, 3, 29, null, 1, true, '2025-08-21 06:20:52');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (51, 31, 14, null, 2, false, '2025-05-06 14:17:12');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (52, 16, 3, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', 3, true, '2026-03-12 20:53:57');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (53, 5, 27, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 5, true, '2026-03-24 02:48:37');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (54, 33, 14, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 0, true, '2026-03-01 03:12:11');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (55, 26, 5, null, 2, true, '2026-01-16 05:09:33');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (56, 8, 28, null, 5, true, '2026-01-31 10:18:06');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (57, 14, 32, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 4, false, '2025-06-16 01:26:19');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (58, 34, 36, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 4, false, '2026-03-28 19:46:50');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (59, 15, 30, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 2, true, '2025-12-24 17:48:04');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (60, 15, 23, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 3, true, '2025-08-04 14:43:55');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (61, 11, 16, null, 3, false, '2025-09-14 18:52:30');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (62, 15, 25, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', 2, false, '2025-09-20 06:49:36');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (63, 11, 36, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 3, true, '2025-06-04 19:23:20');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (64, 22, 18, null, 0, false, '2025-10-27 04:15:17');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (65, 23, 36, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', 3, true, '2025-08-23 09:55:09');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (66, 21, 3, 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', 5, true, '2025-04-27 14:05:09');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (67, 15, 33, 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', 5, false, '2026-01-24 01:10:36');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (68, 24, 26, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', 4, true, '2025-09-25 05:38:32');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (69, 23, 27, null, 4, false, '2025-05-17 15:30:07');
insert into Reviews (reviewId, userId, venueId, comment, rating, isFlagged, createdAt) values (70, 25, 9, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', 5, false, '2026-01-11 00:57:34');

-- Posts --
insert into Posts (postId, ownerId, venueId, content, postDate) values (1, 22, 28, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', '2025-11-12 15:37:57');
insert into Posts (postId, ownerId, venueId, content, postDate) values (2, 26, 35, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '2025-08-02 20:02:48');
insert into Posts (postId, ownerId, venueId, content, postDate) values (3, 33, 6, 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '2025-10-13 23:33:29');
insert into Posts (postId, ownerId, venueId, content, postDate) values (4, 22, 11, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '2025-08-29 22:01:19');
insert into Posts (postId, ownerId, venueId, content, postDate) values (5, 18, 3, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '2025-11-29 10:01:29');
insert into Posts (postId, ownerId, venueId, content, postDate) values (6, 7, 31, 'Fusce consequat. Nulla nisl. Nunc nisl.', '2025-08-08 10:21:46');
insert into Posts (postId, ownerId, venueId, content, postDate) values (7, 6, 6, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '2025-09-24 07:15:14');
insert into Posts (postId, ownerId, venueId, content, postDate) values (8, 37, 22, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '2025-05-24 09:33:10');
insert into Posts (postId, ownerId, venueId, content, postDate) values (9, 6, 8, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '2025-12-18 14:01:34');
insert into Posts (postId, ownerId, venueId, content, postDate) values (10, 35, 26, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '2025-08-16 18:10:24');
insert into Posts (postId, ownerId, venueId, content, postDate) values (11, 17, 10, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2025-04-25 08:08:00');
insert into Posts (postId, ownerId, venueId, content, postDate) values (12, 31, 1, 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '2026-03-29 23:45:08');
insert into Posts (postId, ownerId, venueId, content, postDate) values (13, 28, 26, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '2025-10-12 06:49:10');
insert into Posts (postId, ownerId, venueId, content, postDate) values (14, 35, 1, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '2025-09-29 19:36:45');
insert into Posts (postId, ownerId, venueId, content, postDate) values (15, 9, 28, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '2025-07-27 09:36:03');
insert into Posts (postId, ownerId, venueId, content, postDate) values (16, 8, 36, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '2026-01-11 23:28:32');
insert into Posts (postId, ownerId, venueId, content, postDate) values (17, 19, 28, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', '2025-11-08 15:36:39');
insert into Posts (postId, ownerId, venueId, content, postDate) values (18, 2, 3, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '2025-04-25 02:09:17');
insert into Posts (postId, ownerId, venueId, content, postDate) values (19, 8, 3, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2026-01-30 20:11:59');
insert into Posts (postId, ownerId, venueId, content, postDate) values (20, 18, 31, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '2026-01-26 18:08:52');
insert into Posts (postId, ownerId, venueId, content, postDate) values (21, 22, 4, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '2026-01-16 17:00:07');
insert into Posts (postId, ownerId, venueId, content, postDate) values (22, 29, 27, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '2025-11-03 11:14:51');
insert into Posts (postId, ownerId, venueId, content, postDate) values (23, 31, 29, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '2025-05-04 02:29:32');
insert into Posts (postId, ownerId, venueId, content, postDate) values (24, 12, 1, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '2025-08-28 22:47:16');
insert into Posts (postId, ownerId, venueId, content, postDate) values (25, 37, 27, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '2026-04-08 05:34:58');
insert into Posts (postId, ownerId, venueId, content, postDate) values (26, 34, 32, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', '2026-02-19 13:20:16');
insert into Posts (postId, ownerId, venueId, content, postDate) values (27, 20, 7, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2026-04-07 15:22:34');
insert into Posts (postId, ownerId, venueId, content, postDate) values (28, 30, 6, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '2025-09-05 17:40:22');
insert into Posts (postId, ownerId, venueId, content, postDate) values (29, 40, 34, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', '2025-06-17 13:04:53');
insert into Posts (postId, ownerId, venueId, content, postDate) values (30, 34, 38, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '2026-01-16 08:51:25');
insert into Posts (postId, ownerId, venueId, content, postDate) values (31, 23, 24, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', '2026-04-01 03:04:27');
insert into Posts (postId, ownerId, venueId, content, postDate) values (32, 15, 31, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '2025-04-25 18:36:32');
insert into Posts (postId, ownerId, venueId, content, postDate) values (33, 10, 23, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '2025-07-23 13:22:12');
insert into Posts (postId, ownerId, venueId, content, postDate) values (34, 10, 13, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '2026-01-28 07:34:11');
insert into Posts (postId, ownerId, venueId, content, postDate) values (35, 28, 34, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2025-05-20 08:27:44');
insert into Posts (postId, ownerId, venueId, content, postDate) values (36, 37, 8, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '2025-09-13 12:53:50');
insert into Posts (postId, ownerId, venueId, content, postDate) values (37, 39, 16, 'Pellentesque at nulla. Suspendisse potenti. Cras in purus eu magna vulputate luctus.', '2025-06-24 06:05:38');
insert into Posts (postId, ownerId, venueId, content, postDate) values (38, 5, 36, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '2026-02-02 13:02:23');
insert into Posts (postId, ownerId, venueId, content, postDate) values (39, 31, 6, 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.', '2025-05-22 07:35:00');
insert into Posts (postId, ownerId, venueId, content, postDate) values (40, 16, 27, 'Aenean fermentum. Donec ut mauris eget massa tempor convallis. Nulla neque libero, convallis eget, eleifend luctus, ultricies eu, nibh.', '2026-03-27 23:59:53');
insert into Posts (postId, ownerId, venueId, content, postDate) values (41, 5, 11, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2025-11-09 23:09:22');
insert into Posts (postId, ownerId, venueId, content, postDate) values (42, 7, 31, 'In congue. Etiam justo. Etiam pretium iaculis justo.', '2025-08-09 00:15:19');
insert into Posts (postId, ownerId, venueId, content, postDate) values (43, 23, 25, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '2026-04-16 17:11:54');
insert into Posts (postId, ownerId, venueId, content, postDate) values (44, 9, 27, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '2025-10-06 21:30:50');
insert into Posts (postId, ownerId, venueId, content, postDate) values (45, 4, 22, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2025-06-18 10:58:43');
insert into Posts (postId, ownerId, venueId, content, postDate) values (46, 5, 9, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '2025-07-08 03:04:23');
insert into Posts (postId, ownerId, venueId, content, postDate) values (47, 4, 37, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '2025-12-25 01:50:38');
insert into Posts (postId, ownerId, venueId, content, postDate) values (48, 18, 33, 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2025-10-22 20:11:25');
insert into Posts (postId, ownerId, venueId, content, postDate) values (49, 14, 11, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '2026-01-30 09:59:03');
insert into Posts (postId, ownerId, venueId, content, postDate) values (50, 14, 40, 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '2025-11-13 08:44:45');
insert into Posts (postId, ownerId, venueId, content, postDate) values (51, 28, 24, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '2026-03-24 20:26:34');
insert into Posts (postId, ownerId, venueId, content, postDate) values (52, 11, 24, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '2025-11-23 09:58:11');
insert into Posts (postId, ownerId, venueId, content, postDate) values (53, 13, 14, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2025-08-27 22:02:22');
insert into Posts (postId, ownerId, venueId, content, postDate) values (54, 35, 5, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', '2025-12-01 07:04:42');
insert into Posts (postId, ownerId, venueId, content, postDate) values (55, 37, 2, 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '2025-10-05 16:27:12');
insert into Posts (postId, ownerId, venueId, content, postDate) values (56, 17, 17, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', '2026-01-20 17:55:28');
insert into Posts (postId, ownerId, venueId, content, postDate) values (57, 31, 10, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '2026-01-20 22:26:21');
insert into Posts (postId, ownerId, venueId, content, postDate) values (58, 32, 37, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', '2026-03-30 14:52:10');
insert into Posts (postId, ownerId, venueId, content, postDate) values (59, 36, 40, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', '2025-11-08 01:03:56');
insert into Posts (postId, ownerId, venueId, content, postDate) values (60, 21, 5, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2025-05-15 14:23:57');
insert into Posts (postId, ownerId, venueId, content, postDate) values (61, 34, 23, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', '2026-03-30 04:39:12');
insert into Posts (postId, ownerId, venueId, content, postDate) values (62, 27, 22, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2026-02-09 13:59:03');
insert into Posts (postId, ownerId, venueId, content, postDate) values (63, 9, 22, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '2025-07-10 07:12:15');
insert into Posts (postId, ownerId, venueId, content, postDate) values (64, 9, 27, 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '2025-07-14 13:30:54');
insert into Posts (postId, ownerId, venueId, content, postDate) values (65, 20, 34, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', '2025-08-03 21:06:33');
insert into Posts (postId, ownerId, venueId, content, postDate) values (66, 26, 15, 'Cras non velit nec nisi vulputate nonummy. Maecenas tincidunt lacus at velit. Vivamus vel nulla eget eros elementum pellentesque.', '2025-05-20 17:31:29');
insert into Posts (postId, ownerId, venueId, content, postDate) values (67, 36, 15, 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '2026-02-25 01:27:38');
insert into Posts (postId, ownerId, venueId, content, postDate) values (68, 16, 35, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '2025-09-28 05:28:27');
insert into Posts (postId, ownerId, venueId, content, postDate) values (69, 29, 35, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '2026-04-07 14:41:38');
insert into Posts (postId, ownerId, venueId, content, postDate) values (70, 6, 19, 'In congue. Etiam justo. Etiam pretium iaculis justo.', '2025-06-05 11:22:19');

-- Lists --
insert into Lists (listId, userId, name) values (1, 1, 'Propranolol Hydrochloride');
insert into Lists (listId, userId, name) values (2, 2, 'Technetium Tc99m Generator');
insert into Lists (listId, userId, name) values (3, 3, 'Stavudine');
insert into Lists (listId, userId, name) values (4, 4, 'Glyburide and Metformin Hydrochloride');
insert into Lists (listId, userId, name) values (5, 5, 'Stay Awake');
insert into Lists (listId, userId, name) values (6, 6, 'Quality Choice Hemorrhoidal');
insert into Lists (listId, userId, name) values (7, 7, 'Simvastatin');
insert into Lists (listId, userId, name) values (8, 8, 'Hydrocodone Bitartrate and Acetaminophen');
insert into Lists (listId, userId, name) values (9, 9, 'AZITHROMYCIN');
insert into Lists (listId, userId, name) values (10, 10, 'Naproxen Sodium');
insert into Lists (listId, userId, name) values (11, 11, 'Glyburide');
insert into Lists (listId, userId, name) values (12, 12, 'Fluoxetine');
insert into Lists (listId, userId, name) values (13, 13, 'DR.G WHITENING REFORMER');
insert into Lists (listId, userId, name) values (14, 14, 'benzoyl peroxide');
insert into Lists (listId, userId, name) values (15, 15, 'Nabumetone');
insert into Lists (listId, userId, name) values (16, 16, 'BabyGanics Sunscreen');
insert into Lists (listId, userId, name) values (17, 17, 'Ibuprofen');
insert into Lists (listId, userId, name) values (18, 18, 'CD CAPTURE TOTALE Triple Correcting Serum Foundation Wrinkles-Dark Spots-Radiance with sunscreen Broad Spectrum SPF 25 040');
insert into Lists (listId, userId, name) values (19, 19, 'Menstrual Relief');
insert into Lists (listId, userId, name) values (20, 20, 'Kendall 2-in-1 Cleanser');
insert into Lists (listId, userId, name) values (21, 21, 'Standardized Grass Pollen, Ryegrass');
insert into Lists (listId, userId, name) values (22, 22, 'Black Radiance True Complexion BB Cream SPF 15');
insert into Lists (listId, userId, name) values (23, 23, 'Ranitidine');
insert into Lists (listId, userId, name) values (24, 24, 'Estradiol');
insert into Lists (listId, userId, name) values (25, 25, 'Mini Berry Lip Balm Blueberry');
insert into Lists (listId, userId, name) values (26, 26, 'Carbinoxamine Maleate');
insert into Lists (listId, userId, name) values (27, 27, 'Darby');
insert into Lists (listId, userId, name) values (28, 28, 'Irbesartan and Hydrochlorothiazide');
insert into Lists (listId, userId, name) values (29, 29, 'FLAWLESS FINISH PERFECTLY NUDE MAKEUP BROAD SPECTRUM SUNSCREEN SPF 15 SHADE COCOA');
insert into Lists (listId, userId, name) values (30, 30, 'Benzoyl Peroxide');

-- List Venues --
insert into ListVenue (listId, venueId) values (29, 40);
insert into ListVenue (listId, venueId) values (29, 9);
insert into ListVenue (listId, venueId) values (23, 3);
insert into ListVenue (listId, venueId) values (2, 24);
insert into ListVenue (listId, venueId) values (2, 2);
insert into ListVenue (listId, venueId) values (26, 18);
insert into ListVenue (listId, venueId) values (19, 33);
insert into ListVenue (listId, venueId) values (24, 11);
insert into ListVenue (listId, venueId) values (10, 20);
insert into ListVenue (listId, venueId) values (6, 8);
insert into ListVenue (listId, venueId) values (11, 20);
insert into ListVenue (listId, venueId) values (4, 23);
insert into ListVenue (listId, venueId) values (22, 39);
insert into ListVenue (listId, venueId) values (9, 5);
insert into ListVenue (listId, venueId) values (13, 40);
insert into ListVenue (listId, venueId) values (15, 39);
insert into ListVenue (listId, venueId) values (12, 6);
insert into ListVenue (listId, venueId) values (11, 13);
insert into ListVenue (listId, venueId) values (26, 22);
insert into ListVenue (listId, venueId) values (12, 7);
insert into ListVenue (listId, venueId) values (3, 16);
insert into ListVenue (listId, venueId) values (22, 13);
insert into ListVenue (listId, venueId) values (26, 10);
insert into ListVenue (listId, venueId) values (9, 30);
insert into ListVenue (listId, venueId) values (19, 5);
insert into ListVenue (listId, venueId) values (25, 16);
insert into ListVenue (listId, venueId) values (30, 34);
insert into ListVenue (listId, venueId) values (19, 11);
insert into ListVenue (listId, venueId) values (20, 3);
insert into ListVenue (listId, venueId) values (19, 3);
insert into ListVenue (listId, venueId) values (25, 18);
insert into ListVenue (listId, venueId) values (3, 10);
insert into ListVenue (listId, venueId) values (25, 32);
insert into ListVenue (listId, venueId) values (11, 31);
insert into ListVenue (listId, venueId) values (23, 40);
insert into ListVenue (listId, venueId) values (5, 32);
insert into ListVenue (listId, venueId) values (5, 15);
insert into ListVenue (listId, venueId) values (16, 36);
insert into ListVenue (listId, venueId) values (3, 29);
insert into ListVenue (listId, venueId) values (20, 26);
insert into ListVenue (listId, venueId) values (28, 11);
insert into ListVenue (listId, venueId) values (12, 9);
insert into ListVenue (listId, venueId) values (13, 29);
insert into ListVenue (listId, venueId) values (28, 32);
insert into ListVenue (listId, venueId) values (25, 23);
insert into ListVenue (listId, venueId) values (14, 22);
insert into ListVenue (listId, venueId) values (23, 33);
insert into ListVenue (listId, venueId) values (17, 39);
insert into ListVenue (listId, venueId) values (23, 21);
insert into ListVenue (listId, venueId) values (2, 30);
insert into ListVenue (listId, venueId) values (16, 31);
insert into ListVenue (listId, venueId) values (28, 26);
insert into ListVenue (listId, venueId) values (8, 39);
insert into ListVenue (listId, venueId) values (12, 25);
insert into ListVenue (listId, venueId) values (23, 28);
insert into ListVenue (listId, venueId) values (20, 22);
insert into ListVenue (listId, venueId) values (1, 24);
insert into ListVenue (listId, venueId) values (27, 33);
insert into ListVenue (listId, venueId) values (9, 25);
insert into ListVenue (listId, venueId) values (22, 12);
insert into ListVenue (listId, venueId) values (21, 39);
insert into ListVenue (listId, venueId) values (1, 6);
insert into ListVenue (listId, venueId) values (7, 33);
insert into ListVenue (listId, venueId) values (6, 10);
insert into ListVenue (listId, venueId) values (1, 2);
insert into ListVenue (listId, venueId) values (24, 39);
insert into ListVenue (listId, venueId) values (30, 24);
insert into ListVenue (listId, venueId) values (27, 16);
insert into ListVenue (listId, venueId) values (9, 37);
insert into ListVenue (listId, venueId) values (19, 40);
insert into ListVenue (listId, venueId) values (26, 33);
insert into ListVenue (listId, venueId) values (30, 23);
insert into ListVenue (listId, venueId) values (22, 33);
insert into ListVenue (listId, venueId) values (26, 3);
insert into ListVenue (listId, venueId) values (26, 15);
insert into ListVenue (listId, venueId) values (30, 29);
insert into ListVenue (listId, venueId) values (12, 1);
insert into ListVenue (listId, venueId) values (11, 6);
insert into ListVenue (listId, venueId) values (21, 34);
insert into ListVenue (listId, venueId) values (27, 25);
insert into ListVenue (listId, venueId) values (16, 38);
insert into ListVenue (listId, venueId) values (6, 39);
insert into ListVenue (listId, venueId) values (30, 13);
insert into ListVenue (listId, venueId) values (8, 30);
insert into ListVenue (listId, venueId) values (17, 7);
insert into ListVenue (listId, venueId) values (7, 3);
insert into ListVenue (listId, venueId) values (29, 38);
insert into ListVenue (listId, venueId) values (28, 21);
insert into ListVenue (listId, venueId) values (1, 7);
insert into ListVenue (listId, venueId) values (7, 20);
insert into ListVenue (listId, venueId) values (15, 28);
insert into ListVenue (listId, venueId) values (11, 35);
insert into ListVenue (listId, venueId) values (7, 23);
insert into ListVenue (listId, venueId) values (5, 28);
insert into ListVenue (listId, venueId) values (1, 16);
insert into ListVenue (listId, venueId) values (25, 13);
insert into ListVenue (listId, venueId) values (7, 12);
insert into ListVenue (listId, venueId) values (13, 4);
insert into ListVenue (listId, venueId) values (12, 19);
insert into ListVenue (listId, venueId) values (26, 6);
insert into ListVenue (listId, venueId) values (10, 39);
insert into ListVenue (listId, venueId) values (2, 13);
insert into ListVenue (listId, venueId) values (7, 5);
insert into ListVenue (listId, venueId) values (15, 40);
insert into ListVenue (listId, venueId) values (29, 20);
insert into ListVenue (listId, venueId) values (27, 21);
insert into ListVenue (listId, venueId) values (25, 33);
insert into ListVenue (listId, venueId) values (28, 40);
insert into ListVenue (listId, venueId) values (12, 28);
insert into ListVenue (listId, venueId) values (16, 25);
insert into ListVenue (listId, venueId) values (14, 11);
insert into ListVenue (listId, venueId) values (3, 23);
insert into ListVenue (listId, venueId) values (3, 15);
insert into ListVenue (listId, venueId) values (1, 20);
insert into ListVenue (listId, venueId) values (19, 16);
insert into ListVenue (listId, venueId) values (3, 33);
insert into ListVenue (listId, venueId) values (6, 25);

-- Saved Venues --
insert into SavedVenues (userId, venueId, savedAt) values (21, 8, '2025-09-29 13:03:32');
insert into SavedVenues (userId, venueId, savedAt) values (14, 7, '2025-11-07 12:42:56');
insert into SavedVenues (userId, venueId, savedAt) values (28, 11, '2026-02-26 21:19:03');
insert into SavedVenues (userId, venueId, savedAt) values (25, 30, '2025-07-24 00:19:45');
insert into SavedVenues (userId, venueId, savedAt) values (40, 21, '2026-04-06 02:53:01');
insert into SavedVenues (userId, venueId, savedAt) values (6, 19, '2025-04-24 01:08:09');
insert into SavedVenues (userId, venueId, savedAt) values (29, 32, '2026-02-23 16:53:43');
insert into SavedVenues (userId, venueId, savedAt) values (7, 12, '2025-07-27 12:19:18');
insert into SavedVenues (userId, venueId, savedAt) values (7, 2, '2025-11-21 19:17:45');
insert into SavedVenues (userId, venueId, savedAt) values (5, 19, '2026-02-08 03:37:51');
insert into SavedVenues (userId, venueId, savedAt) values (25, 40, '2025-12-26 14:02:20');
insert into SavedVenues (userId, venueId, savedAt) values (11, 22, '2025-11-06 00:35:59');
insert into SavedVenues (userId, venueId, savedAt) values (5, 38, '2025-04-26 21:43:49');
insert into SavedVenues (userId, venueId, savedAt) values (34, 7, '2025-10-13 20:02:47');
insert into SavedVenues (userId, venueId, savedAt) values (25, 13, '2025-12-04 11:37:15');
insert into SavedVenues (userId, venueId, savedAt) values (11, 25, '2026-01-13 09:46:46');
insert into SavedVenues (userId, venueId, savedAt) values (36, 16, '2025-08-24 02:36:10');
insert into SavedVenues (userId, venueId, savedAt) values (16, 33, '2025-04-21 02:19:13');
insert into SavedVenues (userId, venueId, savedAt) values (34, 19, '2025-11-11 22:49:03');
insert into SavedVenues (userId, venueId, savedAt) values (15, 3, '2025-07-17 18:32:36');
insert into SavedVenues (userId, venueId, savedAt) values (30, 5, '2025-10-31 12:42:09');
insert into SavedVenues (userId, venueId, savedAt) values (39, 24, '2026-02-20 05:49:23');
insert into SavedVenues (userId, venueId, savedAt) values (22, 20, '2025-05-09 06:03:38');
insert into SavedVenues (userId, venueId, savedAt) values (24, 16, '2026-02-17 01:22:56');
insert into SavedVenues (userId, venueId, savedAt) values (22, 31, '2026-02-28 18:28:33');
insert into SavedVenues (userId, venueId, savedAt) values (30, 14, '2026-01-16 08:26:40');
insert into SavedVenues (userId, venueId, savedAt) values (32, 20, '2025-05-08 19:13:51');
insert into SavedVenues (userId, venueId, savedAt) values (3, 38, '2026-01-23 16:52:01');
insert into SavedVenues (userId, venueId, savedAt) values (25, 34, '2025-05-30 21:02:33');
insert into SavedVenues (userId, venueId, savedAt) values (35, 14, '2026-01-12 03:56:14');
insert into SavedVenues (userId, venueId, savedAt) values (38, 24, '2026-01-20 17:10:30');
insert into SavedVenues (userId, venueId, savedAt) values (23, 13, '2025-12-22 21:19:41');
insert into SavedVenues (userId, venueId, savedAt) values (20, 24, '2025-09-18 20:51:51');
insert into SavedVenues (userId, venueId, savedAt) values (17, 40, '2025-11-24 09:55:00');
insert into SavedVenues (userId, venueId, savedAt) values (16, 19, '2025-10-17 23:44:54');
insert into SavedVenues (userId, venueId, savedAt) values (21, 32, '2026-03-29 11:24:46');
insert into SavedVenues (userId, venueId, savedAt) values (11, 37, '2025-12-18 09:44:30');
insert into SavedVenues (userId, venueId, savedAt) values (35, 17, '2025-06-06 06:44:49');
insert into SavedVenues (userId, venueId, savedAt) values (9, 22, '2025-05-29 07:14:52');
insert into SavedVenues (userId, venueId, savedAt) values (22, 40, '2025-09-03 10:33:49');
insert into SavedVenues (userId, venueId, savedAt) values (27, 2, '2025-04-20 20:32:21');
insert into SavedVenues (userId, venueId, savedAt) values (37, 35, '2025-12-29 09:32:17');
insert into SavedVenues (userId, venueId, savedAt) values (13, 2, '2025-10-16 14:39:43');
insert into SavedVenues (userId, venueId, savedAt) values (27, 13, '2025-07-12 06:06:24');
insert into SavedVenues (userId, venueId, savedAt) values (24, 21, '2025-04-30 02:13:18');
insert into SavedVenues (userId, venueId, savedAt) values (31, 34, '2025-06-12 10:07:20');
insert into SavedVenues (userId, venueId, savedAt) values (26, 34, '2026-03-15 08:58:08');
insert into SavedVenues (userId, venueId, savedAt) values (13, 24, '2025-09-07 09:48:06');
insert into SavedVenues (userId, venueId, savedAt) values (11, 23, '2025-11-02 21:31:00');
insert into SavedVenues (userId, venueId, savedAt) values (12, 27, '2025-07-15 12:56:38');
insert into SavedVenues (userId, venueId, savedAt) values (16, 31, '2025-10-08 06:01:15');
insert into SavedVenues (userId, venueId, savedAt) values (21, 27, '2026-01-01 07:15:43');
insert into SavedVenues (userId, venueId, savedAt) values (22, 24, '2025-12-05 08:41:04');
insert into SavedVenues (userId, venueId, savedAt) values (29, 31, '2025-06-25 09:51:10');
insert into SavedVenues (userId, venueId, savedAt) values (27, 15, '2025-07-21 19:12:06');
insert into SavedVenues (userId, venueId, savedAt) values (36, 30, '2025-12-26 06:33:32');
insert into SavedVenues (userId, venueId, savedAt) values (10, 3, '2025-04-25 22:21:29');
insert into SavedVenues (userId, venueId, savedAt) values (17, 2, '2026-01-27 12:36:32');
insert into SavedVenues (userId, venueId, savedAt) values (15, 17, '2025-10-24 02:55:51');
insert into SavedVenues (userId, venueId, savedAt) values (26, 22, '2025-05-13 17:53:32');
insert into SavedVenues (userId, venueId, savedAt) values (20, 1, '2025-12-07 03:41:47');
insert into SavedVenues (userId, venueId, savedAt) values (10, 14, '2026-04-16 05:45:06');
insert into SavedVenues (userId, venueId, savedAt) values (31, 10, '2025-11-25 00:14:45');
insert into SavedVenues (userId, venueId, savedAt) values (13, 19, '2026-02-11 10:31:21');
insert into SavedVenues (userId, venueId, savedAt) values (19, 15, '2026-02-24 11:26:05');
insert into SavedVenues (userId, venueId, savedAt) values (2, 18, '2026-03-27 23:52:17');
insert into SavedVenues (userId, venueId, savedAt) values (36, 27, '2025-05-02 21:46:04');
insert into SavedVenues (userId, venueId, savedAt) values (38, 15, '2026-02-04 13:45:03');
insert into SavedVenues (userId, venueId, savedAt) values (10, 30, '2026-02-09 07:45:25');
insert into SavedVenues (userId, venueId, savedAt) values (33, 27, '2025-06-15 18:00:09');
insert into SavedVenues (userId, venueId, savedAt) values (22, 6, '2025-05-23 16:08:13');
insert into SavedVenues (userId, venueId, savedAt) values (37, 25, '2025-11-23 04:38:37');
insert into SavedVenues (userId, venueId, savedAt) values (1, 22, '2025-06-14 09:20:48');
insert into SavedVenues (userId, venueId, savedAt) values (35, 40, '2026-01-09 08:30:01');
insert into SavedVenues (userId, venueId, savedAt) values (20, 30, '2025-11-13 15:29:03');
insert into SavedVenues (userId, venueId, savedAt) values (16, 9, '2025-09-18 20:36:24');
insert into SavedVenues (userId, venueId, savedAt) values (14, 38, '2025-09-18 17:43:02');
insert into SavedVenues (userId, venueId, savedAt) values (39, 2, '2026-02-13 07:10:32');
insert into SavedVenues (userId, venueId, savedAt) values (8, 34, '2025-12-14 21:46:32');
insert into SavedVenues (userId, venueId, savedAt) values (10, 39, '2026-01-31 16:51:29');
insert into SavedVenues (userId, venueId, savedAt) values (2, 36, '2025-06-18 21:29:36');
insert into SavedVenues (userId, venueId, savedAt) values (29, 13, '2026-04-06 04:34:23');
insert into SavedVenues (userId, venueId, savedAt) values (5, 37, '2025-08-08 21:03:04');
insert into SavedVenues (userId, venueId, savedAt) values (10, 29, '2025-08-29 04:41:18');
insert into SavedVenues (userId, venueId, savedAt) values (2, 15, '2026-04-12 20:08:14');
insert into SavedVenues (userId, venueId, savedAt) values (18, 15, '2025-07-11 20:31:04');
insert into SavedVenues (userId, venueId, savedAt) values (14, 23, '2026-03-08 10:45:34');
insert into SavedVenues (userId, venueId, savedAt) values (17, 7, '2026-01-07 13:59:32');
insert into SavedVenues (userId, venueId, savedAt) values (15, 11, '2025-09-06 06:49:38');
insert into SavedVenues (userId, venueId, savedAt) values (6, 4, '2025-12-01 05:01:23');
insert into SavedVenues (userId, venueId, savedAt) values (33, 29, '2025-08-09 14:34:55');
insert into SavedVenues (userId, venueId, savedAt) values (19, 23, '2025-11-02 17:40:35');
insert into SavedVenues (userId, venueId, savedAt) values (26, 12, '2025-09-23 16:39:50');
insert into SavedVenues (userId, venueId, savedAt) values (30, 40, '2025-11-16 05:58:16');
insert into SavedVenues (userId, venueId, savedAt) values (24, 4, '2025-05-12 18:02:42');
insert into SavedVenues (userId, venueId, savedAt) values (22, 36, '2025-12-19 06:26:50');
insert into SavedVenues (userId, venueId, savedAt) values (4, 38, '2026-01-01 04:01:28');
insert into SavedVenues (userId, venueId, savedAt) values (2, 14, '2025-06-27 08:18:02');
insert into SavedVenues (userId, venueId, savedAt) values (31, 5, '2025-05-17 20:32:56');
insert into SavedVenues (userId, venueId, savedAt) values (15, 14, '2026-02-07 04:04:48');
insert into SavedVenues (userId, venueId, savedAt) values (28, 21, '2025-11-09 02:34:39');
insert into SavedVenues (userId, venueId, savedAt) values (28, 23, '2025-10-16 16:42:52');
insert into SavedVenues (userId, venueId, savedAt) values (13, 11, '2025-11-01 19:45:47');
insert into SavedVenues (userId, venueId, savedAt) values (25, 24, '2025-05-10 16:37:09');
insert into SavedVenues (userId, venueId, savedAt) values (28, 38, '2025-07-24 06:41:23');
insert into SavedVenues (userId, venueId, savedAt) values (8, 8, '2026-01-16 09:11:59');
insert into SavedVenues (userId, venueId, savedAt) values (29, 9, '2025-08-22 17:33:19');
insert into SavedVenues (userId, venueId, savedAt) values (17, 3, '2025-10-15 09:12:08');
insert into SavedVenues (userId, venueId, savedAt) values (39, 40, '2025-04-27 16:38:49');
insert into SavedVenues (userId, venueId, savedAt) values (31, 3, '2025-10-23 17:11:20');
insert into SavedVenues (userId, venueId, savedAt) values (16, 25, '2025-12-31 23:50:53');
insert into SavedVenues (userId, venueId, savedAt) values (20, 29, '2026-01-10 08:23:46');
insert into SavedVenues (userId, venueId, savedAt) values (18, 3, '2025-09-22 04:09:35');
insert into SavedVenues (userId, venueId, savedAt) values (6, 36, '2025-07-18 16:26:02');
insert into SavedVenues (userId, venueId, savedAt) values (13, 26, '2025-08-07 00:26:23');
insert into SavedVenues (userId, venueId, savedAt) values (18, 37, '2026-02-02 10:02:00');
insert into SavedVenues (userId, venueId, savedAt) values (32, 3, '2025-12-05 02:36:09');
insert into SavedVenues (userId, venueId, savedAt) values (2, 10, '2026-04-09 13:11:07');

-- Venue Apps --
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (1, 34, 'Ernser and Sons', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', '8946 Artisan Center', '771-360-7840', 61, 139, '2025-08-06 00:11:07', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (2, 31, 'Schroeder-Daniel', 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '7 Anthes Terrace', '385-596-7203', 49, 121, '2025-12-11 18:00:49', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (3, 21, 'Raynor Group', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '06652 Hallows Park', '342-682-1438', 45, 72, '2026-02-17 01:38:10', 'APPROVED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (4, 2, 'Abshire-Corwin', null, '082 Luster Drive', '511-245-2447', 33, 49, '2026-03-29 11:21:00', 'REJECTED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (5, 29, 'Doyle, Rau and Shanahan', 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '2 Hooker Hill', '146-398-0031', 69, 121, '2026-02-04 10:06:02', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (6, 35, 'Erdman Group', null, '92918 Old Shore Circle', '392-123-9803', 58, 80, '2025-08-15 06:32:00', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (7, 34, 'Bartoletti-Skiles', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '7457 Karstens Street', '693-471-4958', 26, 118, '2025-09-19 05:26:39', 'APPROVED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (8, 5, 'Jenkins and Sons', 'In congue. Etiam justo. Etiam pretium iaculis justo.', '7 Garrison Center', '865-209-0388', 49, 124, '2026-03-26 05:16:49', 'REJECTED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (9, 26, 'Mills-Bernhard', 'Sed ante. Vivamus tortor. Duis mattis egestas metus.', '564 Fallview Pass', '493-366-1598', 34, 110, '2025-05-16 19:27:39', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (10, 13, 'Jacobi, Kautzer and Zemlak', 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', '60 Crest Line Junction', '416-253-0543', 88, 181, '2026-03-25 07:19:36', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (11, 30, 'Sanford, Klein and Halvorson', null, '509 Hagan Plaza', '406-222-4188', 72, 134, '2026-04-12 19:23:27', 'APPROVED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (12, 19, 'Nitzsche-Sawayn', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '45 4th Circle', '847-383-1539', 94, 182, '2026-01-13 15:17:34', 'REJECTED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (13, 39, 'Will, Rolfson and Veum', 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', '29396 Eagle Crest Plaza', '778-241-3580', 22, 67, '2025-07-24 22:04:58', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (14, 25, 'Wyman and Sons', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '7931 Rutledge Crossing', '898-519-4020', 54, 116, '2025-09-08 15:53:45', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (15, 5, 'Willms-Abernathy', 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', '3289 Oriole Junction', '778-497-2662', 53, 137, '2025-06-23 21:39:58', 'APPROVED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (16, 10, 'Stiedemann-Dibbert', null, '412 Grim Parkway', '755-576-6653', 45, 112, '2025-07-26 15:55:34', 'REJECTED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (17, 24, 'Hauck Group', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', '448 Pond Place', '761-505-7379', 86, 181, '2025-12-03 11:30:34', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (18, 5, 'Bogisich, Blanda and Schmidt', 'Praesent id massa id nisl venenatis lacinia. Aenean sit amet justo. Morbi ut odio.', '8 Gerald Pass', '725-847-3964', 35, 73, '2025-12-23 20:46:03', 'PENDING');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (19, 29, 'Hettinger LLC', null, '65850 Towne Trail', '995-539-8975', 31, 120, '2025-06-14 14:27:05', 'APPROVED');
insert into VenueApplications (applicationId, ownerId, name, description, address, phone, minPrice, maxPrice, createdAt, status) values (20, 26, 'Heathcote-Lang', 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec pharetra, magna vestibulum aliquet ultrices, erat tortor sollicitudin mi, sit amet lobortis sapien sapien non mi. Integer ac neque.', '0690 Calypso Crossing', '104-742-0394', 57, 88, '2025-05-06 16:38:33', 'REJECTED');

-- Report Tickets --
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (1, 23, 13, 'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis. Integer aliquet, massa id lobortis convallis, tortor risus dapibus augue, vel accumsan tellus nisi eu orci. Mauris lacinia sapien quis libero.', 'In hac habitasse platea dictumst. Etiam faucibus cursus urna. Ut tellus.', '2025-12-02 11:59:40', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (2, 26, 32, null, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2025-05-30 11:28:12', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (3, 35, 21, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2025-12-03 05:21:41', 'UNDER REVIEW');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (4, 1, 58, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', '2025-05-05 22:56:55', 'RESOLVED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (5, 13, 20, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'Quisque id justo sit amet sapien dignissim vestibulum. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nulla dapibus dolor vel est. Donec odio justo, sollicitudin ut, suscipit a, feugiat et, eros.', '2025-09-20 17:00:27', 'DISMISSED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (6, 26, 52, 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.', 'Proin eu mi. Nulla ac enim. In tempor, turpis nec euismod scelerisque, quam turpis adipiscing lorem, vitae mattis nibh ligula nec sem.', '2025-05-30 04:46:56', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (7, 6, 23, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '2025-09-01 08:24:59', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (8, 29, 58, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', '2025-12-04 21:47:07', 'UNDER REVIEW');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (9, 18, 60, null, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', '2026-04-10 00:27:22', 'RESOLVED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (10, 32, 56, 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla. Sed accumsan felis. Ut at dolor quis odio consequat varius.', 'Fusce consequat. Nulla nisl. Nunc nisl.', '2026-04-17 11:19:43', 'DISMISSED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (11, 31, 15, 'Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.', 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', '2025-09-30 18:58:38', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (12, 17, 67, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', '2025-10-19 04:46:13', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (13, 8, 10, 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', 'In sagittis dui vel nisl. Duis ac nibh. Fusce lacus purus, aliquet at, feugiat non, pretium quis, lectus.', '2026-03-13 04:18:36', 'UNDER REVIEW');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (14, 24, 9, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', '2025-06-02 12:41:06', 'RESOLVED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (15, 31, 7, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.', '2026-02-28 14:18:20', 'DISMISSED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (16, 25, 30, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', 'Aenean lectus. Pellentesque eget nunc. Donec quis orci eget orci vehicula condimentum.', '2025-08-28 14:44:46', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (17, 19, 51, 'Duis consequat dui nec nisi volutpat eleifend. Donec ut dolor. Morbi vel lectus in quam fringilla rhoncus.', 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', '2025-08-05 18:18:47', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (18, 11, 17, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '2025-06-05 14:25:24', 'UNDER REVIEW');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (19, 31, 69, null, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2026-01-19 02:02:59', 'RESOLVED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (20, 16, 61, 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.', 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2025-08-07 05:38:53', 'DISMISSED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (21, 2, 19, 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat. Vestibulum sed magna at nunc commodo placerat.', 'Curabitur gravida nisi at nibh. In hac habitasse platea dictumst. Aliquam augue quam, sollicitudin vitae, consectetuer eget, rutrum at, lorem.', '2025-11-04 15:17:52', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (22, 22, 48, null, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', '2025-05-28 18:05:54', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (23, 19, 52, null, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', '2025-07-23 13:08:03', 'UNDER REVIEW');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (24, 25, 62, 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.', 'In hac habitasse platea dictumst. Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.', '2026-02-27 11:20:05', 'RESOLVED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (25, 15, 20, null, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', '2026-03-15 07:20:59', 'DISMISSED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (26, 25, 60, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', 'Fusce consequat. Nulla nisl. Nunc nisl.', '2025-07-24 09:09:57', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (27, 12, 68, 'Fusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.', 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', '2025-07-29 11:35:42', 'PENDING');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (28, 8, 57, null, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', '2025-10-22 16:44:24', 'UNDER REVIEW');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (29, 29, 14, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', 'Maecenas tristique, est et tempus semper, est quam pharetra magna, ac consequat metus sapien ut nunc. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Mauris viverra diam vitae quam. Suspendisse potenti.', '2025-07-03 14:59:00', 'RESOLVED');
insert into ReportTickets (reportId, reporterId, reviewId, description, reason, createdAt, status) values (30, 31, 18, 'Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.', 'In congue. Etiam justo. Etiam pretium iaculis justo.', '2026-03-12 18:40:40', 'DISMISSED');

-- Admin Log --
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (1, null, 25, 24, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', null, null, '2025-04-24 14:00:29', 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (2, null, 2, 33, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', null, null, '2025-09-21 13:33:32', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (3, 9, null, 28, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', null, null, '2025-10-11 05:05:48', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (4, 10, null, 18, 'Vestibulum ac est lacinia nisi venenatis tristique. Fusce congue, diam id ornare imperdiet, sapien urna pretium nisl, ut volutpat sapien arcu sed augue. Aliquam erat volutpat.', null, null, '2026-02-04 08:35:18', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (5, null, 6, 32, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', null, null, '2026-02-21 22:37:52', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (6, null, 23, 23, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Proin risus. Praesent lectus.', null, null, '2026-02-20 14:06:34', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (7, null, 24, 30, 'Maecenas ut massa quis augue luctus tincidunt. Nulla mollis molestie lorem. Quisque ut erat.', null, null, '2025-06-08 07:16:54', 'Suspendisse potenti. In eleifend quam a odio. In hac habitasse platea dictumst.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (8, null, 23, 36, 'Nam ultrices, libero non mattis pulvinar, nulla pede ullamcorper augue, a suscipit nulla elit ac nulla. Sed vel enim sit amet nunc viverra dapibus. Nulla suscipit ligula in lacus.', null, null, '2025-12-07 11:51:03', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (9, 5, null, 39, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', null, null, '2025-07-23 18:14:24', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (10, null, 13, 27, 'Donec diam neque, vestibulum eget, vulputate ut, ultrices vel, augue.', null, null, '2025-11-29 14:33:19', 'Morbi porttitor lorem id ligula. Suspendisse ornare consequat lectus. In est risus, auctor sed, tristique in, tempus sit amet, sem.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (11, 14, null, 23, 'Aliquam quis turpis eget elit sodales scelerisque. Mauris sit amet eros. Suspendisse accumsan tortor quis turpis.', null, null, '2025-09-25 18:16:22', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (12, null, 14, 26, 'Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus vestibulum sagittis sapien. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.', null, null, '2025-10-03 08:19:05', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (13, null, 9, 27, 'Phasellus in felis. Donec semper sapien a libero. Nam dui.', null, null, '2025-11-11 21:16:50', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (14, null, 29, 2, 'Curabitur in libero ut massa volutpat convallis. Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.', null, null, '2025-11-28 20:53:11', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (15, null, 27, 18, 'Curabitur at ipsum ac tellus semper interdum. Mauris ullamcorper purus sit amet nulla. Quisque arcu libero, rutrum ac, lobortis vel, dapibus at, diam.', null, null, '2025-11-29 20:02:15', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (16, 5, null, 18, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', null, null, '2025-04-21 18:23:07', 'Phasellus sit amet erat. Nulla tempus. Vivamus in felis eu sapien cursus vestibulum.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (17, null, 13, 24, 'Duis bibendum, felis sed interdum venenatis, turpis enim blandit mi, in porttitor pede justo eu massa. Donec dapibus. Duis at velit eu est congue elementum.', null, null, '2025-10-08 17:42:09', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (18, 15, null, 36, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', null, null, '2025-06-13 21:51:22', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (19, 15, null, 5, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', null, null, '2026-02-04 16:20:10', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (20, 17, null, 35, 'Sed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.', null, null, '2025-08-25 07:54:24', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (21, 10, null, 8, 'Proin interdum mauris non ligula pellentesque ultrices. Phasellus id sapien in sapien iaculis congue. Vivamus metus arcu, adipiscing molestie, hendrerit at, vulputate vitae, nisl.', null, null, '2025-09-09 02:41:55', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (22, null, 26, 2, 'Praesent blandit. Nam nulla. Integer pede justo, lacinia eget, tincidunt eget, tempus vel, pede.', null, null, '2026-01-17 20:44:33', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (23, 3, null, 30, 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.', null, null, '2025-08-07 13:58:56', 'Nullam porttitor lacus at turpis. Donec posuere metus vitae ipsum. Aliquam non mauris.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (24, 19, null, 5, 'In quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.', null, null, '2025-12-19 14:32:42', 'Duis aliquam convallis nunc. Proin at turpis a pede posuere nonummy. Integer non velit.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (25, 8, null, 22, 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo. In blandit ultrices enim. Lorem ipsum dolor sit amet, consectetuer adipiscing elit.', null, null, '2025-06-28 20:17:00', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (26, null, 19, 39, 'Nulla ut erat id mauris vulputate elementum. Nullam varius. Nulla facilisi.', null, null, '2025-08-21 06:47:53', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (27, 19, null, 36, 'Maecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.', null, null, '2025-05-13 21:54:55', 'Integer ac leo. Pellentesque ultrices mattis odio. Donec vitae nisi.');
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (28, 14, null, 34, 'Etiam vel augue. Vestibulum rutrum rutrum neque. Aenean auctor gravida sem.', null, null, '2025-09-28 15:59:03', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (29, null, 8, 4, 'Vestibulum quam sapien, varius ut, blandit non, interdum in, ante. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis faucibus accumsan odio. Curabitur convallis.', null, null, '2025-09-11 04:26:58', null);
insert into AdminLog (logId, appId, reportId, adminId, action, targetTable, targetId, performedAt, notes) values (30, 4, null, 33, 'Quisque porta volutpat erat. Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.', null, null, '2025-06-04 21:15:02', null);
