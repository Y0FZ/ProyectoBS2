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