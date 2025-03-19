CREATE DATABASE TechCorp;

USE TechCorp;

CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    edad INT NOT NULL,
    salario INT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL	
);

/*Me invento la base de datos, le pedí ayuda a GPT que me ayudará 
inventando estos datos, soy la menos inspirada para inventar*/

INSERT INTO empleados (id, nombre, edad, salario, departamento, fecha_contratacion) VALUES
('','Carlos Gómez', 35, 4500.00, 'Ventas', '2019-05-22'),
('','Ana Pérez', 28, 3800.00, 'IT', '2021-06-10'),
('','Javier Torres', 42, 5200.00, 'Ventas', '2015-09-18'),
('','Beatriz Morales', 30, 3100.00, 'Recursos Humanos', '2022-03-05'),
('','Alejandro Ramírez', 39, 4700.00, 'Ventas', '2018-11-30'),
('','Clara Sánchez', 29, 2900.00, 'IT', '2023-01-15'),
('','David Jiménez', 33, 4100.00, 'Marketing', '2017-07-21'),
('','Andrea López', 31, 3500.00, 'IT', '2020-08-25'),
('','Camila Rodríguez', 26, 2800.00, 'Recursos Humanos', '2022-12-10'),
('','Fernando Herrera', 45, 5300.00, 'IT', '2014-04-10');

/*Consulto que si se guardo bien, visualizo la lista de empleados*/
SELECT * FROM empleados;

/*¿Quiénes son los empleados que ganan más de 4000?*/
SELECT nombre, salario FROM empleados WHERE salario > 4000;

/*Empleados que trabajan en el departamento de ventas*/
SELECT * FROM empleados WHERE departamento = 'Ventas';

/*Empleados que tienen entre 30 y 40 años*/
SELECT * FROM empleados WHERE edad>= 30 AND edad<=40;

/*Empleados contratados depués del 2020*/
SELECT * FROM empleados WHERE YEAR(fecha_contratacion) > 2020;

/*Empleados por departamento*/
SELECT departamento, COUNT(*) AS cantidad_empleados FROM empleados GROUP BY departamento;

/*Salario promedio*/
SELECT AVG(salario) AS salario_promedio FROM empleados;

/*Empleados que su nombre empiece con A o C*/
SELECT * FROM empleados WHERE nombre LIKE 'A%' OR nombre LIKE 'C%';

/*Empleados que no pertenecen al departamento de IT*/
SELECT * FROM empleados WHERE departamento <> 'IT';

/*Empleado mejor pago*/
SELECT * FROM empleados ORDER BY salario DESC;

