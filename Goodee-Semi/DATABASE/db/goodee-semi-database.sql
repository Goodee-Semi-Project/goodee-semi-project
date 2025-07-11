-- MySQL 호환 스키마 (코멘트 제거 + PK/FK 추가)
CREATE DATABASE IF NOT EXISTS goodee_semi_db;
USE goodee_semi_db;


CREATE TABLE IF NOT EXISTS `authority` (
	`auth_no` INT NOT NULL,
	`auth_name` VARCHAR(10) NOT NULL,
	PRIMARY KEY (`auth_no`)
);

CREATE TABLE IF NOT EXISTS `account` (
	`account_no` INT AUTO_INCREMENT NOT NULL,
	`auth_no` INT NOT NULL,
	`account_id` VARCHAR(16) NOT NULL,
	`account_pw` VARCHAR(255) NOT NULL,
	`account_name` VARCHAR(20) NOT NULL,
	`account_avail` CHAR(1) NOT NULL DEFAULT 'Y',
	PRIMARY KEY (`account_no`),
	UNIQUE KEY (`account_id`),
	FOREIGN KEY (`auth_no`) REFERENCES `authority`(`auth_no`)
);

CREATE TABLE IF NOT EXISTS `account_info` (
	`info_no` INT AUTO_INCREMENT NOT NULL,
	`account_no` INT NOT NULL,
	`reg_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`account_gender` CHAR(1) NOT NULL,
	`bir_date` CHAR(6) NOT NULL,
	`phone` CHAR(13) NOT NULL,
	`email` VARCHAR(255) NOT NULL,
	`post_num` CHAR(5) NOT NULL,
	`address` VARCHAR(255) NOT NULL,
	`address_detail` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`info_no`),
	UNIQUE KEY (`phone`, `email`),
	FOREIGN KEY (`account_no`) REFERENCES `account`(`account_no`)
);

CREATE TABLE IF NOT EXISTS `pet` (
	`pet_no` INT AUTO_INCREMENT NOT NULL,
	`account_no` INT NOT NULL,
	`pet_name` VARCHAR(20) NOT NULL,
	`pet_gender` CHAR(1) NOT NULL,
	`pet_age` TINYINT NOT NULL,
	`pet_breed` VARCHAR(20) NOT NULL,
	PRIMARY KEY (`pet_no`),
	FOREIGN KEY (`account_no`) REFERENCES `account`(`account_no`)
);

CREATE TABLE IF NOT EXISTS `course` (
	`course_no` INT AUTO_INCREMENT NOT NULL,
	`account_no` INT NOT NULL,
	`title` VARCHAR(255) NOT NULL,
	`sub_title` VARCHAR(20) NOT NULL,
	`object` TEXT NOT NULL,
	`total_step` TINYINT NOT NULL,
	`capacity` TINYINT NOT NULL,
	`thumb` INT,
	PRIMARY KEY (`course_no`),
	FOREIGN KEY (`account_no`) REFERENCES `account`(`account_no`)
);

CREATE TABLE IF NOT EXISTS `class` (
	`class_no` INT AUTO_INCREMENT NOT NULL,
	`course_no` INT NOT NULL,
	`pet_no` INT NOT NULL,
	`class_prog` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`class_no`),
	FOREIGN KEY (`course_no`) REFERENCES `course`(`course_no`),
	FOREIGN KEY (`pet_no`) REFERENCES `pet`(`pet_no`)
);

CREATE TABLE IF NOT EXISTS `schedule` (
	`sched_no` INT AUTO_INCREMENT NOT NULL,
	`class_no` INT NOT NULL,
	`sched_step` TINYINT NOT NULL,
	`sched_date` DATE DEFAULT NULL,
	`sched_start` DATETIME DEFAULT NULL,
	`sched_end` DATETIME DEFAULT NULL,
	`sched_attend` CHAR(1),
	PRIMARY KEY (`sched_no`),
	FOREIGN KEY (`class_no`) REFERENCES `class`(`class_no`)
);

CREATE TABLE IF NOT EXISTS `review` (
	`review_no` INT AUTO_INCREMENT NOT NULL,
	`class_no` INT NOT NULL,
	`review_title` VARCHAR(255) NOT NULL,
	`review_content` TEXT NOT NULL,
	`review_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`review_no`),
	FOREIGN KEY (`class_no`) REFERENCES `class`(`class_no`)
);

CREATE TABLE IF NOT EXISTS `picked_course` (
	`pick_no` INT AUTO_INCREMENT NOT NULL,
	`course_no` INT NOT NULL,
	`account_no` INT NOT NULL,
	PRIMARY KEY (`pick_no`),
	FOREIGN KEY (`course_no`) REFERENCES `course`(`course_no`),
	FOREIGN KEY (`account_no`) REFERENCES `account`(`account_no`)
);

CREATE TABLE IF NOT EXISTS `enroll` (
	`enroll_no` INT AUTO_INCREMENT NOT NULL,
	`course_no` INT NOT NULL,
	`pet_no` INT NOT NULL,
	`enroll_status` CHAR(1),
	PRIMARY KEY (`enroll_no`),
	FOREIGN KEY (`course_no`) REFERENCES `course`(`course_no`),
	FOREIGN KEY (`pet_no`) REFERENCES `pet`(`pet_no`)
);

CREATE TABLE IF NOT EXISTS `pre_course` (
	`pre_no` INT AUTO_INCREMENT NOT NULL,
	`course_no` INT NOT NULL,
	`pre_title` VARCHAR(255) NOT NULL,
	`video_len` TIME DEFAULT NULL,
	PRIMARY KEY (`pre_no`),
	FOREIGN KEY (`course_no`) REFERENCES `course`(`course_no`)
);

