/*Sentencias de DDL/
/Creacion de base de datos*/
create database TiendaMascota;
/*Habilitar la base de datos*/
use TiendaMascota;
/*Creacion de tablas*/
create table Mascota(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);
create table Cliente(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);
create table Producto(
codigoProducto int primary key,
nombreProducto varchar (15),
marca varchar (15),
precio float,
cedulaClienteFK int
);
create table Vacuna(
codigoVacuna int primary key,
nombreVacuna varchar (15),
dosisVacuna int (10),
enfermedad varchar (15)
);
create table Mascota_Vacuna(
codigoVacunaFK int,
idMascotaFK int,
enfermedad varchar (15)
);
/*crear las relaciones*/
alter table Cliente
add constraint FClienteMascota
foreign key (idMascotaFK)
references Mascota(idMascota);

alter table Producto
add constraint FKProductoCliente
foreign key (cedulaClienteFK)
references Cliente(cedulaCliente);

alter table Mascota_Vacuna
add constraint FKMV
foreign key (idMascotaFK)
references Mascota(idMascota );

alter table Mascota_Vacuna
add constraint FKVM
foreign key (codigoVacunaFK)
references Vacuna(codigoVacuna);

insert into Mascota Values (3, 'Perro','M','Golden',2),(5,'Gato','F','Persa','1');
insert into Cliente Values (35478596, 'German','Sierra','cll 12c',299963536, 3),(35854845, 'Angela','Sierra','cll 12c',299963536, 5);
insert into Producto Values (03, 'Pelota','Adidas','4500.0',35478596),(05,'Rascador','Nike','2460.0',35854845);
insert into Vacuna Values (003, 'Rabia',1,'Rabia en los perros'),(005,'Gastritis',2,'Dolores de panza');
insert into Mascota_Vacuna Values (003, 3,'Rabia'),(005,5,'Gastritis');

select * from Vacuna;

/*Eliminacion*/
Delete from Producto where codigoProducto=03;
describe Producto;
Delete from Producto;

/*Procedimientos almacenados
Stored Procedure conjunto de instrucciones de SQL que se almacenan
y estos se pueden ejecutar muchas veces*/

select * from Mascota;
/*tIPOS DE PARAMENTORS: ENTRADA IN, CUANDO VOY A HACER UNA INSERCIÓN, SALIDA OUT, CUANDO LOS PARAMETROS SALEN DEL PROCEDIMIENTO*/

DELIMITER //
CREATE PROCEDURE InsertarMascota(in idMascota int, nombreMascota varchar(15), generoMascota varchar(15),razaMascota varchar(15), cantidad int)
BEGIN
	INSERT INTO mascota values(idMascota,nombreMascota,nombreMascota,razaMascota,cantidad);
END //
DELIMITER ;

select * from mascota;
/*Ejecutar el procedimiento Sintaxis es call nombreProcedimiento (valores)*/
CALL InsertarMascota(8,'Firulais','M','Criolla',1);

select * from Mascota;

select * from producto;
describe producto;

DELIMITER //
CREATE PROCEDURE ConsultarPrecio(out precio float)
BEGIN
	select count(*) into precio from producto;
END //
DELIMITER ;

CALL ConsultarPrecio(@resultado);
 select @resultado;
 
 /*Ejercicio: crear un procedimiento para insertar registristros en tabla en tabla débil
 y crear un procedimiento para consultar las vacunas que se le ha aplicado a una mascota y que enfermedad esta atacando*/
 
DESCRIBE Mascota_Vacuna;
DELIMITER //
CREATE PROCEDURE InsertarMascotaVacuna(IN codigoVacunaFK int,idMascotaFK int,enfermedad varchar(15))
BEGIN
	INSERT INTO Mascota_Vacuna values(codigoVacunaFK,idMascotaFK,enfermedad);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ConsultaVacunaMascota(IN idMascota int)
BEGIN
	SELECT idMascotaFK,codigoVacunaFK,enfermedad 
    from Mascota_Vacuna
    join Vacuna on Mascota_Vacuna.codigoVacunaFK=Vacuna.codigoVacuna
    join Mascota on Mascota_Vacuna.idMascotaFK=Mascota.idMascota
    where Mascota_Vacuna.idMascotaFK=Mascota.idMascota;
END //
DELIMITER ;
describe Mascota_Vacuna;

/*Vistas views Esto es una consulta que se almacena en la base de datos, es una tabla virtual, 
genera una consulta de datos en tipo de tabla, pero esta tabla no queda registrada en la base de datos.

Es una consulta almacenada en la base de datos que genera una tabla virtual, solo puedo consultar lo que esta, es mejor una vista que 
una consulta porque se simplifica el proceso*/

/*Sentencia DDL*/
CREATE VIEW vistaCliente as
select * from Cliente where cedulaCliente=35478596;
select * from VistaCliente;

CREATE VIEW vistaTelCliente AS
SELECT * FROM Cliente WHERE telefono LIKE '%4%' and telefono LIKE '%6%' and telefono LIKE '%7%';
select * from VistaTelCliente;

/*modificar una vista 
alter view (nombre de la vista) as select (valoresaConsultar)
from (nombreTabla) where (condiciones)*/

/*Eliminar una vista
drop view (nombreVista)*/

/*Disparadores o triggers o desencadenador
son objetos de la base de datos que ayudan a tener soportes de información
tipos de disparadores; before, tiene before insert, before update, el before delete: se
ejecutan antes de la operación
crea un backup
; after, tiene after insert, after update y after delete*/

/*Crear un trigger para registar en una tabla consolidado cada vez
que se inserte una mascote*/

/*Create Trigger for send info to a table called consolidado when the client insert a new pet */
create table consolidado(
idMascota int primary key,
nombreMascota varchar (15),
generoMascota varchar (15),
razaMascota varchar (15),
cantidad int (10)
);

DELIMITER //
CREATE TRIGGER registrarConsolidadoMascota
AFTER INSERT ON mascota
FOR EACH ROW
BEGIN
	INSERT INTO consolidado VALUES(OLD.idMascota, NEW.nombreMascota, NEW.generoMascota, NEW.razaMascota, NEW.cantidad );
END//
DELIMITER ;

insert into Mascota Values (6, 'Sasha','M','Golden',8);
select * from consolidado;

/*Cuando el campo es autoincrementable toca colocar 'Insert'*/

/*Crea un trigger de eliminado para que registre los clientes eliminados*/

create table papelera(
cedulaCliente int primary key,
nombreCliente varchar (15),
apellidoCliente varchar (15),
direccionCliente varchar (10),
telefono int (10),
idMascotaFK int
);

DELIMITER //
CREATE TRIGGER papeleraCliente
BEFORE DELETE ON cliente
FOR EACH ROW
BEGIN
	INSERT INTO papelera VALUES(OLD.cedulaCliente, OLD.nombreCliente, OLD.apellidoCliente, OLD.direccionCliente, OLD.telefono, OLD.idMascotaFK );

END//
DELIMITER ;

Insert into cliente values(8826482,'ANA','URUR','CL 8 %637', 38842984,6);
Delete from cliente where nombreCliente='ANA';

select * from papelera;

SET SQL_SAFE_UPDATES=0;
