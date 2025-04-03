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
    generoLibro varchar(30) NOT NULL,
    precio float NOT NULL,
    stock int NOT NULL
);

CREATE TABLE Pedidos(
	idPedidos int AUTO_INCREMENT primary key,
    idClienteFK int NOT NULL
);

CREATE TABLE orden(
	idOrden INT AUTO_INCREMENT primary key,
    idPedidosFK int NOT NULL,
    idLibroFK int NOT NULL,
    cantidad int NOT NULL
);

ALTER TABLE Pedidos add constraint FKidCliente FOREIGN KEY(idClienteFK) REFERENCES Clientes(idCliente);
ALTER TABLE Orden add constraint FKidPedidos FOREIGN KEY(idPedidosFK) REFERENCES Pedidos(idPedidos);
ALTER TABLE Orden add constraint FKidLibro FOREIGN KEY(idLibroFK) REFERENCES Libro(idLibro);

describe Clientes;
INSERT INTO clientes VALUES('','Ana','Triviño','CALLE 15 #9-20','3026578942','2003-02-20');
INSERT INTO clientes VALUES('','María','Monje','CALLE 15 #9-25','3026488942','2001-02-16');
INSERT INTO clientes VALUES('','Santiago','Mora','CALLE 15 #7-20','3026575942','2005-02-20');

select * from clientes;
describe libro;
INSERT INTO Libro (nomLibro, autorLibro, generoLibro, precio, stock)
VALUES
('Un mundo Feliz', 'George Orwell', 'Utopico', 45000, 10),
('Ensayo de la felicidad', 'Estanislao Zuleta', 'Ensayo', 30000, 6),
('Álgebra', 'Baldor', 'Matemática', 50000, 8);

describe pedidos;
INSERT INTO pedidos VALUES('','1');
INSERT INTO pedidos VALUES('','2');
INSERT INTO pedidos VALUES('','3');

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

	describe pedidos;
    
Delimiter // 
CREATE TRIGGER actualizarStock
AFTER INSERT ON orden
for each row
BEGIN
	Update libro
		SET stock=stock-NEW.cantidad
        WHERE idlibro=NEW.idlibroFK;
END //
Delimiter ;

DESCRIBE PEDIDOS;

#Listar los pedidos hechos por un cliente especifico y obtener detalles de los libros comprados
describe clientes;
describe libro;
-- Se debe manejar el modelo logico, de x lugar a y lugar
select c.idCliente,c.nomCliente,c.apellidoCliente,l.idLibro,l.nomLibro,
l.autorLibro,l.generoLibro,l.precio from Clientes c 
JOIN Pedidos p ON c.idCliente = p.idClienteFK
JOIN Orden o ON p.idPedidos = o.idPedidosFK
JOIN Libro l ON o.idLibroFK = l.idLibro WHERE c.idCliente = 1;

#Consultar el cliente que ha realizado el mayor número de ordenes
-- El group by sirve para recopilar un mismo valor para un mismo id
SELECT 
    c.idCliente,
    CONCAT(c.nomCliente, ' ', c.apellidoCliente) AS nombreCliente,
    COUNT(o.idOrden) AS totalOrdenes
FROM Clientes c
JOIN Pedidos p ON c.idCliente = p.idClienteFK
JOIN Orden o ON p.idPedidos = o.idPedidosFK
GROUP BY c.idCliente
HAVING COUNT(o.idOrden) = (
    SELECT MAX(totalOrdenes)
    FROM (
        SELECT COUNT(o2.idOrden) AS totalOrdenes
        FROM Pedidos p2
        JOIN Orden o2 ON p2.idPedidos = o2.idPedidosFK
        GROUP BY p2.idClienteFK
    ) AS sub
);


#Crear un procedimiento almacenado que permita registrar un nuevo pedido, actualizando la tabla de pedidos y reduciendo el stock del libro correspondiente.

Delimiter //
CREATE PROCEDURE realizarPedido(
	IN p_cantidad INT,
    IN p_idClienteFK INT,
    IN p_idLibroFK INT
)
BEGIN
	#Se declara una variable temporal
    DECLARE v_idPedido Int;
    
	INSERT INTO pedidos(idClienteFK)
    VALUES(p_idClienteFK);
    
    #El valor que se registro automaticamente se guarda en la variable temporal
    SET v_idPedido=last_insert_id();
    
    INSERT INTO orden(idPedidosFK,idLibroFK,cantidad) VALUES(v_idPedido,p_idLibroFK,p_cantidad);
END //
Delimiter ;

CALL realizarpedido(2,1,2);
select * from libro;

#Selecciona los libros cuyo precio sea mayor a $20.00.
	ALTER TABLE libro add column precio float NOT NULL;
	UPDATE libro SET precio=12.60 where idLibro=1;
	UPDATE libro SET precio=24.60 where idLibro=2;
	UPDATE libro SET precio=20.00 where idLibro=3;
	describe libro;
	select * from libro;

SELECT * FROM Libro WHERE precio > 20;

#Selecciona los pedidos realizados después del 1 de octubre de 2024
ALTER TABLE Pedidos ADD COLUMN fechaPedido DATE NOT NULL;

SELECT *
FROM Pedidos
WHERE fechaPedido > '2024-10-01';

#Selecciona todos los libros ordenados por su precio de mayor a menor.

SELECT *
FROM Libro
ORDER BY precio DESC;

#Obtén el total de clientes registrados en la tabla clientes. Obtén el total de unidades vendidas en la tabla pedidos.

SELECT COUNT(*) AS totalClientes
FROM Clientes;
SELECT SUM(cantidad) AS totalUnidadesVendidas
FROM Orden;

#Muestra el número de ordenes realizados por cada cliente.

SELECT 
    c.idCliente,
    CONCAT(c.nomCliente, ' ', c.apellidoCliente) AS nombreCliente,
    COUNT(o.idOrden) AS totalOrdenes
FROM Clientes c
JOIN Pedidos p ON c.idCliente = p.idClienteFK
JOIN Orden o ON p.idPedidos = o.idPedidosFK
GROUP BY c.idCliente;

#Muestra el nombre del cliente, el título del libro y la cantidad de cada orden.

SELECT 
    CONCAT(c.nomCliente, ' ', c.apellidoCliente) AS nombreCliente,
    l.nomLibro AS tituloLibro,
    o.cantidad
FROM Clientes c
JOIN Pedidos p ON c.idCliente = p.idClienteFK
JOIN Orden o ON p.idPedidos = o.idPedidosFK
JOIN Libro l ON o.idLibroFK = l.idLibro;

#Muestra los títulos de los libros y la cantidad total vendida de cada uno.

SELECT 
    l.nomLibro AS tituloLibro, SUM(o.cantidad) AS totalVendida
FROM Libro l
JOIN Orden o ON l.idLibro = o.idLibroFK
GROUP BY l.idLibro;
