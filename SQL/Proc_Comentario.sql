--Tabla EstadoOrden
--Procedimiento almacenado

--Adicion de datos

CREATE PROCEDURE sp_IngresarComentario (
    @IdComentario int, 
    @Comentario Varchar(100), 
    @FechaComentario date, 
    @IUsuario Varchar(12), 
    @Estado int, 
    @IdDiagnostico int, 
    @Anexos int
)
AS
BEGIN
    IF((@IdComentario IS NULL) OR (@Comentario='') OR (@IUsuario='') OR (@Estado IS NULL) OR (@IdDiagnostico IS NULL))
    BEGIN
        PRINT 'INGRESO DE DATOS INCOMPLETO'
        RETURN
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT IdComentario FROM Comentarios WHERE IdComentario = @IdComentario)
        BEGIN
            INSERT INTO Comentarios(IdComentario, Comentario, FechaComentario, IUsuario, Estado, IdDiagnostico, Anexos)
            VALUES(@IdComentario, @Comentario, @FechaComentario, @IUsuario, @Estado, @IdDiagnostico, @Anexos)
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

CREATE PROCEDURE sp_ModificarComentario (
    @IdComentario int, 
    @Comentario Varchar(100), 
    @FechaComentario date, 
    @IUsuario Varchar(12), 
    @Estado int, 
    @IdDiagnostico int, 
    @Anexos int
)
AS
BEGIN
    IF((@IdComentario IS NULL) OR (@Comentario='') OR (@IUsuario=''))
    BEGIN
        PRINT 'INGRESO DE DATOS INCOMPLETO'
        RETURN
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT IdComentario FROM Comentarios WHERE IdComentario = @IdComentario)
        BEGIN
            PRINT 'DATOS NO REGISTRADOS'
        END
        ELSE
        BEGIN
            UPDATE Comentarios 
            SET Comentario = @Comentario,
                FechaComentario = @FechaComentario,
                IUsuario = @IUsuario,
                Estado = @Estado,
                IdDiagnostico = @IdDiagnostico,
                Anexos = @Anexos
            WHERE IdComentario = @IdComentario
            PRINT 'ACTUALIZACION COMPLETA'
        END
    END
END
GO

--Borrar datos

CREATE PROCEDURE sp_BorrarComentario (@IdComentario int)
AS
BEGIN
    IF(@IdComentario IS NULL)
    BEGIN
        PRINT 'INGRESO DE DATOS INCOMPLETO'
        RETURN
    END
    ELSE
    BEGIN
        IF NOT EXISTS (SELECT IdComentario FROM Comentarios WHERE IdComentario = @IdComentario)
        BEGIN
            PRINT 'DATOS NO REGISTRADOS'
        END
        ELSE
        BEGIN
            DELETE FROM Comentarios WHERE IdComentario = @IdComentario
            PRINT 'DATOS ELIMINADOS'
        END
    END
END
GO

--Buscar datos

CREATE PROCEDURE sp_BuscarComentario (@IdComentario int)
AS
BEGIN
    IF(@IdComentario IS NULL)
    BEGIN
        PRINT 'DATOS NO INGRESADOS'
    END
    ELSE
    BEGIN
        IF EXISTS (SELECT IdComentario FROM Comentarios WHERE IdComentario = @IdComentario)
        BEGIN
            SELECT IdComentario, Comentario, FechaComentario, IUsuario, Estado, IdDiagnostico, Anexos 
            FROM Comentarios WHERE IdComentario = @IdComentario
        END
        ELSE
        BEGIN
            PRINT 'COMENTARIO NO ENCONTRADO'
        END
    END
END
GO

---------------------------------------------------------------------