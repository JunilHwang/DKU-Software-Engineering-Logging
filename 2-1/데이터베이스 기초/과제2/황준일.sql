CREATE DATABASE `황준일`;
use `황준일`;

CREATE TABLE `황준일_department` (
  `department_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `fax` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
);

CREATE TABLE `황준일_instructor` (
  `instructor_id` int(11) NOT NULL AUTO_INCREMENT,
  `department_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`instructor_id`),
  KEY `department_id_idx` (`department_id`),
  FOREIGN KEY (`department_id`) REFERENCES `황준일_department` (`department_id`)
);

CREATE TABLE `황준일_student` (
  `student_id` int(11) NOT NULL,
  `department_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`student_id`),
  KEY `department_id_idx` (`department_id`),
  FOREIGN KEY (`department_id`) REFERENCES `황준일_department` (`department_id`)
);

CREATE TABLE `황준일_course` (
  `course_id` int(11) NOT NULL AUTO_INCREMENT,
  `instructor_id` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `credit` int(11) NOT NULL,
  `location` varchar(45) NOT NULL,
  `time` varchar(255) NOT NULL,
  PRIMARY KEY (`course_id`),
  KEY `instructor_id1_idx` (`instructor_id`),
  FOREIGN KEY (`instructor_id`) REFERENCES `황준일_instructor` (`instructor_id`)
);

CREATE TABLE `황준일_coursetaken` (
  `courseTaken_id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `grade` varchar(45) NOT NULL,
  PRIMARY KEY (`courseTaken_id`),
  KEY `course_id1_idx` (`course_id`),
  KEY `student_id1_idx` (`student_id`),
  FOREIGN KEY (`course_id`) REFERENCES `황준일_course` (`course_id`),
  FOREIGN KEY (`student_id`) REFERENCES `황준일_student` (`student_id`)
);


insert into `황준일_department` values
(1,"소프트웨어학과","자연과학관 501호","031-8005-3227,3966","031-8021-7203"),
(2,"상담학과","미디어센터 204-1호","031-8005-3358",NULL),
(3,"사학과","인문관 507호","031-8005-3030",NULL),
(4,"전자전기공학부","제2공학관 215호","031-8005-3626,3601","031-8021-7219");

insert into `황준일_instructor` values
(1,1,"이석균","031-8005-3235","sklee@dankook.ac.kr"),
(2,1,"박규식","031-8005-3230","kspark@dankook.ac.kr"),
(3,1,"우진운","031-8005-3233","jwwoo@dankook.ac.kr"),
(4,2,"김병석","031-8005-3804","bskim415@dankook.ac.kr"),
(5,3,"김문식","031-8005-3031","kmsik@dankook.ac.kr"),
(6,1,"권경희","041-550-3466","khkwon@dankook.ac.kr"),
(7,4,"이지행","031-8005-3663","jhyi@dankook.ac.kr");

insert into `황준일_student` values
(32131766,1,"황준일","010-5764-4483"),
(32131767,1,"김남현","010-5764-0001"),
(32131768,1,"오철환","010-5764-0002"),
(32131769,1,"김규범","010-5764-0003"),
(32131760,1,"김우재","010-5764-0004"),
(32131761,1,"이동곤","010-5764-0005"),
(32131762,1,"백준현","010-5764-0006"),
(32131751,2,"김상담","010-5764-0007"),
(32131752,2,"이상담","010-5764-0008"),
(32131741,3,"김사학","010-5764-0009"),
(32131742,3,"이사학","010-5764-0010");

insert into `황준일_course` values
(1,1,"데이터베이스 기초",3,"자연516","화요일 09:00 ~ 10:15 / 수요일 10:30 ~ 11:45"),
(2,2,"멀티미디어 시스템",3,"자연516","수요일 13:00 ~ 14:15 / 목요일 13:00 ~ 14:15"),
(3,6,"모바일 시스템",3,"자연517","월요일 16:00 ~ 17:15 / 화요일 09:00 ~ 10:15"),
(4,3,"객체지향프로그래밍",3,"자연516","수요일 18:00 ~ 20:30"),
(5,7,"공학수학",3,"3공106","수요일 16:30 ~ 17:45 / 목요일 14:30 ~ 15:45"),
(6,1,"데이터베이스 기초",3,"자연516","화요일 10:30 ~ 11:45 / 목요일 10:30 ~ 11:45"),
(7,3,"알고리즘",3,"자연517","월요일 14:30 ~ 15:45 / 수요일 10:30 ~ 11:45"),
(8,3,"알고리즘",3,"자연517","화요일 14:30 ~ 15:45 / 목요일 10:30 ~ 11:45"),
(9,1,"SW종합설계1",3,"자연516","월요일 13:00 ~ 15:45"),
(10,2,"SW종합설계1",3,"자연301-1","월요일 13:00 ~ 15:45");

insert into `황준일_coursetaken` (course_id,student_id,grade) values
(1,32131766,'A+'),
(2,32131766,'A'),
(3,32131766,'A+'),
(4,32131766,'B+'),
(5,32131766,'A+'),
(1,32131767,'A'),
(3,32131769,'B+'),
(3,32131761,'B'),
(9,32131762,'A+'),
(9,32131760,'A');