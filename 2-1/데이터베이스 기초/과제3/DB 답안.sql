/*----------------------- A. 학사 DB에 관한 SQL문제이다. 다음 문제에 답하시오. | 시작 | -----------------------*/
use `학사db`;

# (1) 이장택 교수가 강의한 과목을 수강한 학생들의 이름과 수강 과목명 그리고 소속 전공 명을 구하라. 전공이 미정인 학생들로 포함하시오.
select	c.instructorName,
		s.name as studentName,
		c.name as courseName,
        s.departName
from	(select s2.*, d.name as departName 	from student s2 left outer join department d on s2.major = d.id) s,
        (select c2.*, i.name as instructorName 	from course c2, instructor i where c2.instructor = i.pid) c,
		course_taken ct
where	ct.sid = s.id
and		ct.cid = c.id
and		c.instructorName = "이장택";

# (2) 통계 학과에서 개설된 과목(즉, 통계학 과목)을 한 과목도 수강하지 않은 학생의 이름을 구하라.
select	s.name
from 	student s
where	s.id not in(
	select distinct sid
    from course_taken
    where cid like '%ss%'
);

# (3) 1997년과 1998년에 한 번도 수강되지 않은 과목번호와 과목명을 구하라. 
select	c.id,c.name
from	course c
where	id not in(
	select cid
    from course_taken
    where year_taken = '1997'
    or year_taken = '1998'
);

# (4) 기초전산과 데이타베이스를 둘 다 수강한 학생들의 이름을 구하라.
select s.name
from	course_taken ct join
		student s
on		s.id = ct.sid
where	cid = (select id from course where name='기초전산')
or		cid = (select id from course where name='데이타베이스')
group by ct.sid
having count(*) > 1;
/*----------------------- A. 학사 DB에 관한 SQL문제이다. 다음 문제에 답하시오. | 종료 | -----------------------*/




/*----------------------- B. pubs 데이터베이스에 대한 질의문들이다. 이를 각각 SQL로 표현하시오. | 시작 | -----------------------*/
use pubs;

# (1) 현재 직원(employee)는 출판사에 관계없이 하나의 테이블에 저장되어 있다. 각 출판사 명 별 직원 수를 구하시오. 단 출판사 이름은 유일하지 않다고 가정합니다.
select	p.pub_name, count(e.emp_id) as employeeCount
from	publishers p join
		employee e
on p.pub_id = e.pub_id
group by e.pub_id;

# (2) pubs 데이터베이스에서 날짜는 datetime으로 표현되며 datetime 타입의 데이터는 다양한 함수들을 통해 연, 월, 일, 시간 등의 정보를 각각 추출할 수 있다.
#1990년과 1991년에 고용된 직원들에 대해 직원 명을 성과 이름과 맡은 직책을 반환하시오. 단 직원 명은 fname과 lname 순으로 하나의 문자열(string)로 반환하시오.
select	concat(e.fname," ",e.lname) as fullName,
		j.job_desc as jobDescription,
        e.hire_date
from	employee e join
		jobs j
on 		e.job_id = j.job_id
where	hire_date between '1990-01-01' and '1991-12-31';

/*
	(3) 책에 대해 pubs의 서점들에 의해 1993년도에 주문된 총 판매된 수량, 총 주문 금액을 구하려 한다. 이때 책 이름 별 판매수량 및 주문금액은 sales 테이블의 데이터로부터 계산합니다.
	==> 재 해석 : 1993년에 publishers에서 출판한 책이 판매된 수량, 총 주문 금액을 구하여라.
*/
# (i) 주문된 적이 있는 경우에 한해 위의 질의 내용을 구하라.
select	t.pub_id,
		count(*) as sumCount,
		sum(s.qty) * t.price as sumPrice
from	titles t join sales s
on		t.title_id = s.title_id
where	s.ord_date between '1993-01-01' and '1993-12-31'
group by pub_id;

