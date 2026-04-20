-- =============================================================
-- NutriTracker — Mock Data
-- Run this file after DDL.sql to populate the database with
-- realistic sample data for all four user personas.
-- =============================================================

USE nutritracker;
DELIMITER ;

-- =============================================================
-- DEMOGRAPHICS
-- =============================================================
INSERT INTO demographics (student_type, major, college_year, athletic_team, dietary_label) VALUES
  ('undergraduate', 'Music Technology',        'junior',   NULL,           'none'),
  ('undergraduate', 'Sports Science',          'freshman', 'Men\'s Basketball', 'none'),
  ('staff',         'Data Science',            NULL,       NULL,           'none'),
  ('staff',         'Computer Science',        NULL,       NULL,           'none'),
  ('undergraduate', 'Biology',                 'sophomore', NULL,          'vegetarian'),
  ('undergraduate', 'Computer Science',        'senior',   NULL,           'vegan'),
  ('undergraduate', 'Mechanical Engineering',  'junior',   'Men\'s Soccer', 'none'),
  ('graduate',      'Public Health',           NULL,       NULL,           'gluten-free'),
  ('undergraduate', 'Nursing',                 'freshman', NULL,           'none'),
  ('undergraduate', 'Business Administration', 'senior',   'Women\'s Tennis','none');


-- =============================================================
-- USERS
-- Passwords are bcrypt hashes of 'Password123!' for all users.
-- =============================================================
INSERT INTO users (role_id, demographic_id, first_name, last_name, email, password_hash, is_active, last_login) VALUES
  -- Students / performers
  (1, 1,  'Jordan',    'Carter',    'j.carter@northeastern.edu',    '$2b$12$KIXxHDdSrPHPHPHP1234560uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-04 08:32:00'),
  -- Athletes
  (2, 2,  'Jason',     'Batum',     'j.batum@northeastern.edu',     '$2b$12$KIXxHDdSrPHPHPHP1234561uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-04 07:15:00'),
  -- Analysts
  (3, 3,  'Immanuel',  'Hoffborne', 'i.hoffborne@northeastern.edu', '$2b$12$KIXxHDdSrPHPHPHP1234562uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-03 14:00:00'),
  -- Administrators
  (4, 4,  'Laura',     'Smith',     'l.smith@northeastern.edu',     '$2b$12$KIXxHDdSrPHPHPHP1234563uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-04 09:00:00'),
  -- Additional students
  (1, 5,  'Priya',     'Nair',      'p.nair@northeastern.edu',      '$2b$12$KIXxHDdSrPHPHPHP1234564uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-04 11:20:00'),
  (1, 6,  'Marcus',    'Webb',      'm.webb@northeastern.edu',      '$2b$12$KIXxHDdSrPHPHPHP1234565uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-03 20:45:00'),
  (2, 7,  'Diego',     'Reyes',     'd.reyes@northeastern.edu',     '$2b$12$KIXxHDdSrPHPHPHP1234566uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-04 06:50:00'),
  (3, 8,  'Anika',     'Patel',     'a.patel@northeastern.edu',     '$2b$12$KIXxHDdSrPHPHPHP1234567uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-02 16:30:00'),
  (1, 9,  'Sofia',     'Moran',     's.moran@northeastern.edu',     '$2b$12$KIXxHDdSrPHPHPHP1234568uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-04 12:10:00'),
  (2, 10, 'Tyler',     'Brooks',    't.brooks@northeastern.edu',    '$2b$12$KIXxHDdSrPHPHPHP1234569uQwErTyUiOpAsDfGhJkLzXcVbNm12', TRUE, '2025-04-04 07:00:00');


-- =============================================================
-- DINING_HALLS
-- =============================================================
INSERT INTO dining_halls (name, location, building_code, latitude, longitude, operating_hours, is_active) VALUES
  ('Stetson East',      'Willis Avenue, Boston MA',         'STE', 42.339200, -71.087800,
   '{"mon-fri": {"open": "07:00", "close": "22:00"}, "sat-sun": {"open": "09:00", "close": "21:00"}}', TRUE),
  ('Stetson West',      'Leon Street, Boston MA',           'STW', 42.338900, -71.088500,
   '{"mon-fri": {"open": "07:00", "close": "21:00"}, "sat-sun": {"open": "09:00", "close": "20:00"}}', TRUE),
  ('International Village', 'Davenport Street, Boston MA',  'IV',  42.336700, -71.086200,
   '{"mon-fri": {"open": "07:00", "close": "23:00"}, "sat-sun": {"open": "10:00", "close": "22:00"}}', TRUE),
  ('Levine Marketplace', 'Forsyth Street, Boston MA',       'LM',  42.340100, -71.089300,
   '{"mon-fri": {"open": "08:00", "close": "20:00"}, "sat-sun": {"open": "10:00", "close": "18:00"}}', TRUE),
  ('Outtakes Express',  'Curry Student Center, Boston MA',  'OE',  42.338500, -71.090100,
   '{"mon-fri": {"open": "10:00", "close": "20:00"}, "sat": {"open": "11:00", "close": "17:00"}, "sun": "closed"}', TRUE);


