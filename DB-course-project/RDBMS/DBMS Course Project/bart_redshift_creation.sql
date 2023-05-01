CREATE SCHEMA IF NOT EXISTS BART;

-- -----------------------------------------------------
-- Table `BART`.`agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS BART.agency (
  agency_id INT NOT NULL,
  agency_name VARCHAR(45) NULL,
  agency_url VARCHAR(200) NULL,
  agency_timezone VARCHAR(45) NULL,
  agency_lang VARCHAR(45) NULL,
  agency_phone VARCHAR(45) NULL,
  PRIMARY KEY (agency_id));


-- -----------------------------------------------------
-- Table `BART`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS BART.service (
  service_id VARCHAR(100) NOT NULL,
  service_description VARCHAR(45) NULL,
  monday INT NULL,
  tuesday INT NULL,
  wednesday INT NULL,
  thursday INT NULL,
  friday INT NULL,
  saturday INT NULL,
  sunday INT NULL,
  start_date TIMESTAMP NULL,
  end_date TIMESTAMP NULL,
  PRIMARY KEY (service_id));


-- -----------------------------------------------------
-- Table `BART`.`date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS BART.date (
  date DATE NOT NULL,
  date_yyyymmdd VARCHAR(45) NULL,
  day_of_week VARCHAR(45) NULL,
  is_weekday INT NULL,
  is_weekend INT NULL,
  is_holiday INT NULL,
  week_no INT NULL,
  week_start_date DATE NULL,
  month VARCHAR(45) NULL,
  month_start_date DATE NULL,
  year INT NULL,
  PRIMARY KEY (date));

