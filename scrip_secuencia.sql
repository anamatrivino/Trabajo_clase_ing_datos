CREATE DATABASE movilidad;

USE movilidad;

CREATE TABLE Automovil(
	idAutomovil int auto_increment primary key,
    serialChasis int unique not null,
    marca varchar(50) not null,
    modelo varchar(50) not null,
    placa varchar(50) not null,
    tipos varchar(50) not null,
    anioFabricacion int ,
    pasajeros int,
    cilindraje int,
    codigoFK int
);

CREATE TABLE Aseguramiento(
	codigo int auto_increment primary key,
    fechaInicio date not null,
    fechaExpiracion date not null,
    estado varchar(50) not null,
    valorAsegurado int default 0,
    costo int,
    idCompaniaFK int
);

CREATE TABLE Compania(
	idCompania int auto_increment primary key,
    NIT int,
    nombre varchar (50) not null,
    fechaFundacion date not null,
    representanteLegal varchar(50) not null
);

CREATE TABLE Accidente(
	idAccidente int auto_increment primary key,
    automotores varchar(50) not null,
    fatalidades varchar(50) not null,
    heridos int,
    lugar varchar(50) not null,
    fechaAccidente date not null
);

CREATE TABLE Involucracion(
	codigoInvolucracion int auto_increment primary key,
    serialChasisFK int,
    idAutomovilFK int,
    idAccidenteFK int
);

alter table Involucracion add constraint FKidAutomovil foreign key (idAutomovilFK) references Automovil (idAutomovil);
alter table Involucracion add constraint FKserialChasis foreign key (serialChasisFK) references Automovil (serialChasis);
alter table Involucracion add constraint FKidaccidente foreign key (idaccidenteFK) references Accidente (idAccidente);
alter table Automovil add constraint FKcodigo foreign key (codigoFK) references Aseguramiento (codigo);
alter table Aseguramiento add constraint FKidCompania foreign key (idCompaniaFK) references Compania (idCompania);

