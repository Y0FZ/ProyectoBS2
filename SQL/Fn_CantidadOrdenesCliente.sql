CREATE FUNCTION fn_CantidadOrdenesCliente
(
    @IdCliente VARCHAR(12)
)
RETURNS INT
AS
BEGIN
    DECLARE @Total INT

    SELECT @Total = COUNT(*)
    FROM OrdenDiagnostico
    WHERE IdClienteD = @IdCliente

    RETURN @Total
END
GO