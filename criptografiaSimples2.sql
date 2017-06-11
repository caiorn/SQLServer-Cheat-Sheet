--Exemplo utilizando 1 trigger no momento de inserir e 1 procedure para autenticar
--Autor : Caio
--2017

USE master
GO
IF (SELECT DB_ID('CriptografiaTest2')) IS NOT NULL
	BEGIN
		ALTER DATABASE CriptografiaTest2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE CriptografiaTest2
	END
CREATE DATABASE CriptografiaTest2
go
use CriptografiaTest2
go
CREATE TABLE Usuario (
	id1	int primary key identity,
    Login1 VARCHAR(80),
    Senha1 VARCHAR(70)
)
GO

--trigger para criptograr
create trigger trg_criptInsert
on Usuario
with encryption 
instead of insert	
AS
	set nocount on
	insert into Usuario (Login1, Senha1)
		select 
			inserted.Login1, 	
			CONVERT(varchar(70), PWDENCRYPT(inserted.Senha1))  
		from inserted

GO
--procedure para autenticar
create procedure sp_Autenticar (@usuario varchar(50), @senha varchar(12))
with encryption 
as
	select Id1, Login1 from Usuario where Login1 = @usuario AND PWDCOMPARE(@senha, CONVERT(varbinary(128), Senha1)) = 1


return
--Inserções
insert into Usuario values ('caio', 'cx#m'), ('adm2', 'abc111')
truncate table Usuario
--Autenticacoes
exec sp_Autenticar 'caio', 'test'
exec sp_Autenticar 'caio', 'cx#m'


--OFF Tests---------------------------------------------------------------------------------
--Test select
select * from Usuario

select Id1, Login1, cast(Senha1 as varbinary) as 'Senha(varbinary)'  from Usuario

declare @secretPass varchar(142) = (select Senha1 from Usuario where id1 = 1)  --So exibe via print
print 'Password:'+char(13)+char(13)+char(32)+@secretPass+char(13)+char(13)+
	  'Size:'+cast(len(@secretPass) as varchar)

--test triggers unencrypted  (!(with encryption))
create trigger trg_testNotEncryption
on Usuario
after delete
as
	--code
	if 1 <> 2
		print 'only one test';


--I can see code trg_testNotEncryption, but i can't see code trg_criptInsert
SELECT 
    sysobjects.name AS trigger_name, 
    OBJECT_NAME(parent_obj) AS table_name,
    OBJECT_DEFINITION(id) AS trigger_definition
FROM sysobjects 
WHERE sysobjects.type = 'TR' 


--Novos metodos de criptografia
print HashBytes('SHA1', 'c@i0');
print HashBytes('SHA', 'c@i0');
print HashBytes('MD5', 'c@i0');
print HashBytes('MD4', 'c@i0');
print HashBytes('MD2', 'c@i0');

