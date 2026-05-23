-- ==========================================
-- SMART CAFE DATABASE SCHEMA V2 (HEALTH + VARIATIONS)
-- Complete Database Setup for Smart Cafe System
-- ==========================================

-- 1. Fresh database create karna naye naam ke sath
DROP DATABASE IF EXISTS smart_cafe_health_db;
CREATE DATABASE smart_cafe_health_db;
USE smart_cafe_health_db;

-- ==========================================
-- 1. USERS TABLE
-- ==========================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    role VARCHAR(20) DEFAULT 'user',
    weekly_calorie_budget INT DEFAULT 14000,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 2. MENU ITEMS TABLE
-- ==========================================
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    category VARCHAR(50),
    image_url VARCHAR(255),
    ingredients TEXT, -- e.g., 'maida_150g, vegetables_100g, oil_1tsp'
    availability BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 3. ITEM VARIATIONS TABLE (NEW)
-- ==========================================
CREATE TABLE item_variations (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    variation_name VARCHAR(50) NOT NULL, -- 'Small', 'Medium', 'Large'
    pieces_count INT NOT NULL,           
    price DECIMAL(10,2) NOT NULL,
    calories INT NOT NULL,               -- AI calculated
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE
);

-- ==========================================
-- 4. DINING TABLES TABLE
-- ==========================================
CREATE TABLE dining_tables (
    table_id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    capacity INT DEFAULT 4,
    status ENUM('Available', 'Occupied', 'Reserved') DEFAULT 'Available',
    reserved_by VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 5. BOOKINGS TABLE
-- ==========================================
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    table_id INT NOT NULL,
    booking_date DATE NOT NULL,
    booking_time TIME NOT NULL,
    guests INT NOT NULL,
    status ENUM('Confirmed', 'Cancelled', 'Completed', 'Deleted') DEFAULT 'Confirmed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (table_id) REFERENCES dining_tables(table_id) ON DELETE CASCADE
);

-- ==========================================
-- 6. CART TABLE
-- ==========================================
CREATE TABLE cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    item_id INT,
    variation_id INT, 
    quantity INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES item_variations(variation_id) ON DELETE CASCADE
);

-- ==========================================
-- 7. ORDERS TABLE
-- ==========================================
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(50),
    payment_status ENUM('Pending', 'Verify', 'Paid', 'Failed') DEFAULT 'Pending',
    transaction_id VARCHAR(100),
    delivery_address TEXT,
    table_number INT,
    number_of_guests INT,
    order_type ENUM('Dine-in', 'Takeaway') DEFAULT 'Dine-in',
    status ENUM('Pending', 'Cooking', 'Ready', 'Completed', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- ==========================================
-- 8. ORDER DETAILS TABLE
-- ==========================================
CREATE TABLE order_details (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    variation_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (variation_id) REFERENCES item_variations(variation_id) ON DELETE CASCADE
);

-- ==========================================
-- 9. REVIEWS TABLE
-- ==========================================
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    item_id INT,
    order_id INT,
    item_name VARCHAR(100),
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id) ON DELETE CASCADE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE SET NULL
);

-- ==========================================
-- 10. MESSAGES TABLE
-- ==========================================
CREATE TABLE messages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    admin_reply TEXT,
    status ENUM('Open', 'Replied', 'Closed') DEFAULT 'Open',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- ==========================================
-- 11. NOTIFICATIONS TABLE
-- ==========================================
CREATE TABLE notifications (
    notification_id INT AUTO_INCREMENT PRIMARY KEY,
    user_email VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('Order', 'Booking', 'Message', 'Warning') DEFAULT 'Order',
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================
-- 12. AUTHORITY WARNINGS TABLE
-- ==========================================
CREATE TABLE authority_warnings (
    warning_id INT AUTO_INCREMENT PRIMARY KEY,
    authority_id INT,
    admin_id INT,
    warning_message TEXT NOT NULL,
    warning_type ENUM('Food Quality', 'Pricing', 'Hygiene', 'Other') DEFAULT 'Other',
    status ENUM('Active', 'Resolved') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (authority_id) REFERENCES users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (admin_id) REFERENCES users(user_id) ON DELETE SET NULL
);


-- ----------------------------------------------------
-- TESTING DUMMY DATA
-- ----------------------------------------------------
INSERT INTO users (full_name, email, password, role) VALUES 
('Areeba Riaz', 'admin@cafe.com', 'admin123', 'admin'),
('Aabirah Riaz', 'user@cafe.com', '123456', 'user'),
('Food Authority', 'authority@cafe.com', 'authority123', 'authority');

INSERT INTO menu_items (item_id, name, description, category, image_url, ingredients) VALUES 
(7, 'Pizza', 'Cheesy pizza with fresh toppings', 'Fast Food', 'pizza.jpg', 'dough_150g, cheese_100g, oil_1tsp'),
(36, 'Veg Momos', 'Delicious steamed vegetable momos', 'Fast Food', 'momos.jpg', 'maida_120g, vegetables_100g, oil_1tsp');

INSERT INTO item_variations (item_id, variation_name, pieces_count, price, calories) VALUES 
(36, 'Small', 4, 150.00, 180),
(36, 'Medium', 6, 220.00, 270),
(36, 'Large', 10, 320.00, 450),
(7, 'Small', 4, 400.00, 600),
(7, 'Medium', 6, 800.00, 1200),
(7, 'Large', 8, 1200.00, 1800);

INSERT INTO dining_tables (table_name, capacity, status) VALUES
('Table 1', 4, 'Available'),
('Table 2', 4, 'Available'),
('Table 3', 6, 'Available'),
('Table 4', 4, 'Available'),
('Table 5', 4, 'Available'),
('Table 6', 6, 'Available'),
('Table 7', 8, 'Available'),
('Table 8', 2, 'Available');
