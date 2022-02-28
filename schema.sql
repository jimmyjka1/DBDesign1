CREATE DATABASE IF NOT EXISTS `DB_DESIGN_1`;
USE `DB_DESIGN_1`;



DROP TABLE IF EXISTS `Access_level`;
CREATE TABLE `Access_level`(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128)
);


DROP TABLE IF EXISTS `Designation`;
CREATE TABLE `Designation` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128)
);

DROP TABLE IF EXISTS `Shift`;
CREATE TABLE `Shift` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    time_start TIME NOT NULL,
    time_end TIME NOT NULL,
    description VARCHAR(256)
);


DROP TABLE IF EXISTS `Department`;
CREATE TABLE `Department` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL
);


DROP TABLE IF EXISTS `EmployeeStatus`;
CREATE TABLE `EmployeeStatus` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(128) NOT NULL
);





DROP TABLE IF EXISTS `User`;
CREATE TABLE `User` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    designition_id INT NOT NULL,
    user_code VARCHAR(10) NOT NULL,
    company_email VARCHAR(256) NOT NULL,
    personal_email VARCHAR(256),
    phone_numer INT,
    date_of_birth DATE NOT NULL,
    shift_id INT NOT NULL,
    department_id INT NOT NULL,
    bank_name INT,
    bank_account_number INT,
    pan_number VARCHAR(128),
    employee_status_id INT NOT NULL,
    reporting_person_user_id INT,
    joining_date DATE,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,

    CONSTRAINT `fk_user_designition` FOREIGN KEY (`designition_id`) REFERENCES `Designation`(`id`),
    CONSTRAINT `key_user_company_email` UNIQUE KEY (`company_email`) USING BTREE,
    CONSTRAINT `fk_user_shift` FOREIGN KEY (`shift_id`) REFERENCES `Shift`(`id`),
    CONSTRAINT `fk_user_department` FOREIGN KEY (`department_id`) REFERENCES `Department`(`id`),
    CONSTRAINT `fk_user_employee_status` FOREIGN KEY (`employee_status_id`) REFERENCES `EmployeeStatus`(`id`),
    CONSTRAINT `fk_user_reporting_person_user` FOREIGN KEY (`reporting_person_user_id`) REFERENCES `User`(`id`)

);



-----------
Status 
id
name

-----------
Attandance 
- id 
- date 
- first_in time,
- last_out time,
- logged_hours interval ,
- status_id int 



