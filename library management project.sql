create database library;
use library;
create table branch(branch_no int primary key,
manager_id int,
branch_address varchar(25),
contact_no varchar(15)
);
-- insert 10 values into the employee table
insert into branch (branch_no,manager_id,branch_address,contact_no)
values
(1,101,'kannur','9978656566'),
(2,102,'payyannur','9089980977'),
(3,103,'kasargod','7689890099'),
(4,104,'kochi','9898890900'),
(5,105,'kannur','9988770000'),
(6,106,'trikaripur','8089887733'),
(7,107,'kannur','8190823454'),
(8,108,'kollam','89007556677'),
(9,109,'taliparamb','8989003344'),
(10,110,'kochi','9087665544');
select * from branch;

create table employee(
emp_id int primary key,
emp_name varchar(50),
position varchar(50),
salary decimal(10,2),
branch_no int, foreign key (branch_no) references branch(branch_no)
);
insert into employee (emp_id,emp_name,position,salary,branch_no)
values
(11,'haritha','HR',85000,1),
(12,'rifa','IT',70000,2),
(13,'babu','officestaff',20000,3),
(14,'rahul','HR',70000,4),
(15,'john','sales',35000,5),
(16,'helen','HR',70000,6),
(17,'mary','IT',75000,7),
(18,'manu','sales',50000,8),
(19,'zara','IT',70000,9),
(20,'alex','sales',45000,10);
select * from employee;



create table books(isbn int primary key,
book_title varchar(35),
category varchar(25),
rental_priice decimal(10,2),
status varchar(10) check (status in ('yes','no')),
author varchar(50),
publisher varchar(50)
);
insert into books(isbn,book_title,category,rental_priice,status,author,publisher)
values
(21,'goat brothers','history',150,'yes','calton','doubleday'),
(22,'the missing person','fiction',50,'no','doris','putnam pub'),
(23,'christmas cookies','cooking',150,'yes','katherine','oxmoorhouse'),
(24,'shadow songs','fiction',100,'no','kay','atria books'),
(25,'titanic','film',90,'yes','kirkland','harper paperbacks'),
(26,'majendies cat','fiction',150,'yes','fowlkes','harcourt'),
(27,'joshua','history',50,'yes','girzone','macmillan'),
(28,'changall','art',100,'no','compton','harry'),
(29,'spicy','history',150,'yes','hayes','harpercollins'),
(30,'harry potter','fantasy',180,'yes','j k rowling','bloomsberry');
select * from books;


create table customer (customer_id int primary key,
customer_name varchar(50),
customer_address varchar(50),
reg_date date
);
insert into customer (customer_id,customer_name,customer_address,reg_date)
values
(101,'alia','rajasthan','2020-01-14'),
(102,'arjun','kannur','2021-09-10'),
(103,'mery','nepal','2018-05-20'),
(104,'alex','jaipur','2019-01-12'),
(105,'alena','kochi','2022-09-20'),
(106,'john','goa','2018-02-10'),
(107,'zikra','banglore','2020-01-20'),
(108,'zara','kochi','2021-03-01'),
(109,'ameer','kannur','2018-01-22'),
(110,'hana','rajasthan','2020-08-01');
select * from customer;


create table issuestatus (issue_id int primary key,
issued_cust int,
issued_book_name varchar(150),
issue_date date,
isbn_book int,
foreign key (issued_cust) references customer(customer_id),
foreign key (isbn_book) references books(isbn)
);
insert into issuestatus (issue_id,issued_cust,issued_book_name,issue_date,isbn_book)
values
(100,101,'barbie','2020-02-21',21),
(101,102,'love','2021-04-11',22),
(102,103,'the force','2022-01-01',23),
(103,104,'aadujeevitham','2018-02-21',24),
(104,105,'harrypotter','2021-06-05',25),
(105,106,'next','2018-06-21',26),
(106,107,'mystory','2021-09-21',27),
(107,108,'history','2020-11-01',28),
(108,109,'balyakalasakhi','2021-04-10',29),
(109,110,'stone','2022-03-17',30);
select * from issuestatus;

create table returnstatus (return_id int primary key,
return_cust varchar(50),
return_book_name varchar(100),
return_date date,
isbn_book2 int,
foreign key (isbn_book2) references books(isbn)
);

insert into returnstatus (return_id,return_cust,return_book_name,return_date,isbn_book2)
values
(11,'laila','foryou','2019-08-10',21),
(12,'mathew','harrypotter','2021-01-14',22),
(13,'surya','adujeevitham','2019-05-30',23),
(14,'arun','love','2022-02-22',24),
(15,'aleha','force','2019-04-12',25),
(16,'john','next','2019-10-18',26),
(17,'fathima','stone','2019-08-10',27),
(18,'joji','prideandprejudice','2019-02-11',28),
(19,'smith','thegreat','2018-06-13',29),
(20,'stephen','ride','2021-05-10',30);
select * from returnstatus;

--  Retrieve the book title, category, and rental price of all available books.
select book_title,category,rental_priice from books;

--  List the employee names and their respective salaries in descending order of salary.
select emp_name,salary from employee order by salary desc;

--  Retrieve the book titles and the corresponding customers who have issued those books. 
select books.book_title,issuestatus.issued_cust,customer.customer_name
from issuestatus
inner join books on	issuestatus.isbn_book = books.isbn
inner join customer on issuestatus.issued_cust = customer.customer_id;

--  Display the total count of books in each category.
select category,count(*) as total_books from books group by category;

--  Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
select emp_name,position,salary from employee where salary>50000;

--  List the customer names who registered before 2022-01-01 and have not issued any books yet. 
select customer.customer_name,customer.reg_date
from customer
left join issuestatus on customer.customer_id = issuestatus.issued_cust
where customer.reg_date < '2020-02-21';
and issuestatus.issue_id is null;

 -- Display the branch numbers and the total count of employees in each branch. 
select branch_no,count(*) as total_empployees
from employee
group by branch_no;

--  Display the names of customers who have issued books in the month of June 2021.
select distinct customer.customer_name,issuestatus.issue_date
from customer
inner join issuestatus on customer.customer_id = issuestatus.issued_cust
where year(issuestatus.issue_date)=2021
and month(issuestatus.issue_date)=06;

-- Retrieve book_title from book table containing history
select book_title,category from books where category = 'history';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select branch_no,count(*) as total_employees from employee group by branch_no having count(*)>5;

--  Retrieve the names of employees who manage branches and their respective branch addresses.
select employee.emp_name,branch.branch_address
from employee
inner join branch on employee.emp_id = branch.manager_id;

--  Display the names of customers who have issued books with a rental price higher than Rs. 25.
select distinct customer.customer_name issuestatus,books.rental_priice issued_book_name
from customer
inner join issuestatus on customer.customer_id = issuestatus.issued_cust
inner join books on issuestatus.isbn_book = books.isbn
where books.rental_priice> 25;

