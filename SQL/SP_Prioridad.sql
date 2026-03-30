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