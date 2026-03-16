CREATE FUNCTION fn_UltimaOrdenCliente (@IdCliente VARCHAR(12))
RETURNS INT
AS
BEGIN
    DECLARE @UltimaOrden INT;

    SELECT TOP 1 @UltimaOrden = IdOrden
    FROM OrdenDiagnostico
    WHERE IdClienteD = @IdCliente
    ORDER BY FechaCreacion DESC;

    RETURN ISNULL(@UltimaOrden, 0);
END
GO