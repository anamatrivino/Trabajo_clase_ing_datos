CREATE DATABASE TecNCorp;
USE TecNCorp;

CREATE TABLE departamento (
    idDepartamento INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombreDepartamento VARCHAR(100) NOT NULL
);

CREATE TABLE cargo (
    idCargo VARCHAR(50) PRIMARY KEY NOT NULL,
    nombreCargo VARCHAR(50) NOT NULL,
    rangoCargo VARCHAR(50) NOT NULL,
    descripcionCargo VARCHAR(200) NOT NULL
);

CREATE TABLE empleados (
    idEmpleado INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombreEmpleado VARCHAR(100) NOT NULL,
    edadEmpleado INT NOT NULL,
    ingresosEmpleado DECIMAL(10,2) NOT NULL,
    idDepartamento INT NOT NULL,
    fContratacion DATE NOT NULL,
    idCargo VARCHAR(50) NOT NULL,
    FOREIGN KEY (idDepartamento) REFERENCES departamento(idDepartamento),
    FOREIGN KEY (idCargo) REFERENCES cargo(idCargo)
);

INSERT INTO departamento (nombreDepartamento) VALUES 
('IT'), ('Ventas'), ('Recursos Humanos'), ('Finanzas'), ('Marketing'), ('Analítica'), ('RRHH'), ('Administración');

INSERT INTO cargo (idCargo, nombreCargo, rangoCargo, descripcionCargo) VALUES 
('DP5', 'Director de proyecto', 'Alto', 'Lídera el proyecto'),
('SD2', 'Secretario del director', 'Medio', 'Ayuda a la agenda del director'),
('DP3', 'Programador', 'Bajo', 'Hace la programación en el lenguaje'),
('DP4', 'Analista de datos', 'Medio', 'Analiza que los resultados sean coherentes'),
('DP3A', 'Desarrollador', 'Bajo', 'Ayuda al programador en el desarrollo');

INSERT INTO empleados (nombreEmpleado, edadEmpleado, ingresosEmpleado, idDepartamento, fContratacion, idCargo) VALUES
('Carlos Gómez', 35, 4500.00, 2, '2019-05-22', 'DP5'),
('Ana Pérez', 28, 3800.00, 1, '2021-06-10', 'SD2'),
('Javier Torres', 42, 5200.00, 2, '2015-09-18', 'DP3'),
('Beatriz Morales', 30, 3100.00, 3, '2022-03-05', 'DP4'),
('Alejandro Ramírez', 39, 4700.00, 2, '2018-11-30', 'DP3A'),
('Clara Sánchez', 29, 2900.00, 1, '2023-01-15', 'DP3'),
('David Jiménez', 33, 4100.00, 5, '2017-07-21', 'DP4'),
('Andrea López', 31, 3500.00, 1, '2020-08-25', 'DP3A'),
('Camila Rodríguez', 26, 2800.00, 3, '2022-12-10', 'DP3'),
('Fernando Herrera', 45, 5300.00, 1, '2014-04-10', 'DP3');

/*sCRIPT 1*/
/*Consulto que si se guardo bien, visualizo la lista de empleados*/
SELECT * FROM empleados;

/*¿Quiénes son los empleados que ganan más de 4000?*/
select idEmpleado, nombreEmpleado as 'nombres', ingresosEmpleado as 'salarios' from empleados where ingresosEmpleado >4000.00;

/*Empleados que trabajan en el departamento de ventas*/
select * from empleados where departamento='Ventas';

/*Empleados que tienen entre 30 y 40 años*/
select*from empleados where edadEmpleado>=30 and edadEmpleado<=40;

/*Empleados contratados depués del 2020*/
select * from empleados where year(fContratacion) > 2020;

/*Empleados por departamento*/
select departamento, COUNT(*) as Total from empleados group by departamento;

/*Salario promedio*/
select Avg(ingresosEmpleado) AS promedioSalario  FROM empleados;

/*Empleados que su nombre empiece con A o C*/
select*from empleados where nombreEmpleado like 'A%' or nombreEmpleado like 'C%' ; 

/*Empleados que no pertenecen al departamento de IT*/
SELECT * FROM empleados WHERE departamento <> 'IT';

/*Empleado mejor pago*/
select nombreEmpleado as 'El Más pagado', ingresosEmpleado as 'salario' from empleados where ingresosEmpleado = (select MAX(ingresosEmpleado) from empleados);

/*Script 2*/
/*consultar rangos between*/
 select*from empleados where idEmpleado  between 1 and 4;
 
 /*Consultar un valor que esté dentro de una lista de valores: in*/
 select*from empleados where idEmpleado in (1,6);
 
 /*Si un campo es nulo is null*/
 select*from empleados where nombreEmpleado is null;
 
/*Script3*/
/*Muestre los nombres de los empleados y los nombres de los departamentos a los que pertenecen*/
select nombreEmpleado,nombreDepartamento from empleados inner join departamento on empleados.idDepartamento=departamento.idDepartamento;

/*Hacer una consulta que tenga todos los rangos en especifico*/
SELECT nombreEmpleado, rangoCargo FROM empleados INNER JOIN cargo ON empleados.idCargo = cargo.idCargo;

/*Mostrar en pantalla los empleados que tengan un cargo en específico*/
SELECT nombreEmpleado, nombreCargo FROM empleados INNER JOIN cargo ON empleados.idCargo = cargo.idCargo where nombreCargo='Programador';

/*Mostrar todos los empleados que tengan antiguedad que tenga mas de 3 años, que departamento tienen, que salario y que cargo tienen*/
SELECT nombreEmpleado as 'Empleado', nombreDepartamento as 'Departamento', ingresosEmpleado as 'Salario', nombreCargo as 'Cargo'FROM empleados 
INNER JOIN Departamento ON empleados.idDepartamento = Departamento.idDepartamento INNER JOIN  cargo ON empleados.idCargo=cargo.idCargo
where year(fContratacion) < 2022; 

/*Mostrar toda la información de un empleado, nombre de empleado, fecha que se contrato, departamento que esta contratado, años de antiguedad 
de la empresa, cargo que tiene actualmente y rango que tiene*/
SELECT nombreEmpleado, fContratacion, nombreDepartamento, TIMESTAMPDIFF(YEAR, empleados.fContratacion, CURDATE()) AS antiguedad, 
nombreCargo, rangoCargo FROM empleados INNER JOIN departamento ON empleados.idDepartamento = departamento.idDepartamento INNER JOIN cargo ON 
empleados.idCargo = cargo.idCargo WHERE nombreEmpleado = 'Carlos Gómez'; 


/*Mostrar todos los departamentos que no tengan empleados asignados*/
SELECT nombreDepartamento FROM departamento LEFT JOIN empleados ON departamento.idDepartamento = empleados.idDepartamento WHERE idEmpleado IS NULL;


/*Mostrar todos los cargos que no tengan empleados asignados*/
INSERT INTO cargo (idCargo, nombreCargo, rangoCargo, descripcionCargo) VALUES 
('CEO5', 'CEO', 'Alto', 'Dueño de la empresa'),
('PS01', 'Psicologa laboral', 'Bajo', 'Se encarga del clima laboral');
SELECT nombreCargo FROM cargo LEFT JOIN empleados ON cargo.idCargo = empleados.idCargo WHERE idEmpleado IS NULL;
