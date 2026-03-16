CREATE TRIGGER tr_UsuarioAuditoria
ON Usuario
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO Auditoria_Usuarios (IdUsuarioAfectado, CampoModificado, ValorAnterior, ValorNuevo, UsuarioQueModifico, Accion)
    SELECT 
        i.IdUsuarios,
        CASE 
            WHEN i.NombreUsuario <> d.NombreUsuario THEN 'NombreUsuario'
            WHEN i.Contrasena <> d.Contrasena THEN 'Contrasena'
            WHEN i.IdRol <> d.IdRol THEN 'IdRol'
        END,
        CASE 
            WHEN i.NombreUsuario <> d.NombreUsuario THEN d.NombreUsuario
            WHEN i.Contrasena <> d.Contrasena THEN '********' -- No guardar claves viejas
            WHEN i.IdRol <> d.IdRol THEN CAST(d.IdRol AS VARCHAR)
        END,
        CASE 
            WHEN i.NombreUsuario <> d.NombreUsuario THEN i.NombreUsuario
            WHEN i.Contrasena <> d.Contrasena THEN '********' -- No guardar claves nuevas
            WHEN i.IdRol <> d.IdRol THEN CAST(i.IdRol AS VARCHAR)
        END,
        'yere', 
        'UPDATE'
    FROM inserted i
    JOIN deleted d ON i.IdUsuarios = d.IdUsuarios
    WHERE i.NombreUsuario <> d.NombreUsuario 
       OR i.Contrasena <> d.Contrasena
       OR i.IdRol <> d.IdRol;
END
GO