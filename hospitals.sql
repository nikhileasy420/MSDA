USE `hospitals` ;

-- -----------------------------------------------------
-- Table `hospitals`.`Employee`
-- -----------------------------------------------------
DROP TABLE hospitals.employee;
CREATE TABLE IF NOT EXISTS `hospitals`.`Employee` (
  `employee_id` INT NOT NULL,
  `first_Name` VARCHAR(45) NULL,
  `last_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`employee_id`));


-- -----------------------------------------------------
-- Table `hospitals`.`CareCenter`#
#Error Code: 1239. Incorrect foreign key definition for 'foreign key without name': Key reference and table reference don't match

-- -----------------------------------------------------
DROP TABLE `hospitals`.`CareCenter`;
CREATE TABLE IF NOT EXISTS `hospitals`.`CareCenter` (
  `cc_id` INT NOT NULL,
  `cc_name` VARCHAR(45) NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`cc_id`),
  FOREIGN KEY (`employee_id`)
    REFERENCES `hospitals`.`Employee`
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `hospitals`.`Patient`
-- -----------------------------------------------------
DROP TABLE `hospitals`.`Patient`;
CREATE TABLE IF NOT EXISTS `hospitals`.`Patient` (
  `patient_id` INT NOT NULL,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  PRIMARY KEY (`patient_id`));


-- -----------------------------------------------------
-- Table `hospitals`.`Employee_CareCenter`
-- -----------------------------------------------------
DROP TABLE `hospitals`.`Employee_CareCenter`;
CREATE TABLE IF NOT EXISTS `hospitals`.`Employee_CareCenter` (
  `emp_id` INT NOT NULL,
  `cc_id` INT NOT NULL,
  `hoursperweek` INT NULL,
  PRIMARY KEY (`emp_id`, `cc_id`),
  CONSTRAINT `fk_Employee_has_CareCenter_Employee`
    FOREIGN KEY (`emp_id`)
    REFERENCES `hospitals`.`Employee` (`Employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Employee_has_CareCenter_CareCenter1`
    FOREIGN KEY (`cc_id`)
    REFERENCES `hospitals`.`CareCenter` (`cc_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `hospitals`.`Room`
-- -----------------------------------------------------

DROP TABLE `hospitals`.`Room`;
CREATE TABLE IF NOT EXISTS `hospitals`.`Room` (
  `room_id` INT NOT NULL,
  `cc_id` INT NOT NULL,
  `no_of_beds` INT NULL,
  PRIMARY KEY (`room_id`, `cc_id`),
  CONSTRAINT `fk_Room_CareCenter1`
    FOREIGN KEY (`cc_id`)
    REFERENCES `hospitals`.`CareCenter` (`cc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table `hospitals`.`Bed`
-- -----------------------------------------------------

DROP TABLE `hospitals`.`Bed`;
CREATE TABLE IF NOT EXISTS `hospitals`.`Bed` (
  `Bed_id` INT NOT NULL,
  `bed_type` VARCHAR(45) NULL,
  `room_id` INT NOT NULL,
  `cc_id` INT NOT NULL,
  `patient_id` INT NULL,
  PRIMARY KEY (`Bed_id`, `room_id`, `cc_id`),
  CONSTRAINT `fk_Bed_Room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `hospitals`.`Room` (`room_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `cc_id`
    FOREIGN KEY (`cc_id`)
    REFERENCES `hospitals`.`CareCenter` (`cc_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Bed_Patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospitals`.`Patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `hospitals`.`treatment`
-- -----------------------------------------------------
DROP TABLE `hospitals`.`treatment`;
CREATE TABLE IF NOT EXISTS `hospitals`.`treatment` (
  `treatment_id` INT NOT NULL,
  `description` VARCHAR(120) NULL,
  PRIMARY KEY (`treatment_id`));


-- -----------------------------------------------------
-- Table `hospitals`.`physician`
-- -----------------------------------------------------
DROP TABLE `hospitals`.`physician`;
CREATE TABLE IF NOT EXISTS `hospitals`.`physician` (
  `phy_id` INT NOT NULL,
  `last name` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`phy_id`));


-- -----------------------------------------------------
-- Table `hospitals`.`phy_treatment`
#Error Code: 3734. Failed to add the foreign key constraint. Missing column 'phys_id' for constraint 'fk_physician_has_treatment_physician1' in the referenced table 'physician'
#Error Code: 1822. Failed to add the foreign key constraint. Missing index for constraint 'fk_physician_has_treatment_physician1' in the referenced table 'physician'


-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitals`.`phy_treatment` (
  `phy_id` INT NOT NULL,
  `phy_last_name` VARCHAR(45) NOT NULL,
  `phy_first_name` VARCHAR(45) NOT NULL,
  `treatment_id` INT NOT NULL,
  PRIMARY KEY (`phy_id`, `phy_last_name`, `phy_first_name`, `treatment_id`),
  CONSTRAINT `fk_physician_has_treatment_physician1`
    FOREIGN KEY (`phy_id` , `phy_last_name` , `phy_first_name`)
    REFERENCES `hospitals`.`physician` (`phy_id` , `last name` , `first_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_physician_has_treatment_treatment1`
    FOREIGN KEY (`treatment_id`)
    REFERENCES `hospitals`.`treatment` (`treatment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `hospitals`.`treatment_has_Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitals`.`treatment_has_Patient` (
  `treatment_treatment_id` INT NOT NULL,
  `Patient_patient_id` INT NOT NULL,
  PRIMARY KEY (`treatment_treatment_id`, `Patient_patient_id`),
  CONSTRAINT `fk_treatment_has_Patient_treatment1`
    FOREIGN KEY (`treatment_treatment_id`)
    REFERENCES `hospitals`.`treatment` (`treatment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_treatment_has_Patient_Patient1`
    FOREIGN KEY (`Patient_patient_id`)
    REFERENCES `hospitals`.`Patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `hospitals`.`Medicine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitals`.`Medicine` (
  `medicine_id` INT NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `unit_cost` VARCHAR(45) NOT NULL,
  `medicine_type` VARCHAR(45) NULL,
  PRIMARY KEY (`medicine_id`));


-- -----------------------------------------------------
-- Table `hospitals`.`consumes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitals`.`consumes` (
  `patient_id` INT NOT NULL,
  `medicine_name` INT NOT NULL,
  PRIMARY KEY (`patient_id`, `medicine_name`),
  INDEX `fk_Patient_has_Medicine_Medicine1_idx` (`medicine_name` ASC) VISIBLE,
  INDEX `fk_Patient_has_Medicine_Patient1_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_Patient_has_Medicine_Patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospitals`.`Patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Patient_has_Medicine_Medicine1`
    FOREIGN KEY (`medicine_name`)
    REFERENCES `hospitals`.`Medicine` (`medicine_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);


-- -----------------------------------------------------
-- Table `hospitals`.`surgery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitals`.`surgery` (
  `surgery_ud` INT NOT NULL,
  `surgery_name` VARCHAR(45) NULL,
  PRIMARY KEY (`surgery_ud`));


-- -----------------------------------------------------
-- Table `hospitals`.`phy_treatment_has_treatment_has_Patient`
-- -----------------------------------------------------
DROP TABLE `hospitals`.`phy_treatment_has_treatment_has_Patient`;
CREATE TABLE IF NOT EXISTS `hospitals`.`phy_treatment_has_treatment_has_Patient` (
  `phy_id` INT NOT NULL,
  `phy_last_name` VARCHAR(45) NOT NULL,
  `phy_first_name` VARCHAR(45) NOT NULL,
  `treatment_treatment_id` INT NOT NULL,
  `patient_patient_id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`phy_id`, `phy_last_name`, `phy_first_name`, `treatment_treatment_id`, `date`, `patient_patient_id`),
  CONSTRAINT `fk_phy_treatment_has_treatment_has_Patient_phy_treatment1`
    FOREIGN KEY (`phy_id` , `phy_last_name` , `phy_first_name` )
    REFERENCES `hospitals`.`phy_treatment` (`phy_id` , `phy_last_name` , `phy_first_name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_phy_treatment_has_treatment_has_Patient_treatment_has_Pati1`
    FOREIGN KEY (`treatment_treatment_id` , `[patient_patient_id`)
    REFERENCES `hospitals`.`treatment_has_Patient` (`treatment_treatment_id` , `Patient_patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);

#0 row(s) affected, 1 warning(s): 1050 Table 'phy_treatment_has_treatment_has_Patient' already exists

-- -----------------------------------------------------
-- Table `hospitals`.`Patient_has_surgery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitals`.`Patient_has_surgery` (
  `patient_id` INT NOT NULL,
  `surgery_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`, `surgery_id`),
  CONSTRAINT `fk_Patient_has_surgery_Patient1`
    FOREIGN KEY (`patient_id`)
    REFERENCES `hospitals`.`Patient` (`patient_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Patient_has_surgery_surgery1`
    FOREIGN KEY (`surgery_id`)
    REFERENCES `hospitals`.`surgery` (`surgery_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE);