CREATE DATABASE OnlineBD;
USE OnlineBD;

CREATE TABLE Clientes(
	idCliente int AUTO_INCREMENT primary key,
    nomCliente varchar(30) NOT NULL,
    apellidoCliente varchar(30) NOT NULL,
    direccionCliente varchar(50) NOT NULL,
	celularCliente int NOT NULL,
    fechaNaCliente date NOT NULL
);

CREATE TABLE Libro(
	idLibro int AUTO_INCREMENT primary key,
    nomLibro varchar(30) NOT NULL,
    autorLibro varchar(30) NOT NULL,
    generoLibro varchar(30) NOT NULL
);

CREATE TABLE Pedidos(
	idPedidos int AUTO_INCREMENT primary key,
    idClienteFK int NOT NULL,
    idOrdenFK int NOT NULL
);

CREATE TABLE orden(
	idOrden INT AUTO_INCREMENT primary key,
    idPedidosFK int NOT NULL,
    idLibroFK int NOT NULL
);

ALTER TABLE Pedidos add constraint FKidCliente FOREIGN KEY(idClienteFK) REFERENCES Clientes(idCliente);
ALTER TABLE Pedidos add constraint FKidOrden FOREIGN KEY(idOrdenFK) REFERENCES Orden(idOrden);
ALTER TABLE Orden add constraint FKidPedidos FOREIGN KEY(idPedidosFK) REFERENCES Pedidos(idPedidos);
ALTER TABLE Orden add constraint FKidLibro FOREIGN KEY(idLibroFK) REFERENCES Libro(idLibro);

describe Clientes;
INSERT INTO clientes VALUES('','Ana','Triviño','CALLE 15 #9-20','3026578942','2003-02-20');
INSERT INTO clientes VALUES('','María','Monje','CALLE 15 #9-25','3026488942','2001-02-16');
INSERT INTO clientes VALUES('','Santiago','Mora','CALLE 15 #7-20','3026575942','2005-02-20');

select * from clientes;
describe libro;
INSERT INTO libro VALUES('','Un mundo Feliz','George Orwell','Utopico');
INSERT INTO libro VALUES('','Ensayo de la felicidad','Estanislao Zuleta','Ensayo');
INSERT INTO libro VALUES('','Algebra','Baldor','Matemática');

describe pedidos;
INSERT INTO pedidos VALUES('','1','3');
INSERT INTO pedidos VALUES('','2','2');
INSERT INTO pedidos VALUES('','3','1');

ALTER TABLE libro add column precio float NOT NULL;

#Actualizar el stock de los libros una vez que se realice un pedido.
ALTER TABLE libro add column stock int NOT NULL;
UPDATE libro SET stock=10 where idLibro=1;
UPDATE libro SET stock=6 where idLibro=2;
UPDATE libro SET stock=8 where idLibro=3;
describe libro;
select * from libro;

/*La relación de pedidos y libros es de muchos a muchos, toca crear una tabla débil*/
/*Borra la relación, crea una nueva tabla débil y modifica la tabla de pedidos, vuelve a crear la relación*/
ALTER TABLE Pedidos drop FOREIGN KEY FKidLibro;
DROP TABLE PEDIDOS;



describe pedidos;
Delimiter // 
CREATE TRIGGER actualizarStock
AFTER INSERT ON pedidos
for each row
BEGIN
	Update libros
		SET stock=stock-1
        WHERE idlibro=NEW.idlibroFK;
END //
Delimiter ;

Delimiter //
CREATE PROCEDURE realizarPedido(
    IN p_idClienteFK INT,
    IN p_idLibroFK INT
)
BEGIN
	INSERT INTO pedidos(idClienteFK,idLibroFK)
    VALUES(p_idClienteFK,p_idLibroFK);
END //
Delimiter ;


#Listar los pedidos hechos por un cliente especifico y obtener detalles de los libros comprados
#Consultar el cliente que ha realizado el mayor número de pedidos
#Crear un procedimiento almacenado que permita registrar un nuevo pedido, actualizando la tabla de pedidos y reduciendo el stock del libro correspondiente.
#Selecciona los libros cuyo precio sea mayor a $20.00.
ALTER TABLE libro add column precio float NOT NULL;
UPDATE libro SET precio=12.60 where idLibro=1;
UPDATE libro SET precio=24.60 where idLibro=2;
UPDATE libro SET precio=20.00 where idLibro=3;
describe libro;
select * from libro;

#Selecciona los pedidos realizados después del 1 de octubre de 2024
# Selecciona todos los libros ordenados por su precio de mayor a menor.
#Obtén el total de clientes registrados en la tabla clientes. Obtén el total de unidades vendidas en la tabla pedidos.
#Muestra el número de pedidos realizados por cada cliente.
#Muestra el nombre del cliente, el título del libro y la cantidad de cada pedido.
#Muestra los títulos de los libros y la cantidad total vendida de cada uno.
