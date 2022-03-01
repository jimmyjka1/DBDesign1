DROP DATABASE IF EXISTS `DB_DESIGN_1`;
CREATE DATABASE IF NOT EXISTS `DB_DESIGN_1`;
USE `DB_DESIGN_1`;



-- DROP TABLE IF EXISTS `Access_level`;
-- CREATE TABLE `Access_level`(
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     name VARCHAR(128)
-- );


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
    first_name VARCHAR(128) NOT NULL,
    last_name VARCHAR(128),
    designition_id INT NOT NULL,
    user_code VARCHAR(10) NOT NULL,
    company_email VARCHAR(256) NOT NULL,
    personal_email VARCHAR(256),
    phone_numer VARCHAR(13),
    date_of_birth DATE NOT NULL,
    shift_id INT NOT NULL,
    department_id INT NOT NULL,
    bank_name VARCHAR(128),
    bank_account_number VARCHAR(32),
    pan_number VARCHAR(128),
    employee_status_id INT NOT NULL,
    reporting_person_user_id INT,
    joining_date DATE,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    password VARCHAR(256),

    CONSTRAINT `fk_user_designition` FOREIGN KEY (`designition_id`) REFERENCES `Designation`(`id`),
    CONSTRAINT `key_user_company_email` UNIQUE KEY (`company_email`) USING BTREE,
    CONSTRAINT `fk_user_shift` FOREIGN KEY (`shift_id`) REFERENCES `Shift`(`id`),
    CONSTRAINT `fk_user_department` FOREIGN KEY (`department_id`) REFERENCES `Department`(`id`),
    CONSTRAINT `fk_user_employee_status` FOREIGN KEY (`employee_status_id`) REFERENCES `EmployeeStatus`(`id`),
    CONSTRAINT `fk_user_reporting_person_user` FOREIGN KEY (`reporting_person_user_id`) REFERENCES `User`(`id`)

);




DROP TABLE IF EXISTS `AttandanceStatus`;
CREATE TABLE `AttandanceStatus` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(32) NOT NULL 
);


DROP TABLE IF EXISTS `Attandance`;
CREATE TABLE `Attandance` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    date DATE,
    first_in TIME,
    last_out TIME,
    attandance_status_id INT NOT NULL,

    CONSTRAINT `fk_attandance_user` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
    CONSTRAINT `fk_attandance_status` FOREIGN KEY (`attandance_status_id`) REFERENCES `AttandanceStatus` (`id`)
);

DROP TABLE IF EXISTS `ProjectType`;
CREATE TABLE `ProjectType` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(64)
);


DROP TABLE IF EXISTS `Project`;
CREATE TABLE `Project` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_name VARCHAR(128) NOT NULL,
    project_type_id INT NOT NULL,
    team_leader_user_id INT NOT NULL,
    total_project_hours INT,
    total_project_minutes INT,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    password VARCHAR(256),


    CONSTRAINT `fk_project_type` FOREIGN KEY (`project_type_id`) REFERENCES `ProjectType` (`id`),
    CONSTRAINT `fk_project_team_leader_user` FOREIGN KEY (`team_leader_user_id`) REFERENCES `User` (`id`)
);



DROP TABLE IF EXISTS `ProjectUser`;
CREATE TABLE `ProjectUser` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    project_id INT NOT NULL,

    CONSTRAINT `fk_project_user_user` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
    CONSTRAINT `fk_project_user_project` FOREIGN KEY (`project_id`) REFERENCES `Project` (`id`)
);



DROP TABLE IF EXISTS `Task`;
CREATE TABLE `Task` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    start_date DATE,
    end_date DATE,
    assigned_hours INT,
    assigned_minutes INT,
    created_by_user_id INT NOT NULL,
    project_id INT NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME,
    password VARCHAR(256),

    CONSTRAINT `fk_task_created_by_user` FOREIGN KEY (`created_by_user_id`) REFERENCES `User` (`id`),
    CONSTRAINT `fk_task_project_id` FOREIGN KEY (`project_id`) REFERENCES `Project` (`id`)


    
);



DROP TABLE IF EXISTS `TaskUser`;
CREATE TABLE `TaskUser` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    task_id INT NOT NULL,

    CONSTRAINT `fk_task_user_user` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
    CONSTRAINT `fk_task_user_task` FOREIGN KEY (`task_id`) REFERENCES `Task` (`id`)
);


