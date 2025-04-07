/*Creación de base de datos*/
/*Natalia Camayo*/
/*Ana María Triviño*/
Create database DataVerse;
USE Dataverse;

/*Creación de tablas*/
Create table Sensores(
	id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    tipo varchar(50) not null,
    ubicacion varchar(50) not null,
    fecha_instalacion date not null
);

create table Registros_Sensores (
id_registro INT AUTO_INCREMENT PRIMARY KEY, 
id_sensorFK INT NOT NULL, 
valor BOOL NOT NULL, 
fechaRegistro timestamp NOT NULL
);

Create table transporte(
id_transporte INT AUTO_INCREMENT PRIMARY KEY,
tipo VARCHAR(50) NOT NULL, 
capacidad INT NOT NULL
);

Create table Usuarios (
id_usuario INT AUTO_INCREMENT PRIMARY KEY, 
nombre VARCHAR(50) NOT NULL, 
email VARCHAR(50) NOT NULL, 
id_transporteFK INT NOT NULL
);

Create table Consumo_Energetico (
id_registro INT AUTO_INCREMENT PRIMARY KEY, 
zona VARCHAR(50) NOT NULL, 
consumo_kw INT NOT NULL, 
fecha DATE NOT NULL
);

Create table Seguridad (
id_evento INT AUTO_INCREMENT PRIMARY KEY, 
tipo_evento VARCHAR(50) NOT NULL, 
descripcion VARCHAR(50) NOT NULL, 
fecha_horaFK TIMESTAMP NOT NULL, 
ubicacion VARCHAR(50) NOT NULL
);

/*Modifique la tabla de usuario y cree un campo teléfono*/
ALTER TABLE usuarios ADD telefono int not null;
describe usuarios;

/*Modelo Físico*/
ALTER TABLE Seguridad ADD id_registroFK int not null;
ALTER TABLE Seguridad ADD id_usuarioFK int not null;
ALTER TABLE Seguridad ADD id_registroCEFK int not null;

ALTER TABLE registros_sensores add constraint fkid_sensor FOREIGN KEY(id_sensorFK) references sensores(id_sensor) ON DELETE CASCADE;
ALTER TABLE usuarios add constraint fkid_transporte FOREIGN KEY(id_transporteFK) references transporte(id_transporte) ON DELETE CASCADE;
ALTER TABLE seguridad add constraint fkid_registro FOREIGN KEY(id_registroFK) references Registros_Sensores(id_registro) ON DELETE CASCADE;
ALTER TABLE seguridad add constraint fkid_usuario FOREIGN KEY(id_usuarioFK) references Usuarios(id_usuario) ON DELETE CASCADE;
ALTER TABLE seguridad add constraint fkid_registroCE FOREIGN KEY(id_registroCEFK) references Consumo_Energetico(id_registro) ON DELETE CASCADE;

/*DML*/

/*Inserte 5 registros en cada tabla*/
describe consumo_energetico;
INSERT INTO consumo_energetico VALUES('','Bogota','20','2025-01-10');
INSERT INTO consumo_energetico VALUES('','Chia','25','2025-01-15');
INSERT INTO consumo_energetico VALUES('','Cota','30','2025-01-20');
INSERT INTO consumo_energetico VALUES('','Ibague','40','2025-01-22');
INSERT INTO consumo_energetico VALUES('','Soacha','15','2025-01-26');

describe sensores;
INSERT INTO sensores VALUES('','IoT1','Bogota','2025-01-10');
INSERT INTO sensores VALUES('','IoT2','Chia','2025-01-15');
INSERT INTO sensores VALUES('','IoT3','Cota','2025-01-20');
INSERT INTO sensores VALUES('','IoT4','Ibague','2025-01-22');
INSERT INTO sensores VALUES('','IoT5','Soacha','2025-01-26');

describe registros_sensores;
INSERT INTO registros_sensores VALUES('',1,1,'2025-01-01 06:00:00');
INSERT INTO registros_sensores VALUES('',2,0,'2025-01-10 06:00:00');
INSERT INTO registros_sensores VALUES('',3,1,'2025-01-15 06:00:00');
INSERT INTO registros_sensores VALUES('',4,0,'2025-01-20 06:00:00');
INSERT INTO registros_sensores VALUES('',5,1,'2025-01-22 06:00:00');

describe transporte;
INSERT INTO transporte VALUES('','Bus',50);
INSERT INTO transporte VALUES('','Carro',5);
INSERT INTO transporte VALUES('','Bicileta',1);
INSERT INTO transporte VALUES('','Moto',2);
INSERT INTO transporte VALUES('','Taxi',4);

describe usuarios;
INSERT INTO usuarios VALUES('','Ana','ana@gmail.com',1,3013);
INSERT INTO usuarios VALUES('','Maria','maria@gmail.com',2,3026);
INSERT INTO usuarios VALUES('','Angelica','angelica@gmail.com',3,3048);
INSERT INTO usuarios VALUES('','Mauricio','mauricio@gmail.com',4,3074);
INSERT INTO usuarios VALUES('','Santiago','santiago@gmail.com',5,3094);

describe seguridad;
INSERT INTO seguridad VALUES('','Trancon','Trancon en la via','2025-01-10 06:00:00','Bogota',2,1,1);
INSERT INTO seguridad VALUES('','Accidente','Accidente en la via','2025-01-15 06:00:00','Chia',3,2,2);
INSERT INTO seguridad VALUES('','Incendio','Incendio','2025-01-20 06:00:00','Cota',4,3,3);
INSERT INTO seguridad VALUES('','Trancon','Trancon en la via','2025-01-22 06:00:00','Ibague',5,4,4);
INSERT INTO seguridad VALUES('','Accidente','Accidente en la via','2025-01-26 06:00:00','Soacha',6,5,5);

/*Actualiza el registro de consumo energetico para incrementar un 10% el consumo*/

DELIMITER //
CREATE TRIGGER Verificar_Consumo_Maximo
BEFORE INSERT ON Consumo_Energetico
FOR EACH ROW
BEGIN
    IF NEW.consumo_kw < 10000 THEN
        SET NEW.salarioEmpleado = 10000;
    END IF;
END //
DELIMITER ;

/*Elimina registros de seguridad que sean más antiguos a un año*/
describe seguridad;
delete from seguridad where fecha_hora<'2024-01-01 00:00:00';

/*Cra una vista llamada vista-alertas*/
describe seguridad;
describe sensores;
CREATE VIEW Vista_Alertas AS
Select s.tipo_evento,p.id_sensor,p.id_sensor,p.id_sensor,p.id_sensor from seguridad s join sensores s where s.fecha_horaFK < '2025-01-04 06:00:00';