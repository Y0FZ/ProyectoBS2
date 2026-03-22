CREATE FUNCTION fn_ObtenerPrioridadOrden
(
    @IdOrden INT
)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @Prioridad VARCHAR(20)

    SELECT @Prioridad = NivelPrioridad
    FROM OrdenDiagnostico O
    INNER JOIN Prioridad P
    ON O.Prioridad = P.IdPrioridad
    WHERE O.IdOrden = @IdOrden

    RETURN @Prioridad
END
GO