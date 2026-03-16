--PERMISOS ROL RECEPCION
GRANT SELECT ON Cliente TO RolRecepcion;
GRANT SELECT, INSERT ON OrdenDiagnostico TO RolRecepcion;
GRANT SELECT, INSERT ON Comentarios TO RolRecepcion;
GO