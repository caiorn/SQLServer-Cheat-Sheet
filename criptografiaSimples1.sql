--Exemplo utilizando 2 procedures, uma para cadastrar e a outra para verificar
USE master
GO
IF EXISTS (SELECT 1 FROM SYSDATABASES WHERE name = 'CriptografiaTest')
	BEGIN
		ALTER DATABASE CriptografiaTest SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE CriptografiaTest
	END
CREATE DATABASE CriptografiaTest
go
use CriptografiaTest
go
CREATE TABLE Usuario (
	id	int primary key identity,
    Login VARCHAR (80),
    Senha VARBINARY (128)
)
GO
--procedure test
CREATE PROCEDURE sp_SemCriptografia
as
	if 1 = 1
		select * from Usuario
GO
--criptografando
CREATE PROCEDURE sp_InserirUsuario (@usuario varchar(50), @senha varchar(40))
WITH ENCRYPTION 
AS 
INSERT INTO Usuario (Login, Senha) VALUES (@usuario, PWDENCRYPT(@senha))
GO
---comparando
CREATE PROCEDURE sp_AutenticarUsuario (@usuario varchar(50), @senha varchar(40))
WITH ENCRYPTION 
AS
SELECT Id, Login FROM Usuario WHERE Login = @usuario AND PWDCOMPARE(@senha, Senha) = 1

return
select * from Usuario
exec sp_InserirUsuario 'Caio', '1234'
exec sp_AutenticarUsuario 'Caio', '1234'

exec sp_SemCriptografia 
SELECT SPECIFIC_CATALOG, ROUTINE_NAME, ROUTINE_DEFINITION  from CriptografiaTest.information_schema.routines  where routine_type = 'PROCEDURE'

--https://sites.google.com/site/programacaoonline/family-blog/sql-server/criptografando-senhas-no-sql-server