-- Retrive record from table and store it in variable.
DECLARE 
  student_name students.name%TYPE; 
  age students.age%TYPE; 
BEGIN 
  SELECT 
    name, age 
  INTO 
    student_name, age 
  FROM 
    students 
    where id=100; 
 
  DBMS_OUTPUT.PUT_LINE('Student name' || ':' || student_name ); 
  DBMS_OUTPUT.PUT_LINE('Student age' || ':' || age ); 
END;

-- Store table record into variable
DECLARE 
  student_rec students.%ROWTYPE;
BEGIN 
  SELECT 
    *
  INTO 
    student_rec 
  FROM 
    students 
    where id=100; 
 
	DBMS_OUTPUT.PUT_LINE('Student ID' || ':' || student_rec.id ); 
	DBMS_OUTPUT.PUT_LINE('Student name' || ':' || student_rec.name ); 
	DBMS_OUTPUT.PUT_LINE('Student age' || ':' || student_rec.age ); 
END;

-- IF ELSE STATEMENT.
DECLARE 
  student_age students.age%TYPE;
BEGIN 
  SELECT 
    age
  INTO student_age 
  FROM 
    students 
    where id=100; 
 
	IF student_age>18
	THEN
	    DBMS_OUTPUT.put_line('AGE ABOVE 18');
	ELSE
	    DBMS_OUTPUT.put_line('AGE BELLOW 18');
	END IF;
END;

-- CASE STATEMENT.
DECLARE 
  student_age students.age%TYPE;
BEGIN 
  SELECT 
    age
  INTO student_age 
  FROM 
    students 
    where id=100; 
 
	CASE
		WHEN student_age>18 THEN DBMS_OUTPUT.put_line('APPLICABLE FOR VOTE');
		WHEN student_age<18 THEN DBMS_OUTPUT.put_line('NOT APPLICABLE FOR VOTE');
		WHEN student_age>21 THEN DBMS_OUTPUT.put_line('YOU SHOULD SEARCH JOB');
		ELSE DBMS_OUTPUT.put_line('CAN NOT FIND YOUR AGE');
	END CASE;
END;

-- FOR LOOP.
DECLARE 
  student_age students.age%TYPE;
BEGIN 
  FOR student_rec IN (SELECT * FROM STUDENTS)
	LOOP
	DBMS_OUTPUT.put_line('Student Name :'|| student_rec.name);
	END LOOP;
END;

-- CURSOR
DECLARE 
	student_name students.name%TYPE;
	student_age students.age%TYPE;
	CURSOR getstudents IS SELECT NAME,AGE FROM STUDENTS;
BEGIN 
	OPEN getstudents;
	LOOP
		FETCH getstudents INTO student_name,student_age;
		EXIT WHEN getstudents%NOTFOUND;
		DBMS_OUTPUT.put_line('Student Name :'||student_name||'- age'|| student_age);
	END LOOP;
	CLOSE getstudents;
END;

-- Procedure
CREATE OR REPLACE PROCEDURE print_student(
    student_id NUMBER 
)
IS
BEGIN
	FOR student_rec IN (SELECT * FROM STUDENTS where id = student_id)
	LOOP
	DBMS_OUTPUT.put_line('Student Name :'|| student_rec.name);
	DBMS_OUTPUT.put_line('Student AGE :'|| student_rec.age);
	END LOOP;

	EXCEPTION
	   WHEN OTHERS THEN
		  dbms_output.put_line( SQLERRM );
END;
EXECUTE print_student( arguments);

-- Functions
CREATE OR REPLACE FUNCTION get_students_count(v_dept_id int) 
RETURN NUMBER
IS
    total_count NUMBER := 0;
BEGIN
    -- get total students
    SELECT COUNT(name)
    INTO total_count
    FROM students
    WHERE DEPT_ID = v_dept_id ;
    
    -- return the total students in particular department.
    RETURN total_count;
END;
-- Calling the function.
DECLARE
    total_students NUMBER := 0;
	dept_id NUMBER := 1;
BEGIN
    total_students := get_students_count (dept_id);
    DBMS_OUTPUT.PUT_LINE('Total Students in Department: '||dept_id||' Is ' || total_students);
END;


-- Package Specification
CREATE OR REPLACE PACKAGE student_mgmt
AS
	CURSOR get_department(v_dept_id int)
	IS
		SELECT * FROM DEPARTMENT WHERE ID = v_dept_id;
	FUNCTION get_students_count(v_dept_id int) 
	RETURN NUMBER;
END student_mgmt;
-- Packages
CREATE OR REPLACE PACKAGE student_mgmt
AS
	CURSOR get_department(v_dept_id int)
	IS
		SELECT * FROM DEPARTMENT WHERE ID = v_dept_id;
	FUNCTION get_students_count(v_dept_id int) 
	RETURN NUMBER
	IS
		total_count NUMBER := 0;
		BEGIN
			-- get total students
			SELECT COUNT(name)
			INTO total_count
			FROM students
			WHERE DEPT_ID = v_dept_id ;
			
			-- return the total students in particular department.
			RETURN total_count;
		END;
END student_mgmt;

-- Triggers
CREATE OR REPLACE TRIGGER student_trig
    AFTER 
    UPDATE OR DELETE 
    ON students
    FOR EACH ROW    
BEGIN
   DBMS_OUTPUT.PUT_LINE('Student Table Updated or Deleted.');
END;