-- =============================================================
-- MENU_ITEMS
-- =============================================================
INSERT INTO menu_items (hall_id, name, description, meal_period, available_date, is_active) VALUES
  -- Stetson East — breakfast
  (1, 'Scrambled Eggs',          'Classic fluffy scrambled eggs',                          'breakfast', '2025-04-04', TRUE),
  (1, 'Whole Wheat Toast',       'Two slices of whole wheat bread, toasted',               'breakfast', '2025-04-04', TRUE),
  (1, 'Greek Yogurt Parfait',    'Non-fat Greek yogurt with granola and mixed berries',    'breakfast', '2025-04-04', TRUE),
  (1, 'Oatmeal',                 'Steel-cut oats with brown sugar and raisins',            'breakfast', '2025-04-04', TRUE),
  (1, 'Banana',                  'Fresh whole banana',                                     'breakfast', '2025-04-04', TRUE),
  -- Stetson East — lunch
  (1, 'Grilled Chicken Breast',  'Herb-marinated grilled chicken, 6 oz',                  'lunch',     '2025-04-04', TRUE),
  (1, 'Brown Rice',              'Steamed long-grain brown rice',                          'lunch',     '2025-04-04', TRUE),
  (1, 'Caesar Salad',            'Romaine, parmesan, croutons, Caesar dressing',           'lunch',     '2025-04-04', TRUE),
  (1, 'Vegetable Stir Fry',      'Mixed vegetables in garlic soy sauce',                   'lunch',     '2025-04-04', TRUE),
  (1, 'Tomato Soup',             'Creamy tomato basil soup',                               'lunch',     '2025-04-04', TRUE),
  -- Stetson East — dinner
  (1, 'Salmon Fillet',           'Baked Atlantic salmon with lemon dill sauce',            'dinner',    '2025-04-04', TRUE),
  (1, 'Quinoa Pilaf',            'Quinoa with roasted vegetables and herbs',               'dinner',    '2025-04-04', TRUE),
  (1, 'Steamed Broccoli',        'Fresh broccoli florets, lightly steamed',                'dinner',    '2025-04-04', TRUE),
  (1, 'Beef Burger',             '6 oz beef patty on a brioche bun with lettuce, tomato', 'dinner',    '2025-04-04', TRUE),
  (1, 'Sweet Potato Fries',      'Oven-baked sweet potato fries with sea salt',            'dinner',    '2025-04-04', TRUE),
  -- Stetson West — lunch
  (2, 'Turkey Sandwich',         'Sliced turkey, swiss, mustard on multigrain bread',      'lunch',     '2025-04-04', TRUE),
  (2, 'Black Bean Soup',         'Hearty black bean soup with cumin and lime',             'lunch',     '2025-04-04', TRUE),
  (2, 'Garden Salad',            'Mixed greens, cucumber, tomato, balsamic vinaigrette',   'lunch',     '2025-04-04', TRUE),
  (2, 'Pasta Primavera',         'Penne with seasonal vegetables in marinara sauce',       'lunch',     '2025-04-04', TRUE),
  (2, 'Apple',                   'Fresh whole apple',                                      'all_day',   '2025-04-04', TRUE),
  -- International Village — dinner
  (3, 'Chicken Tikka Masala',    'Tender chicken in spiced tomato cream sauce',            'dinner',    '2025-04-04', TRUE),
  (3, 'Basmati Rice',            'Fragrant steamed basmati rice',                          'dinner',    '2025-04-04', TRUE),
  (3, 'Naan Bread',              'Soft leavened flatbread',                                'dinner',    '2025-04-04', TRUE),
  (3, 'Lentil Dal',              'Spiced red lentil soup with turmeric',                   'dinner',    '2025-04-04', TRUE),
  (3, 'Mango Lassi',             'Yogurt-based mango drink',                               'dinner',    '2025-04-04', TRUE),
  -- Levine Marketplace — all day
  (4, 'Protein Smoothie',        'Whey protein, banana, almond milk, peanut butter',       'all_day',   '2025-04-04', TRUE),
  (4, 'Acai Bowl',               'Acai blend topped with granola, banana, honey',          'breakfast', '2025-04-04', TRUE),
  (4, 'Avocado Toast',           'Smashed avocado on sourdough with everything bagel seasoning', 'breakfast', '2025-04-04', TRUE),
  (4, 'Grilled Salmon Wrap',     'Salmon, avocado, spinach, tzatziki in a whole wheat wrap', 'lunch',  '2025-04-04', TRUE),
  (4, 'Energy Bar',              'Oats, honey, dark chocolate, almonds',                   'all_day',   '2025-04-04', TRUE),
  -- Outtakes Express — all day
  (5, 'Cheese Pizza Slice',      'Classic mozzarella and tomato sauce on hand-tossed dough', 'all_day', '2025-04-04', TRUE),
  (5, 'Buffalo Chicken Wrap',    'Crispy chicken, buffalo sauce, ranch, lettuce, cheddar', 'all_day',   '2025-04-04', TRUE),
  (5, 'Fruit Cup',               'Seasonal fresh fruit medley',                            'all_day',   '2025-04-04', TRUE),
  (5, 'Chocolate Chip Cookie',   'Large fresh-baked chocolate chip cookie',                'all_day',   '2025-04-04', TRUE),
  (5, 'Bottled Water',           '500ml spring water',                                     'all_day',   '2025-04-04', TRUE),
  -- Additional Stetson East — breakfast & lunch
  (1, 'Pancakes',                'Three fluffy pancakes with syrup and butter',             'breakfast', '2025-04-04', TRUE),
  (1, 'Hash Browns',             'Crispy golden hash browns',                              'breakfast', '2025-04-04', TRUE),
  (1, 'Fruit Smoothie Bowl',     'Blended berries topped with granola and coconut',        'breakfast', '2025-04-04', TRUE),
  (1, 'Turkey Meatballs',        'Lean turkey meatballs in marinara sauce',                'lunch',     '2025-04-04', TRUE),
  (1, 'Sweet Potato Bowl',       'Roasted sweet potato, black beans, corn, cilantro',      'lunch',     '2025-04-04', TRUE),
  (1, 'Grilled Fish Tacos',      'Mahi mahi, slaw, chipotle aioli in corn tortillas',      'dinner',    '2025-04-04', TRUE),
  (1, 'Lentil Bolognese',        'Plant-based lentil pasta sauce with penne',              'dinner',    '2025-04-04', TRUE),
  -- Additional Stetson West — lunch & dinner
  (2, 'Falafel Wrap',            'Crispy falafel, hummus, lettuce, tomato in pita',        'lunch',     '2025-04-04', TRUE),
  (2, 'Greek Salad',             'Feta, olives, cucumber, tomato, red onion, vinaigrette', 'lunch',     '2025-04-04', TRUE),
  (2, 'Chicken Shawarma',        'Spiced rotisserie chicken, tahini, pickles',             'dinner',    '2025-04-04', TRUE),
  (2, 'Roasted Vegetable Medley','Seasonal vegetables with garlic herb oil',               'dinner',    '2025-04-04', TRUE),
  (2, 'Hummus & Veggie Platter', 'Carrots, celery, cucumber with house-made hummus',       'lunch',     '2025-04-04', TRUE),
  -- Additional International Village — lunch & dinner
  (3, 'Pad Thai',                'Rice noodles, egg, tofu, peanuts, lime',                 'dinner',    '2025-04-04', TRUE),
  (3, 'Coconut Curry Soup',      'Rich coconut broth with vegetables and tofu',            'dinner',    '2025-04-04', TRUE),
  (3, 'Spring Rolls',            'Rice paper rolls with shrimp, herbs, served with sauce', 'lunch',     '2025-04-04', TRUE),
  (3, 'Japanese Teriyaki Bowl',  'Grilled chicken with sesame seeds over white rice',      'lunch',     '2025-04-04', TRUE),
  (3, 'Vegetable Fried Rice',    'Jasmine rice with egg, peas, carrots, soy sauce',        'lunch',     '2025-04-04', TRUE),
  -- Additional Levine Marketplace — variety
  (4, 'Turkey Meatball Sub',     'Mini meatballs, marinara, mozzarella on Italian herbs roll', 'lunch', '2025-04-04', TRUE),
  (4, 'Caprese Panini',          'Tomato, mozzarella, basil, balsamic on pressed bread',   'lunch',     '2025-04-04', TRUE),
  (4, 'Blueberry Muffin',        'Fresh blueberries in a tender muffin',                   'breakfast', '2025-04-04', TRUE),
  (4, 'Greek Yogurt',            'Plain non-fat Greek yogurt',                             'breakfast', '2025-04-04', TRUE),
  (4, 'Mixed Nuts',              'Almonds, cashews, walnuts mix',                          'all_day',   '2025-04-04', TRUE),
  (4, 'Tuna Poke Bowl',          'Sushi-grade tuna, rice, avocado, edamame, ginger',       'lunch',     '2025-04-04', TRUE),
  -- Additional Outtakes — variety
  (5, 'Pepperoni Pizza Slice',   'Pepperoni and mozzarella on thin crust',                 'all_day',   '2025-04-04', TRUE),
  (5, 'Veggie Burger',           'Plant-based patty, avocado, lettuce, tomato, mayo',      'all_day',   '2025-04-04', TRUE),
  (5, 'Chicken Tenders',         'Three crispy breaded chicken tenders with sauce',        'all_day',   '2025-04-04', TRUE),
  (5, 'Granola Bar',             'Oats, honey, almonds with dark chocolate chips',         'all_day',   '2025-04-04', TRUE),
  (5, 'Mixed Berry Yogurt Cup',  'Yogurt with mixed berries',                              'all_day',   '2025-04-04', TRUE);


