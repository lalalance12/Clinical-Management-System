CREATE DATABASE IF NOT EXISTS `web_cms_database`;

USE `web_cms_database`;

-- LOGIN
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT NOT NULL,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    middle_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email varchar(50) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    user_role VARCHAR(20) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY username (username)
) AUTO_INCREMENT = 1000;

-- -- LOGS
CREATE TABLE IF NOT EXISTS user_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_date DATE,
    log_time TIME,
    role VARCHAR(20),
    username VARCHAR(40),
    action VARCHAR(20),
    details VARCHAR(60) 
);

--PROCEDURES
DELIMITER //
CREATE PROCEDURE rec_admin_add(IN admin_username VARCHAR(40), IN new_username VARCHAR(40))
BEGIN
  INSERT INTO user_logs (
      log_date, log_time, role, username, action, details
  ) VALUES (
      CURDATE(), CURTIME(), 'ADMIN', admin_username,
      'ADD', CONCAT('Username: ', new_username)
  );
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE rec_admin_delete(IN admin_username VARCHAR(40), IN new_username VARCHAR(40))
BEGIN
  INSERT INTO user_logs (
      log_date, log_time, role, username, action, details
  ) VALUES (
      CURDATE(), CURTIME(), 'ADMIN', admin_username,
      'DELETE', CONCAT('Username: ', new_username)
  );
END;
//
DELIMITER ;

DELIMITER //
CREATE PROCEDURE rec_admin_edit(IN admin_username VARCHAR(40), IN new_username VARCHAR(40))
BEGIN
  INSERT INTO user_logs (
      log_date, log_time, role, username, action, details
  ) VALUES (
      CURDATE(), CURTIME(), 'ADMIN', admin_username,
      'EDIT', CONCAT('Username: ', new_username)
  );
END;
//
DELIMITER ;

-- PATIENT INFORMATION
CREATE TABLE IF NOT EXISTS `patientinfo` (
  `patientID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `midName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `civilStatus` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `bloodType` varchar(10) NOT NULL,
  `birthPlace` varchar(255) NOT NULL,
  `birthDate` date NOT NULL,
  `p_address` varchar(255) NOT NULL,
  `nationality` varchar(50) NOT NULL,
  `religion` varchar(50) NOT NULL,
  `eContactName` varchar(255) NOT NULL,
  `relationship` varchar(20) NOT NULL,
  `eContactNum` varchar(20) NOT NULL,
  `occupation` varchar(50) NOT NULL,
  `p_email` varchar(50) NOT NULL,
  `p_contactNum` varchar(20) NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`patientID`),
  UNIQUE KEY `patient_id_UNIQUE` (`patientID`)
  FOREIGN KEY (`userID`) REFERENCES users(`id`) ON DELETE CASCADE
);

