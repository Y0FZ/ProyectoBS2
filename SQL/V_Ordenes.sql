
CREATE VIEW v_ResumenOrdenes AS
SELECT 
    O.IdOrden,
    O.FechaCreacion,
    C.NombreCliente + ' ' + C.ApellidoCliente AS Cliente,
    A.Marca + ' ' + A.Modelo AS Equipo,
    P.NivelPrioridad AS Prioridad,
    E.Estado AS EstadoActual,
    O.Descripcion AS ProblemaReportado
FROM OrdenDiagnostico O
INNER JOIN Cliente C ON O.IdClienteD = C.IdCliente
INNER JOIN ArticuloEquipo A ON O.SerieEquipo = A.NumeroSerie
INNER JOIN Prioridad P ON O.Prioridad = P.IdPrioridad
-- Obtenemos el último estado desde la tabla Comentarios o una relación directa si la tienes
LEFT JOIN (
    SELECT IdDiagnostico, MAX(Estado) as UltimoEstado 
    FROM Comentarios 
    GROUP BY IdDiagnostico
) Ultimo ON O.IdOrden = Ultimo.IdDiagnostico
LEFT JOIN EstadoOrden E ON Ultimo.UltimoEstado = E.IdEstado;
GO