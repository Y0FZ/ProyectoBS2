--Tabla Anexos
--Procedimiento almacenado

--Adicion de datos

Create PROCEDURE sp_IngresarAnexo (@IdAnexo int, @NombreAnexo varchar(50))

as
	if((@IdAnexo='') or (@NombreAnexo=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdAnexo from Anexos where IdAnexo = @IdAnexo)

		BEGIN
			Insert into Anexos(IdAnexo, NombreAnexo)

			Values(@IdAnexo, @NombreAnexo)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select IdAnexo from Anexos where IdAnexo = @IdAnexo)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO

--Modificacion de datos

Create PROCEDURE sp_ModificarAnexo (@IdAnexo int, @NombreAnexo varchar(50))

as
	if((@IdAnexo='') or (@NombreAnexo=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select IdAnexo from Anexos where IdAnexo = @IdAnexo)

			BEGIN
				PRINT 'DATOS NO REGISTRADOS'
			END
		else
			
			BEGIN
				if exists (select IdAnexo from Anexos where IdAnexo = @IdAnexo)
				BEGIN
					update Anexos set NombreAnexo = @NombreAnexo
					
					Print 'ACTUALIZACION COMPLETA'
				END
			END
		END
GO
--Borrar datos
Create PROCEDURE sp_BorrarAnexo (@IdAnexo int)

as
	if((@IdAnexo=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN

			if not exists (select IdAnexo from Anexos where IdAnexo = @IdAnexo)
				
				BEGIN
					Print 'DATOS NO REGISTRADOS'	
		END
	else
		BEGIN
			If exists (select IdAnexo from Anexos where IdAnexo = @IdAnexo)
			
			BEGIN
				delete from Anexos where IdAnexo = @IdAnexo
				Print 'DATOS ELIMINADOS'
			END
		END
	END
GO
--Buscar datos
Create PROCEDURE sp_BuscarAnexo (@IdAnexo int)
as
	if((@IdAnexo = null))
	
		BEGIN
			Print 'DATOS NO INGRESADOS'
		END

	else
		
		BEGIN
			If exists (select IdAnexo from Anexos where IdAnexo = @IdAnexo)
				BEGIN
					Select	IdAnexo, NombreAnexo From Anexos where IdAnexo= @IdAnexo
				END
		END	
GO
--------------------------------------------------------------------
