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