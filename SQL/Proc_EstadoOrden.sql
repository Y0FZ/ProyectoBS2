--Tabla Comentarios
--Procedimiento almacenado

--Adicion de datos

CREATE PROCEDURE sp_IngresarEstadoOrden (@IdEstado int, @Estado Varchar(15))
AS
BEGIN
    IF((@IdEstado IS NULL) OR (@Estado=''))
    BEGIN
        PRINT 'INGRESO DE DATOS INCOMPLETO'
        RETURN
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT IdEstado FROM EstadoOrden WHERE IdEstado = @IdEstado)
        BEGIN
            INSERT INTO EstadoOrden(IdEstado, Estado)
            VALUES(@IdEstado, @Estado)
            PRINT 'DATOS INGRESADOS'
        END
        ELSE
        BEGIN
            PRINT 'DATOS DUPLICADOS'
        END
    END
END
GO

--Modificacion de datos

CREATE PROCEDURE sp_ModificarEstadoOrden (@IdEstado int, @Estado Varchar(15))
AS
BEGIN
    IF((@IdEstado IS NULL) OR (@Estado=''))
    BEGIN
        PRINT 'INGRESO DE DATOS INCOMPLETO'
        RETURN
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT IdEstado FROM EstadoOrden WHERE IdEstado = @IdEstado)
        BEGIN
            PRINT 'DATOS NO REGISTRADOS'
        END
        ELSE
        BEGIN
            UPDATE EstadoOrden SET Estado = @Estado WHERE IdEstado = @IdEstado
            PRINT 'ACTUALIZACION COMPLETA'
        END
    END
END
GO

--Borrar datos

CREATE PROCEDURE sp_BorrarEstadoOrden (@IdEstado int)
AS
BEGIN
    IF(@IdEstado IS NULL)
    BEGIN
        PRINT 'INGRESO DE DATOS INCOMPLETO'
        RETURN
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT IdEstado FROM EstadoOrden WHERE IdEstado = @IdEstado)
        BEGIN
            PRINT 'DATOS NO REGISTRADOS'
        END
        ELSE
        BEGIN
            DELETE FROM EstadoOrden WHERE IdEstado = @IdEstado
            PRINT 'DATOS ELIMINADOS'
        END
    END
END
GO

--Buscar datos
CREATE PROCEDURE sp_BuscarEstadoOrden (@IdEstado int)
AS
BEGIN
    IF(@IdEstado IS NULL)
    BEGIN
        PRINT 'DATOS NO INGRESADOS'
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT IdEstado FROM EstadoOrden WHERE IdEstado = @IdEstado)
        BEGIN
            SELECT IdEstado, Estado FROM EstadoOrden WHERE IdEstado = @IdEstado
        END
        ELSE
        BEGIN
            PRINT 'ESTADO NO ENCONTRADO'
        END
    END
END

------------------- ------------------------------------------------
