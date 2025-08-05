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


-- Insert data in Vehicle_Body_Type
-- We have different set of IDs for (1975-1981), (1982-1990) and (1991-2024)
-- Because of this we'll add the initial year of the set in front of the ID value provided by the book
-- Since this project is mostly interested in motorcycles I didn't do a thorough review of the body_type_names,
-- Be aware that if you're using this for other type of analysis some might need adjustment.
-- reference: https://crashstats.nhtsa.dot.gov/Api/Public/ViewPublication/813706#page=308&zoom=100,92,661
INSERT INTO vehicle_body_type (body_type_id, body_type_name) VALUES
(197501, "Convertible"),
(197502, "2-Door Sedan HT/Coupe"),
(197503, "4-Door Sedan HT"),
(197504, "Hatchback"),
(197505, "Car-Pickup Body"),
(197506, "Station Wagon"),
(197507, "On/Off Road Vehicle – Jeep CJ-S, Bronco, Blazer, Scout, etc. (1975-1979)"),
(197508, "Other Auto"),
(197509, "Unknown Auto Type"),
(197515, "Motorcycle"),
(197516, "Moped"),
(197517, "Other Cycle"),
(197518, "Unknown Cycle"),
(197525, "School Bus"),
(197526, "Cross-County"),
(197527, "Transit Bus"),
(197528, "Other Bus"),
(197529, "Unknown Bus"),
(197535, "Snowmobile"),
(197536, "Farm Equipment"),
(197537, "Dune/Swamp Buggy"),
(197538, "Construction Equipment"),
(197539, "Ambulance/Hearse Type"),
(197540, "Large Limousine"),
(197541, "Camper/Motorhome"),
(197542, "Fire Truck"),
(197543, "On/Off-Road Vehicle – Jeep CJ-S, Bronco, Blazer, Scout, etc. (1980-1981)"),
(197544, "Other Special Vehicle"),
(197545, "Ambulance EMS"),
(197550, "Pickup"),
(197551, "Van"),
(197552, "Truck-Based Station Wagon"),
(197553, "Straight Truck, Low GVW"),
(197554, "Straight Truck, Medium GVW"),
(197555, "Straight Truck, High GVW"),
(197556, "Straight Truck, Unknown GVW"),
(197557, "Two-Unit Truck"),
(197558, "Multi-Unit Truck"),
(197559, "Truck-Tractor"),
(197560, "Unknown Type Truck"),
(197599, "Unknown"),
(198201, "Convertible"),
(198202, "2-Door Sedan HT/Coupe"),
(198203, "3-Door/2-Door Hatchback"),
(198204, "4-Door Sedan HT"),
(198205, "5-Door/4-Door Hatchback"),
(198206, "Station Wagon"),
(198207, "Hatchback/Number of Doors Unknown"),
(198208, "Other Auto"),
(198209, "Unknown Auto Type"),
(198210, "Auto Pickup"),
(198211, "Auto Panel"),
(198212, "Short Utility/Not Truck-Based"),
(198213, "Large Limousine"),
(198214, "3-Wheel Vehicle Unknown Body Type"),
(198220, "Motorcycle"),
(198221, "Moped"),
(198227, "3-Wheel Motorcycle or Moped"),
(198228, "Other Cycle"),
(198229, "Unknown Cycle"),
(198230, "School Bus"),
(198231, "Cross-Country/Intercity"),
(198232, "Transit Bus"),
(198238, "Other Bus"),
(198239, "Unknown Bus"),
(198240, "Van"),
(198241, "Van Commercial Cutaway"),
(198242, "Van Motorhome"),
(198248, "Other Van Type"),
(198249, "Unknown Van Type"),
(198250, "Pickup"),
(198251, "Pickup W/Slide-in Camper"),
(198252, "Pickup W/Box Truck"),
(198253, "Cab Chassis Based"),
(198254, "Truck-Based Panel"),
(198255, "Truck-Based Station Wagon"),
(198256, "Truck-Based Utility"),
(198258, "Other Light Conventional Truck"),
(198259, "Unknown Light Convent Truck"),
(198267, "Utility, Base Body Unknown"), 
(198269, "Unknown Light Truck"),
(198270, "Straight Truck, Low GVW"),
(198271, "Straight Truck, Medium GVW"),
(198272, "Straight Truck, High GVW"),
(198273, "Medium/Heavy Truck Motorhome"),
(198274, "Truck/Tractor"),
(198275, "Unknown Medium Truck"),
(198276, "Unknown Heavy Truck"),
(198277, "Camper/Motorhome"),
(198278, "Single Unit Straight Truck GVW Unknown"),
(198279, "Unknown Truck Type"),
(198280, "Snowmobile"),
(198281, "Farm Equipment/Not Trucks"),
(198282, "ATV, Dune/Swamp Buggy"),
(198283, "Construction Equipment/Not Trucks"),
(198288, "Other"),
(198289, "Unknown Other Vehicle"),
(198290, "3-Wheel Vehicle Unknown Body Type"),
(198299, "Unknown Body Type"),
(199101, "Convertible"),
(199102, "2-Door Sedan HT/Coupe"),
(199103, "3-Door/2-Door Hatchback"),
(199104, "4-Door Sedan HT"),
(199105, "5-Door/4-Door Hatchback"),
(199106, "Station Wagon"),
(199107, "Hatchback/Number of Doors Unknown"),
(199108, "Sedan/Hardtop, Number of Doors Unknown"),
(199109, "Unknown Auto Type"),
(199110, "Auto Pickup"),
(199111, "Auto Panel"),
(199112, "Large Limousine"),
(199113, "3-Wheel Automobile or Automobile Derivative"),
(199114, "Compact Utility (ANSI D-16 Utility Vehicle Categories “Small” and “Midsize”)"),
(199115, "Large Utility (ANSI D-16 Utility Vehicle Categories “Full Size” and “Large”)"),
(199116, "Utility Station Wagon"),
(199117, "3-Door Coupe"),
(199119, "Utility Unknown Body"),
(199120, "Minivan"),
(199121, "Large Van – Includes Van-Based Buses"),
(199122, "Step Van or Walk-in Van"),
(199123, "Van Motorhome"),
(199124, "Van-Based School Bus"),
(199125, "Van-Based Transit Bus"),
(199128, "Other Van Type"),
(199129, "Unknown Van Type"),
(199130, "Compact Pickup"),
(199131, "Standard Pickup"),
(199132, "Pickup With Slide-in Camper"),
(199133, "Convertible Pickup"),
(199134, "Light Pickup"),
(199139, "Unknown Pickup Style Light Conventional"),
(199140, "Cab Chassis Based"),
(199141, "Truck-Based Panel"),
(199142, "Light Truck-Based Motorhome"),
(199145, "Other Light Conventional Truck"),
(199148, "Unknown Light Truck"),
(199150, "School Bus"),
(199151, "Cross-Country/Intercity Bus"),
(199152, "Transit Bus"),
(199155, "Van-Based Bus"),
(199158, "Other Bus"),
(199160, "Step Van (GVWR > 10,000 lbs)"),
(199161, "Single-Unit Straight Truck (GVWR < 10,000 lbs)"),
(199162, "Single-Unit Straight Truck (19,500 lbs < GVWR <= 26,000 lbs)"),
(199163, "Single-Unit Straight Truck (GVWR > 26,000 lbs)"),
(199164, "Single-Unit Straight Truck (GVWR Unknown)"),
(199165, "Medium/Heavy Truck-Based Motorhome"),
(199166, "Truck/Tractor (Cab Only, or With Any Number of Trailing Units: Any Weight)"),
(199167, "Medium/Heavy Pickup (GVWR > 10,000 lbs)"),
(199168, "Single-Unit Straight Truck (GVWR Unknown)"),
(199171, "Unknown if Single-Unit or Combination-Unit Heavy Truck"),
(199172, "Unknown if Single-Unit or Combination-Unit Heavy Truck"),
(199173, "Camper or Motorhome, Unknown Truck Type"),
(199178, "Unknown Medium/Heavy Truck Type"),
(199179, "Unknown Truck Type"),
(199180, "Motorcycle"),
(199181, "Moped"),
(199182, "Three-Wheel Motorcycle"),
(199183, "Off-Road Motorcycle"),
(199184, "Motor Scooter"),
(199185, "Unenclosed Three-Wheel Motorcycle"),
(199186, "Enclosed Three-Wheel Motorcycle"),
(199187, "Unknown Three-Wheel Motorcycle Type"),
(199188, "Other Motored Cycle Type (Mini-Bikes, Motor Scooters)"),
(199189, "Unknown Motored Cycle Type"),
(199190, "ATV (All-Terrain Vehicle; Includes 3 or 4 Wheels)"),
(199191, "Snowmobile"),
(199192, "Farm Equipment Other Than Trucks"),
(199193, "Construction Equipment Other Than Trucks"),
(199194, "Motorized Wheel Chair (1997 Only)"),
(199195, "Golf Cart (Since 2012)"),
(199196, "Recreational Off-Highway Vehicle"),
(199197, "Other Vehicle Type (Includes Go-Cart, ForkLift, City Street Sweeper, Dune/Swamp Buggy)"),
(199198, "Not Reported"),
(199199, "Unknown Body Type");
