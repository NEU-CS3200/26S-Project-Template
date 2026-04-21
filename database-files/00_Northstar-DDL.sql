DROP DATABASE IF EXISTS Northstar;
CREATE DATABASE IF NOT EXISTS Northstar;
USE Northstar;

-- DROP TABLES (in dependency order)
DROP TABLE IF EXISTS Traveler_Vote;
DROP TABLE IF EXISTS Listing_Amenity;
DROP TABLE IF EXISTS Traveler_Preference;
DROP TABLE IF EXISTS Traveler_Booking;
DROP TABLE IF EXISTS Trip_Traveler;
DROP TABLE IF EXISTS Funding_Request;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Listing;
DROP TABLE IF EXISTS Promotion;
DROP TABLE IF EXISTS Notification;
DROP TABLE IF EXISTS Trip;
DROP TABLE IF EXISTS Vendor;
DROP TABLE IF EXISTS Traveler;
DROP TABLE IF EXISTS Planner;


-- CREATE TABLES

CREATE TABLE Planner (
    planner_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Traveler (
    traveler_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    availability VARCHAR(100),
    traveler_status VARCHAR(50),
    is_active BOOLEAN NOT NULL
);

CREATE TABLE Vendor (
    vendor_id INT PRIMARY KEY,
    vendor_name VARCHAR(100) NOT NULL,
    last_active_date DATE,
    is_active BOOLEAN NOT NULL
);

CREATE TABLE Trip (
    trip_id INT PRIMARY KEY,
    planner_id INT NOT NULL,
    trip_name VARCHAR(100) NOT NULL,
    date_booked DATE,
    trip_status VARCHAR(50),
    destination VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100),
    region VARCHAR(100),
    trip_type VARCHAR(50),
    start_date DATE,
    end_date DATE,
    is_active BOOLEAN NOT NULL,
    total_spent DECIMAL(10,2),
    group_size INT,
    FOREIGN KEY (planner_id) REFERENCES Planner(planner_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE Notification (
    notification_id INT PRIMARY KEY,
    traveler_id INT NOT NULL,
    type VARCHAR(50),
    message TEXT,
    created_date DATE,
    read_status BOOLEAN NOT NULL,
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Promotion (
    promotion_id INT PRIMARY KEY,
    vendor_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    discount_type VARCHAR(50),
    discount_value DECIMAL(10,2),
    start_date DATE,
    end_date DATE,
    description TEXT,
    is_active BOOLEAN NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Listing (
    listing_id INT PRIMARY KEY,
    vendor_id INT NOT NULL,
    price DECIMAL(10,2),
    traveler_rating DECIMAL(3,2),
    listing_status VARCHAR(50),
    service_category VARCHAR(50),
    availability VARCHAR(100),
    area_for_later VARCHAR(100),
    is_active BOOLEAN NOT NULL,
    operating_hours VARCHAR(100),
    description TEXT,
    promotional_notes TEXT,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    listing_id INT NOT NULL,
    vendor_id INT NOT NULL,
    trip_id INT,
    promotion_id INT,
    booking_date DATE,
    booking_status VARCHAR(50),
    is_active BOOLEAN NOT NULL,
    FOREIGN KEY (listing_id) REFERENCES Listing(listing_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (promotion_id) REFERENCES Promotion(promotion_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL,
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE Funding_Request (
    request_id INT PRIMARY KEY,
    trip_id INT,
    group_size INT,
    start_date DATE,
    end_date DATE,
    request_status VARCHAR(50),
    data TEXT,
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Trip_Traveler (
    trip_id INT,
    traveler_id INT NOT NULL,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (trip_id, traveler_id),
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Traveler_Booking (
    traveler_id INT NOT NULL,
    booking_id INT NOT NULL,
    PRIMARY KEY (traveler_id, booking_id),
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Traveler_Preference (
    traveler_id INT NOT NULL,
    preference VARCHAR(100) NOT NULL,
    trip_id INT,
    PRIMARY KEY (traveler_id, preference),
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);

CREATE TABLE Listing_Amenity (
    listing_id INT NOT NULL,
    amenity VARCHAR(100) NOT NULL,
    PRIMARY KEY (listing_id, amenity),
    FOREIGN KEY (listing_id) REFERENCES Listing(listing_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE Traveler_Vote (
    traveler_id INT NOT NULL,
    listing_id INT NOT NULL,
    vote_value INT NOT NULL,
    trip_id INT,
    PRIMARY KEY (traveler_id, listing_id),
    FOREIGN KEY (traveler_id) REFERENCES Traveler(traveler_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (listing_id) REFERENCES Listing(listing_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (trip_id) REFERENCES Trip(trip_id)
        ON UPDATE CASCADE
        ON DELETE SET NULL
);