-- =============================================================
-- MENU_ITEM_NUTRIENTS
-- Nutrient IDs: 1=Calories, 2=Total Fat, 6=Sodium,
-- 7=Total Carbohydrate, 8=Dietary Fiber, 9=Total Sugars, 10=Protein
-- =============================================================
INSERT INTO menu_item_nutrients (item_id, nutrient_id, amount) VALUES
  -- Scrambled Eggs (item 1)
  (1,1,180),(1,2,13.0),(1,6,210),(1,7,2.0),(1,8,0.0),(1,9,1.0),(1,10,13.0),
  -- Whole Wheat Toast (item 2)
  (2,1,140),(2,2,2.0),(2,6,240),(2,7,26.0),(2,8,3.0),(2,9,3.0),(2,10,5.0),
  -- Greek Yogurt Parfait (item 3)
  (3,1,280),(3,2,4.0),(3,6,95),(3,7,42.0),(3,8,3.0),(3,9,28.0),(3,10,18.0),
  -- Oatmeal (item 4)
  (4,1,220),(4,2,4.0),(4,6,105),(4,7,40.0),(4,8,5.0),(4,9,9.0),(4,10,7.0),
  -- Banana (item 5)
  (5,1,105),(5,2,0.4),(5,6,1),(5,7,27.0),(5,8,3.1),(5,9,14.0),(5,10,1.3),
  -- Grilled Chicken Breast (item 6)
  (6,1,280),(6,2,6.0),(6,6,320),(6,7,0.0),(6,8,0.0),(6,9,0.0),(6,10,52.0),
  -- Brown Rice (item 7)
  (7,1,215),(7,2,1.8),(7,6,10),(7,7,45.0),(7,8,3.5),(7,9,0.0),(7,10,5.0),
  -- Caesar Salad (item 8)
  (8,1,310),(8,2,22.0),(8,6,680),(8,7,18.0),(8,8,2.0),(8,9,3.0),(8,10,10.0),
  -- Vegetable Stir Fry (item 9)
  (9,1,190),(9,2,7.0),(9,6,540),(9,7,26.0),(9,8,5.0),(9,9,8.0),(9,10,6.0),
  -- Tomato Soup (item 10)
  (10,1,160),(10,2,8.0),(10,6,820),(10,7,18.0),(10,8,2.0),(10,9,10.0),(10,10,4.0),
  -- Salmon Fillet (item 11)
  (11,1,350),(11,2,18.0),(11,6,410),(11,7,0.0),(11,8,0.0),(11,9,0.0),(11,10,40.0),
  -- Quinoa Pilaf (item 12)
  (12,1,240),(12,2,6.0),(12,6,290),(12,7,38.0),(12,8,4.0),(12,9,3.0),(12,10,9.0),
  -- Steamed Broccoli (item 13)
  (13,1,55),(13,2,0.6),(13,6,40),(13,7,11.0),(13,8,4.5),(13,9,2.5),(13,10,4.0),
  -- Beef Burger (item 14)
  (14,1,620),(14,2,32.0),(14,6,890),(14,7,42.0),(14,8,2.0),(14,9,8.0),(14,10,38.0),
  -- Sweet Potato Fries (item 15)
  (15,1,210),(15,2,7.0),(15,6,320),(15,7,35.0),(15,8,4.0),(15,9,7.0),(15,10,3.0),
  -- Turkey Sandwich (item 16)
  (16,1,380),(16,2,9.0),(16,6,750),(16,7,44.0),(16,8,4.0),(16,9,5.0),(16,10,28.0),
  -- Black Bean Soup (item 17)
  (17,1,200),(17,2,3.0),(17,6,610),(17,7,34.0),(17,8,10.0),(17,9,4.0),(17,10,12.0),
  -- Garden Salad (item 18)
  (18,1,120),(18,2,7.0),(18,6,210),(18,7,12.0),(18,8,3.0),(18,9,5.0),(18,10,3.0),
  -- Pasta Primavera (item 19)
  (19,1,420),(19,2,10.0),(19,6,580),(19,7,68.0),(19,8,6.0),(19,9,9.0),(19,10,14.0),
  -- Apple (item 20)
  (20,1,95),(20,2,0.3),(20,6,2),(20,7,25.0),(20,8,4.4),(20,9,19.0),(20,10,0.5),
  -- Chicken Tikka Masala (item 21)
  (21,1,480),(21,2,22.0),(21,6,760),(21,7,28.0),(21,8,3.0),(21,9,10.0),(21,10,38.0),
  -- Basmati Rice (item 22)
  (22,1,200),(22,2,0.5),(22,6,5),(22,7,44.0),(22,8,0.6),(22,9,0.0),(22,10,4.0),
  -- Naan Bread (item 23)
  (23,1,260),(23,2,5.0),(23,6,420),(23,7,45.0),(23,8,2.0),(23,9,4.0),(23,10,8.0),
  -- Lentil Dal (item 24)
  (24,1,230),(24,2,4.0),(24,6,490),(24,7,36.0),(24,8,12.0),(24,9,4.0),(24,10,14.0),
  -- Mango Lassi (item 25)
  (25,1,180),(25,2,3.0),(25,6,85),(25,7,34.0),(25,8,1.0),(25,9,30.0),(25,10,6.0),
  -- Protein Smoothie (item 26)
  (26,1,420),(26,2,14.0),(26,6,220),(26,7,42.0),(26,8,4.0),(26,9,18.0),(26,10,32.0),
  -- Acai Bowl (item 27)
  (27,1,390),(27,2,11.0),(27,6,95),(27,7,62.0),(27,8,8.0),(27,9,30.0),(27,10,9.0),
  -- Avocado Toast (item 28)
  (28,1,320),(28,2,16.0),(28,6,410),(28,7,34.0),(28,8,7.0),(28,9,2.0),(28,10,9.0),
  -- Grilled Salmon Wrap (item 29)
  (29,1,490),(29,2,20.0),(29,6,680),(29,7,40.0),(29,8,5.0),(29,9,3.0),(29,10,36.0),
  -- Energy Bar (item 30)
  (30,1,210),(30,2,8.0),(30,6,95),(30,7,30.0),(30,8,3.0),(30,9,14.0),(30,10,6.0),
  -- Cheese Pizza Slice (item 31)
  (31,1,380),(31,2,14.0),(31,6,720),(31,7,48.0),(31,8,2.0),(31,9,6.0),(31,10,16.0),
  -- Buffalo Chicken Wrap (item 32)
  (32,1,510),(32,2,22.0),(32,6,1100),(32,7,44.0),(32,8,3.0),(32,9,4.0),(32,10,30.0),
  -- Fruit Cup (item 33)
  (33,1,70),(33,2,0.2),(33,6,10),(33,7,18.0),(33,8,2.0),(33,9,14.0),(33,10,1.0),
  -- Chocolate Chip Cookie (item 34)
  (34,1,290),(34,2,14.0),(34,6,180),(34,7,40.0),(34,8,1.0),(34,9,24.0),(34,10,3.0),
  -- Bottled Water (item 35)
  (35,1,0),(35,2,0.0),(35,6,0),(35,7,0.0),(35,8,0.0),(35,9,0.0),(35,10,0.0),
  -- Pancakes (item 36)
  (36,1,310),(36,2,8.0),(36,6,420),(36,7,52.0),(36,8,2.0),(36,9,18.0),(36,10,8.0),
  -- Hash Browns (item 37)
  (37,1,160),(37,2,9.0),(37,6,310),(37,7,18.0),(37,8,1.5),(37,9,1.0),(37,10,2.0),
  -- Fruit Smoothie Bowl (item 38)
  (38,1,380),(38,2,8.0),(38,6,120),(38,7,68.0),(38,8,8.0),(38,9,35.0),(38,10,12.0),
  -- Turkey Meatballs (item 39)
  (39,1,280),(39,2,14.0),(39,6,640),(39,7,22.0),(39,8,2.0),(39,9,6.0),(39,10,28.0),
  -- Sweet Potato Bowl (item 40)
  (40,1,420),(40,2,8.0),(40,6,580),(40,7,72.0),(40,8,12.0),(40,9,18.0),(40,10,14.0),
  -- Grilled Fish Tacos (item 41)
  (41,1,390),(41,2,12.0),(41,6,720),(41,7,38.0),(41,8,6.0),(41,9,4.0),(41,10,38.0),
  -- Lentil Bolognese (item 42)
  (42,1,480),(42,2,6.0),(42,6,620),(42,7,82.0),(42,8,14.0),(42,9,8.0),(42,10,18.0),
  -- Falafel Wrap (item 43)
  (43,1,520),(43,2,24.0),(43,6,890),(43,7,54.0),(43,8,10.0),(43,9,6.0),(43,10,16.0),
  -- Greek Salad (item 44)
  (44,1,240),(44,2,14.0),(44,6,480),(44,7,18.0),(44,8,4.0),(44,9,6.0),(44,10,8.0),
  -- Chicken Shawarma (item 45)
  (45,1,460),(45,2,18.0),(45,6,820),(45,7,42.0),(45,8,4.0),(45,9,8.0),(45,10,38.0),
  -- Roasted Vegetable Medley (item 46)
  (46,1,180),(46,2,6.0),(46,6,320),(46,7,28.0),(46,8,7.0),(46,9,8.0),(46,10,6.0),
  -- Hummus & Veggie Platter (item 47)
  (47,1,280),(47,2,14.0),(47,6,340),(47,7,26.0),(47,8,7.0),(47,9,4.0),(47,10,8.0),
  -- Pad Thai (item 48)
  (48,1,420),(48,2,16.0),(48,6,840),(48,7,52.0),(48,8,4.0),(48,9,12.0),(48,10,16.0),
  -- Coconut Curry Soup (item 49)
  (49,1,320),(49,2,18.0),(49,6,720),(49,7,28.0),(49,8,4.0),(49,9,8.0),(49,10,14.0),
  -- Spring Rolls (item 50)
  (50,1,220),(50,2,6.0),(50,6,580),(50,7,32.0),(50,8,2.0),(50,9,4.0),(50,10,10.0),
  -- Japanese Teriyaki Bowl (item 51)
  (51,1,480),(51,2,12.0),(51,6,960),(51,7,68.0),(51,8,3.0),(51,9,14.0),(51,10,32.0),
  -- Vegetable Fried Rice (item 52)
  (52,1,380),(52,2,10.0),(52,6,840),(52,7,52.0),(52,8,4.0),(52,9,6.0),(52,10,10.0),
  -- Turkey Meatball Sub (item 53)
  (53,1,480),(53,2,16.0),(53,6,1020),(53,7,52.0),(53,8,3.0),(53,9,8.0),(53,10,32.0),
  -- Caprese Panini (item 54)
  (54,1,420),(54,2,18.0),(54,6,680),(54,7,38.0),(54,8,2.0),(54,9,4.0),(54,10,16.0),
  -- Blueberry Muffin (item 55)
  (55,1,380),(55,2,12.0),(55,6,420),(55,7,54.0),(55,8,2.0),(55,9,28.0),(55,10,6.0),
  -- Greek Yogurt (item 56)
  (56,1,130),(56,2,0.5),(56,6,75),(56,7,6.0),(56,8,0.0),(56,9,4.0),(56,10,22.0),
  -- Mixed Nuts (item 57)
  (57,1,720),(57,2,64.0),(57,6,180),(57,7,24.0),(57,8,14.0),(57,9,8.0),(57,10,24.0),
  -- Tuna Poke Bowl (item 58)
  (58,1,520),(58,2,14.0),(58,6,680),(58,7,54.0),(58,8,6.0),(58,9,6.0),(58,10,42.0),
  -- Pepperoni Pizza Slice (item 59)
  (59,1,420),(59,2,16.0),(59,6,840),(59,7,50.0),(59,8,2.0),(59,9,8.0),(59,10,18.0),
  -- Veggie Burger (item 60)
  (60,1,480),(60,2,16.0),(60,6,820),(60,7,56.0),(60,8,8.0),(60,9,6.0),(60,10,18.0),
  -- Chicken Tenders (item 61)
  (61,1,420),(61,2,18.0),(61,6,620),(61,7,34.0),(61,8,1.0),(61,9,2.0),(61,10,32.0),
  -- Granola Bar (item 62)
  (62,1,280),(62,2,12.0),(62,6,140),(62,7,34.0),(62,8,3.0),(62,9,16.0),(62,10,6.0),
  -- Mixed Berry Yogurt Cup (item 63)
  (63,1,180),(63,2,2.0),(63,6,110),(63,7,32.0),(63,8,2.0),(63,9,18.0),(63,10,12.0);


