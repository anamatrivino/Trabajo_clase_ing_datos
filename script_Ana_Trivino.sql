
/*Creacion de base de datos*/
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

select * from Mascota;
describe Mascota;
describe Producto;
insert into Producto values(1,'Shampo','pets',10500,53168);
insert into Mascota (idMascota,nombreMascota,generoMascota,razaMascota,cantidad) values(1,'Rusth','M','Criollo',1);
insert into Mascota values(2,'Macarena','F','Criollo',1);
insert into Mascota values (3,'Sasha','F','Criollo',1);
insert into Mascota values (4,'ANANA','M','Criollo',2);
insert into Mascota values(5,'juanpa','M','Criollo',1);

describe Vacuna;
insert into Vacuna values (4,'Pentavalenta','3','inmuniza contra el moquillo');
insert into Vacuna values (5,'Hexavalenta','1','inmuniza contra el adenovirus 1');
insert into Vacuna values (1,'Pentavalenta','3','inmuniza contra el moquillo');
insert into Vacuna values (2,'Hexavalenta','1','inmuniza contra el adenovirus 1');
insert into Vacuna values (3,'Pentavalenta','3','inmuniza contra el moquillo');

describe Cliente;
insert into Cliente values (5000,'Ana','Morra','carrera 15',32551118000,1);
insert into Cliente values (10000,'Santiago','Alvarez','carrera 1',3105151503,2);
insert into Cliente values (20000,'Camila','Casas','calle 5',312315251151594,1);
insert into Cliente values (8000,'Andres','Azar','carrera 10',312552525036,2);
insert into Cliente values (858588,'Sam','Restrepo','calle 5',31295884885824,1);

describe Producto;
insert into Producto values (1,'cuerda','juguete',1000,7205);
insert into Producto values(2,'bozal','juguete',20000,2487);
insert into Producto values (8,'Pelota','juguete',3500,5075);
insert into Producto values (11,'Placa','juguete',18000,607235);
insert into Producto values (15,'Cepillo','juguete',21000,15018);