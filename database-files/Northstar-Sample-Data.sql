use Northstar;

-- Planner
INSERT INTO Planner VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith');

-- Traveler
INSERT INTO Traveler VALUES
(1, 'John', 'Doe', '1234567890', 'john@example.com', 'Weekend', 'Active', TRUE),
(2, 'Jane', 'Smith', '9876543210', 'jane@example.com', 'Weekdays', 'Active', TRUE);

-- Vendor
INSERT INTO Vendor VALUES
(1, 'HotelCo', '2026-04-01', TRUE),
(2, 'FoodieTours', '2026-04-02', TRUE);

-- Trip
INSERT INTO Trip VALUES
(1, 1, 'NYC Trip', '2026-03-01', 'Planned', 'NYC', 'New York', 'USA', 'East', 'Leisure', '2026-05-01', '2026-05-05', TRUE, 1000.00, 2),
(2, 2, 'LA Trip', '2026-03-02', 'Planned', 'LA', 'Los Angeles', 'USA', 'West', 'Adventure', '2026-06-01', '2026-06-07', TRUE, 1500.00, 3);

-- Notification
INSERT INTO Notification VALUES
(1, 1, 'Update', 'Trip updated', '2026-04-01', FALSE),
(2, 2, 'Reminder', 'Booking reminder', '2026-04-02', FALSE);

-- Promotion
INSERT INTO Promotion VALUES
(1, 1, 'Spring Sale', 'Percent', 10.00, '2026-04-01', '2026-04-30', 'Discount on hotels', TRUE),
(2, 2, 'Food Discount', 'Flat', 20.00, '2026-04-01', '2026-04-30', 'Discount on tours', TRUE);

-- Listing
INSERT INTO Listing VALUES
(1, 1, 200.00, 4.5, 'Available', 'Hotel', 'Daily', 'N/A', TRUE, '9-5', 'Nice hotel', 'None'),
(2, 2, 50.00, 4.2, 'Available', 'Tour', 'Weekly', 'N/A', TRUE, '10-6', 'Food tour', 'Discount included');

-- Booking
INSERT INTO Booking VALUES
(1, 1, 1, 1, 1, '2026-04-05', 'Confirmed', TRUE),
(2, 2, 2, 2, 2, '2026-04-06', 'Pending', TRUE);

-- Funding_Request
INSERT INTO Funding_Request VALUES
(1, 1, 2, '2026-05-01', '2026-05-05', 'Approved', 'N/A'),
(2, 2, 3, '2026-06-01', '2026-06-07', 'Pending', 'N/A');

-- Trip_Traveler
INSERT INTO Trip_Traveler VALUES
(1, 1, '2026-05-01', '2026-05-05'),
(1, 2, '2026-05-01', '2026-05-05');

-- Traveler_Booking
INSERT INTO Traveler_Booking VALUES
(1, 1),
(2, 2);

-- Traveler_Preference
INSERT INTO Traveler_Preference VALUES
(1, 'Food', 1),
(2, 'Adventure', 2);

-- Listing_Amenity
INSERT INTO Listing_Amenity VALUES
(1, 'WiFi'),
(2, 'Guide');

-- Traveler_Vote
INSERT INTO Traveler_Vote VALUES
(1, 1, 5, 1),
(2, 2, 4, 2);