use `학사db`;
# 1. 학생 테이블에 Instructor에 대한 외래키인 advisor라는 속성을 추가하고자 한다.
# (a) 위의 내용을 추가하는 명령문들을 쓰시오.
ALTER TABLE `student`
ADD `advisor` CHAR(10) AFTER `bdate`,
ADD INDEX `fk_advisor_idx` (`advisor` ASC);
ALTER TABLE `student` ADD FOREIGN KEY (`advisor`) REFERENCES `instructor` (`pid`);
# (b) 같은 학과 교수로 advisor(지도교수)를 배정하는데 이는 임의 순서로 처리하고, 전공이 미정인 학생들의 지도교수는 null로 표현하시오. 이를 위한 명령문을 쓰고 처리 결과를 보이시오.
update `student` t1 left outer join `instructor` t2 on t1.major = t2.dept set advisor = 
(SELECT `pid` FROM `instructor` where dept = t1.major ORDER BY RAND() limit 1);

# 2. 과목번호는 종종 교육과정의 변화에 따라 수정되며, 그리고 외부 강사는 수급에 따라 수시로 변경된다. 이를 전제로 다음 문제에 답하시오.
# (a) 과목번호의 수정 시 다른 테이블에 자동 반영되도록, 그리고 강사가 삭제되었을 때 과목 테이블에서 강사번호에 대한 외래키를 NULL로 설정될 수 있도록 외래키 제약조건들을 수정하시오. 
ALTER TABLE `course` DROP FOREIGN KEY `course_ibfk_2`;
ALTER TABLE `course` ADD FOREIGN KEY (`prerequisite`)
REFERENCES `course` (`id`)
ON DELETE SET NULL
ON UPDATE CASCADE;

ALTER TABLE `course_taken` DROP FOREIGN KEY `course_taken_ibfk_2`;
ALTER TABLE `course_taken` ADD FOREIGN KEY (`cid`) REFERENCES `course` (`id`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;
select * from course;
# (b) 위의 내용이 제대로 처리되는 지를 보이는 예제를 보이시오.
start transaction;
delete from course where id='cs111';
select * from course;
rollback;
start transaction;
update course set id = 'cs112' where id='cs111';
select * from course;
rollback;

# 3. 학생들의 성적 조회 용 뷰를 생성하고 이를 통해 자신의 수강 과목들의 성적을 조회하려고 한다. 뷰의 정의는 courseRecord(student_id, student_name, course_name, course_grade, instructor_name)으로 이루어진다. 
# (a) view를 생성하는 명령문을 보이시오.
Create view courseRecord(student_id, student_name, course_name, course_grade, instructor_name) as
	SELECT	s.id as student_id,
			s.name as student_name,
            c.name as course_name,
            ct.grade as course_grade,
            i.name as instructor_name
	FROM	course_taken ct
			join student s on ct.sid = s.id
			join course c on ct.cid = c.id
            join instructor i on c.instructor = i.pid;
set @sid = (select student_id from courseRecord order by rand() limit 1);
SELECT * FROM courseRecord where student_id = @sid;
# (c) courseRecord에 insert문이 실행가능한지 여부를 적고 불가능하면 이유를 쓰고 가능하면 실행예제를 보이시오.
	# ==> 실행이 불가능 합니다. courseRecord는 단일 기본 테이블이 아닙니다.
# (d) courseRecord에 delete문이 실행가능한지 여부를 적고 불가능하면 이유를 쓰고 가능하면 실행예제를 보이시오.
	# ==> 실행이 불가능 합니다. courseRecord는 단일 기본 테이블이 아닙니다.
# (e) courseRecord의 각 속성에 대해 update문을 적용하려고 한다. 어떤 속성인 경우 가능한지를 쓰고 예를 보이고 불가능한 속성인 경우는 그 이유를 쓰시오.
	select * from courseRecord;
    update courseRecord set student_id = '941220' where student_id='930405'; # 불가  ==>  기본키 및 외래키 제약 조건
    update courseRecord set student_name = concat(student_name," 수정",""); # 가능 ==> 아무 제약 조건이 없음
    update courseRecord set course_name = concat(course_name," 수정",""); # 가능 ==> 아무 제약 조건이 없음
    update courseRecord set course_grade = course_grade+10; # 가능 ==> 아무 제약 조건이 없음
    update courseRecord set instructor_name = concat(instructor_name," 수정",""); # 가능 ==> 아무 제약 조건이 없음

# 4. 장학생(ScholarshipStudent) 테이블을 view로 정의하려고 한다. 
# (a) 이를 정의하고 실행 결과를 보이시오.
drop view ScholarshipStudent;
Create view ScholarshipStudent as
	SELECT	* from courseRecord where course_grade >= 4
    with check option;    
# (b) MySQL의 Check Option의 의미을 설명하고 이를 장학생 뷰에 적용했을 때 어떤 변화를 보이는 지를 보이시오.
	#==> MySQL의 Check Option이란 지정한 범위 내의 값만 수정/추가 할 수 있는 조건이다.
    #==> 장학생 뷰에 적용 시 기준학점(3.5) 미만의 수치로 수정/추가 불가능하다.
drop view ScholarshipStudent;
Create view ScholarshipStudent as
	SELECT	* from courseRecord where course_grade >= 4
    with check option;
select * from ScholarshipStudent;
update ScholarshipStudent set course_grade = course_grade+10 where student_name = '한나라';
select * from ScholarshipStudent;
update ScholarshipStudent set course_grade = course_grade-1 where student_name = '한나라';
select * from ScholarshipStudent;
update ScholarshipStudent set course_grade = course_grade-1 where student_name = '한나라';
select * from ScholarshipStudent;

set foreign_key_checks = 1;
start transaction;
rollback;
commit;