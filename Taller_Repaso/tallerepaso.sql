CREATE DATABASE votaciones2503816;
USE votaciones2503816;

#Creación de tablas
CREATE TABLE Genero(
	idGenero int auto_increment primary key,
    nomGenero Enum('Femenino','Masculino') not null,
    estadoG bool not null
);

CREATE TABLE Jornada(
	idJornada int auto_increment primary key,
    nomJornada Enum('Mañana','Tarde','Noche') not null,
    estadoJ bool not null
);

CREATE TABLE TipoDocumento(
	idTipoDoc int auto_increment primary key,
    nomTipoDoc Enum('Tarjeta de identidad','Cédula de ciudadanias','Cédula Extranjera','Pasaporte','NUIP') not null,
    estadoTD bool not null
);

CREATE TABLE TipoMiembro(
	idTipoMiembro int auto_increment primary key,
    nomTipoMiembro Enum('Estudiante','Profesor','Acudiente') not null,
    estadoTipoMiembro bool not null
);

CREATE TABLE Curso(
	idCurso int auto_increment primary key,
    nomCurso int not null,
    estadoCurso bool not null
);

CREATE TABLE Concejo(
	idConcejo int auto_increment primary key,
    nomConcejo Varchar(30) not null,
    estadoConcejo bool not null
);

CREATE TABLE Cargo(
	idCargo int auto_increment primary key,
    nomCargo Varchar(30) not null,
    idConsejoFK int not null,
    estadoC bool not null
);

CREATE TABLE Eleccion(
	idEleccion int auto_increment primary key,
    fechaEleccion date not null,
    anioEleccion int not null,
    estadoEL bool not null
);

CREATE TABLE Usuario(
	idUsuario int auto_increment primary key,
    noDocUsuario int not null,
    idTipoDocFK int not null,
    nombreUsuario Varchar(50) not null,
    apellidoUsuario Varchar(50) not null,
    idGeneroFK int not null,
    fechaNacUsuario date not null,
    emailUsuario varchar(50) not null,
    passwordUsuario varchar(50) not null,
    fotoUsuario blob null,
    idJornadaFk int not null,
    idTipoMiembroFK int not null,
    idCursoFK int not null,
    estadoU bool not null
);

CREATE TABLE Votacion(
	idVotacion int auto_increment primary key,
    horaVotacion time not null,
    idUsuarioVotanteFK int not null,
    idPostCandidatoFK int not null,
    estadoV bool not null
);

CREATE TABLE PostulacionCandidato(
	idPostCandidato int auto_increment primary key,
    idUsuarioFK int not null,
    idEleccionFK int not null,
    idCargoFK int not null,
    Propuestas varchar(50) not null,
    totalvotos int not null,
    estadoCan bool not null
);

#Creación de llaves foranéas 
ALTER TABLE PostulacionCandidato add constraint FKidUsuario FOREIGN KEY(idUsuarioFK) REFERENCES Usuario(idUsuario);
ALTER TABLE PostulacionCandidato add constraint FKidEleccion FOREIGN KEY(idEleccionFK) REFERENCES Eleccion(idEleccion);
ALTER TABLE PostulacionCandidato add constraint FKidCargo FOREIGN KEY (idCargoFK) REFERENCES Cargo(idCargo);

ALTER TABLE Votacion add constraint FKidUsuarioVotante FOREIGN KEY(idUsuarioVotanteFK) REFERENCES Usuario(idUsuario);
ALTER TABLE Votacion add constraint FKiidPostCandidato FOREIGN KEY (idPostCandidatoFK) REFERENCES PostulacionCandidato(idPostCandidato);

ALTER TABLE usuario add constraint FKidTipoDoc FOREIGN KEY(idTipoDocFK) REFERENCES Tipodocumento(idTipoDoc);
ALTER TABLE usuario add constraint FKidGenero FOREIGN KEY(idGeneroFK) REFERENCES Genero(idGenero);
ALTER TABLE usuario add constraint FKidJornada FOREIGN KEY (idJornadaFk) REFERENCES Jornada(idJornada);
ALTER TABLE usuario add constraint FKidTipoMiembro FOREIGN KEY(idTipoMiembroFK) REFERENCES TipoMiembro(idTipoMiembro);
ALTER TABLE usuario add constraint FKidCurso FOREIGN KEY(idCursoFK) REFERENCES Curso(idCurso);