-- =============================================================
-- NUTRITION_GOALS
-- =============================================================
INSERT INTO nutrition_goals (user_id, nutrient_id, min_value, max_value, period, effective_from, effective_to) VALUES
  -- Jordan Carter (user 1) — general health targets
  (1, 1,  1800.0, 2200.0, 'daily', '2025-01-01', NULL),
  (1, 10,  120.0,  160.0, 'daily', '2025-01-01', NULL),
  (1, 6,     NULL, 2300.0, 'daily', '2025-01-01', NULL),
  -- Jason Batum (user 2) — strict athlete targets
  (2, 1,  3000.0, 3500.0, 'daily', '2025-01-15', NULL),
  (2, 10,  200.0,  250.0, 'daily', '2025-01-15', NULL),
  (2, 7,   350.0,  450.0, 'daily', '2025-01-15', NULL),
  (2, 2,    NULL,   80.0, 'daily', '2025-01-15', NULL),
  (2, 6,    NULL, 2500.0, 'daily', '2025-01-15', NULL),
  (2, 8,    30.0,   NULL, 'daily', '2025-01-15', NULL),
  -- Priya Nair (user 5) — vegetarian targets
  (5, 1,  1600.0, 2000.0, 'daily', '2025-02-01', NULL),
  (5, 10,   60.0,  100.0, 'daily', '2025-02-01', NULL),
  (5, 8,    25.0,   NULL, 'daily', '2025-02-01', NULL),
  -- Diego Reyes (user 7) — soccer athlete targets
  (7, 1,  2800.0, 3200.0, 'daily', '2025-01-20', NULL),
  (7, 10,  180.0,  220.0, 'daily', '2025-01-20', NULL),
  (7, 7,   300.0,  400.0, 'daily', '2025-01-20', NULL),
  -- Tyler Brooks (user 10) — tennis athlete targets
  (10, 1, 2500.0, 3000.0, 'daily', '2025-02-10', NULL),
  (10, 10, 160.0,  200.0, 'daily', '2025-02-10', NULL),
  (10, 6,   NULL, 2000.0, 'daily', '2025-02-10', NULL);


