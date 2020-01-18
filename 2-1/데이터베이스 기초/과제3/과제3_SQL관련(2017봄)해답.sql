use 학사DB;


-- (1) 이장택 교수가 강의한 과목을 수강한 학생들의 이름과 수강 과목명 그리고 소속 전공 명을 구하라.
--     전공이 미정인 학생들도 포함하시오.
select s.name as 학생이름, c.name as 과목명, d.name as 학과명
from instructor i, course c, course_taken ct, student s, department d
where i.name = '이장택' and 
      i.pid = c.instructor and c.id = ct.cid and ct.sid = s.id and s.major = d.id;
	  
select s.name as 학생이름, c.name as 과목명, d.name as 학과명
from ( ( (instructor i join course c on c.instructor = i.pid)
         join course_taken ct on c.id = ct.cid)
	   join student s on ct.sid = s.id)
     left outer join department d on s.major = d.id	  
where i.name = '이장택';	  
-- left outer join의 대상이 무엇인지 중요.


 --(2) 통계학 과목을 한 과목도 수강하지 않은 학생의 학번을 구하라.
-- 우선 통계전공의 과목(즉 통계전공의 개설과목)을 한 과목이라도 수강한 학생들의 학번을 구하면
-- 중복이 발생함을 확인
select ct.sid
from instructor i, course c, course_taken ct
where i.dept = 'ss' and c.instructor = i.pid and ct.cid = c.id;

-- 이제 하나도 듣지 않았던 학생의 학번을 구하면
select s.name
from student s
where s.id not in(
   select ct.sid
   from instructor i, course c, course_taken ct
   where i.dept = 'ss' and c.instructor = i.pid and ct.cid = c.id
);

-- (3) 1997년과 1998년에 한 번도 개설(수강)되지 않은 과목번호와 과목명을 구하라. 
-- 단계별 진행
select ct.cid
from course_taken ct
where ct.year_taken = 1997 or ct.year_taken = 1998;

(select id
from course)
except 
(select ct.cid
from course_taken ct
where ct.year = 1997 or ct.year = 1998)

select s.id, s.name
from ( (select id from course) 
       except 
       (select ct.cid
        from course_taken ct
        where ct.year_taken = 1997 or ct.year_taken = 1998)
     ) t, course s
where t.id = s.id

select 
from course c
where c.id not in (
   select ct.cid
   from course_taken ct
   where ct.year_taken = 1997 or ct.year_taken = 1998
   );


-- (4) 기초전산과 데이타베이스를 둘 다 수강한 학생들의 이름을 구하라.
select s.name
from student s
where s.id in (select sid 
               from course_taken ct, course c
               where ct.cid = c.id and c.name = '데이타베이스')
      and
      s.id in (select sid
               from course_taken ct, course c
               where ct.cid = c.id and c.name = '기초전산')
;               

------------------------------------------------------------
------------------------------------------------------------
use Pubs
;
-- (1) 현재 직원(employee)는 출판사에 관계없이 하나의 테이블에 저장되어 있다. 
--    각 출판사 명 별 직원 수를 구하시오. 단 출판사 이름은 유일하지 않다고 가정합니다.
select p.pub_name, count(*) as `Number of Employees`
from publishers p, employee e
where p.pub_id = e.pub_id
group by p.pub_id, p.pub_name
;

-- (2) pubs 데이터베이스에서 날짜는 datetime으로 표현되며 datetime 타입의 데이터는 
-- 다양한 함수들을 통해 연, 월, 일, 시간 등의 정보를 각각 추출할 수 있다. 1990년과 
-- 1991년에 고용된 직원들에 대해 직원 명을 성과 이름과 맡은 직책을 반환하시오. 
-- 단 직원 명은 fname과 lname 순으로 하나의 문자열(string)로 반환하시오.
select concat(e.fname, ' ', e.lname) as Name, j.job_desc
from employee e left outer join jobs j on e.job_id = j.job_id
where (year(e.hire_date) = 1990 or year(e.hire_date) = 1991)
;