#  (ii) 주문된 적이 없는 경우도 포함하도록 질의 내용을 구하라.
#	==> 문제가 에초에 성립하지 않음. 총 판매 수량과 총 주문 금액을 구하는 것이기 때문에 주문되지 않은 것들은 포함해봤자 집계 자체가 되지 않는다.
select * from sales;
select	t.pub_id,
		count(*) as sumCount,
		sum(s.qty) * t.price as sumPrice
from	titles t left outer join sales s
on		t.title_id = s.title_id
where	s.ord_date between '1993-01-01' and '1993-12-31'
group by pub_id;

# (4) 단독 저자에 의해 저술된 책 이름을 구하시오.
select	t.title
from	titleauthor ta join titles t
on		ta.title_id = t.title_id
group by ta.title_id
having 	count(ta.title_id)<2;

# (5) 가장 많은 책을 저술한 저자의 이름('first name last name'의 형태)을 구하시오.
select 	count(a.au_id),
		concat(a.au_fname," ",a.au_lname) as authorName
from 	titleauthor ta join
		authors a
on		ta.au_id = a.au_id
group by ta.au_id
having	count(a.au_id) >= (select count(au_id) from titleauthor group by au_id order by cnt desc limit 1);

/*----------------------- B. pubs 데이터베이스에 대한 질의문들이다. 이를 각각 SQL로 표현하시오. | 종료 | -----------------------*/



/*----------------------- C. 다음은 classicmodels 데이터베이스에 대한 질의문들이다. 이를 각각 SQL로 표현하시오. | 시작 | -----------------------*/
use `classicmodels`;

# (1) 취소된 주문의 주문번호, 고객 명, 담당 직원 명(last name), 주문 날짜, 그리고 그 이유(comments)를 구하시오.
select	o.orderNumber,
		c.customerName,
        c.contactLastName as contactName,
        o.orderDate,
        o.comments
from	orders o,
		customers c
where	o.status = "Cancelled"
and		o.customerNumber = c.customerNumber;

# (2) 2004년도 매출 실적을 월별로 계산하려고 한다. 이를 구하는 SQL문을 쓰시오. 매출을 계산할 때 날짜는 주문 날짜를 기준으로 계산한다.
select	month(o.orderDate) as orderMonth,
		count(o.orderNumber) as totalCount,
		round(sum(totalPrice),3) as sumPrice,
		round(avg(totalPrice),3) as avgPrice,
		round(min(totalPrice),3) as minPrice,
		round(max(totalPrice),3) as maxPrice
from	orders o,
		(select orderNumber, quantityOrdered*priceEach as totalPrice from orderDetails) od
where	o.orderNumber = od.orderNumber
and		o.status = "Shipped"
and		o.orderDate between '2004-01-01' and '2004-12-31'
group by orderMonth;

# (3) 고객 회사들에 대해 매출 성향을 분석하려고 한다. 각 고객 회사에 대해 회사명, 주문 회수, 평균 주문 금액, 최대 주문 금액을 구하시오. 
select	c.customerName,
		count(o.customerNumber) as orderCount,
        round(avg(o.totalPrice),3) as avgOrderPrice,
        round(max(o.totalPrice),2) as maxOrderPrice
from	(select	o2.customerNumber, od.quantityOrdered*od.priceEach as totalPrice
		 from	orders o2 join orderdetails od
		 on		o2.orderNumber = od.orderNumber) o,
        customers c
where	o.customerNumber = c.customerNumber
group by o.customerNumber;

# (4) 가장 많은 주문 금액의 주문의 고객회사 명, 주문 날짜, 주문금액을 구하시오.
select	c.customerName,
		o.orderDate,
        o.totalPrice
from	(select	o2.customerNumber, od.quantityOrdered*od.priceEach as totalPrice, o2.orderDate
		 from	orders o2 join orderdetails od
		 on		o2.orderNumber = od.orderNumber) o join
        customers c
on		o.customerNumber = c.customerNumber
where	o.totalPrice >= (select max(quantityOrdered*priceEach) from orderdetails);

/*----------------------- C. 다음은 classicmodels 데이터베이스에 대한 질의문들이다. 이를 각각 SQL로 표현하시오. | 종료 | -----------------------*/