-- =============================================================
-- MEAL_LOGS
-- Covers the past 7 days for key personas.
-- =============================================================
INSERT INTO meal_logs (user_id, log_date, meal_period, logged_at) VALUES
  -- Jordan Carter
  (1, '2025-03-29', 'breakfast', '2025-03-29 08:10:00'),
  (1, '2025-03-29', 'lunch',     '2025-03-29 12:45:00'),
  (1, '2025-03-29', 'dinner',    '2025-03-29 18:30:00'),
  (1, '2025-03-30', 'breakfast', '2025-03-30 08:00:00'),
  (1, '2025-03-30', 'lunch',     '2025-03-30 13:00:00'),
  (1, '2025-04-04', 'breakfast', '2025-04-04 08:20:00'),
  (1, '2025-04-04', 'lunch',     '2025-04-04 12:55:00'),
  -- Jason Batum
  (2, '2025-03-29', 'breakfast', '2025-03-29 06:45:00'),
  (2, '2025-03-29', 'lunch',     '2025-03-29 11:30:00'),
  (2, '2025-03-29', 'dinner',    '2025-03-29 17:45:00'),
  (2, '2025-03-30', 'breakfast', '2025-03-30 06:30:00'),
  (2, '2025-03-30', 'lunch',     '2025-03-30 11:45:00'),
  (2, '2025-03-30', 'dinner',    '2025-03-30 17:30:00'),
  (2, '2025-04-04', 'breakfast', '2025-04-04 06:40:00'),
  (2, '2025-04-04', 'lunch',     '2025-04-04 11:30:00'),
  (2, '2025-04-04', 'dinner',    '2025-04-04 17:45:00'),
  -- Priya Nair
  (5, '2025-04-03', 'lunch',     '2025-04-03 13:10:00'),
  (5, '2025-04-03', 'dinner',    '2025-04-03 19:00:00'),
  (5, '2025-04-04', 'breakfast', '2025-04-04 09:00:00'),
  (5, '2025-04-04', 'lunch',     '2025-04-04 13:00:00'),
  -- Diego Reyes
  (7, '2025-04-04', 'breakfast', '2025-04-04 07:00:00'),
  (7, '2025-04-04', 'lunch',     '2025-04-04 12:00:00'),
  (7, '2025-04-04', 'dinner',    '2025-04-04 18:00:00'),
  -- Tyler Brooks
  (10,'2025-04-04', 'breakfast', '2025-04-04 07:15:00'),
  (10,'2025-04-04', 'lunch',     '2025-04-04 12:30:00');


