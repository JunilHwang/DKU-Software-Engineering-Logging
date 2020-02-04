

use test;
drop database if exists 학사DB;

CREATE DATABASE IF NOT EXISTS 학사DB;
USE 학사DB;

CREATE TABLE IF NOT EXISTS department (
	id CHAR(10) NOT NULL,
	name CHAR(10),
	constraint pk_department PRIMARY KEY (id)
);

INSERT INTO department (id, name) VALUES
	('cs', '전산전공'),
	('ss', '통계전공');

CREATE TABLE IF NOT EXISTS instructor (
	pid CHAR(10) NOT NULL,
	name CHAR(10) NOT NULL,
	dept CHAR(10),
	constraint pk_instructor PRIMARY KEY (pid),
	constraint uniq_instructor UNIQUE KEY (name),
	constraint fk_instructor_department foreign key(dept) references department(id)
);
	
INSERT INTO instructor (pid, name, dept) VALUES
	('cs10', '구자영', 'cs'),
	('cs11', '우진운', 'cs'),
	('cs12', '유해영', 'cs'),
	('cs13', '이석균', 'cs'),
	('cs14', '조경산', 'cs'),
	('cs15', '조성제', 'cs'),
	('ss16', '이강섭', 'ss'),
	('ss17', '황형태', 'ss'),
	('ss18', '이장택', 'ss');


CREATE TABLE IF NOT EXISTS course (
	id CHAR(10) NOT NULL,
	name CHAR(20),
	instructor CHAR(10),
	prerequisite CHAR(10),
	PRIMARY KEY (id),
	foreign key(instructor) references instructor(pid),
	foreign key(prerequisite) references course(id)
);

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES 	('cs111', '기초전산', 'cs13', NULL);

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('ss111', '전산통계', 'ss18', NULL);

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs211', '수치해석', 'cs12', 'cs111');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs221', '자료구조론', 'cs11', 'cs111');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs222', '시스템프로그래밍', 'cs10', 'cs111');
	
INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs311', '컴퓨터 구조론', 'cs14', 'cs111');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs312', '알고리즘', 'cs11', 'cs221');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs321', '프로그래밍언어론', 'cs13', 'cs221');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs322', '운영체제', 'cs15', 'cs222');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs411', '데이타베이스', 'cs13', 'cs321');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs413', '컴퓨터네트워크', 'cs14', 'cs311');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('ss311', '응용해석학', 'ss17', 'ss111');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('ss312', '통계적 품질관리', 'ss16', 'ss111');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('cs421', '소프트웨어 공학', 'cs12', 'cs312');

INSERT INTO course (id, name, instructor, prerequisite) 
VALUES	('ss321', '회귀분석', 'ss18', 'ss312');


CREATE TABLE IF NOT EXISTS student (
	id CHAR(10) NOT NULL,
	name CHAR(10),
	major CHAR(10) DEFAULT NULL,
	address CHAR(30) DEFAULT '단국대학교',
	gpa FLOAT,
	bdate date,
	constraint pk_student PRIMARY KEY (id),
	constraint fk_student_department foreign key(major) references department(id)
);


INSERT INTO student (id, name, major, address, gpa, bdate) VALUES
	('930405', '한나라', 'cs', '서울 마포구 원효로', 3.299999952, '1974-06-12'),
	('940123', '강동희', 'ss', '서울 중구 필동', 3.625, '1975-08-07'),
	('950564', '허영만', 'cs', '서울 강동구 풍납동', 1.75, '1976-12-21'),
	('960157', '이동주', 'cs', '서울 서초구 잠원동', 1.799999952, '1977-10-10'),
	('970734', '조용필', NULL, '서울 영등포구 영등포동', 2, '1978-07-12'),
	('980115', '이미숙', 'ss', '서울 서초구 반포동', 3.75, NULL),
	('980397', '조용기', NULL, '서울 서대문구 홍은동', 2.25, NULL);

CREATE TABLE IF NOT EXISTS course_taken (
	no INT NOT NULL auto_increment,
	sid CHAR(10),
	cid CHAR(10),
	grade FLOAT,
	year_taken INT,
	PRIMARY KEY (no),
	foreign key(sid) references student(id),
	foreign key(cid) references course(id)
);


INSERT INTO course_taken (sid, cid, grade, year_taken) VALUES
	('930405', 'cs111', 2.0, 1993),
	('930405', 'cs211', 4.0, 1996),
	('930405', 'cs221', 3.0, 1996),
	('930405', 'cs222', 3.0, 1996),
	('930405', 'cs311', 3.0, 1997),
	('930405', 'cs321', 4.0, 1997),
	('930405', 'cs411', 4.0, 1998),
	('940123', 'ss111', 2.0, 1994),
	('940123', 'cs111', 4.0, 1997),
	('940123', 'cs221', 4.0, 1997),
	('940123', 'ss311', 4.0, 1997),
	('940123', 'ss312', 4.0, 1998),
	('940123', 'ss321', 3.0, 1998),
	('950564', 'cs111', 2.0, 1995),
	('950564', 'cs211', 2.0, 1996),
	('950564', 'cs222', 1.0, 1997),
	('950564', 'cs311', 2.0, 1998),
	('950564', 'cs411', 2.0, 1999),
	('960157', 'cs111', 1.0, 1996),
	('960157', 'cs211', 2.0, 1997),
	('970734', 'cs111', 1.0, 1997),
	('970734', 'cs211', 3.0, 1998),
	('970734', 'cs222', 2.0, 1998),
	('980115', 'ss111', 4.0, 1998),
	('980115', 'cs111', 3.0, 1998),
	('980115', 'cs221', 3.0, 1998),
	('980115', 'cs222', 4.0, 1998),
	('980115', 'cs311', 4.0, 1999),
	('980397', 'cs111', 2.0, 1998),
	('980397', 'cs211', 2.0, 1999);