ALTER TABLE Cargo add constraint FKidConsejo FOREIGN KEY(idConsejoFK) REFERENCES Concejo(idConcejo);

#Inserción de los datos
INSERT INTO genero values(' ','Femenino',TRUE);
INSERT INTO genero values(' ','Masculin',TRUE);

INSERT INTO Jornada values(' ','Mañana',TRUE);
INSERT INTO Jornada values(' ','Tarde',TRUE);
INSERT INTO Jornada values(' ','Noche',TRUE);

INSERT INTO TipoDocumento values(' ','Tarjeta de identidad',TRUE);
INSERT INTO TipoDocumento values(' ','Cédula Ciudadanía',TRUE);
INSERT INTO TipoDocumento values(' ','Cédula Extranjeria',TRUE);
INSERT INTO TipoDocumento values(' ','Pasaporte',TRUE);
INSERT INTO TipoDocumento values(' ','NUIP',FALSE);

INSERT INTO TipoMiembro values(' ','Estudiante',TRUE);
INSERT INTO TipoMiembro values(' ','Profesor',TRUE);
INSERT INTO TipoMiembro values(' ','Acudiente',TRUE);

INSERT INTO Curso values(' ','901',TRUE);
INSERT INTO Curso values(' ','902',TRUE);
INSERT INTO Curso values(' ','1001',TRUE);
INSERT INTO Curso values(' ','1002',TRUE);
INSERT INTO Curso values(' ','1003',FALSE);
INSERT INTO Curso values(' ','1101',TRUE);
INSERT INTO Curso values(' ','1102',TRUE);
INSERT INTO Curso values(' ','1103',FALSE);

INSERT INTO Concejo values('','Concejo Académico',TRUE);
INSERT INTO Concejo values('','Concejo Directivo',TRUE);
INSERT INTO Concejo values('','Concejo Convivencia',TRUE);

INSERT INTO Eleccion values(' ','2020-04-20',2020,TRUE);
INSERT INTO Eleccion values(' ','2019-04-15',2019,TRUE);
INSERT INTO Eleccion values(' ','2019-04-12',2019,TRUE);
INSERT INTO Eleccion values(' ','2018-04-14',2018,TRUE);
INSERT INTO Eleccion values(' ','2017-04-12',2017,TRUE);

INSERT INTO Cargo values(' ','Personero',1,TRUE);
INSERT INTO Cargo values(' ','Contralor',1,TRUE);
INSERT INTO Cargo values(' ','Cabildante',1,TRUE);

/*Se crea un procedimiento para registrar usuarios y tener facilidad*/
DELIMITER //
CREATE PROCEDURE RegistrarUsuario(
    IN p_noDocUsuario INT,
    IN p_idTipoDocFK INT,
    IN p_nombreUsuario VARCHAR(50),
    IN p_apellidoUsuario VARCHAR(50),
    IN p_idGeneroFK INT,
    IN p_fechaNacUsuario DATE,
    IN p_emailUsuario VARCHAR(50),
    IN p_passwordUsuario VARCHAR(50),
    IN p_idJornadaFk INT,
    IN p_idTipoMiembroFK INT,
    IN p_idCursoFK INT,
    IN p_estadoU BOOL
)
BEGIN
    INSERT INTO Usuario (
        noDocUsuario, idTipoDocFK, nombreUsuario, apellidoUsuario, idGeneroFK,
        fechaNacUsuario, emailUsuario, passwordUsuario, idJornadaFk,
        idTipoMiembroFK, idCursoFK, estadoU
    )
    VALUES (
        p_noDocUsuario, p_idTipoDocFK, p_nombreUsuario, p_apellidoUsuario, p_idGeneroFK,
        p_fechaNacUsuario, p_emailUsuario, p_passwordUsuario, p_idJornadaFk,
        p_idTipoMiembroFK, p_idCursoFK, p_estadoU
    );
END //

DELIMITER ;