-- =============================================================
-- MEAL_LOG_ITEMS
-- =============================================================
INSERT INTO meal_log_items (log_id, item_id, servings) VALUES
  -- Log 1: Jordan breakfast 3/29
  (1, 1, 1.0),   -- Scrambled Eggs
  (1, 2, 1.0),   -- Whole Wheat Toast
  (1, 5, 1.0),   -- Banana
  -- Log 2: Jordan lunch 3/29
  (2, 6, 1.0),   -- Grilled Chicken Breast
  (2, 7, 1.0),   -- Brown Rice
  (2, 18,1.0),   -- Garden Salad
  -- Log 3: Jordan dinner 3/29
  (3, 11,1.0),   -- Salmon Fillet
  (3, 12,1.0),   -- Quinoa Pilaf
  (3, 13,1.0),   -- Steamed Broccoli
  -- Log 4: Jordan breakfast 3/30
  (4, 3, 1.0),   -- Greek Yogurt Parfait
  (4, 5, 1.0),   -- Banana
  -- Log 5: Jordan lunch 3/30
  (5, 16,1.0),   -- Turkey Sandwich
  (5, 18,1.0),   -- Garden Salad
  (5, 20,1.0),   -- Apple
  -- Log 6: Jordan breakfast 4/4
  (6, 28,1.0),   -- Avocado Toast
  (6, 5, 1.0),   -- Banana
  -- Log 7: Jordan lunch 4/4
  (7, 29,1.0),   -- Grilled Salmon Wrap
  (7, 33,1.0),   -- Fruit Cup
  -- Log 8: Jason breakfast 3/29
  (8, 1, 2.0),   -- Scrambled Eggs x2
  (8, 4, 1.0),   -- Oatmeal
  (8, 26,1.0),   -- Protein Smoothie
  -- Log 9: Jason lunch 3/29
  (9, 6, 2.0),   -- Grilled Chicken Breast x2
  (9, 7, 2.0),   -- Brown Rice x2
  (9, 13,1.0),   -- Steamed Broccoli
  -- Log 10: Jason dinner 3/29
  (10,11,1.0),   -- Salmon Fillet
  (10,12,1.5),   -- Quinoa Pilaf x1.5
  (10,13,1.0),   -- Steamed Broccoli
  (10,26,1.0),   -- Protein Smoothie
  -- Log 11: Jason breakfast 3/30
  (11,1, 2.0),   -- Scrambled Eggs x2
  (11,4, 1.0),   -- Oatmeal
  (11,5, 2.0),   -- Banana x2
  -- Log 12: Jason lunch 3/30
  (12,6, 2.0),   -- Grilled Chicken Breast x2
  (12,7, 2.0),   -- Brown Rice x2
  (12,9, 1.0),   -- Vegetable Stir Fry
  -- Log 13: Jason dinner 3/30
  (13,21,1.5),   -- Chicken Tikka Masala x1.5
  (13,22,2.0),   -- Basmati Rice x2
  (13,24,1.0),   -- Lentil Dal
  -- Log 14: Jason breakfast 4/4
  (14,27,1.0),   -- Acai Bowl
  (14,26,1.0),   -- Protein Smoothie
  (14,30,1.0),   -- Energy Bar
  -- Log 15: Jason lunch 4/4
  (15,6, 2.0),   -- Grilled Chicken Breast x2
  (15,7, 1.5),   -- Brown Rice x1.5
  (15,13,1.0),   -- Steamed Broccoli
  -- Log 16: Jason dinner 4/4
  (16,11,1.5),   -- Salmon Fillet x1.5
  (16,12,1.0),   -- Quinoa Pilaf
  (16,13,2.0),   -- Steamed Broccoli x2
  (16,26,1.0),   -- Protein Smoothie
  -- Log 17: Priya lunch 4/3
  (17,19,1.0),   -- Pasta Primavera
  (17,18,1.0),   -- Garden Salad
  -- Log 18: Priya dinner 4/3
  (18,24,1.0),   -- Lentil Dal
  (18,22,1.0),   -- Basmati Rice
  (18,13,1.0),   -- Steamed Broccoli
  -- Log 19: Priya breakfast 4/4
  (19,3, 1.0),   -- Greek Yogurt Parfait
  (19,5, 1.0),   -- Banana
  -- Log 20: Priya lunch 4/4
  (20,17,1.0),   -- Black Bean Soup
  (20,18,1.0),   -- Garden Salad
  (20,20,1.0),   -- Apple
  -- Log 21: Diego breakfast 4/4
  (21,4, 1.0),   -- Oatmeal
  (21,26,1.0),   -- Protein Smoothie
  (21,5, 1.0),   -- Banana
  -- Log 22: Diego lunch 4/4
  (22,6, 2.0),   -- Grilled Chicken Breast x2
  (22,7, 1.5),   -- Brown Rice x1.5
  (22,9, 1.0),   -- Vegetable Stir Fry
  -- Log 23: Diego dinner 4/4
  (23,14,1.0),   -- Beef Burger
  (23,15,1.0),   -- Sweet Potato Fries
  (23,33,1.0),   -- Fruit Cup
  -- Log 24: Tyler breakfast 4/4
  (24,28,1.0),   -- Avocado Toast
  (24,3, 1.0),   -- Greek Yogurt Parfait
  -- Log 25: Tyler lunch 4/4
  (25,29,1.0),   -- Grilled Salmon Wrap
  (25,18,1.0),   -- Garden Salad
  (25,35,1.0);   -- Bottled Water


