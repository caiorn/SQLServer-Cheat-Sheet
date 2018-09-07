USE MASTER
	GO
IF EXISTS (SELECT 1 FROM SYSDATABASES WHERE name = 'db_Lojinha')
	DROP DATABASE db_Lojinha
	GO
CREATE DATABASE db_Lojinha
	GO
USE db_Lojinha
	GO
CREATE TABLE tbl_Compra(
	id_compra smallint primary key identity
	,item_comprado varchar(20)	
	,preco_item smallmoney
	,total_vendidos tinyint
		,preco_total AS (preco_item * total_vendidos)
	,data_compra date default GETDATE()
	,hora_compra time(0)
	,protocolo decimal (6,2)
	,foto varbinary(MAX)
)					
								
INSERT INTO tbl_Compra VALUES	 ('PenDriver',	30.50,	13,	SYSDATETIME(),	GETDATE(),	3456.78, null)								
								,('Cartao SD',	22.50,	2,	'09/05/2012',	'18:05:32',	13.45, null)
								,('Cabo USB',	30.15,	8,	'10-05-2013',	'16:46:6',	4345, null)
								,('Teclado',	50.00,	22,	'2013/05/11',	'17:10',	1.4, null)
								,('Mouse',		25.5,	7,	'12-05-2013',	'14:3',		12, null)
								,('Fone',		24,		6,	'20160513',		'9:2',		1,null)
								
select * from tbl_Compra
truncate table tbl_Compra
