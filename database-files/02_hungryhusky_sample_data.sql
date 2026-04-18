SET FOREIGN_KEY_CHECKS = 0;
USE `HungryHusky`;

-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;

SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 11, 2034, 'Boston College'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'WPI'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 3, 2027, 'Boston College'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Harvard'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Emerson'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Boston College'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Boston University'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Boston University'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'MIT'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 8, 2026, 'WPI'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 6, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Boston College'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 4, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Boston College'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Emerson'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 12, 2029, 'Harvard'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 9, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 13, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Boston College'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 4, 2036, 'WPI'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 4, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'WPI');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(190378124, 'Léopold', 'Said', 'sale@northeastern.edu', 1, 2034, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'fusi@northeastern.edu', 1, 2032, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'ragr@northeastern.edu', 1, 2032, 'Northeastern'),
(417164128, 'April', 'Komárek', 'koap@northeastern.edu', 1, 2032, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'kayo@northeastern.edu', 1, 2036, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'qaki@northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'luce@northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'nore@northeastern.edu', 1, 2027, 'Northeastern'),
(102847563, 'Amara', 'Diallo', 'diam@northeastern.edu', 1, 2028, 'Northeastern'),
(113920485, 'Soren', 'Andersen', 'anso@northeastern.edu', 1, 2029, 'Northeastern'),
(124538971, 'Priya', 'Nambiar', 'napr@northeastern.edu', 1, 2030, 'Northeastern'),
(135674820, 'Emeka', 'Okafor', 'okem@northeastern.edu', 1, 2033, 'Northeastern'),
(146892037, 'Yuna', 'Hashimoto', 'hayu@northeastern.edu', 1, 2027, 'Northeastern'),
(157034982, 'Tobias', 'Krüger', 'krto@northeastern.edu', 1, 2035, 'Northeastern'),
(168245793, 'Naledi', 'Dlamini', 'dlna@northeastern.edu', 1, 2028, 'Northeastern'),
(179361048, 'Mateus', 'Ferreira', 'fema@northeastern.edu', 1, 2031, 'Northeastern'),
(201483765, 'Ingrid', 'Holm', 'hoin@northeastern.edu', 1, 2034, 'Northeastern'),
(212597834, 'Kwame', 'Asante', 'askw@northeastern.edu', 1, 2026, 'Northeastern'),
(223614590, 'Sofía', 'Reyes', 'reso@northeastern.edu', 1, 2029, 'Northeastern'),
(234728163, 'Tariq', 'Mansour', 'mata@northeastern.edu', 1, 2033, 'Northeastern'),
(245839274, 'Linnea', 'Bergström', 'beli@northeastern.edu', 1, 2035, 'Northeastern'),
(256940381, 'Kofi', 'Mensah', 'meko@northeastern.edu', 1, 2030, 'Northeastern'),
(267051492, 'Hana', 'Nakamura', 'naha@northeastern.edu', 1, 2028, 'Northeastern'),
(278162503, 'Dante', 'Esposito', 'esda@northeastern.edu', 1, 2027, 'Northeastern'),
(289273614, 'Zara', 'Osei', 'osza@northeastern.edu', 1, 2032, 'Northeastern'),
(310384725, 'Mikhail', 'Volkov', 'vomi@northeastern.edu', 1, 2031, 'Northeastern'),
(321495836, 'Fatou', 'Balde', 'bafa@northeastern.edu', 1, 2036, 'Northeastern'),
(332506947, 'Elan', 'Shapiro', 'shel@northeastern.edu', 1, 2026, 'Northeastern'),
(343617058, 'Chiara', 'Russo', 'ruch@northeastern.edu', 1, 2033, 'Northeastern'),
(354728169, 'Idris', 'Kamara', 'kaid@northeastern.edu', 1, 2029, 'Northeastern');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItemAllergen`;

-- fabricate-flush

ALTER TABLE `MenuItemAllergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentAllergen`;

-- fabricate-flush

ALTER TABLE `StudentAllergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `MenuItemAllergen` (`ItemId`, `AllergenId`) VALUES
(1, 6),
(1, 5),
(2, 7),
(2, 9),
(2, 6),
(2, 5),
(3, 7),
(3, 9),
(3, 27),
(4, 7),
(4, 9),
(4, 6),
(4, 5),
(4, 23),
(5, 8),
(5, 20),
(6, 7),
(6, 9),
(6, 5),
(7, 7),
(7, 9),
(7, 5),
(7, 10),
(8, 7),
(8, 9),
(8, 6),
(8, 5),
(9, 7),
(9, 9),
(9, 6),
(9, 23),
(10, 5),
(10, 6),
(11, 7),
(11, 9),
(11, 5),
(11, 20),
(12, 5),
(12, 6),
(12, 7),
(12, 9),
(12, 4),
(12, 20),
(13, 8),
(13, 4),
(13, 20),
(13, 21),
(14, 7),
(14, 9),
(14, 5),
(14, 11),
(15, 7),
(15, 9),
(15, 5),
(15, 23),
(16, 7),
(16, 9),
(16, 6),
(16, 8),
(17, 3),
(17, 7),
(17, 9),
(17, 5),
(18, 8),
(18, 7),
(18, 9),
(18, 10),
(18, 20),
(19, 7),
(19, 9),
(19, 5),
(19, 20),
(19, 21),
(20, 7),
(20, 9),
(20, 10),
(20, 20),
(21, 4),
(21, 22),
(22, 7),
(22, 9),
(22, 5),
(22, 6),
(22, 23),
(22, 29),
(23, 5),
(23, 20),
(23, 21),
(24, 7),
(24, 9),
(24, 14),
(24, 23),
(24, 29),
(25, 5),
(25, 12),
(25, 20),
(26, 7),
(26, 9),
(26, 5),
(26, 6),
(26, 23),
(26, 29),
(27, 7),
(27, 9),
(27, 5),
(27, 6),
(27, 23),
(28, 7),
(28, 9),
(28, 5),
(28, 23),
(29, 1),
(29, 8),
(29, 6),
(29, 4),
(29, 20),
(30, 29),
(30, 5),
(30, 7),
(30, 9),
(30, 20),
(31, 5),
(31, 20),
(31, 21),
(31, 2);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentAllergen` (`StudentId`, `AllergenId`) VALUES
(158088292, 1),
(158088292, 2),
(190378124, 5),
(190378124, 6),
(197261453, 7),
(197261453, 9),
(230487833, 3),
(230487833, 15),
(243651497, 8),
(253404623, 1),
(253404623, 2),
(253404623, 8),
(307146955, 5),
(329238050, 7),
(329238050, 9),
(329238050, 5),
(329238050, 6),
(385877207, 3),
(385877207, 4),
(385877207, 15),
(417164128, 10),
(421841475, 6),
(434770757, 20),
(434770757, 21),
(452236448, 22),
(452236448, 23),
(468071425, 1),
(498363326, 5),
(498363326, 8),
(518182674, 7),
(518182674, 9),
(518182674, 6),
(559275331, 24),
(559275331, 26),
(559275331, 28),
(594229870, 2),
(651783829, 3),
(654833896, 14),
(701151057, 27),
(701151057, 17),
(782593151, 29),
(787386291, 11),
(787386291, 12),
(796117600, 7),
(796117600, 9),
(796117600, 1),
(796117600, 2),
(806014339, 5),
(806014339, 6),
(806014339, 8),
(844124902, 16),
(850087733, 4),
(869436845, 30),
(902010136, 10),
(902010136, 19),
(910059737, 25),
(910059737, 28),
(910059737, 17),
(243651497, 16),
(307146955, 30),
(417164128, 20),
(421841475, 21),
(468071425, 20),
(594229870, 22),
(594229870, 25),
(654833896, 4),
(654833896, 15),
(158088292, 23),
(158088292, 8),
(190378124, 7),
(190378124, 9),
(197261453, 5),
(230487833, 4),
(253404623, 6),
(329238050, 8),
(434770757, 23),
(434770757, 22),
(452236448, 20),
(518182674, 5),
(559275331, 27),
(651783829, 1),
(701151057, 28),
(787386291, 20),
(787386291, 21),
(796117600, 5),
(796117600, 6),
(806014339, 7),
(806014339, 9),
(844124902, 22),
(850087733, 3),
(850087733, 15),
(869436845, 5),
(902010136, 7),
(902010136, 9),
(910059737, 22),
(910059737, 27),
(158088292, 14),
(158088292, 16),
(190378124, 16),
(197261453, 6),
(230487833, 8),
(243651497, 20),
(243651497, 21),
(253404623, 16),
(253404623, 14),
(307146955, 14),
(307146955, 22),
(329238050, 14),
(329238050, 16),
(385877207, 8),
(385877207, 6),
(417164128, 7),
(417164128, 9),
(421841475, 14),
(421841475, 16),
(434770757, 14),
(452236448, 5),
(468071425, 22),
(498363326, 6),
(498363326, 7),
(498363326, 9),
(518182674, 14),
(559275331, 14),
(594229870, 8),
(651783829, 4);


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
SET FOREIGN_KEY_CHECKS = 0;


-- fabricate-flush

DELETE FROM `Admin`;

-- fabricate-flush

ALTER TABLE `Admin` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Allergen`;

-- fabricate-flush

ALTER TABLE `Allergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningHall`;

-- fabricate-flush

ALTER TABLE `DiningHall` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `DiningStation`;

-- fabricate-flush

ALTER TABLE `DiningStation` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItem`;

-- fabricate-flush

ALTER TABLE `MenuItem` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `MenuItemAllergen`;

-- fabricate-flush

ALTER TABLE `MenuItemAllergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `OperatingHours`;

-- fabricate-flush

ALTER TABLE `OperatingHours` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Report`;

-- fabricate-flush

ALTER TABLE `Report` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Restaurant`;

-- fabricate-flush

ALTER TABLE `Restaurant` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Review`;

-- fabricate-flush

ALTER TABLE `Review` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `SavedSpot`;

-- fabricate-flush

ALTER TABLE `SavedSpot` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Student`;

-- fabricate-flush