-- =============================================================
-- ALERTS
-- =============================================================
INSERT INTO alerts (user_id, goal_id, alert_type, message, is_read, triggered_at) VALUES
  -- Jason exceeded sodium max on 3/29
  (2, 8, 'exceeded_max', 'Your sodium intake today has exceeded your daily maximum of 2500mg.', TRUE,  '2025-03-29 18:00:00'),
  -- Jason below calorie minimum on 3/30
  (2, 4, 'below_min',    'You are currently below your minimum calorie goal of 3000 kcal for today.', TRUE, '2025-03-30 15:00:00'),
  -- Jordan below protein minimum on 3/29
  (1, 2, 'below_min',    'Your protein intake is below your daily minimum of 120g.', TRUE,  '2025-03-29 20:00:00'),
  -- Tyler exceeded sodium on 4/4
  (10, 17, 'exceeded_max','Your sodium intake is approaching your daily maximum of 2000mg.', FALSE, '2025-04-04 13:10:00'),
  -- Diego below calorie minimum on 4/4
  (7, 13, 'below_min',   'You are currently below your minimum calorie goal of 2800 kcal for today.', FALSE, '2025-04-04 14:00:00'),
  -- System alert for all admins
  (4, NULL, 'system',    'Scheduled nightly data sync completed successfully.', TRUE, '2025-04-04 02:00:00');


-- =============================================================
-- SAVED_MEALS
-- =============================================================
INSERT INTO saved_meals (user_id, name, description, created_at) VALUES
  (1, 'Energy Pre-Performance', 'Quick high-calorie combo before shows', '2025-03-20 10:15:00'),
  (1, 'Post-Show Recovery', 'Protein-rich meal for recovery after performances', '2025-03-22 14:30:00'),
  (1, 'Quick Lunch Between Classes', 'Fast balanced meal when schedule is packed', '2025-03-25 11:45:00'),
  (2, 'Athlete Pre-Game', 'Carb and protein loaded for game day', '2025-03-18 09:00:00'),
  (2, 'Recovery Bowl', 'High protein muscle recovery meal', '2025-03-20 16:20:00');


-- =============================================================
-- SAVED_MEAL_ITEMS
-- =============================================================
INSERT INTO saved_meal_items (saved_meal_id, item_id, servings) VALUES
  -- Energy Pre-Performance: Grilled Chicken, Rice, Pasta
  (1, 6, 1.5),   -- Grilled Chicken Breast
  (1, 7, 1.0),   -- Brown Rice
  (1, 19, 1.0),  -- Pasta Primavera
  -- Post-Show Recovery: Salmon, Sweet Potato, Greek Yogurt
  (2, 11, 1.5),  -- Salmon Fillet
  (2, 15, 1.0),  -- Sweet Potato Fries
  (2, 3, 1.0),   -- Greek Yogurt Parfait
  -- Quick Lunch: Caesar Salad, Chicken, Bread
  (3, 8, 1.0),   -- Caesar Salad
  (3, 6, 1.0),   -- Grilled Chicken Breast
  (3, 2, 1.0),   -- Whole Wheat Toast
  -- Athlete Pre-Game: Pasta, Chicken, Vegetables
  (4, 19, 1.5),  -- Pasta Primavera
  (4, 6, 2.0),   -- Grilled Chicken Breast
  (4, 9, 1.0),   -- Vegetable Stir Fry
  -- Recovery Bowl: Salmon, Rice, Berries
  (5, 11, 1.5),  -- Salmon Fillet
  (5, 7, 1.0),   -- Brown Rice
  (5, 33, 1.0);  -- Fruit Cup


