USE master
go

--Creacion de la BD
Create database DiagnoSysBD
go

--Uso de la BD
USE DiagnoSysBD
GO

--Creacion de tabla Cliente
Create table Cliente(
IdCliente Varchar(12) not null primary key,
NombreCliente Varchar(10) not null,
ApellidoCliente Varchar(10) not null,
Telefono int not null,
Correo Varchar(20),
Direccion Varchar(20)
)
go

/*
IdCliente: Referencia a la identificacion
NombreCliente 
ApellidoCliente
Telefono 
Correo 
Direccion 
*/

--Tabla rol
Create table Rol(
IdRol int not null primary key,
NombreRol Varchar(15) not null
)
go

/*
IdRol: Numero para relacionar sencillamente el rol
NombreRol
*/

--Creacion de la tabla Usuario
Create table Usuario(
IdUsuarios Varchar(12) not null primary key,
NombreUsuario Varchar(20) not null,
Contrasena Varchar(20) not null,
IdRol int not null foreign key references Rol (IdRol)
)
go

/*
IdUsuario: Identificacion del empleado
NombreUsuario
Contrasena
IdRol
*/

--Creacion de la tabla Prioridad
Create table Prioridad(
IdPrioridad int not null primary key,
NivelPrioridad Varchar(10)
)
go

/*
IdPrioridad: Numero referencia a:
NivelPrioridad: Categoria de prioridad
ej: Urgente, Alta, Media, Baja.
*/

--Creacion de tabla ArticuloEquipo
Create table ArticuloEquipo(
NumeroSerie Varchar(30) not null primary key,
TipoEquipo Varchar(15) not null,
Marca Varchar(10) not null,
Modelo Varchar(15) not null
)
go

/*
NumeroSerie: Numero unico que identifica a un unico articulo

TipoEquipo: Categoria del Equipo:
ej en informatica: Impresora, PC, Laptop, Consola, Celular...
ej en Mecanica: Sedan, Wagon, SUV, Moto...

Marca
Modelo
*/

--Creacion de Tabla EstadoOrden
Create table EstadoOrden(
IdEstado int not null primary key,
Estado Varchar(15) not Null
)
go

/*
IdEstado: Numero de referencia para:
Estado
ej: Recibida, Pendiente, En Revicion...
*/

--Creacion de tabla OrdenDiagnostico
Create table OrdenDiagnostico(
IdOrden int not null primary key,
FechaCreacion date default getdate() not null,
Descripcion Varchar(200),
EstadoRecepcion Varchar(200),
SerieEquipo Varchar(30) not null references ArticuloEquipo (NumeroSerie),
IdClienteD Varchar(12) not null references Cliente (IdCliente),
Prioridad int not null references Prioridad (IdPrioridad)
)
go

/*
IdOrden: Numero de referencia para la orden de trabajo
FechaCreacion: fecha de recepcion del trabajo
Descripcion: descripcion del articulo
ej: color, diseno...

EstadoRecepcion: Descripcion sobre detalles que tenga el articulo
ej: Golpe en esquina, tapas con separacion anormal...

SerieEquipo: referencia a NumeroSerie de tabla ArticuloEquipo

IdClienteD: referencia a IdCliente de tabla Cliente

Prioridad: referencia a IdPrioridad de tabla Prioridad
*/

--Creacion de tabla anexos
Create table Anexos(
IdAnexos int not null primary key,
RutaArchivo Nvarchar(max)
)
go

/*
IdAnexos: Numero de guia para los Anexos
RutaArchivo: Ruta del archivo
ej: la ruta de una foto o documento referente al caso
*/

--Creacion de tabla Comentarios
Create table Comentarios(
IdComentario int not null primary key,
Comentario Varchar(100) not null,
FechaComentario date not null,
IUsuario Varchar(12) not null references Usuario (IdUsuarios),
Estado int not null references EstadoOrden (IdEstado),
IdDiagnostico int not null references OrdenDiagnostico (IdOrden),
Anexos int references Anexos (IdAnexos)
)
go

/*
IdComentario: Identificador para los comentarios
Comentario: espacio para escribir sobre el articulo

FechaComentario: fecha en la que se subio el comentario

IUsuario: Identificacion del Empleado
-Referencia IdUsuario de tabla Usuarios

Estado: Referencia al; revicion reparado...
-Referencia IdOrden de tabla EstadoOrden

IdDiagnostico: Numero de referencia para la Orden:
Guia los comentarios a esta referencia
-Referencia IdOrden de tabla OrdenDiagnostico

Anexos: Se usa para agregar los archivos
-Referencia IdAnexos de la tabla Anexos
*/

--Integracion de datos a tabla

--
insert into Cliente values
('208460900', 'Yeremy', 'Fernandez', 87610820, '','')
go

insert into Rol values
(1, 'Recepcion'),
(2, 'Administrador'),
(3, 'Tecnico')
go

insert into Usuario values
('IND', 'Indiana', '12345', 2)
go

insert into Usuario values
('YFZ', 'Yeremy', '123', 3)
go

insert into Prioridad values
(1, 'Alta'),
(2, 'Estandar'),
(3, 'Baja')
go

insert into ArticuloEquipo values
('AABB12', 'Laptop', 'HP', 'Pavilion')
go

insert into EstadoOrden values
(1, 'Recibida'),
(2, 'Pendiente'),
(3, 'En Revicion'),
(4, 'En Espera'),
(5, 'En reparacion'),
(6, 'Reparado'),
(7, 'Entregado')
go

insert into OrdenDiagnostico values
(1,'2026-01-10', 'Muy lenta',
'Color azul, con cargador, esta rayado en x lugar', 'AABB12',
'208460900', 2)
go

insert into Anexos values
(1, 'C:\Users\YereF\Downloads\mt03.avif')
go

insert into Comentarios values
(1, 'Se recomienda cambio de memoria', '2026-01-13', 'IND', 4, 1, 1)
go

----------------------------------------------

--Tabla para auditoria de clientes

CREATE TABLE Auditoria_Clientes (
    IdAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    IdCliente Varchar(12) NOT NULL foreign key references Cliente (IdCliente),
    CampoModificado VARCHAR(50),
    ValorAnterior VARCHAR(MAX),
    ValorNuevo VARCHAR(MAX),
    UsuarioModifica Varchar(12) NOT NULL foreign key references Usuario (IdUsuarios),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    Accion VARCHAR(10)
)
GO

--Auditoria Usuarios
CREATE TABLE Auditoria_Usuarios (
    IdAuditoria INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuarioAfectado Varchar(12) NOT NULL foreign key references Usuario (IdUsuarios),
    CampoModificado VARCHAR(50),
    ValorAnterior VARCHAR(MAX),
    ValorNuevo VARCHAR(MAX),
    UsuarioQueModifico Varchar(12) NOT NULL foreign key references Usuario (IdUsuarios),
    FechaModificacion DATETIME DEFAULT GETDATE(),
    Accion VARCHAR(10)
)
GO

--Vistas de Tablas 
select * from Cliente; 
select * from Rol; 
select * from Usuario; 
select * from Prioridad; 
select * from ArticuloEquipo; 
select * from OrdenDiagnostico; 
select * from Anexos; 
select * from Comentarios; 
select * from EstadoOrden;

