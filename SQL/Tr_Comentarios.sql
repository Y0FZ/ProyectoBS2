CREATE TRIGGER tr_FechaAutomaticaComentario
ON Comentarios
AFTER INSERT
AS
BEGIN
    UPDATE Comentarios
    SET FechaComentario = GETDATE()
    FROM Comentarios C
    INNER JOIN inserted I
    ON C.IdComentario = I.IdComentario
END
GO
