--ASIGNACION DE USUARIOS A ROLES
ALTER ROLE RolRecepcion ADD MEMBER UsuarioRecepcion;
ALTER ROLE RolTecnico ADD MEMBER UsuarioTecnico;
ALTER ROLE RolAdministrador ADD MEMBER UsuarioAdmin;
GO