-- (3) 책(titles) 이름에 대해 현재 pubs에서 관리되는 서점들에 의해 주문된 총 판매된 수량, 
--    총 주문 금액을 구하시오.
-- (i)
select t.title, sum(s.qty) as 주문수량, sum(t.price * s.qty) as 주문금액
from  titles t, sales s
where t.title_id = s.title_id
group by t.title_id, t.title
;
-- (ii)
select t.title, sum(s.qty) as 주문수량, sum(t.price * s.qty) as 주문금액
from  titles t left outer join sales s on t.title_id = s.title_id
group by t.title_id, t.title
;

select t.title, sum(s.qty) as 주문수량, sum(t.price * s.qty) as 주문금액
from  titles t left outer join sales s on t.title_id = s.title_id
where year(s.ord_date) = 1993
group by t.title_id, t.title
;

/* 과제에서는 1993년도에 주문된 내용으로 한정. 따라서 where 절에 
연도 비교 조건이 포함되어 left outer join의 결과에 날짜 비교가 Unknown 따라서 
위의 방식으로는 처리가 되지 않음. UNION을 사용해야 */

select t.title, sum(s.qty) as 주문수량, sum(t.price * s.qty) as 주문금액
from  titles t join sales s on t.title_id = s.title_id
where year(s.ord_date) = 1993
group by t.title_id, t.title

union

select t.title, 0 as 주문수량, 0 as 주문금액
from  titles t 
where t.title_id NOT IN 
     (select s.title_id
      from sales s
      where year(s.ord_date) = 1993
      )
;


-- (4) 단독 저자에 의해 저술된 책 이름을 구하시오.
select title
from titles
where title_id In (
	select ta.title_id
	from titleauthor ta
	group by ta.title_id
	having count(*) = 1)
;

select title 
from titles 
where title_id not in (
     select ta.title_id
     from titleauthor ta
     where ta.au_ord >= 2
     )
; #이 경우 저자가 표시되지 않은 책들도 포함됨.

-- (5) 가장 많은 책을 저술한 저자의 이름을 구하시오.
-- 단계별 설명
-- (solution a)
select count(*) as NoOfBooks
from titleauthor
group by au_id
;

select max(temp.NoOfBooks)
from (select count(*) as NoOfBooks
      from titleauthor
      group by au_id) temp
;

select concat(a.au_fname, ' ', a.au_lname) as 저자이름, count(*)
from authors a join titleauthor ta on a.au_id = ta.au_id
group by a.au_id, a.au_fname, a.au_lname
having count(*) = (
				select max(temp.NoOfBooks)
				from (select count(*) as NoOfBooks
			         from titleauthor
			         group by au_id) temp
)
;

# (solution b)

set @NofBook = (
			select  count(*) as NoOfBooks
			from titleauthor
			group by au_id
			Order by 1 desc
			limit 1);
			
select @NofBook;			

select concat(a.au_fname, ' ', a.au_lname) as 저자이름
from authors a join titleauthor ta on a.au_id = ta.au_id
group by a.au_id, a.au_fname, a.au_lname
having count(*) = @NofBook
;

----------------------------------------------------------------
----------------------------------------------------------------
use classicmodels
;

-- (1) 

select o.orderNumber, c.customerName, e.lastName EmployeeName,
       o.orderDate, o.comments
from orders o join customers c on 
     o.customerNumber = c.customerNumber
     join employees e on 
	  c.salesRepEmployeeNumber = e.employeeNumber
where status = 'Cancelled';

select o.orderNumber, c.customerName, e.lastName EmployeeName,
       o.orderDate, o.comments
from orders o join customers c on 
     o.customerNumber = c.customerNumber
     left outer join employees e on 
	  c.salesRepEmployeeNumber = e.employeeNumber
where status = 'Cancelled';
-- 담당직원이 없는 경우도 표시해야 하므로


# (2) 2004년도 매출 실적을 월별로 계산하려고 한다. 이를 구하는 SQL문을 쓰시오.
# 매출을 계산할 때 날짜는 주문 날짜를 기준으로 계산한다.

select month(O.OrderDate) as '월', sum(od.quantityOrdered * od.priceEach) as '매출액'
from orders o join orderdetails od on 
    o.orderNumber = od.orderNumber
