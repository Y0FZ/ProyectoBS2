CREATE TRIGGER tr_OrdenDiagnostico
ON OrdenDiagnostico
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Comentarios (
        IdComentario,
        Comentario,
        FechaComentario,
        IUsuario,
        Estado,
        IdDiagnostico
    )
    SELECT 
        (SELECT ISNULL(MAX(IdComentario),0) + 1 FROM Comentarios),
        'Orden registrada en el sistema',
        GETDATE(),
        'ADMIN',
        1,
        i.IdOrden
    FROM inserted i;
END
GO