-- -----------------------------------------------------
-- Table `BART`.`stops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS stops (
  stop_id INT NOT NULL,
  stop_name VARCHAR(45) NULL,
  PRIMARY KEY (stop_id))
DISTSTYLE ALL;

-- -----------------------------------------------------
-- Table `BART`.`station_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS station_details (
  station_id VARCHAR(10) NOT NULL,
  station_name VARCHAR(45) NULL,
  address VARCHAR(200) NULL,
  distance_from_berryessa DECIMAL(6,4) NULL,
  lattitude DECIMAL(5,4) NULL,
  longitude DECIMAL(5,4) NULL,
  zipcode INT NULL,
  agency_id INT NOT NULL,
  stops_stop_id INT NOT NULL,
  PRIMARY KEY (station_id, stop_id),
  CONSTRAINT fk_station_details_agency1
    FOREIGN KEY (agency_id)
    REFERENCES agency (agency_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT fk_station_details_stops1
    FOREIGN KEY (stops_stop_id)
    REFERENCES stops (stop_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
DISTSTYLE ALL;

-- -----------------------------------------------------
-- Table `BART`.`fare_rules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS fare_rules (
  fare_id INT NOT NULL,
  price DECIMAL(4,3) NULL,
  currency_type VARCHAR(45) NULL,
  payment_method INT NULL,
  origin_station VARCHAR(45) NULL,
  destination_station VARCHAR(45) NULL,
  origin_station_id VARCHAR(10) NOT NULL,
  destination_station_id VARCHAR(10) NOT NULL,
  PRIMARY KEY (fare_id, origin_station_id, destination_station_id),
  CONSTRAINT fk_fare_rules_station_details1
    FOREIGN KEY (origin_station_id)
    REFERENCES station_details (station_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
DISTSTYLE ALL;

-- -------------------------------------------------------------
-- -------------------------------------------------------------

-- Table BART.calendar_dates

CREATE TABLE IF NOT EXISTS BART.calendar_dates (
service_id VARCHAR(100) NOT NULL,
date DATETIME NOT NULL,
PRIMARY KEY (service_id, date),
INDEX fk_service_has_date_date1_idx (date ASC) VISIBLE,
INDEX fk_service_has_date_service_idx (service_id ASC) VISIBLE,
CONSTRAINT fk_service_has_date_service
FOREIGN KEY (service_id)
REFERENCES BART.service (service_id)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT fk_service_has_date_date1
FOREIGN KEY (date)
REFERENCES BART.date (date)
ON DELETE RESTRICT
ON UPDATE CASCADE)
DISTSTYLE ALL;

-- ---------------------------------------------------------
-- --------------------------------------------------------

-- Table BART.routes

CREATE TABLE IF NOT EXISTS BART.routes (
route_id INT NOT NULL,
route_short_name VARCHAR(105) NULL,
route_long_name VARCHAR(250) NULL,
route_type INT NULL,
route_url VARCHAR(100) NULL,
route_color VARCHAR(45) NULL,
realtime_enabled INT NULL,
category INT NULL,
subcategory INT NULL,
running_way INT NULL,
PRIMARY KEY (route_id))
DISTSTYLE ALL;

-- ------------------------------------------------
-- -------------------------------------------------

-- Table BART.rider_categories

CREATE TABLE IF NOT EXISTS BART.rider_categories (
rider_category_id INT NOT NULL,
rider_category_desc VARCHAR(45) NULL,
PRIMARY KEY (rider_category_id))
DISTSTYLE ALL;

-- ----------------------------------------------------
-- ----------------------------------------------------

-- Table BART.fare_rider_categories

CREATE TABLE IF NOT EXISTS BART.fare_rider_categories (
rider_category_id INT NOT NULL,
fare_id INT NOT NULL,
price DECIMAL(4,3) NULL,
PRIMARY KEY (rider_category_id, fare_id),
CONSTRAINT fk_rider_categories_has_fare_rules_rider_categories1
FOREIGN KEY (rider_category_id)
REFERENCES BART.rider_categories (rider_category_id)
ON DELETE DELETE
ON UPDATE CASCADE,
CONSTRAINT fk_rider_categories_has_fare_rules_fare_rules1
FOREIGN KEY (fare_id)
REFERENCES BART.fare_rules (fare_id)
ON DELETE DELETE
ON UPDATE CASCADE)
DISTSTYLE ALL;

-- ------------------------
-- ------------------------

-- Table BART.directions

CREATE TABLE IF NOT EXISTS BART.directions (
direction_id INT NOT NULL,
direction VARCHAR(45) NULL,
route_id INT NOT NULL,
PRIMARY KEY (direction_id,route_id),
CONSTRAINT "fk_directions_routes1"
FOREIGN KEY (route_id)
REFERENCES BART.routes (route_id)
ON DELETE RESTRICT
ON UPDATE CASCADE);

-- ---------------------------------------------------------------
-- ---------------------------------------------------------------

-- Table BART.trips

CREATE TABLE IF NOT EXISTS BART.trips (
trip_id INT NOT NULL,
trip_headsign VARCHAR(45) NULL,
shape_id INT NULL,
wheelchair_accessible INT NULL,
bikes_allowed INT NULL,
service_id VARCHAR(100) NOT NULL,
direction_id INT NOT NULL,
route_id INT NOT NULL,
PRIMARY KEY (service_id, trip_id),
CONSTRAINT "fk_trips_service1"
FOREIGN KEY (service_id)
REFERENCES BART.service (service_id)
ON DELETE RESTRICT
ON UPDATE CASCADE,
CONSTRAINT "fk_trips_directions1"
FOREIGN KEY (direction_id , route_id)
REFERENCES BART.directions (direction_id,route_id)
ON DELETE RESTRICT
ON UPDATE CASCADE)
DISTSTYLE ALL;

-- ------------------------------------------------------------------
-- ------------------------------------------------------------------

-- Table BART.stop_times

CREATE TABLE IF NOT EXISTS BART.stop_times (
stop_id INT NOT NULL,
service_id VARCHAR(100) NOT NULL,
trip_id INT NOT NULL,
arrival_time TIME NULL,
departure_time TIME NULL,
stop_sequence INT NULL,
stop_headsign VARCHAR(100) NULL,
shape_dist_travelled DECIMAL(10,6) NULL,
PRIMARY KEY (stop_id, service_id, trip_id),
CONSTRAINT "fk_stops_has_trips_stops1"
FOREIGN KEY (stop_id)
REFERENCES BART.stops (stop_id)
ON DELETE DELETE
ON UPDATE CASCADE,
CONSTRAINT "fk_stops_has_trips_trips1"
FOREIGN KEY (service_id,trip_id)
REFERENCES BART.trips (service_id,trip_id)
ON DELETE RESTRICT
ON UPDATE CASCADE)
DISTSTYLE ALL;



