-- 统计出当前(titles.to_date='9999-01-01')各个title类型对应的员工当前(salaries.to_date='9999-01-01')薪水对应的平均工资。结果给出title以及平均工资avg。
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
CREATE TABLE IF NOT EXISTS "titles" (
`emp_no` int(11) NOT NULL,
`title` varchar(50) NOT NULL,
`from_date` date NOT NULL,
`to_date` date DEFAULT NULL);

-- 如插入：
INSERT INTO salaries VALUES(10001,88958,'1986-06-26','9999-01-01');
INSERT INTO salaries VALUES(10003,43311,'2001-12-01','9999-01-01');
INSERT INTO salaries VALUES(10004,70698,'1986-12-01','1995-12-01');
INSERT INTO salaries VALUES(10004,74057,'1995-12-01','9999-01-01');
INSERT INTO salaries VALUES(10006,43311,'2001-08-02','9999-01-01');
INSERT INTO salaries VALUES(10007,88070,'2002-02-07','9999-01-01');

INSERT INTO titles VALUES(10001,'Senior Engineer','1986-06-26','9999-01-01');
INSERT INTO titles VALUES(10003,'Senior Engineer','2001-12-01','9999-01-01');
INSERT INTO titles VALUES(10004,'Engineer','1986-12-01','1995-12-01');
INSERT INTO titles VALUES(10004,'Senior Engineer','1995-12-01','9999-01-01');
INSERT INTO titles VALUES(10006,'Senior Engineer','2001-08-02','9999-01-01');
INSERT INTO titles VALUES(10007,'Senior Staff','1996-02-11','9999-01-01');

--答案
select title,avg(s.salary) from salaries s
join titles t
on s.emp_no = t.emp_no
where t.to_date='9999-01-01'
and s.to_date='9999-01-01'
group by t.title

-- 获取当前（to_date='9999-01-01'）薪水第二多的员工的emp_no以及其对应的薪水salary
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));

--答案 distinct防止第一名出现多而去重，不然第二不一定是真的第二
select emp_no,salary
from salaries
where salary = (select distinct salary from salaries order by salary desc limit 1,1)

-- 查找当前薪水(to_date='9999-01-01')排名第二多的员工编号emp_no、薪水salary、last_name以及first_name，你可以不使用order by完成吗
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));

--答案 这题有点难度，多点理解
select e.emp_no,s.salary,e.last_name,e.first_name
from
employees e
join
salaries s on e.emp_no = s.emp_no
where s.to_date = '9999-01-01'
and s.salary =
(select s1.salary
 from salaries s1
 join salaries s2 on s1.salary<= s2.salary
 and s1.to_date='9999-01-01' and s2.to_date = '9999-01-01'
 group by s1.salary
 having count(distinct s2.salary)=2

)