CREATE TABLE IF NOT EXISTS `pre_test` (
	`test_no` INT AUTO_INCREMENT NOT NULL,
	`pre_no` INT NOT NULL,
	`test_content` TEXT NOT NULL,
	`test_answer` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`test_no`),
	FOREIGN KEY (`pre_no`) REFERENCES `pre_course`(`pre_no`)
);

CREATE TABLE IF NOT EXISTS `pre_progress` (
	`prog_no` INT AUTO_INCREMENT NOT NULL,
	`pre_no` INT NOT NULL,
	`class_no` INT NOT NULL,
	`watch_len` TIME NOT NULL DEFAULT '00:00:00',
	`pre_prog` INT NOT NULL DEFAULT 0,
	PRIMARY KEY (`prog_no`),
	FOREIGN KEY (`pre_no`) REFERENCES `pre_course`(`pre_no`),
	FOREIGN KEY (`class_no`) REFERENCES `class`(`class_no`)
);

CREATE TABLE IF NOT EXISTS `hashtag` (
	`tag_no` INT AUTO_INCREMENT NOT NULL,
	`tag_text` VARCHAR(10) NOT NULL,
	PRIMARY KEY (`tag_no`)
);

CREATE TABLE IF NOT EXISTS `tag_course` (
	`tag_cou_no` INT AUTO_INCREMENT NOT NULL,
	`tag_no` INT NOT NULL,
	`course_no` INT NOT NULL,
	PRIMARY KEY (`tag_cou_no`),
	FOREIGN KEY (`tag_no`) REFERENCES `hashtag`(`tag_no`),
	FOREIGN KEY (`course_no`) REFERENCES `course`(`course_no`)
);

CREATE TABLE IF NOT EXISTS `notice` (
	`notice_no` INT AUTO_INCREMENT NOT NULL,
	`account_no` INT NOT NULL,
	`notice_title` VARCHAR(255) NOT NULL,
	`notice_content` TEXT NOT NULL,
	`reg_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`mod_date` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`nail_up` CHAR(1),
	PRIMARY KEY (`notice_no`),
	FOREIGN KEY (`account_no`) REFERENCES `account`(`account_no`)
);

CREATE TABLE IF NOT EXISTS `question` (
	`quest_no` INT AUTO_INCREMENT NOT NULL,
	`account_no` INT NOT NULL,
	`quest_title` VARCHAR(255) NOT NULL,
	`quest_content` TEXT NOT NULL,
	`quest_reg` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`quest_mod` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`quest_no`),
	FOREIGN KEY (`account_no`) REFERENCES `account`(`account_no`)
);

CREATE TABLE IF NOT EXISTS `answer` (
	`answer_no` INT AUTO_INCREMENT NOT NULL,
	`quest_no` INT NOT NULL,
	`account_no` INT NOT NULL,
	`answer_content` TEXT NOT NULL,
	`answer_reg` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`answer_mod` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`answer_no`),
	FOREIGN KEY (`quest_no`) REFERENCES `question`(`quest_no`),
	FOREIGN KEY (`account_no`) REFERENCES `account`(`account_no`)
);

CREATE TABLE IF NOT EXISTS `assignment` (
	`assign_no` INT AUTO_INCREMENT NOT NULL,
	`class_no` INT DEFAULT NULL,
	`sched_no` INT DEFAULT NULL,
	`assign_title` VARCHAR(255) NOT NULL DEFAULT '새 과제',
	`assign_content` TEXT DEFAULT NULL,
	`assign_receipt` CHAR(1),
	`assign_start` DATETIME DEFAULT NULL,
	`assign_end` DATETIME DEFAULT NULL,
	PRIMARY KEY (`assign_no`),
	FOREIGN KEY (`class_no`) REFERENCES `class`(`class_no`),
	FOREIGN KEY (`sched_no`) REFERENCES `schedule`(`sched_no`)
);

CREATE TABLE IF NOT EXISTS `submit` (
	`submit_no` INT AUTO_INCREMENT NOT NULL,
	`assign_no` INT NOT NULL,
	`submit_title` VARCHAR(255) NOT NULL,
	`submit_content` TEXT DEFAULT NULL,
	`submit_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`submit_no`),
	FOREIGN KEY (`assign_no`) REFERENCES `assignment`(`assign_no`)
);

CREATE TABLE IF NOT EXISTS `attach_type` (
	`type_no` INT NOT NULL,
	`type_name` VARCHAR(20) NOT NULL,
	`type_path` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`type_no`)
);

CREATE TABLE IF NOT EXISTS `attachment` (
	`attach_no` INT AUTO_INCREMENT NOT NULL,
	`type_no` INT NOT NULL,
	`pk_no` INT NOT NULL,
	`ori_name` VARCHAR(255) NOT NULL,
	`save_name` VARCHAR(40) NOT NULL,
	PRIMARY KEY (`attach_no`),
	FOREIGN KEY (`type_no`) REFERENCES `attach_type`(`type_no`)
);

CREATE TABLE IF NOT EXISTS `test_select` (
	`select_no` INT AUTO_INCREMENT NOT NULL,
	`test_no` INT NOT NULL,
	`select_content` VARCHAR(255) NOT NULL,
	PRIMARY KEY (`select_no`),
	FOREIGN KEY (`test_no`) REFERENCES `pre_test`(`test_no`)
);
