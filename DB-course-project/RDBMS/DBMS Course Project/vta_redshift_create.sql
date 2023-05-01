CREATE SCHEMA IF NOT EXISTS VTA;
SET search_path = VTA;

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.stops

CREATE TABLE IF NOT EXISTS VTA.stops (
stop_id INT NOT NULL,
stop_code INT NULL,
stop_name VARCHAR(100) NULL,
stop_desc VARCHAR(45) NULL,
stop_lat DECIMAL(10,5) NULL,
stop_lon DECIMAL(10,5) NULL,
location_type INT NULL,
parent_station VARCHAR(45) NULL,
wheelchair_boarding INT NULL,
platform_code INT NULL,
sign_dest VARCHAR(200) NULL,
PRIMARY KEY (stop_id))
DISTSTYLE KEY
DISTKEY (stop_id)
SORTKEY (stop_id);

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.service

CREATE TABLE IF NOT EXISTS VTA.service (
service_id VARCHAR(45) NOT NULL,
monday INT NULL,
tuesday INT NULL,
wednesday INT NULL,
thursday VARCHAR(45) NULL,
friday VARCHAR(45) NULL,
saturday VARCHAR(45) NULL,
sunday VARCHAR(45) NULL,
start_date DATE NULL,
end_date DATE NULL,
PRIMARY KEY (service_id))
DISTSTYLE KEY
DISTKEY (service_id)
SORTKEY (service_id);

-- ---------------------------------------------------------
-- --------------------------------------------------------- 
-- Table VTA.agency

CREATE TABLE IF NOT EXISTS VTA.agency (
agency_id VARCHAR(10) NOT NULL,
agency_name VARCHAR(45) NULL,
agency_url VARCHAR(45) NULL,
agency_timezone VARCHAR(45) NULL,
agency_lang VARCHAR(10) NULL,
agency_phone VARCHAR(45) NULL,
agency_fare_url VARCHAR(100) NULL,
agency_email VARCHAR(45) NULL,
PRIMARY KEY (agency_id))
DISTSTYLE KEY
DISTKEY (agency_id)
SORTKEY (agency_id);

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.route_attributes

CREATE TABLE IF NOT EXISTS VTA.route_attributes (
route_id INT NOT NULL,
route_short_name VARCHAR(45) NULL,
route_long_name VARCHAR(200) NULL,
route_desc VARCHAR(300) NULL,
route_type INT NULL,
route_url VARCHAR(150) NULL,
route_color VARCHAR(45) NULL,
route_sort_order INT NULL,
ext_route_type INT NULL,
realtime_enabled INT NULL,
category VARCHAR(45) NULL,
running_way VARCHAR(45) NULL,
subcategory VARCHAR(45) NULL,
agency_id VARCHAR(10) NOT NULL,
PRIMARY KEY (route_id),
CONSTRAINT fk_route_attributes_agency1 FOREIGN KEY (agency_id) REFERENCES VTA.agency (agency_id))
DISTSTYLE KEY
DISTKEY (route_id)
SORTKEY (route_id);

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.directions

CREATE TABLE IF NOT EXISTS VTA.directions (
direction_id INT NOT NULL,
direction VARCHAR(45) NULL,
direction_name VARCHAR(45) NULL,
route_id INT NOT NULL,
PRIMARY KEY (direction_id, route_id),
CONSTRAINT fk_directions_route_attributes1 FOREIGN KEY (route_id) REFERENCES VTA.route_attributes (route_id))
DISTSTYLE KEY
DISTKEY (direction_id)
SORTKEY (direction_id, route_id);

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.trips

CREATE TABLE IF NOT EXISTS VTA.trips (
trip_id INTEGER NOT NULL,
trip_headsign VARCHAR(45) NULL,
block_id INTEGER NULL,
shape_id VARCHAR(45) NULL,
wheelchair_accessible INTEGER NULL,
bikes_allowed INTEGER NULL,
service_id VARCHAR(45) NOT NULL,
direction_id INTEGER NOT NULL,
route_id INTEGER NOT NULL,
PRIMARY KEY (trip_id),
CONSTRAINT fk_trips_service1
FOREIGN KEY (service_id)
REFERENCES VTA.service (service_id)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT "fk_trips_directions1"
FOREIGN KEY (direction_id, route_id)
REFERENCES VTA.directions (direction_id, route_id)
ON DELETE RESTRICT
ON UPDATE DELETE);

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.stop_times

CREATE TABLE IF NOT EXISTS VTA.stop_times (
trip_id INTEGER NOT NULL,
stop_id INTEGER NOT NULL,
arrival_time TIME NULL,
departure_time TIME NULL,
stop_sequence INTEGER NULL,
shape_dist_travelled DECIMAL(5,3) NULL,
timeopint VARCHAR(45) NULL,
PRIMARY KEY (trip_id, stop_id),
CONSTRAINT "fk_trips_has_stops_trips"
FOREIGN KEY (trip_id)
REFERENCES VTA.trips (trip_id)
ON DELETE RESTRICT
ON UPDATE DELETE,
CONSTRAINT "fk_trips_has_stops_stops1"
FOREIGN KEY (stop_id)
REFERENCES VTA.stops (stop_id)
ON DELETE RESTRICT
ON UPDATE DELETE);

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.fare_attributes

CREATE TABLE IF NOT EXISTS VTA.fare_attributes (
fare_id INTEGER NOT NULL,
price DECIMAL(5,3) NULL,
currency_type VARCHAR(10) NULL,
payment_method INTEGER NULL,
transfers INTEGER NULL,
route_id INTEGER NOT NULL,
PRIMARY KEY ("fare_id", "route_id"),
CONSTRAINT "fk_fare_attributes_route_attributes1"
FOREIGN KEY (route_id)
REFERENCES VTA.route_attributes (route_id)
ON DELETE RESTRICT
ON UPDATE CASCADE);

-- ----------------------------------------------
-- ----------------------------------------------

-- Table VTA.date

CREATE TABLE IF NOT EXISTS VTA.date (
date DATE NOT NULL,
date_yyyymmdd VARCHAR(45) NULL,
day_of_week VARCHAR(40) NULL,
is_weekday INTEGER NULL,
is_weekend INTEGER NULL,
is_holiday INTEGER NULL,
week_number INTEGER NULL,
week_start_date DATE NULL,
month VARCHAR(45) NULL,
month_start_date DATE NULL,
year INTEGER NULL,
PRIMARY KEY (date));

-- ------------------------------------------------------------------------
-- ------------------------------------------------------------------------
-- Table VTA.calendar_dates

CREATE TABLE IF NOT EXISTS VTA.calendar_dates (
service_service_id VARCHAR(45) NOT NULL,
date_date DATE NOT NULL,
PRIMARY KEY (service_service_id, date_date)
);

ALTER TABLE VTA.calendar_dates ADD CONSTRAINT fk_service_has_date_service1

FOREIGN KEY (service_service_id)
REFERENCES VTA.service (service_id)ON DELETE RESTRICT 

ON UPDATE CASCADE;

ALTER TABLE VTA.calendar_dates ADD CONSTRAINT fk_service_has_date_date1
FOREIGN KEY (date_date)
REFERENCES VTA.date (date)
ON DELETE RESTRICT 

ON UPDATE CASCADE;

