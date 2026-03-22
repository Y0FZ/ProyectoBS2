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