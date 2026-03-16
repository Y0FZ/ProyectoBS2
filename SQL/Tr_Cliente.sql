CREATE PROCEDURE sp_BuscarAuditoriaCliente (@IdCliente Varchar(12))
AS
BEGIN
    IF(@IdCliente IS NULL OR @IdCliente = '')
    BEGIN
        PRINT 'DATOS NO INGRESADOS'
    END
    ELSE
    BEGIN
        SELECT 
            A.FechaModificacion,
            U.NombreUsuario AS Tecnico,
            A.CampoModificado,
            A.ValorAnterior,
            A.ValorNuevo
        FROM Auditoria_Clientes A
        INNER JOIN Usuario U ON A.UsuarioModifica = U.IdUsuarios
        WHERE A.IdCliente = @IdCliente
        ORDER BY A.FechaModificacion DESC
    END
END
GO