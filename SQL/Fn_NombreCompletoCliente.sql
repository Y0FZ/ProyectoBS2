CREATE FUNCTION fn_NombreCompletoCliente
(
    @IdCliente VARCHAR(12)
)
RETURNS VARCHAR(50)
AS
BEGIN
    DECLARE @NombreCompleto VARCHAR(50)

    SELECT @NombreCompleto = NombreCliente + ' ' + ApellidoCliente
    FROM Cliente
    WHERE IdCliente = @IdCliente

    RETURN @NombreCompleto
END
GO