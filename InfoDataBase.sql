
--versao do banco
select @@VERSION

--busca o banco atual rodando
SELECT DB_NAME() AS [Current Database];

--busca usuario do banco 
SELECT SUSER_NAME() as Usuario
--OU 
--SUSER_SNAME()
--SYSTEM_USER 

--busca de todos banco do sistema
SELECT name, database_id, create_date FROM sys.databases

--busca o nome do servidor rodando o banco
SELECT @@SERVERNAME AS 'SERVIDOR'
--OU
--HOST_NAME();

--buscar todas tabelas do banco rodando atual
SELECT table_name FROM INFORMATION_SCHEMA.TABLES

--buscando nome das colunas
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS

--buscando stored procedures
SELECT SPECIFIC_CATALOG, ROUTINE_NAME, ROUTINE_DEFINITION  from db_testSqlInjection.information_schema.routines  where routine_type = 'PROCEDURE'
--ou 
SELECT * FROM sys.procedures

--buscando triggers
SELECT  sysobjects.name AS trigger_name, OBJECT_NAME(parent_obj) AS table_name, OBJECT_DEFINITION(id) AS trigger_definition FROM sysobjects WHERE sysobjects.type = 'TR' 

--buscando mais objetos como PKS, tabelas
SELECT name, type  FROM sys.sysobjects -- WHERE type = 'P'

--exibe a quantidade de conexoes ativas de cada usuario
SELECT 
    DB_NAME(dbid) as DBName, 
    COUNT(dbid) as NoOfConnections,
    loginame as LoginName
FROM
    sys.sysprocesses
WHERE 
    dbid > 0
GROUP BY 
    dbid, loginame

--outras info 
SELECT * FROM sys.server_principals
 

--SELECT name, password, LOGINPROPERTY(name, 'PasswordHash' ) hash
--FROM sys.syslogins
--WHERE password IS NOT NULL
--ORDER BY name