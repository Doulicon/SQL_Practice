-- SQL（来源https://www.nowcoder.com/ta/sql 1-5）

-- 1、
-- 查找最晚入职员工的所有信息，为了减轻入门难度，目前所有的数据里员工入职的日期都不是同一天(sqlite里面的注释为--,mysql为comment)
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,  -- '员工编号'
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));

-- 方法一：limit 如果限定员工入职的日期不是同一天的话
    select emp_no,birth_date,first_name,last_name,gender,hire_date
    from employees
    ORDER by hire_date desc
    limit 0,1

-- 方法二：子查询 考虑周全的情况下，假设有很多人是同一天的
    select emp_no,birth_date,first_name,last_name,gender,hire_date
    from employees
    where hire_date =
    (select MAX(hire_date) from employees)

-- 2、查找入职员工时间排名倒数第三的员工所有信息，为了减轻入门难度，目前所有的数据里员工入职的日期都不是同一天
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));

-- 方法一：limit 如果限定员工入职的日期不是同一天的话
    select emp_no,birth_date,first_name,last_name,gender,hire_date
    from employees
    ORDER by hire_date desc
    limit 2,1

-- 方法二：严谨的方法，思路，找到倒数第三天的那天，查出符合那天的人
    select emp_no,birth_date,first_name,last_name,gender,hire_date
    from employees
    where hire_date = (select distinct hire_date
                    from employees
                    order by hire_date desc
                    limit 2,1)

-- 答案
        select s.*,m.dept_no from salaries s
        left join dept_manager m
        on s.emp_no = m.emp_no
        where m.to_date = '9999-01-01'
        and s.to_date = '9999-01-01'
        order by s.emp_no asc

-- 4、查找所有已经分配部门的员工的last_name和first_name以及dept_no(请注意输出描述里各个列的前后顺序)
CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));

--答案
    select e.last_name, e.first_name,d.dept_no from employees e
    join dept_emp d
    on e.emp_no = d.emp_no

-- 5、查找所有员工的last_name和first_name以及对应部门编号dept_no，也包括暂时没有分配具体部门的员工(请注意输出描述里各个列的前后顺序)
CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));

--答案
select e.last_name, e.first_name,d.dept_no from employees e
left join dept_emp d
on e.emp_no = d.emp_no