CALL RegistrarUsuario(1010123456,1,'DAVID SANTIAGO','LÓPEZ MORA',2,'2004-10-11','davidLopez456@hotmail.com','David2004',1,1,1,TRUE);
CALL RegistrarUsuario(1010123789,1,'LAURA MILENA','GOMEZ BONILLA',1,'2004-03-17','lauragomez@gmail.com','Gomez2004',1,1,1,TRUE);
CALL RegistrarUsuario(1010123741,1,'DIEGO FERNANDO','CAÑON VARGAS',2,'2003-05-20','diegocanon@hotmail.com','Diego2003',1,1,1,TRUE);
CALL RegistrarUsuario(1010123852,1,'TATIANA','VARGAS CABRERA',1,'2003-11-28','tatacabrera@gmail.com','Cabrera2003',1,1,1,TRUE);
CALL RegistrarUsuario(1010123963,1,'LEYDY KATHERINE','FERNANDEZ RODRIGUEZ',1,'2004-06-28','leydy2004@gmail.com','Leydy2004',1,1,1,TRUE);
CALL RegistrarUsuario(1010123654,2,'MAURICIO','BERMUDEZ AMAYA',2,'2002-01-26','maobermudez@gmail.com','Amaya2002',1,1,1,TRUE);
CALL RegistrarUsuario(1010741258,1,'ANDRES FELIPE','RODRIGUEZ PEREZ',2,'2004-03-23','andyrodriguez@gmail.com','Arodriguez2004',1,1,1,TRUE);
CALL RegistrarUsuario(1010236859,1,'MARIA ANGÉLICA','TRIVIÑO LATORRE',1,'2002-02-04','angelicatri@gmail.com','Trivino2002',1,1,1,TRUE);
CALL RegistrarUsuario(1010236963,1,'GENARO','VASQUEZ RODRIGUEZ',2,'2002-11-14','gevasquez@gmail.com','Vasquez123',1,1,1,FALSE);

/*Se prosigue a registrar las postulaciones de candidato*/
INSERT INTO PostulacionCandidato VALUES (' ',1,1,1,'Mejorar entrega refrigerios,Alargar descansos',0,TRUE);
INSERT INTO PostulacionCandidato VALUES (' ',5,1,1,'Mejorar entrega refrigerios,Alargar descansos',0,TRUE);
INSERT INTO PostulacionCandidato VALUES (' ',7,1,1,'Mejorar sala de informática, Construir piscina',0,TRUE);

/*Se crea un registroVotacion*/
DELIMITER //
CREATE PROCEDURE RegistrarVotacion(
    IN 	p_horaVotacion time,
    IN  p_idUsuarioVotanteFK int,
    IN  p_idPostCandidatoFK int,
    IN 	p_estadoV bool
)
BEGIN
    INSERT INTO Votacion (
        horaVotacion,idUsuarioVotanteFK,idPostCandidatoFK,estadoV)
    VALUES (p_horaVotacion,p_idUsuarioVotanteFK,p_idPostCandidatoFK,p_estadoV);
END //

DELIMITER ;

CALL RegistrarVotacion('12:12:35',1,1,TRUE);
CALL RegistrarVotacion('12:14:18',2,3,TRUE);
CALL RegistrarVotacion('12:15:58',3,2,TRUE);
CALL RegistrarVotacion('12:18:02',4,2,TRUE);
CALL RegistrarVotacion('12:24:22',5,3,TRUE);
CALL RegistrarVotacion('12:28:02',6,3,TRUE);
CALL RegistrarVotacion('12:30:14',7,3,TRUE);
CALL RegistrarVotacion('12:40:20',8,2,TRUE);
CALL RegistrarVotacion('12:45:20',9,2,TRUE);

#Realice una consulta que muestre el nombre de cada concejo, que tenga asignado un cargo y el estado actual del mismo
SELECT c.nomConcejo AS 'Nombre Concejo', ca.nomCargo AS 'nombre de cargo', c.estadoConcejo AS 'Estado Concejo'
FROM Concejo c INNER JOIN Cargo ca ON c.idConcejo = ca.idConsejoFK;

#REALICE UNA CONSULTA QUE MUESTRE EL NOMBRE DE CADA CONCEJO
SELECT c.nomConcejo AS 'Nombre Concejo', ca.nomCargo AS 'nombre de cargo', c.estadoConcejo AS 'Estado Concejo'
FROM Concejo c LEFT JOIN Cargo ca ON c.idConcejo = ca.idConsejoFK;