ALTER TABLE `Student` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentAllergen`;

-- fabricate-flush

ALTER TABLE `StudentAllergen` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `StudentFeedback`;

-- fabricate-flush

ALTER TABLE `StudentFeedback` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `Tag`;

-- fabricate-flush

ALTER TABLE `Tag` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `UsageStats`;

-- fabricate-flush

ALTER TABLE `UsageStats` AUTO_INCREMENT = 1;

-- fabricate-flush

DELETE FROM `WaitTime`;

-- fabricate-flush

ALTER TABLE `WaitTime` AUTO_INCREMENT = 1;

-- fabricate-flush


INSERT INTO `Admin` (`AdminId`, `HallId`, `FirstName`, `LastName`, `Email`, `Role`, `Department`) VALUES
(1, 1, 'Charlotte', 'Garcia', 'garcia.ch@northeastern.edu', 'Director', 'Dining Services'),
(2, 2, 'Mary', 'Johnson', 'johnson.m@northeastern.edu', 'Manager', 'Dining Services'),
(3, 3, 'Ruusa', 'Nyambirai', 'ruusa.nyambirai@northeastern.edu', 'Coordinator', 'Nutrition'),
(4, 4, 'Kjartan', 'Zaki', 'kjartan.zaki@northeastern.edu', 'Supervisor', 'Campus Operations'),
(5, 5, 'Arnaud', 'Pasaribu', 'arnaud.pasaribu@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(6, 6, 'Kiaan', 'Wagner', 'kiaan.wagner@northeastern.edu', 'Operations Lead', 'Facilities'),
(7, 7, 'Ateraoi', 'Nuriyev', 'ateraoi.nuriyev@northeastern.edu', 'Director', 'Dining Services'),
(8, 8, 'Jade', 'Kennedy', 'jade.kennedy@northeastern.edu', 'Manager', 'Food Safety'),
(9, 9, 'Osvaldo', 'Serafi', 'osvaldo.serafi@northeastern.edu', 'Coordinator', 'Nutrition'),
(10, 10, 'Khumo', 'Zida', 'khumo.zida@northeastern.edu', 'Supervisor', 'Campus Operations'),
(11, 11, 'Vernon', 'Henriksen', 'vernon.henriksen@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(12, 12, 'Lefa', 'Sorgho', 'lefa.sorgho@northeastern.edu', 'Operations Lead', 'Facilities'),
(13, 13, 'Franklin', 'Brown', 'franklin.brown@northeastern.edu', 'Director', 'Dining Services'),
(14, 14, 'Houmadi', 'Ward', 'houmadi.ward@northeastern.edu', 'Manager', 'Food Safety'),
(15, 15, 'Wunmi', 'Buddoo', 'wunmi.buddoo@northeastern.edu', 'Coordinator', 'Nutrition'),
(16, 16, 'Magnus', 'Muller', 'magnus.muller@northeastern.edu', 'Supervisor', 'Campus Operations'),
(17, 17, 'Fabrício', 'Balewa', 'fabrício.balewa@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(18, 18, 'Pavlos', 'Xiao', 'pavlos.xiao@northeastern.edu', 'Operations Lead', 'Facilities'),
(19, 19, 'Jasmin', 'Lệ', 'jasmin.lệ@northeastern.edu', 'Director', 'Dining Services'),
(20, 20, 'Teine', 'Sika', 'teine.sika@northeastern.edu', 'Manager', 'Food Safety'),
(21, 21, 'Pauline', 'Yesimov', 'pauline.yesimov@northeastern.edu', 'Coordinator', 'Nutrition'),
(22, 22, 'Philip', 'Vukčević', 'philip.vukčević@northeastern.edu', 'Supervisor', 'Campus Operations'),
(23, 23, 'Pauline', 'McCormick', 'pauline.mccormick@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(24, 24, 'Maurice', 'Ýagşyýev', 'maurice.ýagşyýev@northeastern.edu', 'Operations Lead', 'Facilities'),
(25, 25, 'Guled', 'Graber', 'guled.graber@northeastern.edu', 'Director', 'Dining Services'),
(26, 26, 'Rafik', 'Vui', 'rafik.vui@northeastern.edu', 'Manager', 'Food Safety'),
(27, 27, 'Mahmoud', 'Chen', 'mahmoud.chen@northeastern.edu', 'Coordinator', 'Nutrition'),
(28, 28, 'Rachid', 'Boekhoudt', 'rachid.boekhoudt@northeastern.edu', 'Supervisor', 'Campus Operations'),
(29, 29, 'Leroy', 'Khean', 'leroy.khean@northeastern.edu', 'Assistant Manager', 'Student Affairs'),
(30, 30, 'Natasha', 'Niel', 'natasha.niel@northeastern.edu', 'Operations Lead', 'Facilities');


-- fabricate-flush


INSERT INTO `Allergen` (`AllergenId`, `AllergyName`, `Severity`) VALUES
(1, 'Peanuts', 'severe'),
(2, 'Tree Nuts', 'severe'),
(3, 'Shellfish', 'severe'),
(4, 'Fish', 'moderate'),
(5, 'Milk', 'moderate'),
(6, 'Eggs', 'moderate'),
(7, 'Wheat', 'moderate'),
(8, 'Soy', 'mild'),
(9, 'Gluten', 'moderate'),
(10, 'Sesame', 'severe'),
(11, 'Mustard', 'mild'),
(12, 'Celery', 'mild'),
(13, 'Lupin', 'moderate'),
(14, 'Sulfites', 'mild'),
(15, 'Mollusks', 'severe'),
(16, 'Corn', 'mild'),
(17, 'Latex', 'moderate'),
(18, 'Sunflower Seeds', 'mild'),
(19, 'Poppy Seeds', 'mild'),
(20, 'Garlic', 'mild'),
(21, 'Onion', 'mild'),
(22, 'Citrus', 'mild'),
(23, 'Tomato', 'mild'),
(24, 'Strawberry', 'mild'),
(25, 'Kiwi', 'moderate'),
(26, 'Mango', 'mild'),
(27, 'Avocado', 'mild'),
(28, 'Banana', 'mild'),
(29, 'Red Meat', 'moderate'),
(30, 'Gelatin', 'mild');


-- fabricate-flush


INSERT INTO `DiningHall` (`HallId`, `Name`, `Location`, `CampusArea`, `Capacity`) VALUES
(1, 'Stetson East', '11 Speare Pl', 'North', 350),
(2, 'Stetson West', '10 Forsyth St', 'North', 320),
(3, 'International Village', '1155 Tremont St', 'West', 500),
(4, 'Levine Marketplace', '40 Leon St', 'Central', 420),
(5, 'Café Crossing', '55 Hemenway St', 'Central', 150),
(6, 'Outtakes', '100 St Stephen St', 'South', 80),
(7, 'The West End', '245 Columbus Ave', 'West', 275),
(8, 'Argo Tea Café', '30 Gainsborough St', 'Central', 65),
(9, 'Popeyes', '50 Forsyth St', 'North', 90),
(10, 'Tú Taco', '380 Huntington Ave', 'Central', 85),
(11, 'The Faculty Club', '12 Columbus Pl', 'West', 180),
(12, 'Uburger', '62 Hemenway St', 'Central', 95),
(13, 'Café 716', '716 Columbus Ave', 'South', 110),
(14, 'Kigo Kitchen', '200 Ruggles St', 'South', 120),
(15, 'Rebecca''s Café', '15 Egan Way', 'North', 100),
(16, 'The Commons', '525 Parker St', 'East', 450),
(17, 'Wollaston''s Market', '22 Leon St', 'Central', 70),
(18, 'Sweet Tomatoes', '140 The Fenway', 'West', 200),
(19, 'Gyroscope', '290 Huntington Ave', 'Central', 105),
(20, 'Churchill Hall Dining', '44 St Botolph St', 'South', 310),
(21, 'Marine Science Café', '430 Nahant Rd', 'East', 75),
(22, 'Global Bites', '105 Forsyth St', 'North', 160),
(23, 'The Noodle Bar', '78 St Stephen St', 'South', 90),
(24, 'Café Quattro', '400 Huntington Ave', 'Central', 130),
(25, 'The Green Line Grill', '220 Ruggles St', 'South', 185),
(26, 'Beantown Bistro', '33 Gainsborough St', 'Central', 145),
(27, 'Curry Kitchen', '346 Huntington Ave', 'Central', 115),
(28, 'Harbor Eatery', '1 University Ave', 'East', 260),
(29, 'Steast Express', '13 Speare Pl', 'North', 55),
(30, 'Midtown Market', '77 St Botolph St', 'South', 170);


-- fabricate-flush


INSERT INTO `DiningStation` (`StationId`, `HallId`, `ItemId`, `Name`, `WaitMinutes`, `UpdatedAt`) VALUES
(1, 1, 1, 'Egg Bar', 3, '2025-01-15 07:30:00'),
(2, 1, 2, 'Griddle Station', 5, '2025-01-15 07:45:00'),
(3, 1, 11, 'Wrap Counter', 4, '2025-01-15 11:30:00'),
(4, 1, 21, 'Seafood Grill', 8, '2025-01-15 17:00:00'),
(5, 1, 42, 'Bread Oven', 2, '2025-01-15 16:30:00'),
(6, 1, 43, 'Dessert Case', 1, '2025-01-15 18:00:00'),
(7, 2, 3, 'Toast Bar', 3, '2025-01-15 08:00:00'),
(8, 2, 4, 'Burrito Roller', 5, '2025-01-15 08:15:00'),
(9, 2, 12, 'Salad Station', 2, '2025-01-15 11:45:00'),
(10, 2, 22, 'Pasta Bar', 6, '2025-01-15 17:30:00'),
(11, 2, 44, 'Italian Sweets', 1, '2025-01-15 18:15:00'),
(12, 3, 5, 'Asian Breakfast Bar', 4, '2025-01-15 07:30:00'),
(13, 3, 13, 'Noodle Soup Station', 7, '2025-01-15 12:00:00'),
(14, 3, 23, 'Curry Counter', 5, '2025-01-15 17:15:00'),
(15, 3, 45, 'Tropical Desserts', 2, '2025-01-15 18:30:00'),
(16, 4, 6, 'Oatmeal & Cereal Bar', 2, '2025-01-15 07:00:00'),
(17, 4, 24, 'BBQ Pit', 8, '2025-01-15 17:00:00'),
(18, 4, 46, 'Bakery Counter', 2, '2025-01-15 18:00:00'),
(19, 5, 7, 'Bagel Station', 3, '2025-01-15 07:30:00'),
(20, 5, 33, 'Dip & Chip Bar', 2, '2025-01-15 14:00:00'),
(21, 5, 53, 'Coffee Bar', 4, '2025-01-15 08:00:00'),
(22, 6, 14, 'Deli Counter', 5, '2025-01-15 11:30:00'),
(23, 6, 34, 'Fried Appetizers', 4, '2025-01-15 15:00:00'),
(24, 7, 8, 'French Toast Griddle', 6, '2025-01-15 08:00:00'),
(25, 7, 25, 'Risotto Station', 10, '2025-01-15 17:30:00'),
(26, 7, 47, 'Crème Counter', 2, '2025-01-15 18:30:00'),
(27, 8, 15, 'Panini Press', 5, '2025-01-15 12:00:00'),
(28, 8, 54, 'Smoothie Blender', 3, '2025-01-15 10:00:00'),
(29, 9, 16, 'Chicken Fryer', 6, '2025-01-15 11:45:00'),
(30, 9, 55, 'Beverage Fountain', 1, '2025-01-15 11:30:00'),
(31, 10, 9, 'Taco Assembly', 4, '2025-01-15 08:00:00'),
(32, 10, 48, 'Churro Fryer', 3, '2025-01-15 19:00:00'),
(33, 11, 17, 'Seafood Bar', 7, '2025-01-15 12:15:00'),
(34, 11, 56, 'Espresso Machine', 2, '2025-01-15 09:00:00'),
(35, 12, 26, 'Burger Grill', 7, '2025-01-15 17:00:00'),
(36, 13, 35, 'Pretzel Warmer', 2, '2025-01-15 14:30:00'),
(37, 13, 52, 'Cheesecake Display', 1, '2025-01-15 18:00:00'),
(38, 14, 18, 'Bowl Assembly', 5, '2025-01-15 12:00:00'),
(39, 14, 57, 'Bubble Tea Station', 4, '2025-01-15 13:00:00'),
(40, 15, 27, 'Bake Oven', 6, '2025-01-15 17:30:00'),
(41, 16, 10, 'Parfait Counter', 2, '2025-01-15 07:45:00'),
(42, 16, 49, 'Ice Cream Scoop Bar', 3, '2025-01-15 19:00:00'),
(43, 17, 36, 'Snack Shelf', 1, '2025-01-15 10:00:00'),
(44, 17, 58, 'Juice Press', 3, '2025-01-15 09:30:00'),
(45, 18, 28, 'Pizza Oven', 8, '2025-01-15 17:00:00'),
(46, 19, 19, 'Gyro Rotisserie', 5, '2025-01-15 12:00:00'),
(47, 20, 32, 'Comfort Food Hearth', 6, '2025-01-15 17:15:00'),
(48, 20, 59, 'Tea & Chai Counter', 3, '2025-01-15 15:00:00'),
(49, 21, 37, 'Steamer Basket', 3, '2025-01-15 14:00:00'),
(50, 22, 20, 'Mediterranean Counter', 5, '2025-01-15 12:30:00'),
(51, 22, 50, 'Pastry Shelf', 1, '2025-01-15 18:30:00'),
(52, 23, 29, 'Wok Station', 7, '2025-01-15 17:00:00'),
(53, 24, 38, 'Guac & Chips Bar', 2, '2025-01-15 14:30:00'),
(54, 24, 60, 'Hot Cocoa Station', 3, '2025-01-15 16:00:00'),
(55, 25, 30, 'Steak Grill', 10, '2025-01-15 18:00:00'),
(56, 26, 39, 'Spring Roll Fryer', 4, '2025-01-15 13:00:00'),
(57, 27, 31, 'Tandoori Station', 6, '2025-01-15 17:30:00'),
(58, 28, 51, 'Cannoli Cart', 2, '2025-01-15 19:00:00'),
(59, 29, 40, 'Tender Fryer', 5, '2025-01-15 15:30:00'),
(60, 30, 41, 'Nacho Builder', 4, '2025-01-15 16:00:00');


-- fabricate-flush


INSERT INTO `MenuItem` (`ItemId`, `HallId`, `ItemName`, `Description`, `Category`, `IsAvailable`) VALUES
(1, 1, 'Scrambled Eggs', 'Fluffy scrambled eggs with herbs', 'Breakfast', 1),
(2, 1, 'Pancake Stack', 'Three buttermilk pancakes with maple syrup', 'Breakfast', 1),
(3, 2, 'Avocado Toast', 'Sourdough toast with smashed avocado and chili flakes', 'Breakfast', 1),
(4, 2, 'Breakfast Burrito', 'Eggs, cheese, peppers, and salsa in a flour tortilla', 'Breakfast', 1),
(5, 3, 'Congee', 'Rice porridge with ginger, scallions, and soy egg', 'Breakfast', 1),
(6, 4, 'Oatmeal Bowl', 'Steel-cut oats with berries, honey, and granola', 'Breakfast', 1),
(7, 5, 'Bagel & Cream Cheese', 'Toasted everything bagel with cream cheese', 'Breakfast', 1),
(8, 7, 'French Toast', 'Thick-cut brioche with cinnamon and powdered sugar', 'Breakfast', 0),
(9, 10, 'Breakfast Taco', 'Corn tortilla with scrambled eggs and pico de gallo', 'Breakfast', 1),
(10, 16, 'Fruit & Yogurt Parfait', 'Greek yogurt layered with granola and fresh fruit', 'Breakfast', 1),
(11, 1, 'Grilled Chicken Wrap', 'Grilled chicken, lettuce, tomato in a spinach wrap', 'Lunch', 1),
(12, 2, 'Caesar Salad', 'Romaine, parmesan, croutons, house caesar dressing', 'Lunch', 1),
(13, 3, 'Pho', 'Vietnamese beef noodle soup with fresh herbs', 'Lunch', 1),
(14, 6, 'Turkey Club Sandwich', 'Sliced turkey, bacon, lettuce, tomato on sourdough', 'Lunch', 1),
(15, 8, 'Caprese Panini', 'Fresh mozzarella, tomato, basil with balsamic glaze', 'Lunch', 1),
(16, 9, 'Fried Chicken Sandwich', 'Crispy fried chicken with pickles and spicy mayo', 'Lunch', 1),
(17, 11, 'Lobster Roll', 'Chilled lobster meat with mayo on a toasted roll', 'Lunch', 0),
(18, 14, 'Teriyaki Chicken Bowl', 'Grilled chicken over rice with teriyaki glaze', 'Lunch', 1),
(19, 19, 'Lamb Gyro', 'Seasoned lamb, tzatziki, onion in warm pita', 'Lunch', 1),
(20, 22, 'Falafel Plate', 'Crispy falafel with hummus, tabbouleh, and pita', 'Lunch', 1),
(21, 1, 'Grilled Salmon', 'Atlantic salmon with lemon dill sauce and rice', 'Dinner', 1),
(22, 2, 'Pasta Bolognese', 'Penne with slow-cooked beef and tomato ragu', 'Dinner', 1),
(23, 3, 'Chicken Tikka Masala', 'Tender chicken in creamy spiced tomato sauce', 'Dinner', 1),
(24, 4, 'BBQ Pulled Pork', 'Slow-smoked pulled pork with coleslaw on a bun', 'Dinner', 1),
(25, 7, 'Mushroom Risotto', 'Creamy arborio rice with wild mushrooms and parmesan', 'Dinner', 1),
(26, 12, 'Classic Cheeseburger', 'Angus beef patty with cheddar, lettuce, and tomato', 'Dinner', 1),
(27, 15, 'Eggplant Parmesan', 'Breaded eggplant baked with marinara and mozzarella', 'Dinner', 1),
(28, 18, 'Margherita Pizza', 'Wood-fired pizza with tomato, mozzarella, and basil', 'Dinner', 1),
(29, 23, 'Pad Thai', 'Rice noodles with shrimp, peanuts, and tamarind sauce', 'Dinner', 0),
(30, 25, 'Steak Frites', 'Grilled sirloin with herb butter and crispy fries', 'Dinner', 1),
(31, 27, 'Butter Chicken', 'Chicken in rich buttery tomato-cream sauce with naan', 'Dinner', 1),
(32, 20, 'Shepherd''s Pie', 'Ground lamb with vegetables under mashed potato crust', 'Dinner', 1),
(33, 5, 'Hummus & Pita Chips', 'House-made hummus with warm seasoned pita chips', 'Snack', 1),
(34, 6, 'Mozzarella Sticks', 'Breaded mozzarella with marinara dipping sauce', 'Snack', 1),
(35, 13, 'Soft Pretzel', 'Warm salted pretzel with cheese dip', 'Snack', 1),
(36, 17, 'Trail Mix Cup', 'Mixed nuts, dried fruit, and chocolate chips', 'Snack', 1),
(37, 21, 'Edamame', 'Steamed edamame pods with sea salt', 'Snack', 1),
(38, 24, 'Chips & Guacamole', 'Tortilla chips with fresh-made guacamole', 'Snack', 1),
(39, 26, 'Spring Rolls', 'Crispy vegetable spring rolls with sweet chili sauce', 'Snack', 1),
(40, 29, 'Chicken Tenders', 'Breaded chicken strips with honey mustard', 'Snack', 1),
(41, 30, 'Loaded Nachos', 'Tortilla chips with cheese, beans, jalapeños, sour cream', 'Snack', 0),
(42, 1, 'Garlic Bread', 'Toasted baguette with garlic butter and parsley', 'Snack', 1),
(43, 1, 'Chocolate Brownie', 'Fudgy chocolate brownie with walnuts', 'Dessert', 1),
(44, 2, 'Tiramisu', 'Espresso-soaked ladyfingers with mascarpone cream', 'Dessert', 1),
(45, 3, 'Mango Sticky Rice', 'Sweet coconut sticky rice with fresh mango', 'Dessert', 1),
(46, 4, 'Apple Pie Slice', 'Classic apple pie with flaky crust à la mode', 'Dessert', 1),
(47, 7, 'Crème Brûlée', 'Vanilla custard with caramelized sugar top', 'Dessert', 1),
(48, 10, 'Churros', 'Fried dough sticks with cinnamon sugar and chocolate', 'Dessert', 1),
(49, 16, 'Ice Cream Sundae', 'Vanilla ice cream with hot fudge and whipped cream', 'Dessert', 1),
(50, 22, 'Baklava', 'Flaky phyllo pastry with honey and pistachios', 'Dessert', 1),
(51, 28, 'Cannoli', 'Crispy shell filled with sweet ricotta cream', 'Dessert', 0),
(52, 13, 'Cheesecake Slice', 'New York-style cheesecake with strawberry topping', 'Dessert', 1),
(53, 5, 'Iced Coffee', 'Cold-brewed coffee served over ice', 'Other', 1),
(54, 8, 'Green Smoothie', 'Spinach, banana, mango, and almond milk blend', 'Other', 1),
(55, 9, 'Lemonade', 'Fresh-squeezed lemonade with mint', 'Other', 1),
(56, 11, 'Espresso', 'Double shot of house espresso', 'Other', 1),
(57, 14, 'Bubble Tea', 'Milk tea with tapioca pearls', 'Other', 1),
(58, 17, 'Fresh Juice', 'Freshly pressed orange juice', 'Other', 1),
(59, 20, 'Chai Latte', 'Spiced chai tea with steamed milk', 'Other', 1),
(60, 24, 'Hot Chocolate', 'Rich cocoa with whipped cream and marshmallows', 'Other', 0);


-- fabricate-flush


INSERT INTO `MenuItemAllergen` (`ItemId`, `AllergenId`) VALUES
(1, 6),
(1, 5),
(2, 7),
(2, 9),
(2, 6),
(2, 5),
(3, 7),
(3, 9),
(3, 27),
(4, 7),
(4, 9),
(4, 6),
(4, 5),
(4, 23),
(5, 8),
(5, 20),
(6, 7),
(6, 9),
(6, 5),
(7, 7),
(7, 9),
(7, 5),
(7, 10),
(8, 7),
(8, 9),
(8, 6),
(8, 5),
(9, 7),
(9, 9),
(9, 6),
(9, 23),
(10, 5),
(10, 6),
(11, 7),
(11, 9),
(11, 5),
(11, 20),
(12, 5),
(12, 6),
(12, 7),
(12, 9),
(12, 4),
(12, 20),
(13, 8),
(13, 4),
(13, 20),
(13, 21),
(14, 7),
(14, 9),
(14, 5),
(14, 11),
(15, 7),
(15, 9),
(15, 5),
(15, 23),
(16, 7),
(16, 9),
(16, 6),
(16, 8),
(17, 3),
(17, 7),
(17, 9),
(17, 5),
(18, 8),
(18, 7),
(18, 9),
(18, 10),
(18, 20),
(19, 7),
(19, 9),
(19, 5),
(19, 20),
(19, 21),
(20, 7),
(20, 9),
(20, 10),
(20, 20),
(21, 4),
(21, 22),
(22, 7),
(22, 9),
(22, 5),
(22, 6),
(22, 23),
(22, 29),
(23, 5),
(23, 20),
(23, 21),
(24, 7),
(24, 9),
(24, 14),
(24, 23),
(24, 29),
(25, 5),
(25, 12),
(25, 20),
(26, 7),
(26, 9),
(26, 5),
(26, 6),
(26, 23),
(26, 29),
(27, 7),
(27, 9),
(27, 5),
(27, 6),
(27, 23),
(28, 7),
(28, 9),
(28, 5),
(28, 23),
(29, 1),
(29, 8),
(29, 6),
(29, 4),
(29, 20),
(30, 29),
(30, 5),
(30, 7),
(30, 9),
(30, 20),
(31, 5),
(31, 20),
(31, 21),
(31, 2);


-- fabricate-flush


INSERT INTO `OperatingHours` (`HallId`, `DayOfWeek`, `OpenTime`, `CloseTime`, `Note`) VALUES
(1, 'Monday', '2025-01-13 07:00:00', '2025-01-13 21:00:00', NULL),
(1, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 21:00:00', NULL),
(1, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 21:00:00', NULL),
(1, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 21:00:00', NULL),
(1, 'Friday', '2025-01-17 07:00:00', '2025-01-17 20:00:00', 'Early close on Fridays'),
(1, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 20:00:00', 'Weekend brunch starts at 9'),
(1, 'Sunday', '2025-01-19 09:00:00', '2025-01-19 20:00:00', 'Weekend brunch starts at 9'),
(2, 'Monday', '2025-01-13 07:30:00', '2025-01-13 20:30:00', NULL),
(2, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 20:30:00', NULL),
(2, 'Wednesday', '2025-01-15 07:30:00', '2025-01-15 20:30:00', NULL),
(2, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 20:30:00', NULL),
(2, 'Friday', '2025-01-17 07:30:00', '2025-01-17 19:30:00', 'Early close on Fridays'),
(2, 'Saturday', '2025-01-18 10:00:00', '2025-01-18 19:00:00', NULL),
(2, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 19:00:00', NULL),
(3, 'Monday', '2025-01-13 07:00:00', '2025-01-13 22:00:00', NULL),
(3, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 22:00:00', NULL),
(3, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 22:00:00', NULL),
(3, 'Thursday', '2025-01-16 07:00:00', '2025-01-16 22:00:00', 'Late night menu available after 9pm'),
(3, 'Friday', '2025-01-17 07:00:00', '2025-01-17 23:00:00', 'Extended hours on Friday'),
(3, 'Saturday', '2025-01-18 08:00:00', '2025-01-18 23:00:00', 'Extended weekend hours'),
(3, 'Sunday', '2025-01-19 08:00:00', '2025-01-19 21:00:00', NULL),
(4, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(4, 'Wednesday', '2025-01-15 07:00:00', '2025-01-15 20:00:00', NULL),
(4, 'Friday', '2025-01-17 07:00:00', '2025-01-17 15:00:00', 'MLK weekend — closing early'),
(5, 'Monday', '2025-01-13 08:00:00', '2025-01-13 18:00:00', NULL),
(5, 'Thursday', '2025-01-16 08:00:00', '2025-01-16 18:00:00', NULL),
(6, 'Monday', '2025-01-13 10:00:00', '2025-01-13 22:00:00', NULL),
(6, 'Saturday', '2025-01-18 11:00:00', '2025-01-18 20:00:00', 'Reduced weekend hours'),
(7, 'Tuesday', '2025-01-14 07:00:00', '2025-01-14 20:00:00', NULL),
(7, 'Friday', '2025-01-17 07:00:00', '2025-01-17 21:00:00', NULL),
(8, 'Monday', '2025-01-13 06:30:00', '2025-01-13 19:00:00', NULL),
(8, 'Wednesday', '2025-01-15 06:30:00', '2025-01-15 19:00:00', NULL),
(9, 'Monday', '2025-01-13 10:30:00', '2025-01-13 21:00:00', NULL),
(9, 'Sunday', '2025-01-19 11:00:00', '2025-01-19 18:00:00', 'Holiday hours — closes early'),
(10, 'Tuesday', '2025-01-14 08:00:00', '2025-01-14 21:00:00', NULL),
(11, 'Wednesday', '2025-01-15 11:00:00', '2025-01-15 15:00:00', 'Faculty/staff lunch service only'),
(12, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 22:00:00', NULL),
(14, 'Monday', '2025-01-13 11:00:00', '2025-01-13 21:00:00', NULL),
(16, 'Monday', '2025-01-13 07:00:00', '2025-01-13 20:00:00', NULL),
(16, 'Saturday', '2025-01-18 09:00:00', '2025-01-18 14:00:00', 'Spring semester move-in — limited service'),
(17, 'Monday', '2025-01-13 07:00:00', '2025-01-13 23:00:00', 'Convenience store hours'),
(19, 'Friday', '2025-01-17 11:00:00', '2025-01-17 20:00:00', NULL),
(20, 'Tuesday', '2025-01-14 07:30:00', '2025-01-14 19:30:00', NULL),
(20, 'Thursday', '2025-01-16 07:30:00', '2025-01-16 14:00:00', 'Thanksgiving break — lunch only'),
(22, 'Wednesday', '2025-01-15 10:00:00', '2025-01-15 20:00:00', NULL),
(23, 'Thursday', '2025-01-16 11:00:00', '2025-01-16 21:30:00', NULL),
(25, 'Friday', '2025-01-17 11:00:00', '2025-01-17 22:00:00', 'Late night grill on Fridays'),
(27, 'Saturday', '2025-01-18 12:00:00', '2025-01-18 21:00:00', NULL),
(13, 'Friday', '2025-01-17 08:00:00', '2025-01-17 17:00:00', 'Closed early — winter storm warning'),
(28, 'Sunday', '2025-01-19 10:00:00', '2025-01-19 16:00:00', 'Sunday brunch service only');


-- fabricate-flush


INSERT INTO `Report` (`ReportId`, `AdminId`, `Title`, `ExportDate`, `Format`, `StartDate`, `EndDate`) VALUES
(1, 1, 'Monthly Usage Summary', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(2, 2, 'Weekly Visitor Report', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(3, 3, 'Allergen Compliance', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(4, 4, 'Revenue Breakdown', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(5, 5, 'Peak Hour Analysis', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(6, 6, 'Student Satisfaction', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(7, 7, 'Menu Item Popularity', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(8, 8, 'Wait Time Trends', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(9, 9, 'Dining Hall Capacity', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(10, 10, 'Feedback Overview', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(11, 11, 'Budget Report', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(12, 12, 'Staffing Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(13, 13, 'Food Waste Audit', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(14, 14, 'Vendor Performance', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(15, 15, 'Health Inspection Log', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(16, 16, 'Nutrition Analysis', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(17, 17, 'Seasonal Menu Review', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(18, 18, 'Event Catering Log', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(19, 19, 'Supply Chain Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(20, 20, 'Energy Usage Report', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(21, 21, 'Monthly Usage Summary', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(22, 22, 'Weekly Visitor Report', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(23, 23, 'Allergen Compliance', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(24, 24, 'Revenue Breakdown', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(25, 25, 'Peak Hour Analysis', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(26, 26, 'Student Satisfaction', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(27, 27, 'Menu Item Popularity', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(28, 28, 'Wait Time Trends', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(29, 29, 'Dining Hall Capacity', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(30, 30, 'Feedback Overview', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(31, 1, 'Budget Report', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(32, 2, 'Staffing Analysis', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(33, 3, 'Food Waste Audit', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(34, 4, 'Vendor Performance', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(35, 5, 'Health Inspection Log', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(36, 6, 'Nutrition Analysis', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(37, 7, 'Seasonal Menu Review', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(38, 8, 'Event Catering Log', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28'),
(39, 9, 'Supply Chain Report', '2024-04-28', 'Excel', '2024-03-01', '2024-03-31'),
(40, 10, 'Energy Usage Report', '2024-05-28', 'PDF', '2024-04-01', '2024-04-30'),
(41, 11, 'Monthly Usage Summary', '2024-06-28', 'CSV', '2024-05-01', '2024-05-31'),
(42, 12, 'Weekly Visitor Report', '2024-07-28', 'Excel', '2024-06-01', '2024-06-30'),
(43, 13, 'Allergen Compliance', '2024-08-28', 'PDF', '2024-07-01', '2024-07-31'),
(44, 14, 'Revenue Breakdown', '2024-09-28', 'CSV', '2024-08-01', '2024-08-31'),
(45, 15, 'Peak Hour Analysis', '2024-10-28', 'Excel', '2024-09-01', '2024-09-30'),
(46, 16, 'Student Satisfaction', '2024-11-28', 'PDF', '2024-10-01', '2024-10-31'),
(47, 17, 'Menu Item Popularity', '2024-12-28', 'CSV', '2024-11-01', '2024-11-30'),
(48, 18, 'Wait Time Trends', '2024-12-28', 'Excel', '2024-12-01', '2024-12-31'),
(49, 19, 'Dining Hall Capacity', '2024-02-28', 'PDF', '2024-01-01', '2024-01-31'),
(50, 20, 'Feedback Overview', '2024-03-28', 'CSV', '2024-02-01', '2024-02-28');


-- fabricate-flush


INSERT INTO `Restaurant` (`RestaurantId`, `Name`, `Address`, `PriceRange`, `Cuisine`, `DistFromCampus`) VALUES
(1, 'Giacomo''s Ristorante', '355 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.1),
(2, 'Neptune Oyster', '63 Salem St, Boston, MA 02113', '$$$', 'American', 2.3),
(3, 'Peach Farm', '4 Tyler St, Boston, MA 02111', '$$', 'Chinese', 1.8),
(4, 'Gourmet Dumpling House', '52 Beach St, Boston, MA 02111', '$', 'Chinese', 1.7),
(5, 'El Pelon Taqueria', '92 Peterborough St, Boston, MA 02215', '$', 'Mexican', 0.4),
(6, 'Oleana', '134 Hampshire St, Cambridge, MA 02139', '$$$', 'Mediterranean', 3.5),
(7, 'Punjab Palace', '109 Hampshire St, Cambridge, MA 02139', '$$', 'Indian', 3.4),
(8, 'Myers + Chang', '1145 Washington St, Boston, MA 02118', '$$', 'Fusion', 1.2),
(9, 'Toro', '1704 Washington St, Boston, MA 02118', '$$$', 'Mediterranean', 1.5),
(10, 'La Taberna', '239 Hanover St, Boston, MA 02113', '$$', 'Italian', 2.2),
(11, 'Wingstop', '1400 Tremont St, Boston, MA 02120', '$', 'American', 0.6),
(12, 'India Quality', '484 Commonwealth Ave, Boston, MA 02215', '$$', 'Indian', 0.9),
(13, 'Anna''s Taqueria', '822 Somerville Ave, Cambridge, MA 02140', '$', 'Mexican', 3.1),
(14, 'O Ya', '9 East St, Boston, MA 02111', '$$$$', 'Fusion', 1.9),
(15, 'Mamma Maria', '3 North Square, Boston, MA 02113', '$$$$', 'Italian', 2.5),
(16, 'China King', '60 Beach St, Boston, MA 02111', '$', 'Chinese', 1.8),
(17, 'Lolita Cocina', '271 Dartmouth St, Boston, MA 02116', '$$$', 'Mexican', 1.1),
(18, 'Sarma', '249 Pearl St, Somerville, MA 02145', '$$$', 'Mediterranean', 3.8),
(19, 'The Salty Pig', '130 Dartmouth St, Boston, MA 02116', '$$', 'American', 1),
(20, 'Shanti Taste of India', '1111 Dorchester Ave, Boston, MA 02125', '$$', 'Indian', 4.2),
(21, 'Coppa Enoteca', '253 Shawmut Ave, Boston, MA 02118', '$$$', 'Italian', 1.3),
(22, 'Dumpling Xuan', '77 Harrison Ave, Boston, MA 02111', '$', 'Chinese', 1.6),
(23, 'Veggie Galaxy', '450 Massachusetts Ave, Cambridge, MA 02139', '$$', 'American', 2.8),
(24, 'Casa Razdora', '115 Water St, Boston, MA 02109', '$$', 'Italian', 2.6),
(25, 'Chilacates', '175 Huntington Ave, Boston, MA 02115', '$', 'Mexican', 0.3),
(26, 'Café ArtScience', '650 E Kendall St, Cambridge, MA 02142', '$$$', 'Fusion', 3),
(27, 'Tasty Burger', '1301 Boylston St, Boston, MA 02215', '$', 'American', 0.5),
(28, 'Rino''s Place', '258 Saratoga St, Boston, MA 02128', '$$', 'Italian', 4.5),
(29, 'Pho Hoa', '199 Brighton Ave, Allston, MA 02134', '$', 'Other', 3.2),
(30, 'Rani Indian Bistro', '1375 Washington St, Boston, MA 02118', '$$', 'Indian', 1);


-- fabricate-flush


INSERT INTO `Review` (`ReviewId`, `StudentId`, `HallId`, `RestaurantId`, `Rating`, `Comment`, `AllergenFlag`, `PriceRating`, `ReviewDate`) VALUES
(1, 158088292, 1, NULL, 3, 'Great food, quick service!', NULL, 2, '2025-01-13'),
(2, 190378124, NULL, 2, 4, 'Loved the variety of options.', NULL, 3, '2025-01-14'),
(3, 197261453, 3, 3, 4, 'A bit crowded during lunch.', NULL, 3, '2025-01-15'),
(4, 230487833, 4, NULL, 5, 'Best pasta on campus.', NULL, 4, '2025-01-16'),
(5, 243651497, NULL, 5, 5, 'Excellent vegan options.', NULL, 1, '2025-01-17'),
(6, 253404623, 6, 6, 4, 'Could use more seating.', NULL, 3, '2025-01-18'),
(7, 307146955, 7, NULL, 3, 'Fresh ingredients, would recommend.', NULL, 4, '2025-01-19'),
(8, 329238050, NULL, 8, 2, 'Long wait but worth it.', NULL, 2, '2025-01-20'),
(9, 385877207, 9, 9, 5, 'Decent portion sizes.', NULL, 5, '2025-01-21'),
(10, 417164128, 10, NULL, 4, 'Perfect for a quick bite.', NULL, 3, '2025-01-22'),
(11, 421841475, NULL, 11, 3, 'The curry was amazing!', NULL, 2, '2025-01-23'),
(12, 434770757, 12, 12, 4, 'Friendly staff.', NULL, 3, '2025-01-24'),
(13, 452236448, 13, NULL, 4, 'Not enough gluten-free options.', NULL, 3, '2025-01-25'),
(14, 468071425, NULL, 14, 5, 'Always reliable and tasty.', NULL, 4, '2025-01-26'),
(15, 498363326, 15, 15, 5, 'My go-to lunch spot.', NULL, 1, '2025-01-27'),
(16, 518182674, 16, NULL, 4, 'Pizza was a bit cold.', 'contains nuts', 3, '2025-01-28'),
(17, 559275331, NULL, 17, 3, 'Love the late night hours.', 'gluten-free available', 4, '2025-01-29'),
(18, 594229870, 3, 18, 2, 'Great smoothies!', 'dairy-free option', 2, '2025-01-30'),
(19, 651783829, 19, NULL, 5, 'Overpriced for what you get.', 'vegan option available', 5, '2025-01-13'),
(20, 654833896, NULL, 20, 4, 'Solid breakfast options.', 'contains shellfish', 3, '2025-01-14'),
(21, 701151057, 6, 1, 3, 'The tacos here are unbeatable.', 'nut-free zone', 2, '2025-01-15'),
(22, 782593151, 22, NULL, 4, 'Wish they had more desserts.', 'soy-free available', 3, '2025-01-16'),
(23, 787386291, NULL, 23, 4, 'Clean and well-maintained.', 'egg-free option', 3, '2025-01-17'),
(24, 796117600, 9, 4, 5, 'Good coffee selection.', 'halal certified', 4, '2025-01-18'),
(25, 806014339, 25, NULL, 5, 'Average food, nothing special.', 'kosher available', 1, '2025-01-19'),
(26, 844124902, NULL, 26, 4, 'The burger was perfectly cooked.', NULL, 3, '2025-01-20'),
(27, 850087733, 12, 7, 3, 'Nice ambiance.', NULL, 4, '2025-01-21'),
(28, 869436845, 28, NULL, 2, 'Allergen info was clearly posted.', NULL, 2, '2025-01-22'),
(29, 902010136, NULL, 29, 5, 'Would love more spicy options.', NULL, 5, '2025-01-23'),
(30, 910059737, 15, 10, 4, 'Consistently good quality.', NULL, 3, '2025-01-24'),
(31, 158088292, 1, NULL, 3, 'Best dining hall on campus!', NULL, 2, '2025-01-25'),
(32, 190378124, NULL, 2, 4, 'The salad bar is fantastic.', NULL, 3, '2025-01-26'),
(33, 197261453, 3, 13, 4, 'Needs better vegetarian options.', NULL, 3, '2025-01-27'),
(34, 230487833, 4, NULL, 5, 'Portion sizes could be bigger.', NULL, 4, '2025-01-28'),
(35, 243651497, NULL, 5, 5, 'Great value for the price.', NULL, 1, '2025-01-29'),
(36, 253404623, 6, 16, 4, 'The sushi was surprisingly good.', NULL, 3, '2025-01-30'),
(37, 307146955, 7, NULL, 3, 'Too salty for my taste.', NULL, 4, '2025-01-13'),
(38, 329238050, NULL, 8, 2, 'Excellent Mediterranean spread.', NULL, 2, '2025-01-14'),
(39, 385877207, 9, 19, 5, 'Love their breakfast burritos.', NULL, 5, '2025-01-15'),
(40, 417164128, 10, NULL, 4, 'The noodle soup hit the spot.', NULL, 3, '2025-01-16'),
(41, 421841475, NULL, 11, 3, 'Could improve dessert selection.', 'contains nuts', 2, '2025-01-17'),
(42, 434770757, 12, 2, 4, 'Fast and efficient service.', 'gluten-free available', 3, '2025-01-18'),
(43, 452236448, 13, NULL, 4, 'The steak was cooked perfectly.', 'dairy-free option', 3, '2025-01-19'),
(44, 468071425, NULL, 14, 5, 'Great place to study and eat.', 'vegan option available', 4, '2025-01-20'),
(45, 498363326, 15, 5, 5, 'Wish they were open later.', 'contains shellfish', 1, '2025-01-21'),
(46, 518182674, 16, NULL, 4, 'The fried chicken is addictive.', 'nut-free zone', 3, '2025-01-22'),
(47, 559275331, NULL, 17, 3, 'Good healthy options available.', 'soy-free available', 4, '2025-01-23'),
(48, 594229870, 3, 8, 2, 'The gyro was authentic.', 'egg-free option', 2, '2025-01-24'),
(49, 651783829, 19, NULL, 5, 'Nice outdoor seating area.', 'halal certified', 5, '2025-01-25'),
(50, 654833896, NULL, 20, 4, 'Always fresh and hot.', 'kosher available', 3, '2025-01-26');


-- fabricate-flush


INSERT INTO `SavedSpot` (`SavedId`, `StudentId`, `HallId`, `RestaurantId`, `TagId`, `DateAdded`, `Notes`) VALUES
(1, 158088292, 1, NULL, 1, '2025-01-05', 'Love their breakfast menu'),
(2, 190378124, NULL, 2, 2, '2025-01-06', 'Best coffee on campus'),
(3, 197261453, 3, NULL, 3, '2025-01-07', 'Great study spot'),
(4, 230487833, NULL, 4, 4, '2025-01-08', 'My go-to for lunch'),
(5, 243651497, 5, NULL, 5, '2025-01-09', 'Amazing curry selection'),
(6, 253404623, NULL, 6, 6, '2025-01-10', 'Try the window seat'),
(7, 307146955, 7, NULL, 7, '2025-01-11', 'Good for group dining'),
(8, 329238050, NULL, 8, 8, '2025-01-12', 'Late night favorite'),
(9, 385877207, 9, NULL, 9, '2025-01-13', 'Best desserts here'),
(10, 417164128, NULL, 10, 10, '2025-01-14', 'Quick grab-and-go'),
(11, 421841475, 11, NULL, 11, '2025-01-15', 'Healthy options galore'),
(12, 434770757, NULL, 12, 12, '2025-01-16', 'Perfect for rainy days'),
(13, 452236448, 13, NULL, 13, '2025-01-17', 'Get the special on Tuesdays'),
(14, 468071425, NULL, 14, 14, '2025-01-18', 'Affordable and filling'),
(15, 498363326, 15, NULL, 15, '2025-01-19', 'Great vegan menu'),
(16, 518182674, NULL, 16, 16, '2025-01-20', NULL),
(17, 559275331, 17, NULL, 17, '2025-01-21', NULL),
(18, 594229870, NULL, 18, 26, '2025-01-22', NULL),
(19, 651783829, 19, NULL, 27, '2025-01-23', NULL),
(20, 654833896, NULL, 20, 28, '2025-01-24', NULL),
(21, 701151057, 21, NULL, 29, '2025-01-25', NULL),
(22, 782593151, NULL, 22, 30, '2025-01-26', NULL),
(23, 787386291, 23, NULL, 31, '2025-01-27', NULL),
(24, 796117600, NULL, 24, 32, '2025-01-28', NULL),
(25, 806014339, 25, NULL, 33, '2025-01-29', NULL),
(26, 844124902, NULL, 26, 34, '2025-01-05', NULL),
(27, 850087733, 27, NULL, 35, '2025-01-06', NULL),
(28, 869436845, NULL, 28, 36, '2025-01-07', NULL),
(29, 902010136, 29, NULL, 37, '2025-01-08', NULL),
(30, 910059737, NULL, 30, 38, '2025-01-09', NULL),
(31, 158088292, 1, NULL, 39, '2025-01-10', NULL),
(32, 190378124, NULL, 2, 1, '2025-01-11', NULL),
(33, 197261453, 3, NULL, 2, '2025-01-12', NULL),
(34, 230487833, NULL, 4, 3, '2025-01-13', NULL),
(35, 243651497, 5, NULL, 4, '2025-01-14', NULL),
(36, 253404623, NULL, 6, 5, '2025-01-15', NULL),
(37, 307146955, 7, NULL, 6, '2025-01-16', NULL),
(38, 329238050, NULL, 8, 7, '2025-01-17', NULL),
(39, 385877207, 9, NULL, 8, '2025-01-18', NULL),
(40, 417164128, NULL, 10, 9, '2025-01-19', NULL),
(41, 421841475, 11, NULL, 10, '2025-01-20', NULL),
(42, 434770757, NULL, 12, 11, '2025-01-21', NULL),
(43, 452236448, 13, NULL, 12, '2025-01-22', NULL),
(44, 468071425, NULL, 14, 13, '2025-01-23', NULL),
(45, 498363326, 15, NULL, 14, '2025-01-24', NULL),
(46, 518182674, NULL, 16, 15, '2025-01-25', NULL),
(47, 559275331, 17, NULL, 16, '2025-01-26', NULL),
(48, 594229870, NULL, 18, 17, '2025-01-27', NULL),
(49, 651783829, 19, NULL, 26, '2025-01-28', NULL),
(50, 654833896, NULL, 20, 27, '2025-01-29', NULL);


-- fabricate-flush


INSERT INTO `Student` (`StudentId`, `FirstName`, `LastName`, `Email`, `CampusId`, `GradYear`, `University`) VALUES
(158088292, 'Rita', 'Adellach', 'rita.adellach@husky.northeastern.edu', 1, 2034, 'Northeastern'),
(190378124, 'Léopold', 'Said', 'léopold.said@ug.northeastern.edu', 1, 2034, 'Northeastern'),
(197261453, 'Lara', 'Mukonkole', 'lara.mukonkole@northeastern.edu', 1, 2036, 'Northeastern'),
(230487833, 'Simon', 'Fuimaono', 'simon.fuimaono@northeastern.edu', 1, 2032, 'Northeastern'),
(243651497, 'Siara', 'Holmberg', 'siara.holmberg@students.northeastern.edu', 1, 2027, 'Northeastern'),
(253404623, 'Gregory', 'Rasoamanarivo', 'gregory.rasoamanarivo@ug.northeastern.edu', 1, 2032, 'Northeastern'),
(307146955, 'Jelena', 'Tabe', 'jelena.tabe@northeastern.edu', 1, 2036, 'Northeastern'),
(329238050, 'Tahar', 'Harel', 'tahar.harel@ug.northeastern.edu', 1, 2028, 'Northeastern'),
(385877207, 'Taha', 'Danailov', 'taha.danailov@northeastern.edu', 1, 2030, 'Northeastern'),
(417164128, 'April', 'Komárek', 'april.komárek@husky.northeastern.edu', 1, 2032, 'Northeastern'),
(421841475, 'Sioeli', 'Msa', 'sioeli.msa@ug.northeastern.edu', 1, 2027, 'Northeastern'),
(434770757, 'Brianna', 'Benattar', 'brianna.benattar@northeastern.edu', 1, 2034, 'Northeastern'),
(452236448, 'Rhonda', 'Munyakayanza', 'rhonda.munyakayanza@students.northeastern.edu', 1, 2030, 'Northeastern'),
(468071425, 'Yong-hwa', 'Kamilo', 'yong-hwa.kamilo@ug.northeastern.edu', 1, 2036, 'Northeastern'),
(498363326, 'Pablo', 'Nugraha', 'pablo.nugraha@mail.northeastern.edu', 1, 2026, 'Northeastern'),
(518182674, 'Ayodeji', 'Vuković', 'ayodeji.vuković@students.northeastern.edu', 1, 2030, 'Northeastern'),
(559275331, 'Toaiti', 'Sadiq', 'toaiti.sadiq@northeastern.edu', 1, 2036, 'Northeastern'),
(594229870, 'Yahya', 'Burduja', 'yahya.burduja@northeastern.edu', 1, 2033, 'Northeastern'),
(651783829, 'Leonor', 'Osorio', 'leonor.osorio@husky.northeastern.edu', 1, 2030, 'Northeastern'),
(654833896, 'Zainab', 'Carlsson', 'zainab.carlsson@students.northeastern.edu', 1, 2033, 'Northeastern'),
(701151057, 'Gloria', 'Swain', 'gloria.swain@students.northeastern.edu', 1, 2029, 'Northeastern'),
(782593151, 'Maria', 'Reifer', 'maria.reifer@students.northeastern.edu', 1, 2033, 'Northeastern'),
(787386291, 'Gabriela', 'Lau', 'gabriela.lau@northeastern.edu', 1, 2032, 'Northeastern'),
(796117600, 'Alhassan', 'Omarov', 'alhassan.omarov@northeastern.edu', 1, 2032, 'Northeastern'),
(806014339, 'Kione', 'Qadiri', 'kione.qadiri@students.northeastern.edu', 1, 2036, 'Northeastern'),
(844124902, 'Sireli', 'Nasser', 'sireli.nasser@husky.northeastern.edu', 1, 2036, 'Northeastern'),
(850087733, 'Cesare', 'Luna', 'cesare.luna@ug.northeastern.edu', 1, 2031, 'Northeastern'),
(869436845, 'Reuben', 'Novruzlu', 'reuben.novruzlu@students.northeastern.edu', 1, 2027, 'Northeastern'),
(902010136, 'Sadie', 'Naruseb', 'sadie.naruseb@northeastern.edu', 1, 2036, 'Northeastern'),
(910059737, 'Wilmarie', 'Robertson', 'wilmarie.robertson@mail.northeastern.edu', 1, 2032, 'Northeastern');


-- fabricate-flush


INSERT INTO `StudentAllergen` (`StudentId`, `AllergenId`) VALUES
(158088292, 1),
(158088292, 2),
(190378124, 5),
(190378124, 6),
(197261453, 7),
(197261453, 9),
(230487833, 3),
(230487833, 15),
(243651497, 8),
(253404623, 1),
(253404623, 2),
(253404623, 8),
(307146955, 5),
(329238050, 7),
(329238050, 9),
(329238050, 5),
(329238050, 6),
(385877207, 3),
(385877207, 4),
(385877207, 15),
(417164128, 10),
(421841475, 6),
(434770757, 20),
(434770757, 21),
(452236448, 22),
(452236448, 23),
(468071425, 1),
(498363326, 5),
(498363326, 8),
(518182674, 7),
(518182674, 9),
(518182674, 6),
(559275331, 24),
(559275331, 26),
(559275331, 28),
(594229870, 2),
(651783829, 3),
(654833896, 14),
(701151057, 27),
(701151057, 17),
(782593151, 29),
(787386291, 11),
(787386291, 12),
(796117600, 7),
(796117600, 9),
(796117600, 1),
(796117600, 2),
(806014339, 5),
(806014339, 6),
(806014339, 8),
(844124902, 16),
(850087733, 4),
(869436845, 30),
(902010136, 10),
(902010136, 19),
(910059737, 25),
(910059737, 28),
(910059737, 17),
(243651497, 16),
(307146955, 30),
(417164128, 20),
(421841475, 21),
(468071425, 20),
(594229870, 22),
(594229870, 25),
(654833896, 4),
(654833896, 15),
(158088292, 23),
(158088292, 8),
(190378124, 7),
(190378124, 9),
(197261453, 5),
(230487833, 4),
(253404623, 6),
(329238050, 8),
(434770757, 23),
(434770757, 22),
(452236448, 20),
(518182674, 5),
(559275331, 27),
(651783829, 1),
(701151057, 28),
(787386291, 20),
(787386291, 21),
(796117600, 5),
(796117600, 6),
(806014339, 7),
(806014339, 9),
(844124902, 22),
(850087733, 3),
(850087733, 15),
(869436845, 5),
(902010136, 7),
(902010136, 9),
(910059737, 22),
(910059737, 27),
(158088292, 14),
(158088292, 16),
(190378124, 16),
(197261453, 6),
(230487833, 8),
(243651497, 20),
(243651497, 21),
(253404623, 16),
(253404623, 14),
(307146955, 14),
(307146955, 22),
(329238050, 14),
(329238050, 16),
(385877207, 8),
(385877207, 6),
(417164128, 7),
(417164128, 9),
(421841475, 14),
(421841475, 16),
(434770757, 14),
(452236448, 5),
(468071425, 22),
(498363326, 6),
(498363326, 7),
(498363326, 9),
(518182674, 14),
(559275331, 14),
(594229870, 8),
(651783829, 4);


-- fabricate-flush


INSERT INTO `StudentFeedback` (`FeedbackSubmissionId`, `DietaryRestriction`, `HallId`, `Content`, `SubmittedDate`, `Status`, `CuisinePref`, `StudentId`) VALUES
(1, 'vegan', 1, 'The pasta station was excellent today, fresh ingredients and great seasoning.', '2025-01-08', 'positive', 'Italian', 158088292),
(2, 'vegetarian', 2, 'Would love to see more plant-based protein options at breakfast.', '2025-01-09', 'positive', 'Chinese', 190378124),
(3, 'pescatarian', 3, 'The stir fry was overcooked and bland. Needs improvement.', '2025-01-10', 'positive', 'Mexican', 197261453),
(4, 'gluten-free', 4, 'Great variety this week! The Mediterranean bowl was a highlight.', '2025-01-11', 'negative', 'Mediterranean', 230487833),
(5, 'halal', 5, 'Please bring back the Thursday sushi special, it was very popular.', '2025-01-12', 'negative', 'Indian', 243651497),
(6, 'kosher', 6, 'Allergy labels were missing on several items. This is a safety concern.', '2025-01-13', 'neutral', 'Fusion', 253404623),
(7, 'dairy-free', 7, 'Loved the new smoothie bar addition. Perfect after morning classes.', '2025-01-14', 'positive', 'American', 307146955),
(8, 'nut-free', 8, 'The dining hall was way too crowded during lunch. Need better flow.', '2025-01-15', 'neutral', 'Other', 329238050),
(9, 'egg-free', 9, 'Indian curry night was amazing! More events like this please.', '2025-01-16', 'positive', 'Italian', 385877207),
(10, NULL, 10, 'Breakfast options are repetitive. Same eggs and toast every day.', '2025-01-17', 'positive', 'Chinese', 417164128),
(11, NULL, 11, 'The salad bar was fresh and well-stocked. Keep it up!', '2025-01-18', 'positive', 'Mexican', 421841475),
(12, NULL, 12, 'Wish there were more halal options available during dinner.', '2025-01-19', 'positive', 'Mediterranean', 434770757),
(13, 'vegan', 13, 'The burger grill has improved significantly this semester.', '2025-01-20', 'positive', 'Indian', 452236448),
(14, 'vegetarian', 14, 'Dessert selection is lacking. More variety would be appreciated.', '2025-01-21', 'negative', 'Fusion', 468071425),
(15, 'pescatarian', 15, 'Staff was very friendly and accommodating with my dietary needs.', '2025-01-22', 'negative', 'American', 498363326),
(16, 'gluten-free', 16, 'The soup of the day is always a solid choice. Great job.', '2025-01-23', 'neutral', 'Other', 518182674),
(17, 'halal', 17, 'Pizza was undercooked last Tuesday. Quality control needed.', '2025-01-24', 'positive', 'Italian', 559275331),
(18, 'kosher', 18, 'Love the grab-and-go section for busy days between classes.', '2025-01-25', 'neutral', 'Chinese', 594229870),
(19, 'dairy-free', 19, 'The vegan options have gotten so much better this year!', '2025-01-26', 'positive', 'Mexican', 651783829),
(20, 'nut-free', 20, 'Portions feel smaller lately. Are serving sizes being reduced?', '2025-01-27', 'positive', 'Mediterranean', 654833896),
(21, 'egg-free', 21, 'Taco Tuesday is the best meal of the week, hands down.', '2025-01-28', 'positive', 'Indian', 701151057),
(22, NULL, 22, 'The coffee at the beverage station is always lukewarm.', '2025-01-29', 'positive', 'Fusion', 782593151),
(23, NULL, 23, 'Really appreciate the nutrition info posted at each station.', '2025-01-08', 'positive', 'American', 787386291),
(24, NULL, 24, 'The fried rice was greasy and sitting out too long.', '2025-01-09', 'negative', 'Other', 796117600),
(25, 'vegan', 25, 'Excellent gluten-free bread options now. Thank you!', '2025-01-10', 'negative', 'Italian', 806014339),
(26, 'vegetarian', 26, 'Would be great to have a suggestion box near the exit.', '2025-01-11', 'neutral', 'Chinese', 844124902),
(27, 'pescatarian', 27, 'The new Thai curry is incredible. Please keep it permanent!', '2025-01-12', 'positive', 'Mexican', 850087733),
(28, 'gluten-free', 28, 'Seating area could use more outlets for charging laptops.', '2025-01-13', 'neutral', 'Mediterranean', 869436845),
(29, 'halal', 29, 'Breakfast burrito station is always my first stop. So good.', '2025-01-14', 'positive', 'Indian', 902010136),
(30, 'kosher', 30, 'The fish was dry and overcooked. Not up to usual standards.', '2025-01-15', 'positive', 'Fusion', 910059737),
(31, 'dairy-free', 1, 'Great job keeping the dining area clean during peak hours.', '2025-01-16', 'positive', 'American', 158088292),
(32, 'nut-free', 2, 'More kosher options would really help students who need them.', '2025-01-17', 'positive', 'Other', 190378124),
(33, 'egg-free', 3, 'The waffle station on weekends is a game changer!', '2025-01-18', 'positive', 'Italian', 197261453),
(34, NULL, 4, 'Ran out of the chicken entree by 6pm. Please make more.', '2025-01-19', 'negative', 'Chinese', 230487833),
(35, NULL, 5, 'The Mediterranean hummus plate is chef''s kiss.', '2025-01-20', 'negative', 'Mexican', 243651497),
(36, NULL, 6, 'Late night dining hours are a lifesaver during finals.', '2025-01-21', 'neutral', 'Mediterranean', 253404623),
(37, 'vegan', 7, 'The mac and cheese has gone downhill this semester.', '2025-01-22', 'positive', 'Indian', 307146955),
(38, 'vegetarian', 8, 'Appreciate the seasonal menu changes. Keeps things interesting.', '2025-01-23', 'neutral', 'Fusion', 329238050),
(39, 'pescatarian', 9, 'The noodle soup on cold days is exactly what we need.', '2025-01-24', 'positive', 'American', 385877207),
(40, 'gluten-free', 10, 'Would love a dedicated nut-free station for safety.', '2025-01-25', 'positive', 'Other', 417164128),
(41, 'halal', 11, 'Brunch on Sundays is my favorite meal of the whole week.', '2025-01-26', 'positive', 'Italian', 421841475),
(42, 'kosher', 12, 'The fruit selection has been lacking lately. More variety please.', '2025-01-27', 'positive', 'Chinese', 434770757),
(43, 'dairy-free', 13, 'Excellent catering for the campus event last weekend!', '2025-01-28', 'positive', 'Mexican', 452236448),
(44, 'nut-free', 14, 'The grilled chicken is always reliable and well-seasoned.', '2025-01-29', 'negative', 'Mediterranean', 468071425),
(45, 'egg-free', 15, 'Wish the salad dressings were house-made instead of bottled.', '2025-01-08', 'negative', 'Indian', 498363326),
(46, NULL, 16, 'The dim sum special was a wonderful surprise!', '2025-01-09', 'neutral', 'Fusion', 518182674),
(47, NULL, 17, 'Dining hall music is too loud. Hard to have conversations.', '2025-01-10', 'positive', 'American', 559275331),
(48, NULL, 18, 'The panini press station is underrated. More people should try it.', '2025-01-11', 'neutral', 'Other', 594229870),
(49, 'vegan', 19, 'Really enjoyed the cultural food night celebrating Lunar New Year.', '2025-01-12', 'positive', 'Italian', 651783829),
(50, 'vegetarian', 20, 'Overall satisfied with the dining experience this semester.', '2025-01-13', 'positive', 'Chinese', 654833896);


-- fabricate-flush


INSERT INTO `Tag` (`TagId`, `Name`, `Category`) VALUES
(1, 'Italian', 'cuisine preference'),
(2, 'Chinese', 'cuisine preference'),
(3, 'Mexican', 'cuisine preference'),
(4, 'Indian', 'cuisine preference'),
(5, 'Mediterranean', 'cuisine preference'),
(6, 'Fusion', 'cuisine preference'),
(7, 'American', 'cuisine preference'),
(8, 'Other', 'cuisine preference'),
(9, 'Vegan', 'food type'),
(10, 'Vegetarian', 'food type'),
(11, 'Halal', 'food type'),
(12, 'Kosher', 'food type'),
(13, 'Organic', 'food type'),
(14, 'Seafood', 'food type'),
(15, 'BBQ', 'food type'),
(16, 'Fast Food', 'food type'),
(17, 'Comfort Food', 'food type'),
(26, 'Budget-Friendly', 'other'),
(27, 'Late Night', 'other'),
(28, 'Spicy', 'other'),
(29, 'Locally Sourced', 'other'),
(30, 'High Protein', 'other'),
(31, 'Vegan', 'allergen'),
(32, 'Vegetarian', 'allergen'),
(33, 'Pescatarian', 'allergen'),
(34, 'Gluten-Free', 'allergen'),
(35, 'Halal', 'allergen'),
(36, 'Kosher', 'allergen'),
(37, 'Dairy-Free', 'allergen'),
(38, 'Nut-Free', 'allergen'),
(39, 'Egg-Free', 'allergen');


-- fabricate-flush


INSERT INTO `UsageStats` (`HallId`, `TimeStamp`, `VisitorCount`, `PeakHour`, `DayOfWeek`) VALUES
(1, '2025-01-13 08:00:00', 320, '12:15:00', 'Monday'),
(1, '2025-01-14 08:00:00', 290, '12:30:00', 'Tuesday'),
(1, '2025-01-15 08:00:00', 345, '12:00:00', 'Wednesday'),
(1, '2025-01-16 08:00:00', 310, '12:15:00', 'Thursday'),
(1, '2025-01-17 08:00:00', 275, '11:45:00', 'Friday'),
(2, '2025-01-13 08:00:00', 280, '12:30:00', 'Monday'),
(2, '2025-01-14 08:00:00', 265, '12:15:00', 'Tuesday'),
(2, '2025-01-15 08:00:00', 300, '12:45:00', 'Wednesday'),
(2, '2025-01-16 08:00:00', 250, '12:00:00', 'Thursday'),
(2, '2025-01-17 08:00:00', 230, '11:30:00', 'Friday'),
(3, '2025-01-13 08:00:00', 410, '12:00:00', 'Monday'),
(3, '2025-01-14 08:00:00', 385, '12:30:00', 'Tuesday'),
(3, '2025-01-15 08:00:00', 420, '12:15:00', 'Wednesday'),
(3, '2025-01-18 10:00:00', 190, '13:00:00', 'Saturday'),
(3, '2025-01-19 10:00:00', 175, '12:45:00', 'Sunday'),
(4, '2025-01-13 08:00:00', 200, '12:30:00', 'Monday'),
(4, '2025-01-15 08:00:00', 215, '12:00:00', 'Wednesday'),
(4, '2025-01-17 08:00:00', 180, '11:45:00', 'Friday'),
(5, '2025-01-13 09:00:00', 95, '12:15:00', 'Monday'),
(5, '2025-01-16 09:00:00', 110, '12:30:00', 'Thursday'),
(6, '2025-01-13 10:00:00', 150, '13:00:00', 'Monday'),
(6, '2025-01-18 11:00:00', 85, '13:30:00', 'Saturday'),
(7, '2025-01-14 08:00:00', 170, '12:00:00', 'Tuesday'),
(7, '2025-01-17 08:00:00', 195, '18:30:00', 'Friday'),
(8, '2025-01-13 07:00:00', 60, '08:30:00', 'Monday'),
(8, '2025-01-15 07:00:00', 72, '09:00:00', 'Wednesday'),
(9, '2025-01-13 11:00:00', 130, '12:30:00', 'Monday'),
(9, '2025-01-19 11:00:00', 90, '13:00:00', 'Sunday'),
(10, '2025-01-14 09:00:00', 105, '12:45:00', 'Tuesday'),
(10, '2025-01-16 09:00:00', 115, '13:00:00', 'Thursday'),
(11, '2025-01-15 11:00:00', 45, '12:00:00', 'Wednesday'),
(12, '2025-01-16 11:00:00', 120, '18:00:00', 'Thursday'),
(14, '2025-01-13 11:00:00', 85, '12:30:00', 'Monday'),
(16, '2025-01-13 08:00:00', 155, '12:00:00', 'Monday'),
(16, '2025-01-18 09:00:00', 70, '11:30:00', 'Saturday'),
(17, '2025-01-13 07:00:00', 200, '17:00:00', 'Monday'),
(19, '2025-01-17 11:00:00', 75, '12:30:00', 'Friday'),
(20, '2025-01-14 08:00:00', 140, '12:15:00', 'Tuesday'),
(20, '2025-01-16 08:00:00', 95, '12:00:00', 'Thursday'),
(22, '2025-01-15 10:00:00', 110, '12:45:00', 'Wednesday'),
(23, '2025-01-16 11:00:00', 95, '18:00:00', 'Thursday'),
(25, '2025-01-17 11:00:00', 130, '19:00:00', 'Friday'),
(27, '2025-01-18 12:00:00', 80, '13:30:00', 'Saturday'),
(28, '2025-01-19 10:00:00', 65, '12:00:00', 'Sunday'),
(13, '2025-01-17 08:00:00', 88, '10:00:00', 'Friday'),
(15, '2025-01-19 11:00:00', 55, '12:30:00', 'Sunday'),
(18, '2025-01-20 12:00:00', 100, '18:30:00', 'Monday'),
(24, '2025-01-14 09:00:00', 78, '13:00:00', 'Tuesday'),
(26, '2025-01-15 10:00:00', 92, '12:15:00', 'Wednesday'),
(29, '2025-01-16 10:00:00', 68, '14:00:00', 'Thursday');


-- fabricate-flush


INSERT INTO `WaitTime` (`RestaurantId`, `EstimatedMin`, `TimeStamp`) VALUES
(1, 15, '2025-01-13 11:30:00'),
(1, 25, '2025-01-13 12:45:00'),
(1, 10, '2025-01-13 18:00:00'),
(2, 20, '2025-01-13 11:45:00'),
(2, 35, '2025-01-13 12:30:00'),
(2, 12, '2025-01-13 18:15:00'),
(3, 10, '2025-01-14 11:30:00'),
(3, 30, '2025-01-14 12:15:00'),
(3, 18, '2025-01-14 19:00:00'),
(4, 40, '2025-01-14 12:00:00'),
(4, 25, '2025-01-14 13:00:00'),
(4, 15, '2025-01-14 18:30:00'),
(5, 8, '2025-01-15 11:30:00'),
(5, 20, '2025-01-15 12:30:00'),
(5, 5, '2025-01-15 17:00:00'),
(6, 30, '2025-01-15 12:00:00'),
(6, 45, '2025-01-15 12:45:00'),
(6, 20, '2025-01-15 18:30:00'),
(7, 12, '2025-01-16 11:30:00'),
(7, 22, '2025-01-16 12:15:00'),
(7, 8, '2025-01-16 19:00:00'),
(8, 35, '2025-01-16 12:00:00'),
(8, 28, '2025-01-16 13:00:00'),
(8, 15, '2025-01-16 18:00:00'),
(9, 18, '2025-01-17 11:30:00'),
(9, 42, '2025-01-17 12:30:00'),
(9, 10, '2025-01-17 18:30:00'),
(10, 25, '2025-01-17 12:00:00'),
(10, 38, '2025-01-17 13:00:00'),
(10, 14, '2025-01-17 19:00:00'),
(11, 20, '2025-01-18 12:00:00'),
(11, 30, '2025-01-18 18:30:00'),
(12, 15, '2025-01-18 11:30:00'),
(12, 25, '2025-01-18 17:00:00'),
(13, 10, '2025-01-18 12:15:00'),
(13, 35, '2025-01-18 19:00:00'),
(14, 22, '2025-01-19 12:00:00'),
(14, 40, '2025-01-19 13:00:00'),
(15, 8, '2025-01-19 11:30:00'),
(15, 18, '2025-01-19 18:00:00'),
(16, 28, '2025-01-19 12:30:00'),
(16, 12, '2025-01-19 19:30:00'),
(17, 32, '2025-01-20 12:00:00'),
(17, 16, '2025-01-20 18:00:00'),
(18, 45, '2025-01-20 12:30:00'),
(18, 20, '2025-01-20 19:00:00'),
(19, 10, '2025-01-20 11:45:00'),
(19, 28, '2025-01-20 18:30:00'),
(20, 15, '2025-01-21 12:00:00'),
(20, 35, '2025-01-21 18:00:00');


-- fabricate-flush


SET FOREIGN_KEY_CHECKS = 1;