DROP TABLE IF EXISTS `TaskEntry`;
CREATE TABLE `TaskEntry` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    task_user_id INT NOT NULL,
    date DATE,
    hours INT,
    minutes INT,
    description VARCHAR(512),

    CONSTRAINT `fk_task_entry_task_user_id` FOREIGN KEY (`task_user_id`) REFERENCES `TaskUser` (`id`)
);


DROP TABLE IF EXISTS `LeaveType`;
CREATE TABLE `LeaveType` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(32)
);

DROP TABLE IF EXISTS `LeaveStatus`;
CREATE TABLE `LeaveStatus` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(32)
);


DROP TABLE IF EXISTS `LeaveSlot`;
CREATE TABLE `LeaveSlot` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(32)
);

DROP TABLE IF EXISTS `Leave`;
CREATE TABLE `Leave` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    leave_reason VARCHAR(256),
    start_date DATE,
    start_slot_id INT NOT NULL,
    end_date DATE,
    end_slot_id INT NOT NULL,
    leave_type_id INT NOT NULL,
    leave_status_id INT NOT NULL,

    CONSTRAINT `fk_leave_user` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`),
    CONSTRAINT `fk_leave_start_slot` FOREIGN KEY (`start_slot_id`) REFERENCES `LeaveSlot` (`id`),
    CONSTRAINT `fk_leave_end_slot` FOREIGN KEY (`end_slot_id`) REFERENCES `LeaveSlot` (`id`),
    CONSTRAINT `fk_leave_type` FOREIGN KEY (`leave_type_id`) REFERENCES `LeaveType` (`id`),
    CONSTRAINT `fk_leave_status` FOREIGN KEY (`leave_status_id`) REFERENCES `LeaveStatus` (`id`)

);





-- ----------------------------------
INSERT INTO `designation` (`id`, `name`) VALUES 
(NULL, 'Trainee'), 
(NULL, 'Developer'), 
(NULL, 'Sr. Developer'), 
(NULL, 'Team Leader '), 
(NULL, 'Manager '), 
(NULL, 'HR');


INSERT INTO `shift` (`id`, `time_start`, `time_end`, `description`) VALUES 
(NULL, '09:00:00', '19:00:00', 'Morning '), 
(NULL, '18:00:00', '04:00:00', 'Night Shift');


INSERT INTO `department` (`id`, `name`) VALUES 
(NULL, 'PHP'), 
(NULL, 'Wordpress'), 
(NULL, 'Mobile'), 
(NULL, 'JS'), 
(NULL, 'QA'), 
(NULL, 'HR');


INSERT INTO `employeestatus` (`id`, `name`) VALUES 
(NULL, 'Probation'), 
(NULL, 'Full Time'), 
(NULL, 'Part Time'), 
(NULL, 'Freelancing');


INSERT INTO `user` (`id`, `first_name`, `last_name`, `designition_id`, `user_code`, `company_email`, `personal_email`, `phone_numer`, `date_of_birth`, `shift_id`, `department_id`, `bank_name`, `bank_account_number`, `pan_number`, `employee_status_id`, `reporting_person_user_id`, `joining_date`, `updated_at`, `deleted_at`, `password`) VALUES (NULL, 'MFirst Name ', 'Last Name ', '5', '1232', 'manager@gmail.com', 'manager_personal@gmail.com', '9090909090', '2000-11-03', '1', '1', 'none bank', '9090909090', '9090909090', '2', NULL, '2022-03-01', current_timestamp(), '2022-03-01 10:22:10.000000', 'manager@gmail.com');

INSERT INTO `user` (`id`, `first_name`, `last_name`, `designition_id`, `user_code`, `company_email`, `personal_email`, `phone_numer`, `date_of_birth`, `shift_id`, `department_id`, `bank_name`, `bank_account_number`, `pan_number`, `employee_status_id`, `reporting_person_user_id`, `joining_date`, `updated_at`, `deleted_at`, `password`) VALUES (NULL, 'Jimmy Kumar ', 'Ahalpara ', '1', '1232', 'jimmyatridhyatech@gmail.com', 'mypersonal@gmail.com', '9090909090', '2000-11-03', '1', '1', 'none bank', '9090909090', '9090909090', '1', '1', '2022-03-01', current_timestamp(), '2022-03-01 10:24:30.000000', NULL);



INSERT INTO `attandancestatus` (`id`, `name`) VALUES 
(NULL, 'OnTime'), 
(NULL, 'Early'), 
(NULL, 'Late'), 
(NULL, 'Absent');



INSERT INTO `attandance` (`id`, `user_id`, `date`, `first_in`, `last_out`, `attandance_status_id`) VALUES 
(NULL, '2', '2022-03-02', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-03-03', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-03-04', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-04-05', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-04-06', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-04-07', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-04-08', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-04-09', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-05-10', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-05-11', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-05-12', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-05-13', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-05-14', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-06-15', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-06-16', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-06-17', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-06-18', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-06-19', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-07-20', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-07-21', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-07-22', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-07-23', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-07-24', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-08-25', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-08-26', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-08-27', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-08-28', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-08-29', '09:58:31', '18:58:31', '1'),
(NULL, '2', '2022-03-30', '09:58:31', '18:58:31', '1')
;



INSERT INTO `attandance` (`id`, `user_id`, `date`, `first_in`, `last_out`, `attandance_status_id`) VALUES 
(NULL, '1', '2022-03-02', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-03-03', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-03-04', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-04-05', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-04-06', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-04-07', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-04-08', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-04-09', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-05-10', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-05-11', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-05-12', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-05-13', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-05-14', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-06-15', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-06-16', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-06-17', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-06-18', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-06-19', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-07-20', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-07-21', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-07-22', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-07-23', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-07-24', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-08-25', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-08-26', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-08-27', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-08-28', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-08-29', '09:58:31', '18:58:31', '1'),
(NULL, '1', '2022-03-30', '09:58:31', '18:58:31', '1')
;







SELECT 
        s1.user_id,
        s1.Name, 
        s1.Jan, 
        s2.Feb,
        s3.March,
        s4.April,
        s5.May,
        s6.June, 
        s7.July, 
        s8.August,
        s9.Sept, 
        s10.Oct, 
        s11.Nov,
        s12.December
        FROM 

(SELECT u.id as user_id ,count(a.id) as Jan, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 1 GROUP BY u.id) as s1 

JOIN 

(SELECT u.id as user_id, count(a.id) as Feb, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 2 GROUP BY u.id) as s2 

JOIN 

(SELECT u.id as user_id, count(a.id) as March, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 3 GROUP BY u.id) as s3 

JOIN 

(SELECT u.id as user_id, count(a.id) as April, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 4 GROUP BY u.id) as s4 

JOIN 

(SELECT u.id as user_id, count(a.id) as May, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 5 GROUP BY u.id) as s5 

JOIN 

(SELECT u.id as user_id, count(a.id) as June, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 6 GROUP BY u.id) as s6 

JOIN 

(SELECT u.id as user_id, count(a.id) as July, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 7 GROUP BY u.id) as s7 

JOIN 

(SELECT u.id as user_id, count(a.id) as August, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 8 GROUP BY u.id) as s8

JOIN 

(SELECT u.id as user_id, count(a.id) as Sept, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 9 GROUP BY u.id) as s9

JOIN 

(SELECT u.id as user_id, count(a.id) as Oct, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 10 GROUP BY u.id) as s10

JOIN 

(SELECT u.id as user_id, count(a.id) as Nov, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 11 GROUP BY u.id) as s11

JOIN 

(SELECT u.id as user_id, count(a.id) as December, CONCAT(u.first_name, " ", u.last_name) as Name FROM attandance as a RIGHT JOIN User as u on u.id = a.user_id AND MONTH(a.date) = 12 GROUP BY u.id) as s12


ON (
    s1.user_id = s2.user_id
    AND 
    s1.user_id = s3.user_id
    AND 
    s1.user_id = s4.user_id
    AND 
    s1.user_id = s5.user_id
    AND 
    s1.user_id = s6.user_id
    AND 
    s1.user_id = s7.user_id
    AND 
    s1.user_id = s8.user_id
    AND 
    s1.user_id = s9.user_id
    AND 
    s1.user_id = s10.user_id
    AND 
    s1.user_id = s11.user_id
    AND 
    s1.user_id = s12.user_id
);