#Realice una consulta que muestre cada usuario con su jornada, tipo de miembro y curso
SELECT 
    u.nombreUsuario AS 'Nombre',
    u.apellidoUsuario AS 'Apellido',
    j.nomJornada AS 'Jornada',
    tm.nomTipoMiembro AS 'TipoMiembro',
    c.nomCurso AS 'Curso'
FROM 
    Usuario u
INNER JOIN 
    Jornada j ON u.idJornadaFk = j.idJornada
INNER JOIN 
    TipoMiembro tm ON u.idTipoMiembroFK = tm.idTipoMiembro
INNER JOIN 
    Curso c ON u.idCursoFK = c.idCurso;

#Agregue el campo a la tabla estudiante llamada profesión.
ALTER TABLE Usuario ADD profesion VARCHAR(50) NULL;
describe Usuario;

#Realice una consulta que muestre la cantidad de votos obtenidos por cada candidato en las votaciones registradas. 
SELECT 
    u.nombreUsuario AS 'Nombre',
    u.apellidoUsuario AS 'Apellido',
    pc.totalvotos AS 'Total de votos',
    v.idVotacion AS 'Votación registrada'
FROM 
    PostulacionCandidato pc
INNER JOIN 
    Usuario u ON pc.idUsuarioFK = u.idUsuario
LEFT JOIN 
    Votacion v ON pc.idPostCandidato = v.idPostCandidatoFK;

#Implemente tres procedimientos almacenados, tres vistas y dos subconsultas
/*Arriba se habia realizado un procedimiento para registrar*/
/*Procedimiento para registrarcurso*/
DELIMITER //
CREATE PROCEDURE RegistrarCurso(
    IN p_nomCurso INT,
    IN p_estadoCurso BOOL
)
BEGIN
    INSERT INTO Curso (nomCurso, estadoCurso)
    VALUES (p_nomCurso, p_estadoCurso);
END //
DELIMITER ;
CALL registrarCurso(807, FALSE);

/*Procedimiento para cambiar estado de usuario*/
DELIMITER //
CREATE PROCEDURE CambiarEstadoUsuario(
    IN p_idUsuario INT,
    IN p_nuevoEstado BOOL
)
BEGIN
    UPDATE Usuario 
    SET estadoU = p_nuevoEstado
    WHERE idUsuario = p_idUsuario;
END //
DELIMITER ;
CALL CambiarEstadoUsuario(1,FALSE);

/*Vistas del detalle de votaciones*/
CREATE VIEW VistaVotaciones AS
SELECT 
    v.idVotacion,
    v.horaVotacion,
    CONCAT(vu.nombreUsuario, ' ', vu.apellidoUsuario) AS Votante,
    CONCAT(vc.nombreUsuario, ' ', vc.apellidoUsuario) AS Candidato
FROM Votacion v
JOIN Usuario vu ON v.idUsuarioVotanteFK = vu.idUsuario
JOIN PostulacionCandidato pc ON v.idPostCandidatoFK = pc.idPostCandidato
JOIN Usuario vc ON pc.idUsuarioFK = vc.idUsuario;
select * from VistaVotaciones;

/*Vista cargos de concejos*/
CREATE VIEW VistaConcejoCargo AS
SELECT 
    co.nomConcejo,
    ca.nomCargo,
    ca.estadoC
FROM Concejo co
LEFT JOIN Cargo ca ON ca.idConsejoFK = co.idConcejo;
select * from VistaConcejoCargo;

/*Vista Curso por usuario*/
CREATE VIEW VistaCursoUsu AS
SELECT 
    u.idUsuario,
    u.nombreUsuario,
    u.apellidoUsuario,
    c.nomCurso
FROM Usuario u
JOIN Curso c ON u.idCursoFK = c.idCurso;
select * from VistaCursoUsu;

/*Subconsulta de candidato con mas votos que el promedio*/
SELECT 
    idPostCandidato,
    totalvotos
FROM PostulacionCandidato
WHERE totalvotos > (SELECT AVG(totalvotos) FROM PostulacionCandidato);

/*Nombre del cargo con mayor o menor votos*/
SELECT 
    c.nomCargo
FROM Cargo c
WHERE c.idCargo = (SELECT pc.idCargoFK FROM PostulacionCandidato pc WHERE pc.totalvotos = 
					(SELECT min(totalvotos) FROM PostulacionCandidato)
);

