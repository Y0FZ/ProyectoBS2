--Tabla OrdenDiagnostico
--Procedimiento almacenado

--Adicion de datos
Create PROCEDURE sp_IgresarOrdenDiagnostico (@InOrden int, @FechaCreacion date, @Descripcion varchar(100), @EstadoRecepcion varchar(50), @SerieEquipo varchar (30), @IdClienteD varchar (12), @Prioridad int)

as
	if((@InOrden=null) or (@FechaCreacion='') or (@Descripcion='') or (@EstadoRecepcion='') or (@SerieEquipo='') or (@IdClienteD='') or (@Prioridad=''))
		BEGIN
			Print 'INGRESO DE DATOS INCOMPLETO'
			return
		END
	else
		BEGIN
			If not exists (select InOrden from OrdenDiagnostico where @InOrden = @InOrden)

		BEGIN
			Insert into OrdenDiagnostico(IdOrden, FechaCreacion, Descripcion, EstadoRecepcion, SerieEquipo, IdClienteD, Prioridad)

			Values(@InOrden, @FechaCreacion, @Descripcion,@EstadoRecepcion, @SerieEquipo,@IdClienteD, @Prioridad)

			Print 'DATOS INGRESADOS'

		END
	else
		BEGIN
			If exists (select IdOrden from OrdenDiagnostico where IdOrden = @InOrden)
			BEGIN
				Print 'DATOS DUPLICADOS'
			END
		END
	END
GO


--Modificacion de datos

CREATE PROCEDURE sp_ModificarOrdenDiagnostico (
    @InOrden int, 
    @FechaCreacion date, 
    @Descripcion varchar(100), 
    @EstadoRecepcion varchar(50), 
    @SerieEquipo varchar(30), 
    @IdClienteD varchar(12), 
    @Prioridad int
)
AS
BEGIN
    -- 1. Validación de nulos y vacíos (Corregido el uso de IS NULL)
    IF (@InOrden IS NULL OR @FechaCreacion IS NULL OR @SerieEquipo = '' OR @IdClienteD = '')
    BEGIN
        PRINT 'INGRESO DE DATOS INCOMPLETO'
        RETURN
    END

    -- 2. Verificar si la Orden existe
    IF NOT EXISTS (SELECT 1 FROM OrdenDiagnostico WHERE IdOrden = @InOrden)
    BEGIN
        PRINT 'DATOS NO REGISTRADOS (LA ORDEN NO EXISTE)'
    END
    ELSE
    BEGIN
        -- 3. Actualizar la tabla OrdenDiagnostico
        -- Nota: Solo actualizamos esta tabla, ya que es el propósito del SP
        UPDATE OrdenDiagnostico 
        SET FechaCreacion = @FechaCreacion,
            Descripcion = @Descripcion,
            EstadoRecepcion = @EstadoRecepcion,
            SerieEquipo = @SerieEquipo,
            IdClienteD = @IdClienteD,
            Prioridad = @Prioridad
        WHERE IdOrden = @InOrden

        PRINT 'ACTUALIZACION DE ORDEN COMPLETA'
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