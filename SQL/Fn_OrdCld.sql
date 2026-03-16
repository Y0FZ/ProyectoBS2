
CREATE FUNCTION fn_ContarOrdenesPorCliente (@IdCliente Varchar(12))
RETURNS INT
AS
BEGIN
    DECLARE @Total INT;
    SELECT @Total = COUNT(*) 
    FROM OrdenDiagnostico 
    WHERE IdClienteD = @IdCliente;
    
    RETURN ISNULL(@Total, 0);
END
GO