-- -----------------------------------------------------
-- Table `VTA`.`stops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dbms-sjsu`.`VTA`.`stops` (
  `stop_id` INT NOT NULL,
  `stop_code` INT NULL,
  `stop_name` VARCHAR(100) NULL,
  `stop_desc` VARCHAR(45) NULL,
  `stop_lat` DECIMAL(10,5) NULL,
  `stop_lon` DECIMAL(10,5) NULL,
  `location_type` INT NULL,
  `parent_station` VARCHAR(45) NULL,
  `wheelchair_boarding` INT NULL,
  `platform_code` INT NULL,
  `sign_dest` VARCHAR(200) NULL,
  PRIMARY KEY (`stop_id`));


-- -----------------------------------------------------
-- Table `VTA`.`service`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`. `VTA`.`service` (
  `service_id` VARCHAR(45) NOT NULL,
  `monday` INT NULL,
  `tuesday` INT NULL,
  `wednesday` INT NULL,
  `thursday` VARCHAR(45) NULL,
  `friday` VARCHAR(45) NULL,
  `saturday` VARCHAR(45) NULL,
  `sunday` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  PRIMARY KEY (`service_id`));


-- -----------------------------------------------------
-- Table `VTA`.`agency`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`.`VTA`.`agency` (
  `agency_id` VARCHAR(10) NOT NULL,
  `agency_name` VARCHAR(45) NULL,
  `agency_url` VARCHAR(45) NULL,
  `agency_timezone` VARCHAR(45) NULL,
  `agency_lang` VARCHAR(10) NULL,
  `agency_phone` VARCHAR(45) NULL,
  `agency_fare_url` VARCHAR(100) NULL,
  `agency_email` VARCHAR(45) NULL,
  PRIMARY KEY (`agency_id`));


-- -----------------------------------------------------
-- Table `VTA`.`route_attributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`.`VTA`.`route_attributes` (
  `route_id` INT NOT NULL,
  `route_short_name` VARCHAR(45) NULL,
  `route_long_name` VARCHAR(200) NULL,
  `route_desc` VARCHAR(300) NULL,
  `route_type` INT NULL,
  `route_url` VARCHAR(150) NULL,
  `route_color` VARCHAR(45) NULL,
  `route_sort_order` INT NULL,
  `ext_route_type` INT NULL,
  `realtime_enabled` INT NULL,
  `category` VARCHAR(45) NULL,
  `running_way` VARCHAR(45) NULL,
  `subcategory` VARCHAR(45) NULL,
  `agency_id` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`route_id`),
  CONSTRAINT `fk_route_attributes_agency1`
    FOREIGN KEY (`agency_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`agency` (`agency_id`));



-- -----------------------------------------------------
-- Table `VTA`.`directions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`.`VTA`.`directions` (
  `direction_id` INT NOT NULL,
  `direction` VARCHAR(45) NULL,
  `direction_name` VARCHAR(45) NULL,
  `route_id` INT NOT NULL,
  PRIMARY KEY (`direction_id`, `route_id`),
  INDEX `fk_directions_route_attributes1_idx` (`route_id` ASC) VISIBLE,
  CONSTRAINT `fk_directions_route_attributes1`
    FOREIGN KEY (`route_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`route_attributes` (`route_id`));


-- -----------------------------------------------------
-- Table `VTA`.`trips`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VTA`.`trips` (
  `trip_id` INT NOT NULL,
  `trip_headsign` VARCHAR(45) NULL,
  `block_id` INT NULL,
  `shape_id` VARCHAR(45) NULL,
  `wheelchari_accessible` INT NULL,
  `bikes_allowed` INT NULL,
  `service_id` VARCHAR(45) NOT NULL,
  `directions_direction_id` INT NOT NULL,
  `directions_route_id` INT NOT NULL,
  PRIMARY KEY (`trip_id`),
  CONSTRAINT `fk_trips_service1`
    FOREIGN KEY (`service_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`service` (`service_id`),
  CONSTRAINT `fk_trips_directions1`
    FOREIGN KEY (`directions_direction_id` , `directions_route_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`directions` (`direction_id` , `route_id`));


-- -----------------------------------------------------
-- Table `VTA`.`stop_times`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`.`VTA`.`stop_times` (
  `trip_id` INT NOT NULL,
  `stop_id` INT NOT NULL,
  `arrival_time` TIME NULL,
  `departure_time` TIME NULL,
  `stop_sequence` INT NULL,
  `shape_dist_travelled` DECIMAL(5,3) NULL,
  `timeopint` VARCHAR(45) NULL,
  PRIMARY KEY (`trip_id`, `stop_id`),
  CONSTRAINT `fk_trips_has_stops_trips`
    FOREIGN KEY (`trip_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`trips` (`trip_id`),
  CONSTRAINT `fk_trips_has_stops_stops1`
    FOREIGN KEY (`stop_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`stops` (`stop_id`));



-- -----------------------------------------------------
-- Table `VTA`.`fare_attributes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`.`VTA`.`fare_attributes` (
  `fare_id` INT NOT NULL,
  `price` DECIMAL(5,3) NULL,
  `currency_type` VARCHAR(10) NULL,
  `payment_method` INT NULL,
  `transfers` INT NULL,
  `route_id` INT NOT NULL,
  PRIMARY KEY (`fare_id`, `route_id`),
  CONSTRAINT `fk_fare_attributes_route_attributes1`
    FOREIGN KEY (`route_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`route_attributes` (`route_id`));

-- -----------------------------------------------------
-- Table `VTA`.`date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`.`VTA`.`date` (
  `date` DATE NOT NULL,
  `date_yyyymmdd` VARCHAR(45) NULL,
  `day_of_week` VARCHAR(40) NULL,
  `is_weekday` INT NULL,
  `is_weekend` INT NULL,
  `is_holiday` INT NULL,
  `week_number` INT NULL,
  `week_start_date` DATE NULL,
  `month` VARCHAR(45) NULL,
  `month_start_date` DATE NULL,
  `year` INT NULL,
  PRIMARY KEY (`date`));


-- -----------------------------------------------------
-- Table `VTA`.`calendar_dates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `dbms-sjsu`.`VTA`.`calendar_dates` (
  `service_service_id` VARCHAR(45) NOT NULL,
  `date_date` INT NOT NULL,
  PRIMARY KEY (`service_service_id`, `date_date`),
  CONSTRAINT `fk_service_has_date_service1`
    FOREIGN KEY (`service_service_id`)
    REFERENCES  `dbms-sjsu`.`VTA`.`service` (`service_id`),
  CONSTRAINT `fk_service_has_date_date1`
    FOREIGN KEY (`date_date`)
    REFERENCES  `dbms-sjsu`.`VTA`.`date` (`date`));
