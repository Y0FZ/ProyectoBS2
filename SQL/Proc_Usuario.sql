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