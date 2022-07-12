CREATE TABLE Department (
	ID NUMBER,
    DEPT_NAME VARCHAR(50),
    HOD_NAME VARCHAR(50)
);

CREATE TABLE Students (
	ID NUMBER,
	DEPT_ID NUMBER,
    NAME VARCHAR(50),
    AGE NUMBER
);



INSERT INTO students (id,dept_id, name,age)
VALUES (100,1,'Vaitheeswaran',21);
INSERT INTO students (id,dept_id, name,age)
VALUES (400,4,'Mani',19);
INSERT INTO students (id,dept_id, name,age)
VALUES (200,2,'Jhon',22);

INSERT INTO Department
VALUES (1,'BE Mech','Vijay');
INSERT INTO Department
VALUES (2,'Bsc CS ','Saravana');

//Inner join
SELECT Students.name, Students.age, Department.dept_name, Department.hod_name
FROM Students
INNER JOIN Department ON Students.dept_id=Department.id;

//left join
SELECT Students.name, Students.age, Department.dept_name, Department.hod_name
FROM Students
LEFT JOIN Department ON Students.dept_id=Department.id;

//right join if it not working swap the table name in left join.
SELECT Students.name, Students.age, Department.dept_name, Department.hod_name
FROM Students
RIGHT JOIN Department ON Students.dept_id=Department.id;
//OR
SELECT Students.name, Students.age, Department.dept_name, Department.hod_name
FROM Department
LEFT JOIN Students ON Students.dept_id=Department.id;

//Full outer join example
SELECT Students.name, Students.age, Department.dept_name, Department.hod_name
FROM Students
LEFT JOIN Department ON Students.dept_id=Department.id
UNION
SELECT Students.name, Students.age, Department.dept_name, Department.hod_name
FROM Department
LEFT JOIN Students ON Students.dept_id=Department.id;


//CROSS Join
SELECT Students.name, Students.age, Department.dept_name, Department.hod_name
FROM Students
CROSS JOIN Department 
