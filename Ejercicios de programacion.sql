USE projectes;

/*1) (2 points) Implement a function that receives a salary and a department code as a
parameter, and will return the category that corresponds to the employee, taking into
account that:
- employees of departments 1 and 2 are always category A
- the others will be category B, if the salary is greater than or equal to 1400,
otherwise, they will be category C.
Create an employee view with the employee ID and name, city, and category (A, B, or C)
as previously indicated. You should use the function you have implemented before.
Is this view always updatable? Explain it and give examples*/

DELIMITER $$

CREATE FUNCTION departamento(salary INT, departmentCode INT)
	RETURNS CHAR(1) DETERMINISTIC
		BEGIN
			DECLARE category CHAR(1);
            IF departmentCode = 1 THEN
				SET category = "A";
			ELSEIF departmentCode = 2 THEN
				SET category = "A";
			ELSEIF departmentCode <> 1 AND salary >= 1400 THEN
				SET category = "B";
			ELSEIF departmentCode <> 2 AND salary >= 1400 THEN
				SET category = "B";
			ELSE
				SET category = "C";
			END IF;
			RETURN category;
		END $$
        
    DELIMITER ;
        
CREATE VIEW employeeView
AS 
SELECT empleats.id, empleats.nom, empleats.ciutat, departamento(empleats.salari, empleats.departament) AS category
FROM empleats;

SELECT * FROM employeeView;

/*2) (2 points) Projects are in a phase of their life cycle. You can always go back to any
previous phase, but to advance you must go progressively from Requirements to
Analysis, Design, Development, ... successively from phase to phase without skipping
any. Implement a procedure that allows us to control this (advance one phase or go
back to any previous phase) and try it.*/

DELIMITER $$

DROP PROCEDURE fases $$

CREATE PROCEDURE fases(IN projecte INT, IN faseFin TINYINT)
	BEGIN
		DECLARE faseInicial TINYINT;
        SET faseInicial = (SELECT projectes.fase FROM projectes WHERE projectes.id = projecte);
		IF faseFin < (SELECT fase FROM projectes WHERE projectes.id = projecte) THEN
			UPDATE projectes SET fase = faseFin WHERE projectes.id = projecte;
		ELSEIF faseFin = (SELECT fase FROM projectes WHERE projectes.id = projecte) + 1 THEN
			UPDATE projectes SET fase = faseFin WHERE projectes.id = projecte;
		END IF;
    END $$
            
/*3) (2 points) Write a procedure that receives the name of a project as a parameter and
displays a numbered list of the employees working on it. Example: CALL
emple_pro('HUMOR AMARILLO')*/

DROP PROCEDURE emple_pro; $$

CREATE PROCEDURE emple_pro(IN nombre TEXT)
	BEGIN
		SELECT * FROM empleats WHERE projecte IN (SELECT id FROM projectes WHERE nom = nombre);
	END $$
    
CALL emple_pro('HUMOR AMARILLO') $$

/*4) (2 points) Modify the "projectes" table to add a field: nEmployees int default 0, which
should reflect the number of employees working on the project (you can update it to
reflect the current situation although it is not required).
Create a procedure that automatically updates this value correctly. Implement it and
try it.*/

ALTER TABLE projectes
	ADD COLUMN nEmployees INT DEFAULT 0; $$
    
DROP PROCEDURE IF EXISTS modificaProjectes; $$

CREATE PROCEDURE modificaProjectes()
	BEGIN
		DECLARE contador INT;
        DECLARE limite INT;
        DECLARE nEmpleados INT;
        SET contador = 0;
        SET limite = (SELECT COUNT(id) FROM projectes);
        bucle1: LOOP
			IF contador	> limite THEN
				LEAVE bucle1;
			END IF;
			SET contador = contador + 1;
			SET nEmpleados = (SELECT COUNT(*) FROM empleats WHERE projecte = contador);
			UPDATE projectes SET nEmployees = nEmpleados WHERE id = contador;
        END LOOP;
	END $$
    
ALTER TABLE projectes
	DROP COLUMN nEmployees; $$
    
CALL modificaProjectes(); $$

/*5) (2 points) Create a function called infodep that with a department’s identifier returns,
the number of employees who live in a city other than the department, and the number
of projects of the department in the last phase.*/

DROP FUNCTION IF EXISTS infodep; $$

CREATE FUNCTION infodep(departmentIdentifier INT)
RETURNS VARCHAR(256) DETERMINISTIC
	BEGIN
		DECLARE nEmpOC INT;
        DECLARE nProjLF INT;
        SET nEmpOC = (SELECT COUNT(e.id) FROM empleats e, departaments d WHERE e.departament = d.id AND departmentIdentifier = d.id AND e.ciutat != d.ciutat);
        SET nProjLF = (SELECT COUNT(p.id) FROM projectes p, departaments d, empleats e WHERE p.id = e.projecte AND e.departament = d.id AND p.fase = 7 AND d.id = departmentIdentifier);
		RETURN (CONCAT("El numero de empleados que viven en otra ciudad es: ",nEmpOC,", Los proyectos de este departamento que estan en la ultima fase son: ", nProjLF));
	END; $$    
    
    SELECT infodep();
        