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

-- Create the indexes
CREATE INDEX idx_accidents_state_id ON accidents (state_id);
CREATE INDEX idx_accidents_county_id ON accidents (county_id);
CREATE INDEX idx_accidents_city_id ON accidents (city_id);
CREATE INDEX idx_vehicles_accident_id ON vehicles (accident_id);
CREATE INDEX idx_persons_vehicle_id ON persons (vehicle_id);
CREATE INDEX idx_persons_accident_id ON persons (accident_id);

-- Insert data in States, Vehicle_Body_Type, Person_Type
-- Accidents, vehicles, persons will be populated in the ETL process
-- Counties, cities will be populated from GSA Geographical Codes

-- Insert data in States
INSERT INTO states (state_id, state_name) VALUES
(1, 'Alabama'),
(2, 'Alaska'),
(4, 'Arizona'),
(5, 'Arkansas'),
(6, 'California'),
(8, 'Colorado'),
(9, 'Connecticut'),
(10, 'Delaware'),
(11, 'District of Columbia'),
(12, 'Florida'),
(13, 'Georgia'),
(15, 'Hawaii'),
(16, 'Idaho'),
(17, 'Illinois'),
(18, 'Indiana'),
(19, 'Iowa'),
(20, 'Kansas'),
(21, 'Kentucky'),
(22, 'Louisiana'),
(23, 'Maine'),
(24, 'Maryland'),
(25, 'Massachusetts'),
(26, 'Michigan'),
(27, 'Minnesota'),
(28, 'Mississippi'),
(29, 'Missouri'),
(30, 'Montana'),
(31, 'Nebraska'),
(32, 'Nevada'),
(33, 'New Hampshire'),
(34, 'New Jersey'),
(35, 'New Mexico'),
(36, 'New York'),
(37, 'North Carolina'),
(38, 'North Dakota'),
(39, 'Ohio'),
(40, 'Oklahoma'),
(41, 'Oregon'),
(42, 'Pennsylvania'),
(43, 'Puerto Rico'),
(44, 'Rhode Island'),
(45, 'South Carolina'),
(46, 'South Dakota'),
(47, 'Tennessee'),
(48, 'Texas'),
(49, 'Utah'),
(50, 'Vermont'),
(51, 'Virginia'),
(53, 'Washington'),
(54, 'West Virginia'),
(55, 'Wisconsin'),
(56, 'Wyoming');
