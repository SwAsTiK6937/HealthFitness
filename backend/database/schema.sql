CREATE DATABASE HealthFitnessDB;
USE HealthFitnessDB;

-- Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    height DECIMAL(5,2), -- in cm
    weight DECIMAL(5,2), -- in kg
    activity_level ENUM('Sedentary', 'Lightly Active', 'Moderately Active', 'Very Active', 'Super Active')
);

-- IoT Devices Table
CREATE TABLE IoT_Devices (
    device_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    device_name VARCHAR(100),
    device_status ENUM('Active', 'Inactive'),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Device Data Table
CREATE TABLE Device_Data (
    data_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    device_id INT,
    heart_rate INT,
    steps INT,
    sleep_duration DECIMAL(4,2), -- in hours
    calories_burned DECIMAL(6,2),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (device_id) REFERENCES IoT_Devices(device_id) ON DELETE CASCADE
);

-- Food Log Table
CREATE TABLE Food_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    food_item VARCHAR(255),
    calories INT,
    protein DECIMAL(5,2),
    carbs DECIMAL(5,2),
    fats DECIMAL(5,2),
    meal_type ENUM('Breakfast', 'Lunch', 'Dinner', 'Snack'),
    log_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Exercise Log Table
CREATE TABLE Exercise_Log (
    exercise_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    workout_type VARCHAR(100),
    duration DECIMAL(5,2), -- in minutes
    calories_burned DECIMAL(6,2),
    log_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- AI Recommendations Table
CREATE TABLE AI_Recommendations (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    recommendation TEXT,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Weight Progress Table
CREATE TABLE Weight_Progress (
    progress_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    weight DECIMAL(5,2), -- in kg
    recorded_at DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Friends Table
CREATE TABLE Friends (
    user_id INT,
    friend_id INT,
    status ENUM('Pending', 'Accepted', 'Rejected'),
    PRIMARY KEY (user_id, friend_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (friend_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Posts & Comments Table
CREATE TABLE Posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    content TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT,
    user_id INT,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Posts(post_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);