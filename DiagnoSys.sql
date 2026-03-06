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
Descripcion Varchar(100),
EstadoRecepcion Varchar(50),
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
--Procedimiento almacenado--

--Tabla clientes
--Adicion de datos

Create PROCEDURE sp_IngresarCliente (@IdCliente Varchar(12), @NombreCliente Varchar(10),
@ApellidoCliente Varchar(10), @Telefono int, @Correo Varchar(20), @Direccion Varchar(20))

as
	if((@IdCliente='') or (@NombreCliente='') or (@ApellidoCliente='') or
	(@Telefono=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdCliente from Cliente where IdCliente = @IdCliente)

		BEGIN
			Insert into Cliente(IdCliente, NombreCliente, ApellidoCliente, Telefono, Correo, Direccion)

			Values(@IdCLiente, @NombreCliente, @ApellidoCliente, @Telefono, @Correo, @Direccion)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select IdCliente from Cliente where IdCliente = @IdCliente)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO
	
--Modificar

Create PROCEDURE sp_ModificarCliente (@IdCliente Varchar(12), @NombreCliente Varchar(10),
@ApellidoCliente Varchar(10), @Telefono int, @Correo Varchar(20), @Direccion Varchar(20))

as
	if((@IdCliente='') or (@NombreCliente='') or (@ApellidoCliente='') or
	(@Telefono=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdCliente from Cliente where IdCliente = @IdCliente)

			BEGIN
				PRINT 'DATOS NO REGISTRADOS'
			END
		else
			
			BEGIN
				if exists (select IdCliente from Cliente where IdCliente = @IdCliente
															and ApellidoCliente = @ApellidoCliente
															and Telefono = @Telefono
															and Correo = @Correo
															and Direccion = @Direccion)
				BEGIN
					update Cliente set NombreCliente = @NombreCliente,
										ApellidoCliente = @ApellidoCliente,
										Telefono = @Telefono,
										Correo = @Correo,
										Direccion = @Direccion
					Print 'ACTUALIZACION COMPLETA'
				END
			END
		END
GO

--Borrar
Create PROCEDURE sp_BorrarCliente (@IdCliente Varchar(12))

as
	if((@IdCliente=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN

			if not exists (select IdCliente from Cliente where IdCliente = @IdCliente)
				
				BEGIN
					Print 'DATOS NO REGISTRADOS'	
		END
	else
		BEGIN
			If exists (select IdCliente from Cliente where IdCliente = @IdCliente)
			
			BEGIN
				delete from Cliente where IdCliente = @IdCliente
				Print 'DATOS ELIMINADOS'
			END
		END
	END
GO

--Buscar

Create PROCEDURE sp_BuscarCliente (@IdCliente Varchar(12))
as
	if((@IdCliente = null))
	
		BEGIN
			Print 'DATOS NO INGRESADOS'
		END

	else
		
		BEGIN
			If exists (select IdCliente from Cliente where IdCliente = @IdCliente)
				BEGIN
					Select	IdCliente, NombreCliente, ApellidoCliente, Telefono,
					Correo, Direccion From Cliente where IdCliente = @IdCliente
				END
		END	
go

-------------------------------------------------------------------
--Tabla Rol
--Procedimiento almacenado

--Adicion de datos
Create PROCEDURE sp_IgresarRol (@IdRol int, @NombreRol Varchar(15))

as
	if((@IdRol='') or (@NombreRol='') )
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdRol from Rol where IdRol = @IdRol)

		BEGIN
			Insert into Rol(IdRol, NombreRol)

			Values(@IdRol, @NombreRol)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select IdRol from Rol where IdRol = @IdRol)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO

--Modificacion de datos

Create PROCEDURE sp_ModificarRol (@IdRol int, @NombreRol Varchar(15))

as
	if((@IdRol='') or (@NombreRol=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdRol from Rol where IdRol = @IdRol)

			BEGIN
				PRINT 'DATOS NO REGISTRADOS'
			END
		else
			
			BEGIN
				if exists (select IdRol from Rol where IdRol = @IdRol)
				BEGIN
					update Rol set NombreRol = @NombreRol
					
					Print 'ACTUALIZACION COMPLETA'
				END
			END
		END
GO

--Borrar datos

Create PROCEDURE sp_BorrarRol (@IdRol int)

as
	if((@IdRol=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN

			if not exists (select IdRol from Rol where IdRol = @IdRol)
				
				BEGIN
					Print 'DATOS NO REGISTRADOS'	
		END
	else
		BEGIN
			If exists (select IdRol from Rol where IdRol = @IdRol)
			
			BEGIN
				delete from Rol where IdRol = @IdRol
				Print 'DATOS ELIMINADOS'
			END
		END
	END
GO


--Buscar datos

Create PROCEDURE sp_BuscarRol (@IdRol int)
as
	if((@IdRol = null))
	
		BEGIN
			Print 'DATOS NO INGRESADOS'
		END

	else
		
		BEGIN
			If exists (select IdRol from Rol where IdRol = @IdRol)
				BEGIN
					Select	IdRol, NombreRol From Rol where IdRol = @IdRol
				END
		END	
go

------------------------------------------------------------------
--Tabla Usuario
--Procedimiento almacenado

--Adicion de datos
Create PROCEDURE sp_IgresarUsuario (@IdUsuarios varchar(12), @NombreUsuario Varchar(20), @Contrasena varchar(20))

as
	if((@IdUsuarios='') or (@NombreUsuario='') or (@Contrasena=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdUsuarios from Usuario where IdUsuarios = @IdUsuarios)
			
		BEGIN
			Insert into Usuario(IdUsuarios, NombreUsuario, Contrasena)

			Values(@IdUsuarios, @NombreUsuario,@Contrasena)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select IdUsuarios from Usuario where IdUsuarios = @IdUsuarios)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO

--Modificacion de datos

Create PROCEDURE sp_ModificarUsuarios (@IdUsuarios Varchar(12), @NombreUsuario Varchar(20),
@Contrasena Varchar(20))

as
	if((@IdUsuarios='') or (@NombreUsuario='') or (@Contrasena='') )
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdUsuarios from Usuario where IdUsuarios = @IdUsuarios)

			BEGIN
				PRINT 'DATOS NO REGISTRADOS'
			END
		else
			
			BEGIN
				if exists (select IdUsuarios from Usuario where IdUsuarios = @IdUsuarios
															and NombreUsuario = @NombreUsuario
															and Contrasena = @Contrasena
														)
				BEGIN
					update Usuario set NombreUsuario = @NombreUsuario,
										Contrasena = @Contrasena
										
					Print 'ACTUALIZACION COMPLETA'
				END
			END
		END
GO


--Borrar datos

Create PROCEDURE sp_BorrarUsuario (@IdUsuarios Varchar(12))

as
	if((@IdUsuarios=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN

			if not exists (select IdUsuarios from Usuario where IdUsuarios = @IdUsuarios)
				
				BEGIN
					Print 'DATOS NO REGISTRADOS'	
		END
	else
		BEGIN
			If exists (select IdUsuarios from Usuario where IdUsuarios = @IdUsuarios)
			
			BEGIN
				delete from Usuario where IdUsuarios = @IdUsuarios
				Print 'DATOS ELIMINADOS'
			END
		END
	END
GO

--Buscar datos
Create PROCEDURE sp_BuscarUsuario (@IdUsuarios Varchar(12))
as
	if((@IdUsuarios = null))
	
		BEGIN
			Print 'DATOS NO INGRESADOS'
		END

	else
		
		BEGIN
			If exists (select IdUsuarios from Usuario where IdUsuarios= @IdUsuarios)
				BEGIN
					Select	IdUsuarios, NombreUsuario, Contrasena From Usuario where IdUsuarios = @IdUsuarios
				END
		END	
go


-----------------------------------------------------------------
--Tabla Prioridad 
--Procedimiento almacenado

--Adicion de datos
Create PROCEDURE sp_IgresarPrioridad (@IdPrioridad int, @NivelPrioridad Varchar(10))

as
	if((@IdPrioridad='') or (@NivelPrioridad='') )
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdPrioridad from Prioridad where IdPrioridad = @IdPrioridad)

		BEGIN
			Insert into Prioridad(IdPrioridad, NivelPrioridad)

			Values(@IdPrioridad, @NivelPrioridad)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select IdPrioridad from Prioridad where IdPrioridad = @IdPrioridad)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO

--Modificacion de datos

Create PROCEDURE sp_ModificarPrioridad (@IdPrioridad int, @NivelPrioridad Varchar(10))

as
	if((@IdPrioridad='') or (@NivelPrioridad=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdPrioridad from Prioridad where IdPrioridad = @IdPrioridad)

			BEGIN
				PRINT 'DATOS NO REGISTRADOS'
			END
		else
			
			BEGIN
				if exists (select IdPrioridad from Prioridad where IdPrioridad = @IdPrioridad)
				BEGIN
					update Prioridad set NivelPrioridad = @NivelPrioridad
					
					Print 'ACTUALIZACION COMPLETA'
				END
			END
		END
GO

--Borrar datos

Create PROCEDURE sp_BorrarPrioridad (@IdPrioridad int)

as
	if((@IdPrioridad=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN

			if not exists (select IdPrioridad from Prioridad where IdPrioridad = @IdPrioridad)
				
				BEGIN
					Print 'DATOS NO REGISTRADOS'	
		END
	else
		BEGIN
			If exists (select IdPrioridad from Prioridad where IdPrioridad = @IdPrioridad)
			
			BEGIN
				delete from Prioridad where IdPrioridad = @IdPrioridad
				Print 'DATOS ELIMINADOS'
			END
		END
	END
GO


--Buscar datos

Create PROCEDURE sp_BuscarPrioridad (@IdPrioridad int)
as
	if((@IdPrioridad = null))
	
		BEGIN
			Print 'DATOS NO INGRESADOS'
		END

	else
		
		BEGIN
			If exists (select IdPrioridad from Prioridad where IdPrioridad = @IdPrioridad)
				BEGIN
					Select	IdPrioridad, NivelPrioridad From Prioridad where IdPrioridad= @IdPrioridad
				END
		END	
go

-------------------------------------------------------------------
--Tabla ArticuloEquipo
--Procedimiento almacenado

--Adicion de datos
Create PROCEDURE sp_IgresarArticuloEquipo (@NumeroSerie varchar(30), @TipoEquipo Varchar(15), @Marca varchar(10), @Modelo varchar(15))

as
	if((@NumeroSerie='') or (@TipoEquipo='') or (@Marca='') or (@Modelo='') )
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select @NumeroSerie from ArticuloEquipo where NumeroSerie = @NumeroSerie)

		BEGIN
			Insert into ArticuloEquipo(NumeroSerie, TipoEquipo, Marca, Modelo)

			Values(@NumeroSerie, @TipoEquipo, @Marca,@Modelo)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select @NumeroSerie from ArticuloEquipo where NumeroSerie = @NumeroSerie)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO


--Modificacion de datos

Create PROCEDURE sp_ModificarArticuloEquipo (@NumeroSerie varchar (30), @TipoEquipo varchar (15), @Marca varchar (10), @Modelo varchar (15))

as
	if((@NumeroSerie='') or (@TipoEquipo='') or (@Marca='') or (@Modelo=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select NumeroSerie from ArticuloEquipo where NumeroSerie = @NumeroSerie)

			BEGIN
				PRINT 'DATOS NO REGISTRADOS'
			END
		else
			
			BEGIN
				if exists (select NumeroSerie from ArticuloEquipo where NumeroSerie = @NumeroSerie)
				BEGIN
					update ArticuloEquipo set NumeroSerie = @NumeroSerie,
											  TipoEquipo = @TipoEquipo,
											  Marca = @Marca, 
											  Modelo = @Modelo
					
					Print 'ACTUALIZACION COMPLETA'
				END
			END
		END
GO


--Borrar datos

Create PROCEDURE sp_BorrarArticuloEquipo (@NumeroSerie varchar (30))

as
	if((@NumeroSerie=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN

			if not exists (select @NumeroSerie from ArticuloEquipo where NumeroSerie = @NumeroSerie)
				
				BEGIN
					Print 'DATOS NO REGISTRADOS'	
		END
	else
		BEGIN
			If exists (select NumeroSerie from ArticuloEquipo where NumeroSerie = @NumeroSerie)
			
			BEGIN
				delete from ArticuloEquipo where NumeroSerie = @NumeroSerie
				Print 'DATOS ELIMINADOS'
			END
		END
	END
GO


--Buscar datos
Create PROCEDURE sp_BuscarArticuloEquipo (@NumeroSerie varchar (30))
as
	if((@NumeroSerie = null))
	
		BEGIN
			Print 'DATOS NO INGRESADOS'
		END

	else
		
		BEGIN
			If exists (select NumeroSerie from ArticuloEquipo where NumeroSerie = @NumeroSerie)
				BEGIN
					Select	NumeroSerie, TipoEquipo, Marca, Modelo From ArticuloEquipo where NumeroSerie= @NumeroSerie
				END
		END	
go


-------------------------------------------------------------------
--Tabla OrdenDiagnostico
--Procedimiento almacenado

--Adicion de datos
Create PROCEDURE sp_IgresarOrdenDiagnostico (@IdOrden int, @FechaCreacion date, @Descripcion varchar(100), @EstadoRecepcion varchar(50), @SerieEquipo varchar (30), @IdClienteD varchar (12), @Prioridad int)

as
	if((@IdOrden=null) or (@FechaCreacion='') or (@Descripcion='') or (@EstadoRecepcion='') or (@SerieEquipo='') or (@IdClienteD='') or (@Prioridad=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdOrden from OrdenDiagnostico where @IdOrden = @IdOrden)

		BEGIN
			Insert into OrdenDiagnostico(IdOrden, FechaCreacion, Descripcion, EstadoRecepcion, SerieEquipo, IdClienteD, Prioridad)

			Values(@IdOrden, @FechaCreacion, @Descripcion,@EstadoRecepcion, @SerieEquipo,@IdClienteD, @Prioridad)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select IdOrden from OrdenDiagnostico where IdOrden = @IdOrden)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO


--Modificacion de datos

Create PROCEDURE sp_ModificarOrdenDiagnostico (@IdOrden int, @FechaCreacion date, @Descripcion varchar(100), @EstadoRecepcion varchar(50), @SerieEquipo varchar (30), @IdClienteD varchar (12), @Prioridad int)

as
	if((@IdOrden=null) or (@FechaCreacion='') or (@Descripcion='') or (@EstadoRecepcion='') or (@SerieEquipo='') or (@IdClienteD='') or (@Prioridad=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select Idorden from OrdenDiagnostico where IdOrden = @IdOrden)

			BEGIN
				PRINT 'DATOS NO REGISTRADOS'
			END
		else
			
			BEGIN
				if exists (select @IdOrden from OrdenDiagnostico where IdOrden = @IdOrden)
				BEGIN
					update OrdenDiagnostico set IdOrden = @IdOrden, 
												FechaCreacion = @FechaCreacion, 
												Descripcion = @Descripcion,
												EstadoRecepcion = @EstadoRecepcion,
												SerieEquipo = @SerieEquipo,
												IdClienteD = @IdClienteD,
												Prioridad = @Prioridad
											
					
					Print 'ACTUALIZACION COMPLETA'
				END
			END
		END
GO


--Borrar datos

Create PROCEDURE sp_BorrarOrdenDiagnostico (@IdOrden int)

as
	if((@IdOrden=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN

			if not exists (select @IdOrden from OrdenDiagnostico where Idorden = @IdOrden)
				
				BEGIN
					Print 'DATOS NO REGISTRADOS'	
		END
	else
		BEGIN
			If exists (select @IdOrden from OrdenDiagnostico where IdOrden = @IdOrden)
			
			BEGIN
				delete from OrdenDiagnostico where IdOrden = @IdOrden
				Print 'DATOS ELIMINADOS'
			END
		END
	END
GO


--Buscar datos
Create PROCEDURE sp_BuscarOrdenDiagnostico (@IdOrden int)
as
	if((@IdOrden = null))
	
		BEGIN
			Print 'DATOS NO INGRESADOS'
		END

	else
		
		BEGIN
			If exists (select IdOrden from OrdenDiagnostico where IdOrden = @IdOrden)
				BEGIN
					Select	IdOrden, FechaCreacion, Descripcion, EstadoRecepcion, SerieEquipo, IdClienteD, Prioridad From OrdenDiagnostico where IdOrden= @IdOrden
				END
		END	
go

-------------------------------------------------------------------
--Tabla Anexos
--Procedimiento almacenado

--Adicion de datos

--Modificacion de datos

--Borrar datos

--Buscar datos

--------------------------------------------------------------------
--Tabla Comentarios
--Procedimiento almacenado

--Adicion de datos

--Modificacion de datos

--Borrar datos

--Buscar datos

------------------- ------------------------------------------------
--Tabla EstadoOrden
--Procedimiento almacenado

--Adicion de datos

--Modificacion de datos

--Borrar datos

--Buscar datos


---------------------------------------------------------------------
/*
Create Trigger tr_ClienteAuditoria
on Cliente
after update
as
begin
	set nocount on;

	insert into Cliente
	(IdCliente, NombreCliente, ApellidoCliente, Telefono, Correo, Direccion)
	select
	d.Idcliente,
		case
			when i.


--Vistas de Tablas 
select * from Cliente; */
select * from Rol; 
select * from Usuario; 
select * from Prioridad; 
select * from ArticuloEquipo; 
select * from OrdenDiagnostico; 
select * from Anexos; 
select * from Comentarios; 
select * from EstadoOrden;

