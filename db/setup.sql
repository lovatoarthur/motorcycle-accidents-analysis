-- Tables:
-- States state_name, state_id
-- Counties county_name, county_id, state_id
-- Cities city_name, city_id, county_id, state_id
-- Accidents accident_id, city_id, county_id, state_id, date, latitude, longitude, notification_time, fatalities
-- Vehicles vehicle_id, accident_id, fatalities (deaths), body_type_id
-- Vehicle_Body_Type body_type_id, body_type_name PAGE 147 (142 in the book)
-- Persons age, sex, vehicle_id, accident_id, injury_severity, helmet_use, type_id
-- Person_Type type_id, type_name PAGE 309 (304 in the book)

-- Create the database
CREATE DATABASE fatality_accidents;

-- Use the database
USE fatality_accidents;

-- Create the tables

-- Create the states table
CREATE TABLE states (
    state_id INT PRIMARY KEY,
    state_name VARCHAR(255)
);

-- Create the counties table
CREATE TABLE counties (
    county_id INT PRIMARY KEY,
    county_name VARCHAR(255),
    state_id INT,
    FOREIGN KEY (state_id) REFERENCES states(state_id)
);

-- Create the cities table
CREATE TABLE cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(255),
    county_id INT,
    state_id INT,
    FOREIGN KEY (county_id) REFERENCES counties(county_id),
    FOREIGN KEY (state_id) REFERENCES states(state_id)
);

-- Create the accidents table
CREATE TABLE accidents (
    accident_id INT PRIMARY KEY,
    city_id INT,
    county_id INT,
    state_id INT,
    date DATE,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    notification_time TIME,
    fatalities INT,
    FOREIGN KEY (city_id) REFERENCES cities(city_id),
    FOREIGN KEY (county_id) REFERENCES counties(county_id),
    FOREIGN KEY (state_id) REFERENCES states(state_id)
);

-- Create the vehicles table
CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    accident_id INT,
    fatalities INT,
    body_type_id INT,
    FOREIGN KEY (accident_id) REFERENCES accidents(accident_id),
    FOREIGN KEY (body_type_id) REFERENCES vehicle_body_type(body_type_id)
);

-- Create the vehicle body type table
CREATE TABLE vehicle_body_type (
    body_type_id INT PRIMARY KEY,
    body_type_name VARCHAR(255)
);

-- Create the persons table
CREATE TABLE persons (
    age INT,
    sex VARCHAR(255),
    vehicle_id INT,
    accident_id INT,
    injury_severity VARCHAR(255),
    helmet_use VARCHAR(255),
    type_id INT,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (accident_id) REFERENCES accidents(accident_id),
    FOREIGN KEY (type_id) REFERENCES person_type(type_id)
);

-- Create the person type table
CREATE TABLE person_type (
    type_id INT PRIMARY KEY,
    type_name VARCHAR(255)
);