-- DOCTOR-PATIENT RELATION
CREATE TABLE docpatient_relation (
    relationID int NOT NULL AUTO_INCREMENT,
    doctorID int NOT NULL,
    patientID int NOT NULL,
    PRIMARY KEY (`relationID`),
    UNIQUE KEY `relation_id_UNIQUE` (`relationID`),
    FOREIGN KEY (`doctorID`) REFERENCES users(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- MEDICAL HISTORY
CREATE TABLE IF NOT EXISTS medicalhistory (
    `historyID` int NOT NULL AUTO_INCREMENT,
    `patientID` int NOT NULL,
    `bcgCheckbox` BOOLEAN,
    `dtpCheckbox` BOOLEAN,
    `pcvCheckbox` BOOLEAN,
    `influenzaCheckbox` BOOLEAN,
    `hepaCheckbox` BOOLEAN,
    `ipvCheckbox` BOOLEAN,
    `mmrCheckbox` BOOLEAN,
    `hpvCheckbox` BOOLEAN,
    `asthmaCheckbox` BOOLEAN,
    `diabetesCheckbox` BOOLEAN,
    `heartCheckbox` BOOLEAN,
    `birthCheckbox` BOOLEAN,
    `boneCheckbox` BOOLEAN,
    `alzheimerCheckbox` BOOLEAN,
    `cancerCheckbox` BOOLEAN,
    `thyroidCheckbox` BOOLEAN,
    `tuberculosisCheckbox` BOOLEAN,
    `eyeCheckbox` BOOLEAN,
    `clotsCheckbox` BOOLEAN,
    `mentalCheckbox` BOOLEAN,
    `kidneyCheckbox` BOOLEAN,
    `anemiaCheckbox` BOOLEAN,
    `muscleCheckbox` BOOLEAN,
    `highbloodCheckbox` BOOLEAN,
    `epilepsyCheckbox` BOOLEAN,
    `skinCheckbox` BOOLEAN,
    `hivCheckbox` BOOLEAN,
    `pulmonaryCheckbox` BOOLEAN,
    `specifications` TEXT,
    `others` TEXT,
    `past_c1` varchar(255),
    `medication1` varchar(255),
    `dosage1` varchar(255),
    `h_date1` date,
    `past_c2` varchar(255),
    `medication2` varchar(255),
    `dosage2` varchar(255),
    `h_date2` date,
    `past_c3` varchar(255),
    `medication3` varchar(255),
    `dosage3` varchar(255),
    `h_date3` date,
    `habitually` VARCHAR(10),
    `yearsDrunk` int,
    `frequencyDrink` VARCHAR(255),
    `quitDrinking` int,
    `frequently` VARCHAR(10),
    `yearsSmoked` int,
    `frequencySmoke` VARCHAR(255),
    `quitSmoking` int,
    `often` VARCHAR(10),
    `exerciseType` VARCHAR(255),
    `frequencyExercise` VARCHAR(255),
    `durationActivity` VARCHAR(255),
    `sexActive` VARCHAR(10),
    `sexPartner` VARCHAR(10),
    `numSexPartner` int,
    `contraception` VARCHAR(255),
    `useDrugs` VARCHAR(10),
    `specifyDrugs` VARCHAR(255),
    `frequencyDrugs` VARCHAR(255),
    `surgeryDate1` date,
    `surgeryProcedure1` VARCHAR(255),
    `hospital1` TEXT,
    `surgeryDate2` date,
    `surgeryProcedure2` VARCHAR(255),
    `hospital2` TEXT,
    `surgeryDate3` date,
    `surgeryProcedure3` VARCHAR(255),
    `hospital3` TEXT,
    `medications` TEXT,
    `allergies` TEXT,
    `diet` VARCHAR(255),
    PRIMARY KEY (`historyID`),
    UNIQUE KEY `history_id_UNIQUE` (`historyID`),
    FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- MEDICAL ASSESSMENT
CREATE TABLE IF NOT EXISTS `assessment` (
  `assessmentID` int NOT NULL AUTO_INCREMENT,
  `patientID` int NOT NULL,
  `subjectComp` varchar(255) NOT NULL,
  `complaints` TEXT,
  `illnessHistory` varchar(255),
  `bloodPressure` varchar(100),
  `pulseRate` varchar(100),
  `temperature` varchar(100),
  `respRate` varchar(100),
  `height` varchar(50),
  `weight_p` varchar(50),
  `bmi` varchar(50),
  `normal_head` varchar(50),
  `abnormalities_head` varchar(255),
  `normal_ears` varchar(50),
  `abnormalities_ears` varchar(255),
  `normal_eyes` varchar(50),
  `abnormalities_eyes` varchar(255),
  `normal_nose` varchar(50),
  `abnormalities_nose` varchar(255),
  `normal_skin` varchar(50),
  `abnormalities_skin` varchar(255),
  `normal_back` varchar(50),
  `abnormalities_back` varchar(255),
  `normal_neck` varchar(50),
  `abnormalities_neck` varchar(255),
  `normal_throat` varchar(50),
  `abnormalities_throat` varchar(255),
  `normal_chest` varchar(50),
  `abnormalities_chest` varchar(255),
  `normal_abdomen` varchar(50),
  `abnormalities_abdomen` varchar(255),
  `normal_upper` varchar(50),
  `abnormalities_upper` varchar(255),
  `normal_lower` varchar(50),
  `abnormalities_lower` varchar(255),
  `normal_tract` varchar(50),
  `abnormalities_tract` varchar(255),
  `comments` TEXT,
  `diagnosis` TEXT,
  `oxygenSaturation` varchar(100),
  `painSection` varchar(100),
  `consultationDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assessmentID`),
  UNIQUE KEY `assessment_id_UNIQUE` (`assessmentID`),
  FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- PRESCRIPTION 
CREATE TABLE IF NOT EXISTS `prescription` (
  `prescriptionID` int NOT NULL AUTO_INCREMENT,
  `assessmentID` int NOT NULL,
  PRIMARY KEY (`prescriptionID`),
  UNIQUE KEY `prescription_id_UNIQUE` (`prescriptionID`),
  FOREIGN KEY (`assessmentID`) REFERENCES assessment(`assessmentID`) ON DELETE CASCADE
);

-- PRESCRIPTION DETAILS 
CREATE TABLE IF NOT EXISTS `prescriptiondetails` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `prescriptionID` int NOT NULL,
  `medication_name` varchar(255),
  `dosage` varchar(255),
  `p_quantity` varchar(255),
  `duration` varchar(255),
  `instructions` varchar(255),
  PRIMARY KEY (`detail_id`),
  UNIQUE KEY `detail_id_UNIQUE` (`detail_id`),
  FOREIGN KEY (`prescriptionID`) REFERENCES prescription(`prescriptionID`) ON DELETE CASCADE
);

-- LABORATORY JOB ORDER
CREATE TABLE IF NOT EXISTS `labrequest` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `patientID` int NOT NULL,
  `patientName` varchar(255) NOT NULL,
  `labSubject` varchar(255) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `age` varchar(10) NOT NULL,
  `physician` varchar(255) NOT NULL,
  `orderDate` varchar(20) NOT NULL,
  `otherTest` varchar(255),
  PRIMARY KEY (`orderID`),
  UNIQUE KEY `order_id_UNIQUE` (`orderID`),
  FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- HEMATOLOGY
CREATE TABLE IF NOT EXISTS `hematology` (
  `hematologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `cbcplateCheckbox` BOOLEAN,
  `hgbhctCheckbox` BOOLEAN,
  `protimeCheckbox` BOOLEAN,
  `APTTCheckbox` BOOLEAN,
  `bloodtypingCheckbox` BOOLEAN,
  `ESRCheckbox` BOOLEAN,
  `plateCheckbox` BOOLEAN,
  `hgbCheckbox` BOOLEAN,
  `hctCheckbox` BOOLEAN,
  `cbcCheckbox` BOOLEAN,
  `reticsCheckbox` BOOLEAN,
  `CTBTCheckbox` BOOLEAN,
  PRIMARY KEY (`hematologyID`),
  UNIQUE KEY `hematology_id_UNIQUE` (`hematologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- BACTERIOLOGY
CREATE TABLE IF NOT EXISTS `bacteriology` (
  `bacteriologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `culsenCheckbox` BOOLEAN,
  `cultureCheckbox` BOOLEAN,
  `gramCheckbox` BOOLEAN,
  `KOHCheckbox` BOOLEAN,
  PRIMARY KEY (`bacteriologyID`),
  UNIQUE KEY `bacteriology_id_UNIQUE` (`bacteriologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- HISTOPATHOLOGY
CREATE TABLE IF NOT EXISTS `histopathology` (
  `histopathologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `biopsyCheckbox` BOOLEAN,
  `papsCheckbox` BOOLEAN,
  `FNABCheckbox` BOOLEAN,
  `cellCheckbox` BOOLEAN,
  `cytolCheckbox` BOOLEAN,
  PRIMARY KEY (`histopathologyID`),
  UNIQUE KEY `histopathology_id_UNIQUE` (`histopathologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
);

-- CLINICAL MIRCROSCOPY & PARASITOLOGY
CREATE TABLE IF NOT EXISTS `microscopy` (
  `microscopyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `urinCheckbox` BOOLEAN,
  `stoolCheckbox` BOOLEAN,
  `occultCheckbox` BOOLEAN,
  `semenCheckbox` BOOLEAN,
  `ELISACheckbox` BOOLEAN,
  PRIMARY KEY (`microscopyID`),
  UNIQUE KEY `microscopy_id_UNIQUE` (`microscopyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- SEROLOGY
CREATE TABLE IF NOT EXISTS `serology` (
  `serologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `ASOCheckbox` BOOLEAN,
  `AntiHBSCheckbox` BOOLEAN,
  `HCVCheckbox` BOOLEAN,
  `C3Checkbox` BOOLEAN,
  `HIVICheckbox` BOOLEAN,
  `HIVIICheckbox` BOOLEAN,
  `NS1Checkbox` BOOLEAN,
  `VDRLCheckbox` BOOLEAN,
  `PregCheckbox` BOOLEAN,
  `RFCheckbox` BOOLEAN,
  `QuantiCheckbox` BOOLEAN,
  `QualiCheckbox` BOOLEAN,
  `TyphidotCheckbox` BOOLEAN,
  `TubexCheckbox` BOOLEAN,
  `HAVIgMCheckbox` BOOLEAN,
  `DengueCheckbox` BOOLEAN,
  PRIMARY KEY (`serologyID`),
  UNIQUE KEY `serology_id_UNIQUE` (`serologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- IMMUNOCHEMISTRY
CREATE TABLE IF NOT EXISTS `immunochem` (
  `immunochemID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `AFPCheckbox` BOOLEAN,
  `ferritinCheckbox` BOOLEAN,
  `HBcIgMCheckbox` BOOLEAN,
  `AntiHBECheckbox` BOOLEAN,
  `CA125Checkbox` BOOLEAN,
  `PROBNPCheckbox` BOOLEAN,
  `CA153Checkbox` BOOLEAN,
  `CA199Checkbox` BOOLEAN,
  `PSACheckbox` BOOLEAN,
  `CEACheckbox` BOOLEAN,
  `FreeT3Checkbox` BOOLEAN,
  `ANA2Checkbox` BOOLEAN,
  `FreeT4Checkbox` BOOLEAN,
  `HBsAGCheckbox` BOOLEAN,
  `TroponiniCheckbox` BOOLEAN,
  `HbACheckbox` BOOLEAN,
  `HBAeAgCheckbox` BOOLEAN,
  `BetaCheckbox` BOOLEAN,
  `T3Checkbox` BOOLEAN,
  `T4Checkbox` BOOLEAN,
  `TSHCheckbox` BOOLEAN,
  PRIMARY KEY (`immunochemID`),
  UNIQUE KEY `immunochem_id_UNIQUE` (`immunochemID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
);

-- CLINICAL CHEMISTRY
CREATE TABLE IF NOT EXISTS `clinicalchem` (
  `clinicalchemID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `ALPCheckbox` BOOLEAN,
  `AmylaseCheckbox` BOOLEAN,
  `BUACheckbox` BOOLEAN,
  `BUNCheckbox` BOOLEAN,
  `CreatinineCheckbox` BOOLEAN,
  `SGPTCheckbox` BOOLEAN,
  `SGOTCheckbox` BOOLEAN,
  `FBSCheckbox` BOOLEAN,
  `RBSCheckbox` BOOLEAN,
  `HPPCheckbox` BOOLEAN,
  `OGCTCheckbox` BOOLEAN,
  `HGTCheckbox` BOOLEAN,
  `OGTTCheckbox` BOOLEAN,
  `NaCheckbox` BOOLEAN,
  `MgCheckbox` BOOLEAN,
  `LipidCheckbox` BOOLEAN,
  `TriglyCheckbox` BOOLEAN,
  `CholCheckbox` BOOLEAN,
  `ClCheckbox` BOOLEAN,
  `TPAGCheckbox` BOOLEAN,
  `TotalCheckbox` BOOLEAN,
  `GlobCheckbox` BOOLEAN,
  `AlbCheckbox` BOOLEAN,
  `CKMBCheckbox` BOOLEAN,
  `CKTotalCheckbox` BOOLEAN,
  `LDHCheckbox` BOOLEAN,
  `KCheckbox` BOOLEAN,
  `CaCheckbox` BOOLEAN,
  `IonizedCheckbox` BOOLEAN,
  `PhosCheckbox` BOOLEAN,
  PRIMARY KEY (`clinicalchemID`),
  UNIQUE KEY `clinicalchem_id_UNIQUE` (`clinicalchemID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
);

-- LABORATORY REPORT
CREATE TABLE IF NOT EXISTS `labreport` (
  `reportID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `medtech` varchar(255) NOT NULL,
  `pdfFile` varchar(255) NOT NULL,
  `reportDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reportID`),
  UNIQUE KEY `report_id_UNIQUE` (`reportID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 
CREATE DATABASE IF NOT EXISTS `web_cms_database`;

USE `web_cms_database`;

-- LOGIN
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT NOT NULL,
    username VARCHAR(20) NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    middle_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email varchar(50) NOT NULL,
    gender VARCHAR(20) NOT NULL,
    user_role VARCHAR(20) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY username (username)
) AUTO_INCREMENT = 1000;

CREATE TABLE IF NOT EXISTS `appointment` (
	`reference_number` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`receptionistID` INT(10) NOT NULL,
	`doctorID` INT(10) NOT NULL,
	`doctorName` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`date_appointment` DATE NULL DEFAULT NULL,
	`time_appointment` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`status_` VARCHAR(20) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`book_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`first_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`middle_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`last_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`sex` VARCHAR(10) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`birth_date` DATE NULL DEFAULT NULL,
	`contact_number` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`email` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`address` VARCHAR(100) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`date_updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`reference_number`) USING BTREE,
	UNIQUE INDEX `ref_number_uniq` (`reference_number`) USING BTREE,
	INDEX `receptionistID` (`receptionistID`) USING BTREE,
	INDEX `doctorID` (`doctorID`) USING BTREE,
	CONSTRAINT `fk_appointment_doctor` FOREIGN KEY (`doctorID`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE,
	CONSTRAINT `fk_appointment_receptionist` FOREIGN KEY (`receptionistID`) REFERENCES `users` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

CREATE TABLE IF NOT EXISTS `schedule` (
	`scheduleID` INT(10) NOT NULL AUTO_INCREMENT,
	`date_appointment` DATE NULL DEFAULT NULL,
	`time_appointment` VARCHAR(30) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`slots` INT(10) NOT NULL,
	`doctorID` INT(10) NOT NULL,
	`doctorName` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`receptionistID` INT(10) NOT NULL,
	`date_created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
	`date_updated` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`scheduleID`) USING BTREE,
	UNIQUE INDEX `schedule_id_UNIQUE` (`scheduleID`) USING BTREE,
	INDEX `doctorID` (`doctorID`) USING BTREE,
	INDEX `fk_schedule_receptionist` (`receptionistID`) USING BTREE,
	CONSTRAINT `fk_schedule_doctor` FOREIGN KEY (`doctorID`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT `fk_schedule_receptionist` FOREIGN KEY (`receptionistID`) REFERENCES `users` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8mb4_0900_ai_ci'
ENGINE=InnoDB
;

-- PATIENT INFORMATION
CREATE TABLE IF NOT EXISTS `patientinfo` (
  `patientID` int NOT NULL AUTO_INCREMENT,
  `firstName` varchar(100) NOT NULL,
  `midName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `age` int NOT NULL,
  `civilStatus` varchar(20) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `bloodType` varchar(10) NOT NULL,
  `birthPlace` varchar(255) NOT NULL,
  `birthDate` date NOT NULL,
  `p_address` varchar(255) NOT NULL,
  `nationality` varchar(50) NOT NULL,
  `religion` varchar(50) NOT NULL,
  `eContactName` varchar(255) NOT NULL,
  `relationship` varchar(20) NOT NULL,
  `eContactNum` varchar(20) NOT NULL,
  `occupation` varchar(50) NOT NULL,
  `p_email` varchar(50) NOT NULL,
  `p_contactNum` varchar(20) NOT NULL,
  `userID` int NOT NULL,
  PRIMARY KEY (`patientID`),
  UNIQUE KEY `patient_id_UNIQUE` (`patientID`),
  FOREIGN KEY (`userID`) REFERENCES users(`id`) ON DELETE CASCADE
);

-- DOCTOR-PATIENT RELATION
CREATE TABLE IF NOT EXISTS `docpatient_relation` (
    `relationID` INT NOT NULL AUTO_INCREMENT,
    `doctorID` INT NOT NULL,
    `patientID` INT NOT NULL,
    PRIMARY KEY (`relationID`),
    UNIQUE KEY `relation_id_UNIQUE` (`relationID`),
    FOREIGN KEY (`doctorID`) REFERENCES `users` (`id`) ON DELETE CASCADE,
    FOREIGN KEY (`patientID`) REFERENCES `patientinfo` (`patientID`) ON DELETE CASCADE
);

-- MEDICAL HISTORY
CREATE TABLE IF NOT EXISTS medicalhistory (
    `historyID` int NOT NULL AUTO_INCREMENT,
    `patientID` int NOT NULL,
    `bcgCheckbox` BOOLEAN,
    `dtpCheckbox` BOOLEAN,
    `pcvCheckbox` BOOLEAN,
    `influenzaCheckbox` BOOLEAN,
    `hepaCheckbox` BOOLEAN,
    `ipvCheckbox` BOOLEAN,
    `mmrCheckbox` BOOLEAN,
    `hpvCheckbox` BOOLEAN,
    `asthmaCheckbox` BOOLEAN,
    `diabetesCheckbox` BOOLEAN,
    `heartCheckbox` BOOLEAN,
    `birthCheckbox` BOOLEAN,
    `boneCheckbox` BOOLEAN,
    `alzheimerCheckbox` BOOLEAN,
    `cancerCheckbox` BOOLEAN,
    `thyroidCheckbox` BOOLEAN,
    `tuberculosisCheckbox` BOOLEAN,
    `eyeCheckbox` BOOLEAN,
    `clotsCheckbox` BOOLEAN,
    `mentalCheckbox` BOOLEAN,
    `kidneyCheckbox` BOOLEAN,
    `anemiaCheckbox` BOOLEAN,
    `muscleCheckbox` BOOLEAN,
    `highbloodCheckbox` BOOLEAN,
    `epilepsyCheckbox` BOOLEAN,
    `skinCheckbox` BOOLEAN,
    `hivCheckbox` BOOLEAN,
    `pulmonaryCheckbox` BOOLEAN,
    `specifications` TEXT,
    `others` TEXT,
    `past_c1` varchar(255),
    `medication1` varchar(255),
    `dosage1` varchar(255),
    `h_date1` date,
    `past_c2` varchar(255),
    `medication2` varchar(255),
    `dosage2` varchar(255),
    `h_date2` date,
    `past_c3` varchar(255),
    `medication3` varchar(255),
    `dosage3` varchar(255),
    `h_date3` date,
    `habitually` VARCHAR(10),
    `yearsDrunk` int,
    `frequencyDrink` VARCHAR(255),
    `quitDrinking` int,
    `frequently` VARCHAR(10),
    `yearsSmoked` int,
    `frequencySmoke` VARCHAR(255),
    `quitSmoking` int,
    `often` VARCHAR(10),
    `exerciseType` VARCHAR(255),
    `frequencyExercise` VARCHAR(255),
    `durationActivity` VARCHAR(255),
    `sexActive` VARCHAR(10),
    `sexPartner` VARCHAR(10),
    `numSexPartner` int,
    `contraception` VARCHAR(255),
    `useDrugs` VARCHAR(10),
    `specifyDrugs` VARCHAR(255),
    `frequencyDrugs` VARCHAR(255),
    `surgeryDate1` date,
    `surgeryProcedure1` VARCHAR(255),
    `hospital1` TEXT,
    `surgeryDate2` date,
    `surgeryProcedure2` VARCHAR(255),
    `hospital2` TEXT,
    `surgeryDate3` date,
    `surgeryProcedure3` VARCHAR(255),
    `hospital3` TEXT,
    `medications` TEXT,
    `allergies` TEXT,
    `diet` VARCHAR(255),
    PRIMARY KEY (`historyID`),
    UNIQUE KEY `history_id_UNIQUE` (`historyID`),
    FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- MEDICAL ASSESSMENT
CREATE TABLE IF NOT EXISTS `assessment` (
  `assessmentID` int NOT NULL AUTO_INCREMENT,
  `patientID` int NOT NULL,
  `subjectComp` varchar(255) NOT NULL,
  `complaints` TEXT,
  `illnessHistory` TEXT,
  `bloodPressure` varchar(100),
  `pulseRate` varchar(100),
  `temperature` varchar(100),
  `respRate` varchar(100),
  `height` varchar(50),
  `weight_p` varchar(50),
  `bmi` varchar(50),
  `normal_head` varchar(50),
  `abnormalities_head` varchar(255),
  `normal_ears` varchar(50),
  `abnormalities_ears` varchar(255),
  `normal_eyes` varchar(50),
  `abnormalities_eyes` varchar(255),
  `normal_nose` varchar(50),
  `abnormalities_nose` varchar(255),
  `normal_skin` varchar(50),
  `abnormalities_skin` varchar(255),
  `normal_back` varchar(50),
  `abnormalities_back` varchar(255),
  `normal_neck` varchar(50),
  `abnormalities_neck` varchar(255),
  `normal_throat` varchar(50),
  `abnormalities_throat` varchar(255),
  `normal_chest` varchar(50),
  `abnormalities_chest` varchar(255),
  `normal_abdomen` varchar(50),
  `abnormalities_abdomen` varchar(255),
  `normal_upper` varchar(50),
  `abnormalities_upper` varchar(255),
  `normal_lower` varchar(50),
  `abnormalities_lower` varchar(255),
  `normal_tract` varchar(50),
  `abnormalities_tract` varchar(255),
  `comments` TEXT,
  `diagnosis` TEXT,
  `oxygenSaturation` varchar(100),
  `painSection` varchar(100),
  `consultationDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`assessmentID`),
  UNIQUE KEY `assessment_id_UNIQUE` (`assessmentID`),
  FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- PRESCRIPTION 
CREATE TABLE IF NOT EXISTS `prescription` (
  `prescriptionID` int NOT NULL AUTO_INCREMENT,
  `assessmentID` int NOT NULL,
  PRIMARY KEY (`prescriptionID`),
  UNIQUE KEY `prescription_id_UNIQUE` (`prescriptionID`),
  FOREIGN KEY (`assessmentID`) REFERENCES assessment(`assessmentID`) ON DELETE CASCADE
);

-- PRESCRIPTION DETAILS 
CREATE TABLE IF NOT EXISTS `prescriptiondetails` (
  `detail_id` int NOT NULL AUTO_INCREMENT,
  `prescriptionID` int NOT NULL,
  `medication_name` varchar(255),
  `dosage` varchar(255),
  `p_quantity` varchar(255),
  `duration` varchar(255),
  `instructions` varchar(255),
  PRIMARY KEY (`detail_id`),
  UNIQUE KEY `detail_id_UNIQUE` (`detail_id`),
  FOREIGN KEY (`prescriptionID`) REFERENCES prescription(`prescriptionID`) ON DELETE CASCADE
);

-- MEDICAL CLEARANCE
CREATE TABLE IF NOT EXISTS `clearance` (
  `clearanceID` int NOT NULL AUTO_INCREMENT,
  `patientID` int NOT NULL,
  `subjectClearance` varchar(255) NOT NULL,
  `reason` TEXT,
  `recommendations` TEXT,
  `bloodPressure` varchar(100),
  `pulseRate` varchar(100),
  `temperature` varchar(100),
  `respRate` varchar(100),
  `height` varchar(50),
  `weight_p` varchar(50),
  `bmi` varchar(50),
  `oxygenSaturation` varchar(100),
  `painSection` varchar(100),
  `physicalExam` TEXT,
  `clearance` TEXT,
  `consultationDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`clearanceID`),
  UNIQUE KEY `clearance_id_UNIQUE` (`clearanceID`),
  FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- MEDICAL CERTIFICATE
CREATE TABLE IF NOT EXISTS `certificate` (
  `certificateID` int NOT NULL AUTO_INCREMENT,
  `patientID` int NOT NULL,
  `subjectCertificate` varchar(255) NOT NULL,
  `reason` TEXT,
  `recommendations` TEXT,
  `bloodPressure` varchar(100),
  `pulseRate` varchar(100),
  `temperature` varchar(100),
  `respRate` varchar(100),
  `height` varchar(50),
  `weight_p` varchar(50),
  `bmi` varchar(50),
  `oxygenSaturation` varchar(100),
  `painSection` varchar(100),
  `physicalExam` TEXT,
  `certificate` TEXT,
  `consultationDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`certificateID`),
  UNIQUE KEY `certificate_id_UNIQUE` (`certificateID`),
  FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- LABORATORY JOB ORDER
CREATE TABLE IF NOT EXISTS `labrequest` (
  `orderID` int NOT NULL AUTO_INCREMENT,
  `patientID` int NOT NULL,
  `doctorID` int NOT NULL,
  `patientName` varchar(255) NOT NULL,
  `labSubject` varchar(255) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `age` varchar(10) NOT NULL,
  `physician` varchar(255) NOT NULL,
  `orderDate` varchar(20) NOT NULL,
  `otherTest` varchar(255),
  PRIMARY KEY (`orderID`),
  UNIQUE KEY `order_id_UNIQUE` (`orderID`),
  FOREIGN KEY (`patientID`) REFERENCES patientinfo(`patientID`) ON DELETE CASCADE
);

-- HEMATOLOGY
CREATE TABLE IF NOT EXISTS `hematology` (
  `hematologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `cbcplateCheckbox` BOOLEAN,
  `hgbhctCheckbox` BOOLEAN,
  `protimeCheckbox` BOOLEAN,
  `APTTCheckbox` BOOLEAN,
  `bloodtypingCheckbox` BOOLEAN,
  `ESRCheckbox` BOOLEAN,
  `plateCheckbox` BOOLEAN,
  `hgbCheckbox` BOOLEAN,
  `hctCheckbox` BOOLEAN,
  `cbcCheckbox` BOOLEAN,
  `reticsCheckbox` BOOLEAN,
  `CTBTCheckbox` BOOLEAN,
  PRIMARY KEY (`hematologyID`),
  UNIQUE KEY `hematology_id_UNIQUE` (`hematologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- BACTERIOLOGY
CREATE TABLE IF NOT EXISTS `bacteriology` (
  `bacteriologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `culsenCheckbox` BOOLEAN,
  `cultureCheckbox` BOOLEAN,
  `gramCheckbox` BOOLEAN,
  `KOHCheckbox` BOOLEAN,
  PRIMARY KEY (`bacteriologyID`),
  UNIQUE KEY `bacteriology_id_UNIQUE` (`bacteriologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- HISTOPATHOLOGY
CREATE TABLE IF NOT EXISTS `histopathology` (
  `histopathologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `biopsyCheckbox` BOOLEAN,
  `papsCheckbox` BOOLEAN,
  `FNABCheckbox` BOOLEAN,
  `cellCheckbox` BOOLEAN,
  `cytolCheckbox` BOOLEAN,
  PRIMARY KEY (`histopathologyID`),
  UNIQUE KEY `histopathology_id_UNIQUE` (`histopathologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
);

-- CLINICAL MIRCROSCOPY & PARASITOLOGY
CREATE TABLE IF NOT EXISTS `microscopy` (
  `microscopyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `urinCheckbox` BOOLEAN,
  `stoolCheckbox` BOOLEAN,
  `occultCheckbox` BOOLEAN,
  `semenCheckbox` BOOLEAN,
  `ELISACheckbox` BOOLEAN,
  PRIMARY KEY (`microscopyID`),
  UNIQUE KEY `microscopy_id_UNIQUE` (`microscopyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- SEROLOGY
CREATE TABLE IF NOT EXISTS `serology` (
  `serologyID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `ASOCheckbox` BOOLEAN,
  `AntiHBSCheckbox` BOOLEAN,
  `HCVCheckbox` BOOLEAN,
  `C3Checkbox` BOOLEAN,
  `HIVICheckbox` BOOLEAN,
  `HIVIICheckbox` BOOLEAN,
  `NS1Checkbox` BOOLEAN,
  `VDRLCheckbox` BOOLEAN,
  `PregCheckbox` BOOLEAN,
  `RFCheckbox` BOOLEAN,
  `QuantiCheckbox` BOOLEAN,
  `QualiCheckbox` BOOLEAN,
  `TyphidotCheckbox` BOOLEAN,
  `TubexCheckbox` BOOLEAN,
  `HAVIgMCheckbox` BOOLEAN,
  `DengueCheckbox` BOOLEAN,
  PRIMARY KEY (`serologyID`),
  UNIQUE KEY `serology_id_UNIQUE` (`serologyID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 

-- IMMUNOCHEMISTRY
CREATE TABLE IF NOT EXISTS `immunochem` (
  `immunochemID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `AFPCheckbox` BOOLEAN,
  `ferritinCheckbox` BOOLEAN,
  `HBcIgMCheckbox` BOOLEAN,
  `AntiHBECheckbox` BOOLEAN,
  `CA125Checkbox` BOOLEAN,
  `PROBNPCheckbox` BOOLEAN,
  `CA153Checkbox` BOOLEAN,
  `CA199Checkbox` BOOLEAN,
  `PSACheckbox` BOOLEAN,
  `CEACheckbox` BOOLEAN,
  `FreeT3Checkbox` BOOLEAN,
  `ANA2Checkbox` BOOLEAN,
  `FreeT4Checkbox` BOOLEAN,
  `HBsAGCheckbox` BOOLEAN,
  `TroponiniCheckbox` BOOLEAN,
  `HbACheckbox` BOOLEAN,
  `HBAeAgCheckbox` BOOLEAN,
  `BetaCheckbox` BOOLEAN,
  `T3Checkbox` BOOLEAN,
  `T4Checkbox` BOOLEAN,
  `TSHCheckbox` BOOLEAN,
  PRIMARY KEY (`immunochemID`),
  UNIQUE KEY `immunochem_id_UNIQUE` (`immunochemID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
);

-- CLINICAL CHEMISTRY
CREATE TABLE IF NOT EXISTS `clinicalchem` (
  `clinicalchemID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `ALPCheckbox` BOOLEAN,
  `AmylaseCheckbox` BOOLEAN,
  `BUACheckbox` BOOLEAN,
  `BUNCheckbox` BOOLEAN,
  `CreatinineCheckbox` BOOLEAN,
  `SGPTCheckbox` BOOLEAN,
  `SGOTCheckbox` BOOLEAN,
  `FBSCheckbox` BOOLEAN,
  `RBSCheckbox` BOOLEAN,
  `HPPCheckbox` BOOLEAN,
  `OGCTCheckbox` BOOLEAN,
  `HGTCheckbox` BOOLEAN,
  `OGTTCheckbox` BOOLEAN,
  `NaCheckbox` BOOLEAN,
  `MgCheckbox` BOOLEAN,
  `LipidCheckbox` BOOLEAN,
  `TriglyCheckbox` BOOLEAN,
  `CholCheckbox` BOOLEAN,
  `ClCheckbox` BOOLEAN,
  `TPAGCheckbox` BOOLEAN,
  `TotalCheckbox` BOOLEAN,
  `GlobCheckbox` BOOLEAN,
  `AlbCheckbox` BOOLEAN,
  `CKMBCheckbox` BOOLEAN,
  `CKTotalCheckbox` BOOLEAN,
  `LDHCheckbox` BOOLEAN,
  `KCheckbox` BOOLEAN,
  `CaCheckbox` BOOLEAN,
  `IonizedCheckbox` BOOLEAN,
  `PhosCheckbox` BOOLEAN,
  PRIMARY KEY (`clinicalchemID`),
  UNIQUE KEY `clinicalchem_id_UNIQUE` (`clinicalchemID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
);

-- LABORATORY REPORT
CREATE TABLE IF NOT EXISTS `labreport` (
  `reportID` int NOT NULL AUTO_INCREMENT,
  `orderID` int NOT NULL,
  `medtech` varchar(255) NOT NULL,
  `pdfFile` varchar(255) NOT NULL,
  `reportDate` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`reportID`),
  UNIQUE KEY `report_id_UNIQUE` (`reportID`),
  FOREIGN KEY (`orderID`) REFERENCES labrequest(`orderID`) ON DELETE CASCADE
); 