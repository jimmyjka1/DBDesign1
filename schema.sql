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
    ID INT PRIMARY KEY AUTO_INCREMENT,
    time_start TIME NOT NULL,
    time_end TIME NOT NULL,
    description VARCHAR(256)
);


DROP TABLE IS EXISTS `User`;
CREATE TABLE `User` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    designition_id INT NOT NULL,
    user_code VARCHAR(10) NOT NULL,
    company_email VARCHAR(256) NOT NULL,
    personal_email VARCHAR(256),
    date_of_birth DATE NOT NULL
);

