USE sereneschool;

CREATE TABLE `sch_organizations` (
  `org_code` int(11) NOT NULL AUTO_INCREMENT,
  `org_sht_desc` varchar(30) NOT NULL,
  `org_desc` varchar(1000) NOT NULL,
  `org_postal_address` varchar(1000) DEFAULT NULL,
  `org_physical_address` varchar(1000) DEFAULT NULL,
  `org_type` varchar(10) DEFAULT NULL,
  `org_parent_org_code` int(11) DEFAULT NULL,
  `org_parent_org_sht_desc` varchar(30) DEFAULT NULL,
  `org_wef` datetime DEFAULT NULL,
  `org_wet` datetime DEFAULT NULL,
  `org_level` smallint(6) DEFAULT NULL,
  `org_pin_no` varchar(45) DEFAULT NULL,
  `org_p9a_approval_no` varchar(45) DEFAULT NULL,
  `org_nssf_no` varchar(45) DEFAULT NULL,
  `org_nhif_no` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`org_code`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='Organization structure';

CREATE TABLE `sch_employees` (
  `emp_code` int(11) NOT NULL AUTO_INCREMENT,
  `emp_hm_code` int(11) NOT NULL,
  `emp_created_date` datetime DEFAULT CURRENT_TIMESTAMP,
  `emp_created_by` varchar(45) DEFAULT NULL,
  `emp_sht_desc` varchar(45) DEFAULT NULL,
  `emp_contract_date` date DEFAULT NULL,
  `emp_final_date` date DEFAULT NULL,
  `emp_join_date` date DEFAULT NULL,
  `emp_org_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`emp_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Stores the employees in a firm';

ALTER TABLE `sereneschool`.`sch_employees` 
ADD COLUMN `emp_co_code` INT(11) NULL COMMENT 'Occupation' AFTER `emp_org_code`,
ADD INDEX `emp_co_code_fk_idx` (`emp_co_code` ASC);
ALTER TABLE `sereneschool`.`sch_employees` 
ADD CONSTRAINT `emp_co_code_fk`
  FOREIGN KEY (`emp_co_code`)
  REFERENCES `serenecrmsdb`.`cr_occupations` (`co_code`)
  ON DELETE RESTRICT
  ON UPDATE NO ACTION;

CREATE TABLE `sereneschool`.`sch_school_years` (
  `sy_code` INT NOT NULL AUTO_INCREMENT,
  `sy_sht_desc` VARCHAR(45) NULL COMMENT 'short code for the year period e.g. \'2016/2017\' year or just \'2016\' year',
  `sy_start_date` DATETIME NOT NULL COMMENT 'The starting date of the year',
  `sy_end_date` DATETIME NOT NULL COMMENT 'The end date of the year',
  PRIMARY KEY (`sy_code`))
COMMENT = 'Stores years in a school';

CREATE TABLE `sereneschool`.`sch_school_terms` (
  `st_code` INT NOT NULL AUTO_INCREMENT,
  `st_sy_code` INT NOT NULL COMMENT 'School Year',
  `st_sht_desc` VARCHAR(45) NOT NULL COMMENT 'Term short description e.g. Term1, Term2, Term3',
  `st_desc` VARCHAR(300) NULL COMMENT 'Term Description of term(Optional)	',
  `st_start_date` DATETIME NOT NULL COMMENT 'Start date of term',
  `st_end_date` DATETIME NOT NULL COMMENT 'End date of term',
  PRIMARY KEY (`st_code`),
  INDEX `st_sy_code_fk_idx` (`st_sy_code` ASC),
  CONSTRAINT `st_sy_code_fk`
    FOREIGN KEY (`st_sy_code`)
    REFERENCES `sereneschool`.`sch_school_years` (`sy_code`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
COMMENT = 'Stores terms in a school';

CREATE TABLE `sereneschool`.`sch_class_levels` (
  `scl_code` INT NOT NULL AUTO_INCREMENT,
  `sch_sht_desc` VARCHAR(45) NOT NULL COMMENT 'Short Description of level',
  `sch_desc` VARCHAR(300) NOT NULL COMMENT 'Full Description of level',
  PRIMARY KEY (`scl_code`))
COMMENT = 'Stores the class levels e.g. Primary, Secondary, College Diploma, College Degree';

CREATE TABLE `sereneschool`.`sch_classes` (
  `sc_code` INT NOT NULL AUTO_INCREMENT,
  `sc_sht_desc` VARCHAR(45) NOT NULL COMMENT 'Digit representing the class e.g 1',
  `sc_desc` VARCHAR(100) NOT NULL COMMENT 'Description of class e.g Class 1',
  `sc_scl_code` INT NOT NULL,
  PRIMARY KEY (`sc_code`),
  INDEX `sc_scl_code_fk_idx` (`sc_scl_code` ASC),
  CONSTRAINT `sc_scl_code_fk`
    FOREIGN KEY (`sc_scl_code`)
    REFERENCES `sereneschool`.`sch_class_levels` (`scl_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores the classes/grades offered in a school';

CREATE TABLE `sereneschool`.`sch_class_departments` (
  `scd_code` INT NOT NULL AUTO_INCREMENT,
  `scd_sht_desc` VARCHAR(45) NOT NULL COMMENT 'epartment short code',
  `scd_name` VARCHAR(300) NOT NULL COMMENT 'Full name of the department',
  PRIMARY KEY (`scd_code`))
COMMENT = 'Stores the departments in a school to categorize the subjects';

CREATE TABLE `sereneschool`.`sch_subjects` (
  `ss_code` INT NOT NULL AUTO_INCREMENT,
  `ss_sht_desc` VARCHAR(45) NOT NULL COMMENT 'Short code for the subjects',
  `ss_name` VARCHAR(100) NOT NULL COMMENT 'Subject name',
  `ss_scd_code` INT NULL COMMENT 'Department',
  PRIMARY KEY (`ss_code`),
  INDEX `ss_scd_code_fk_idx` (`ss_scd_code` ASC),
  CONSTRAINT `ss_scd_code_fk`
    FOREIGN KEY (`ss_scd_code`)
    REFERENCES `sereneschool`.`sch_class_departments` (`scd_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores the subjects offered is a school';

CREATE TABLE `sereneschool`.`sch_class_subjects` (
  `scs_code` INT NOT NULL AUTO_INCREMENT,
  `scs_ss_code` INT NOT NULL COMMENT 'Subject',
  `scs_sc_code` INT NOT NULL COMMENT 'Class',
  `scs_emp_code` INT NOT NULL COMMENT 'Teacher',
  PRIMARY KEY (`scs_code`),
  INDEX `scs_ss_code_idx` (`scs_ss_code` ASC),
  INDEX `scs_sc_code_idx` (`scs_sc_code` ASC),
  INDEX `scs_emp_code_fk_idx` (`scs_emp_code` ASC),
  CONSTRAINT `scs_ss_code_fk`
    FOREIGN KEY (`scs_ss_code`)
    REFERENCES `sereneschool`.`sch_subjects` (`ss_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `scs_sc_code_fk`
    FOREIGN KEY (`scs_sc_code`)
    REFERENCES `sereneschool`.`sch_classes` (`sc_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `scs_emp_code_fk`
    FOREIGN KEY (`scs_emp_code`)
    REFERENCES `sereneschool`.`sch_employees` (`emp_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores the subjects offered per class';
ALTER TABLE `sereneschool`.`sch_class_subjects` 
ADD COLUMN `scs_sy_code` INT NOT NULL COMMENT 'School Year' AFTER `scs_emp_code`,
ADD COLUMN `scs_auth` VARCHAR(15) NULL COMMENT 'Authorized YES, NO' AFTER `scs_sy_code`,
ADD COLUMN `scs_auth_by` VARCHAR(45) NULL COMMENT 'User who Authorized the subject' AFTER `scs_auth`,
ADD COLUMN `scs_auth_date` DATETIME NULL COMMENT 'Authorization date' AFTER `scs_auth_by`,
ADD INDEX `scs_sy_code_fk_idx` (`scs_sy_code` ASC);
ALTER TABLE `sereneschool`.`sch_class_subjects` 
ADD CONSTRAINT `scs_sy_code_fk`
  FOREIGN KEY (`scs_sy_code`)
  REFERENCES `sereneschool`.`sch_school_years` (`sy_code`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;

CREATE TABLE `sereneschool`.`sch_class_subjects_alt` (
  `scsa_code` INT NOT NULL AUTO_INCREMENT,
  `scsa_scs_code` INT NOT NULL,
  `scsa_scs_ss_code` INT NULL,
  `scsa_scs_sc_code` INT NULL,
  `scsa_scs_emp_code` INT NULL,
  `scsa_scs_sy_code` INT NULL,
  `scsa_scs_auth` VARCHAR(15) NULL COMMENT 'Authorized YES, NO',
  `scsa_scs_auth_by` VARCHAR(45) NULL,
  `scsa_scs_auth_date` DATETIME NULL,
  `scsa_alt_by` VARCHAR(45) NOT NULL COMMENT 'User who Altered the records',
  `scsa_alt_date` DATETIME NOT NULL COMMENT 'Alteration date and time',
  PRIMARY KEY (`scsa_code`),
  INDEX `scsa_scs_code_fk_idx` (`scsa_scs_code` ASC),
  CONSTRAINT `scsa_scs_code_fk`
    FOREIGN KEY (`scsa_scs_code`)
    REFERENCES `sereneschool`.`sch_class_subjects` (`scs_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores alterations on \'sch_class_subjects\' table after authorization';




CREATE TABLE `sereneschool`.`sch_time_table_type` (
  `ttt_code` INT NOT NULL AUTO_INCREMENT,
  `ttt_type` VARCHAR(45) NOT NULL COMMENT 'Time Table Type e.g. Normal, Holiday, Exam time table',
  PRIMARY KEY (`ttt_code`))
COMMENT = 'Stores Time Table Type e.g. Normal, Holiday time table (Back end non editable)';

CREATE TABLE `sereneschool`.`sch_time_table` (
  `tt_code` INT NOT NULL AUTO_INCREMENT,
  `tt_desc` VARCHAR(300) NOT NULL COMMENT 'Full description of the time table',
  `tt_ttt_code` INT NOT NULL COMMENT 'Time Table Type',
  `tt_sy_code` INT NOT NULL COMMENT 'School Year',
  `tt_st_code` INT NOT NULL COMMENT 'School Term',
  `tt_end_date` DATETIME NOT NULL COMMENT 'The end date to stop weekly scheduling using this time table',
  PRIMARY KEY (`tt_code`),
  INDEX `tt_ttt_code_fk_idx` (`tt_ttt_code` ASC),
  INDEX `tt_sy_code_fk_idx` (`tt_sy_code` ASC),
  INDEX `tt_st_code_fk_idx` (`tt_st_code` ASC),
  CONSTRAINT `tt_ttt_code_fk`
    FOREIGN KEY (`tt_ttt_code`)
    REFERENCES `sereneschool`.`sch_time_table_type` (`ttt_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `tt_sy_code_fk`
    FOREIGN KEY (`tt_sy_code`)
    REFERENCES `sereneschool`.`sch_school_years` (`sy_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `tt_st_code_fk`
    FOREIGN KEY (`tt_st_code`)
    REFERENCES `sereneschool`.`sch_school_terms` (`st_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores the school class training time table';
ALTER TABLE `sereneschool`.`sch_time_table` 
ADD COLUMN `tt_current` VARCHAR(5) NULL COMMENT 'Current YES, NO' AFTER `tt_end_date`;
ALTER TABLE `sereneschool`.`sch_time_table` 
ADD COLUMN `tt_usr_code` INT NULL COMMENT 'Personal Time Table User(Only applies to personal time table type)' AFTER `tt_current`,
ADD INDEX `tt_usr_code_fk_idx` (`tt_usr_code` ASC);
ALTER TABLE `sereneschool`.`sch_time_table` 
ADD CONSTRAINT `tt_usr_code_fk`
  FOREIGN KEY (`tt_usr_code`)
  REFERENCES `serenecrmsdb`.`cr_users` (`usr_code`)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT;


CREATE TABLE `sereneschool`.`sch_time_table_week` (
  `ttw_code` INT NOT NULL AUTO_INCREMENT,
  `ttw_day` VARCHAR(45) NOT NULL COMMENT 'Stores the day of the week  e.g. Monday',
  `ttd_start_time` DATETIME NOT NULL COMMENT 'Start time for daiy activities',
  PRIMARY KEY (`ttw_code`))
COMMENT = 'Stores the time table day periods';

CREATE TABLE `sereneschool`.`sch_time_table_periods` (
  `ttp_code` INT NOT NULL AUTO_INCREMENT,
  `ttp_sc_code` INT NOT NULL COMMENT 'Class',
  `ttp_day` VARCHAR(45) NOT NULL COMMENT 'Day of week',
  `ttp_prd_start_time` DATETIME NOT NULL COMMENT 'Period start time',
  `ttp_prd_duration` INT NOT NULL COMMENT 'Duration of the period in minutes',
  `ttp_ss_code` INT NOT NULL COMMENT 'Subject',
  `ttp_st_code` INT NOT NULL COMMENT 'School Term',
  `ttp_tt_code` INT NOT NULL COMMENT 'Time Table name',
  PRIMARY KEY (`ttp_code`),
  INDEX `ttp_sc_code_fk_idx` (`ttp_sc_code` ASC),
  INDEX `ttp_ss_code_idx` (`ttp_ss_code` ASC),
  INDEX `ttp_st_code_fk_idx` (`ttp_st_code` ASC),
  INDEX `ttp_tt_code_fk_idx` (`ttp_tt_code` ASC),
  CONSTRAINT `ttp_sc_code_fk`
    FOREIGN KEY (`ttp_sc_code`)
    REFERENCES `sereneschool`.`sch_classes` (`sc_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ttp_ss_code_fk`
    FOREIGN KEY (`ttp_ss_code`)
    REFERENCES `sereneschool`.`sch_subjects` (`ss_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ttp_st_code_fk`
    FOREIGN KEY (`ttp_st_code`)
    REFERENCES `sereneschool`.`sch_school_terms` (`st_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ttp_tt_code_fk`
    FOREIGN KEY (`ttp_tt_code`)
    REFERENCES `sereneschool`.`sch_time_table` (`tt_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores the time table periods';

CREATE TABLE `sereneschool`.`sch_events` (
  `se_code` INT NOT NULL AUTO_INCREMENT,
  `se_sht_desc` VARCHAR(45) NOT NULL COMMENT 'Short code',
  `se_desc` VARCHAR(300) NOT NULL COMMENT 'Full Description of events',
  `se_start_date` DATETIME NOT NULL COMMENT 'Event Start Date',
  `se_start_time` DATETIME NOT NULL COMMENT 'Event start time',
  `se_end_date` DATETIME NOT NULL COMMENT 'Event end date',
  `se_end_time` DATETIME NOT NULL COMMENT 'Event end time',
  `se_notes` VARCHAR(300) NULL COMMENT 'Notes',
  `se_headed_by` VARCHAR(100) NULL COMMENT 'Name of Person Heading the event',
  PRIMARY KEY (`se_code`))
COMMENT = 'Stores the events to be undertaken at a particular time';
ALTER TABLE `sereneschool`.`sch_events` 
ADD COLUMN `se_location` VARCHAR(100) NULL COMMENT 'Location of event' AFTER `se_headed_by`;


CREATE TABLE `sereneschool`.`sch_event_activities` (
  `sea_code` INT NOT NULL AUTO_INCREMENT,
  `sea_se_code` INT NOT NULL COMMENT 'Event',
  `sea_sht_desc` VARCHAR(45) NULL COMMENT 'Short Code',
  `sea_desc` VARCHAR(300) NOT NULL COMMENT 'Full Description of activity',
  `sea_start_time` DATETIME NOT NULL COMMENT 'Activity start time',
  `sea_end_time` DATETIME NOT NULL COMMENT 'Activity end time',
  `sea_notes` VARCHAR(300) NULL COMMENT 'Notes',
  `sea_headed_by` VARCHAR(100) NULL COMMENT 'Name of Person Heading the activity',
  PRIMARY KEY (`sea_code`),
  INDEX `sea_se_code_fk_idx` (`sea_se_code` ASC),
  CONSTRAINT `sea_se_code_fk`
    FOREIGN KEY (`sea_se_code`)
    REFERENCES `sereneschool`.`sch_events` (`se_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores the activities of an events';

CREATE TABLE `sereneschool`.`sch_time_table_schedule` (
  `tts_code` INT NOT NULL AUTO_INCREMENT,
  `tts_ttt_code` INT NOT NULL COMMENT 'Time table period',
  `tts_date` DATETIME NOT NULL COMMENT 'Schedule day date',
  `tts_se_code` INT NULL,
  `tts_notes` VARCHAR(300) NULL COMMENT 'Diary Notes',
  PRIMARY KEY (`tts_code`),
  INDEX `tts_ttt_code_fk_idx` (`tts_ttt_code` ASC),
  INDEX `tts_se_code_fk_idx` (`tts_se_code` ASC),
  CONSTRAINT `tts_ttt_code_fk`
    FOREIGN KEY (`tts_ttt_code`)
    REFERENCES `sereneschool`.`sch_time_table_periods` (`ttp_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `tts_se_code_fk`
    FOREIGN KEY (`tts_se_code`)
    REFERENCES `sereneschool`.`sch_events` (`se_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores the time table Schedule at the lowest level detail';
ALTER TABLE `sereneschool`.`sch_time_table_schedule` 
ADD COLUMN `tts_location` VARCHAR(100) NULL COMMENT 'Location of event' AFTER `tts_notes`;


CREATE TABLE `sereneschool`.`sch_personal_tt_notes` (
  `ptn_code` INT NOT NULL AUTO_INCREMENT,
  `ptn_usr_code` INT NOT NULL COMMENT 'User',
  `ptn_tts_code` INT NOT NULL COMMENT 'Time Table Schedule',
  PRIMARY KEY (`ptn_code`),
  INDEX `ptn_tts_code_fk_idx` (`ptn_tts_code` ASC),
  INDEX `ptn_usr_code_fk_idx` (`ptn_usr_code` ASC),
  CONSTRAINT `ptn_tts_code_fk`
    FOREIGN KEY (`ptn_tts_code`)
    REFERENCES `sereneschool`.`sch_time_table_schedule` (`tts_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `ptn_usr_code_fk`
    FOREIGN KEY (`ptn_usr_code`)
    REFERENCES `serenecrmsdb`.`cr_users` (`usr_code`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
COMMENT = 'Stores personal notes that you put on the time table';















