# PL-MySQL EXERCISES

Perform the following activities on projects database (See repository for DB script).

<img src="https://i.gyazo.com/1fdfedf2823f775939b53788935a0b42.png">

## 1
Implement a function that receives a salary and a department code as a
parameter, and will return the category that corresponds to the employee, taking into
account that:
- employees of departments 1 and 2 are always category A
- the others will be category B, if the salary is greater than or equal to 1400,
otherwise, they will be category C.
Create an employee view with the employee ID and name, city, and category (A, B, or C)
as previously indicated. You should use the function you have implemented before.
Is this view always updatable? Explain it and give examples.

## 2
Projects are in a phase of their life cycle. You can always go back to any
previous phase, but to advance you must go progressively from Requirements to
Analysis, Design, Development, ... successively from phase to phase without skipping
any. Implement a procedure that allows us to control this (advance one phase or go
back to any previous phase) and try it.

## 3
Write a procedure that receives the name of a project as a parameter and
displays a numbered list of the employees working on it. Example: CALL
emple_pro('HUMOR AMARILLO')

## 4
Modify the "projectes" table to add a field: nEmployees int default 0, which
should reflect the number of employees working on the project (you can update it to
reflect the current situation although it is not required).
Create a procedure that automatically updates this value correctly. Implement it and
try it.

## 5
Create a function called infodep that with a department’s identifier returns,
the number of employees who live in a city other than the department, and the number
of projects of the department in the last phase.