--CREATE DATABASE db_venda
--	GO
--USE db_venda

CREATE TABLE #cliente (
	id_cliente		INT PRIMARY KEY,
	nome_cliente	VARCHAR(100) NOT NULL
)

CREATE TABLE #produto (
	id_produto		SMALLINT PRIMARY KEY,
	nome_produto	VARCHAR(50) NOT NULL,
	preco_produto	DECIMAL(7,2) NOT NULL
)

CREATE TABLE #venda (
	id_venda		INT PRIMARY KEY,
	id_cliente		INT FOREIGN KEY REFERENCES #cliente,
	desconto		DECIMAL(6,2), --9999.99
	dataHora_venda	SMALLDATETIME
)

CREATE TABLE #itemsVenda (
	id_venda		INT FOREIGN KEY REFERENCES #venda NOT NULL,
	id_produto		SMALLINT FOREIGN KEY REFERENCES #produto NOT NULL,
	preco_venda		DECIMAL(7,2),--OBS: se nao possuir,ao alterar o preço do produto, o preço de todos itens vendido serao alterados tambem 
	quantidade		INT,
	
	CONSTRAINT pk_composta_items_venda PRIMARY KEY (id_venda, id_produto)
	--como a combinaçao desses dois numeros nunca irá repetir, posso definir com chave primaria composta
)

--[Exemplo caso fosse ultilizar a chave primária composta em outra tabela como chave estrangeira]
--CREATE TABLE teste (
--	id_t		INT PRIMARY KEY,
--	id_venda	INT ,
--	id_produto	SMALLINT ,
--	nome VARCHAR(20)	
	
--	,CONSTRAINT fk_composta_teste FOREIGN KEY (id_venda, id_produto) 
--	REFERENCES itemsVenda(id_venda, id_produto)
--)

--EXEMPLO
INSERT INTO #cliente (id_cliente, nome_cliente)
	VALUES			(11,		 'Caio'),
					(22,		 'Paulo')

INSERT INTO #produto (id_produto, nome_produto, preco_produto)
	VALUES			(1,			 'TECLADO',		50.00),
					(2,			 'MOUSE',		40.00)

INSERT INTO #venda	(id_venda,  id_cliente, desconto, dataHora_venda)
	VALUES			(1001,		11,			5.00,	  '2017-29-1 18:00:00'),
					(1002,		22,			20.00,	  '2017-15-2 19:20:31')
					
INSERT INTO #itemsVenda	(id_venda,	id_produto, preco_venda, quantidade)
	VALUES				(1001,		1,			25.50,		 3),
						(1001,		2,			37.90,		 1),
						(1002,		2,			38.50,		 9)

return
select * from #cliente
select * from #venda
select * from #itemsVenda where id_venda = 1001
