create table "departments" (
	"dept_no" varchar not null,
	"dept_name" varchar not null,
	constraint "pk_departments" primary key ("dept_no")
);

create table "titles" (
	"title_id" varchar not null,
	"titles" varchar not null);
	
create table "employees" (
	"emp_no" int not null,
	"title_id" varchar not null,
	"birth_date" date not null,
	"first_name" varchar not null,
	"last_name" varchar not null,
	"gender" char(1) not null,
	"hire_date"  date not null,
	constraint "pk_employees" primary key ("emp_no")
	);
	
create table "salaries" (
	"emp_no" int not null,
	"salary" int not null);

create table "dept_manager" (
	"dept_no" varchar not null,
	"emp_no" int not null);
	
create table "dept_emp" (
	"emp_no" int not null,
	"dept_no" varchar not null);
	
alter table "dept_emp" add constraint "fk_dept_emp_&emp_no" foreign key ("emp_no") 
references "employees" ("emp_no");

alter table "dept_emp" add constraint "fk_dept_emp_&dept_no" foreign key ("dept_no") 
references "departments" ("dept_no");

alter table "dept_manager" add constraint "fk_dept_manager_&dept_no" foreign key ("dept_no") 
references "departments" ("dept_no");

alter table "dept_manager" add constraint "fk_dept_manager_&emp_no" foreign key ("emp_no") 
references "employees" ("emp_no");

alter table "salaries" add constraint "fk_salaries_&emp_no" foreign key ("emp_no") 
references "employees" ("emp_no");

--q1. emp no, last and first name, gender , and salary
select employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
from employees join salaries on employees.emp_no = salaries.emp_no;

--q2. hired in 1986
select last_name, first_name, hire_date from employees
where hire_date between '1986-01-01' and '1986-12-31'

--q3. List the manager of each department along with their department number, 
--department name, employee number, last name, and first name
select departments.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name
from departments join dept_manager on departments.dept_no=dept_manager.dept_no
join employees on dept_manager.emp_no = employees.emp_no;

--q4. List the department number for each employee along with that employee’s employee number,
--last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp join departments on dept_emp.dept_no=departments.dept_no
join employees on dept_emp.emp_no=employees.emp_no;

--q5.List first name, last name, and sex of each employee whose first name is Hercules
--and whose last name begins with the letter B.
select first_name, last_name from employees where first_name='Hercules' and last_name like 'B%';

--q6.List each employee in the Sales department, including their employee number, 
--last name, and first name.
select dept_emp.emp_no, employees.last_name, employees.first_name
from dept_emp join employees on dept_emp.emp_no = employees.emp_no join departments
on dept_emp.dept_no =departments.dept_no where departments.dept_name='Sales';

--q7.List each employee in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
select dept_emp.emp_no, employees.last_name, employees.first_name, departments.dept_name
from dept_emp join employees on dept_emp.emp_no= employees.emp_no 
join departments on dept_emp.dept_no=departments.dept_no where departments.dept_name='Sales'
or departments.dept_name='Development';

--q8.List the frequency counts, in descending order, of all the employee last names
--(that is, how many employees share each last name).
select last_name, count(last_name) as "frequency" from employees 
group by last_name order by count(last_name) desc;