-- =============================================================
-- AUDIT_LOGS
-- =============================================================
INSERT INTO audit_logs (user_id, table_name, action, old_values, new_values, performed_at, ip_address) VALUES
  (4, 'users',         'INSERT', NULL,
   '{"user_id":2,"email":"j.batum@northeastern.edu","role_id":2}',
   '2025-01-15 09:00:00', '192.168.1.10'),
  (4, 'dining_halls',  'UPDATE',
   '{"hall_id":1,"is_active":false}',
   '{"hall_id":1,"is_active":true}',
   '2025-02-01 11:30:00', '192.168.1.10'),
  (4, 'menu_items',    'INSERT', NULL,
   '{"item_id":26,"name":"Protein Smoothie","hall_id":4}',
   '2025-03-01 08:45:00', '192.168.1.10'),
  (2, 'meal_logs',     'INSERT', NULL,
   '{"log_id":8,"user_id":2,"log_date":"2025-03-29","meal_period":"breakfast"}',
   '2025-03-29 06:45:00', '10.0.0.42'),
  (1, 'nutrition_goals','UPDATE',
   '{"goal_id":1,"max_value":2000.0}',
   '{"goal_id":1,"max_value":2200.0}',
   '2025-03-15 14:20:00', '10.0.0.55'),
  (4, 'users',         'UPDATE',
   '{"user_id":6,"is_active":true}',
   '{"user_id":6,"is_active":false}',
   '2025-04-01 10:00:00', '192.168.1.10');


-- =============================================================
-- REPORTS
-- =============================================================
INSERT INTO reports (created_by, title, report_type, filter_params, status, generated_at, file_path) VALUES
  (3, 'Weekly Nutrition Summary — March Week 4', 'nutrition_summary',
   '{"date_from":"2025-03-24","date_to":"2025-03-30","hall_id":null,"demographic":null}',
   'complete', '2025-03-31 06:00:00', '/reports/2025/march_week4_summary.pdf'),
  (3, 'Athlete Protein Intake — Q1 2025', 'trend_analysis',
   '{"date_from":"2025-01-01","date_to":"2025-03-31","role_id":2,"nutrient_id":10}',
   'complete', '2025-04-01 07:30:00', '/reports/2025/q1_athlete_protein.pdf'),
  (3, 'Sodium Trends by Dining Hall — April', 'trend_analysis',
   '{"date_from":"2025-04-01","date_to":"2025-04-30","nutrient_id":6,"group_by":"hall_id"}',
   'pending', NULL, NULL),
  (4, 'Platform Engagement Report — March', 'engagement',
   '{"date_from":"2025-03-01","date_to":"2025-03-31"}',
   'complete', '2025-04-02 08:00:00', '/reports/2025/march_engagement.pdf'),
  (3, 'Nutritional Deficit Risk — Undergraduates', 'risk_analysis',
   '{"student_type":"undergraduate","nutrients":[1,10,8],"threshold":"below_min"}',
   'complete', '2025-04-03 09:15:00', '/reports/2025/undergrad_deficit_risk.pdf');


-- =============================================================
-- EXPORT_CONFIGS
-- =============================================================
INSERT INTO export_configs (user_id, name, format, field_selections, filter_params, is_scheduled, cron_expression) VALUES
  (3, 'Weekly Nutrient CSV', 'csv',
   '["user_id","log_date","nutrient_id","total_amount"]',
   '{"date_range":"last_7_days","group_by":"nutrient_id"}',
   TRUE, '0 6 * * 1'),
  (3, 'Monthly Athlete Report', 'xlsx',
   '["user_id","first_name","last_name","athletic_team","log_date","nutrient_id","amount"]',
   '{"role_id":2,"date_range":"last_30_days"}',
   TRUE, '0 7 1 * *'),
  (4, 'Full Audit Log Export', 'csv',
   '["audit_id","user_id","table_name","action","performed_at","ip_address"]',
   '{"date_range":"last_30_days"}',
   FALSE, NULL),
  (3, 'Sodium Outlier Export', 'json',
   '["user_id","log_date","total_sodium"]',
   '{"nutrient_id":6,"threshold_exceeded":true}',
   FALSE, NULL),
  (4, 'System Metrics Export', 'xlsx',
   '["metric_type","value","unit","recorded_at"]',
   '{"date_range":"last_7_days"}',
   TRUE, '0 8 * * 1');


-- =============================================================
-- SYSTEM_METRICS
-- =============================================================
INSERT INTO system_metrics (metric_type, value, unit, recorded_at, metadata) VALUES
  ('response_time_ms',  142.5,  'ms',      '2025-04-04 00:00:00', '{"endpoint":"/api/menu","method":"GET"}'),
  ('response_time_ms',  98.3,   'ms',      '2025-04-04 01:00:00', '{"endpoint":"/api/logs","method":"POST"}'),
  ('error_rate',        0.012,  'percent', '2025-04-04 00:00:00', '{"threshold":0.05}'),
  ('error_rate',        0.008,  'percent', '2025-04-04 06:00:00', '{"threshold":0.05}'),
  ('active_users',      84.0,   'count',   '2025-04-04 08:00:00', '{"peak_hour":true}'),
  ('active_users',      212.0,  'count',   '2025-04-04 12:00:00', '{"peak_hour":true}'),
  ('active_users',      37.0,   'count',   '2025-04-04 02:00:00', '{"peak_hour":false}'),
  ('db_query_time_ms',  23.1,   'ms',      '2025-04-04 08:00:00', '{"query":"meal_log_summary"}'),
  ('db_query_time_ms',  310.8,  'ms',      '2025-04-04 12:05:00', '{"query":"nutrient_aggregate","note":"slow_query_flagged"}'),
  ('storage_used_gb',   14.7,   'gb',      '2025-04-04 00:00:00', '{"capacity_gb":100}'),
  ('api_requests',      4821.0, 'count',   '2025-04-04 00:00:00', '{"window":"24h"}'),
  ('failed_logins',     3.0,    'count',   '2025-04-04 00:00:00', '{"threshold":10}');
