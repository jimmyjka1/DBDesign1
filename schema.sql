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
    leave_status_id INT NOT NULL
);


-- ---------------
Leave 
- id 
- user_id
- leave_reason  
- start_date,
- start_slot, 
- end date, 
- end slot,
- leave_type_id ,
- leave_status,
-



