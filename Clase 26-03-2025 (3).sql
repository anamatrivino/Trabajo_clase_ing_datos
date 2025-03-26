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