where year(o.orderDate) = 2004 
group by month(o.orderDate)
Order by month(o.orderDate)
;

# (3) 고객 회사들에 대해 매출 성향을 분석하려고 한다. 
# 각 고객 회사에 대해 회사명, 주문 회수, 평균 주문 금액, 최대 주문 금액을 구하시오. 

select c.customerName, count(o.orderNumber) as 주문수, count(distinct o.orderNumber) as 주문수,
       round(avg(temp.OrderAmount),2) as 평균주문금액, round(max(temp.OrderAmount),2) as 최대주문금액
from (
      select od.orderNumber, sum(od.quantityOrdered * od.priceEach) as OrderAmount
      from orderdetails od
      group by od.orderNumber) temp join Orders o on temp.orderNumber = o.orderNumber
		join customers c on o.customerNumber = c.customerNumber
group by c.customerNumber, c.customerName
order by c.customerName
;
-- 고객회사 별 주문 내역을 구하기 전 주문번호 별 주문 금액이 계산되어야
-- 그 후 고객 회사 별 주문 정보를 계산해야.

-- (4) 가장 많은 주문 금액의 주문의 담당 직원 명, 주문문 금액, 주문날짜, 
--    그 주문을 했던 고객 회사명을 구하시오.
--(a)
 
set @OrderNo = (select  od.orderNumber
                from OrderDetails od
                group by od.orderNumber
                Order By sum(od.priceEach *od.quantityOrdered) desc
                limit 1);
set @OrderTotal = (select sum(od.priceEach *od.quantityOrdered)  
                   from orderDetails od
						 where od.orderNumber = @OrderNo
						 );              

# select @OrderNo, @OrderTotal;
 
select concat(E.FirstName, ' ', E.LastName) as 직원이름,
       @OrderTotal as 주문금액,
       O.OrderDate as 주문날짜,
       C.CustomerName as 고객회사
from (Orders O join Customers C on O.customerNumber = C.customerNumber)
     join Employees E on C.salesRepEmployeeNumber = E.EmployeeNumber
where O.OrderNumber = @OrderNo
;

# (b) 변수 부분을 중첩 SQL 문을 통해 구하는 방법

select concat(E.FirstName, ' ', E.LastName) as 직원이름,
       (select sum(od2.quantityOrdered * od2.priceEach) from orderDetails od2 where od2.OrderNumber = o.orderNumber) as 주문금액,
       O.OrderDate as 주문날짜,
       C.CustomerName as 고객회사
from (Orders O join Customers C on O.customerNumber = C.customerNumber)
     join Employees E on C.salesRepEmployeeNumber = E.EmployeeNumber
where o.orderNumber =  ( select od1.OrderNumber
                         from orderDetails OD1
                         group by Od1.OrderNumber 
		  			          Order by sum(od1.quantityOrdered * od1.priceEach) desc
								 limit 1) 



# (c) 가상 테이블 방법을 사용
select concat(E.FirstName, ' ', E.LastName) as 직원이름,
       temp.OrderAmount as 주문금액,
       O.OrderDate as 주문날짜,
       C.CustomerName as 고객회사
from (
      select od.orderNumber, sum(od.priceEach * od.quantityOrdered) as OrderAmount
      from OrderDetails od
      group by od.OrderNumber) temp 
		join Orders o on temp.orderNumber = o.orderNumber
		join Customers c on o.customerNumber = c.customerNumber
		join Employees e on c.salesRepEmployeeNumber = e.employeeNumber
order by temp.OrderAmount DESC
limit 1
;

-- (d) 반환 결과가 1이상인 경우도 계산 가능
select C.CustomerName as 고객회사,
       sum(od.quantityOrdered * od.priceEach) as 주문금액,
       O.OrderDate as 주문날짜
from Orders O, Customers C, orderDetails od
where O.OrderNumber = od.OrderNumber and 
      O.CustomerNumber = C.CustomerNumber
group by O.OrderNumber, O.OrderDate, C.CustomerName
having sum(od.quantityOrdered * od.priceEach) >= all ( select sum(Od.priceEach * Od.quantityOrdered)
                                                 from OrderDetails OD
                                                 group by Od.OrderNumber
                                               )
;



