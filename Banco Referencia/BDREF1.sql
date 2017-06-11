USE master
GO
IF EXISTS (SELECT 1 FROM SYSDATABASES WHERE name = 'db_Biblioteca')
	BEGIN
		ALTER DATABASE db_Biblioteca SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE db_Biblioteca
	END
CREATE DATABASE db_Biblioteca		--criando banco de dados
ON PRIMARY (
NAME = db_Biblioteca,
FILENAME='C:\SQL\db_Biblioteca.MDF',--nome do arquivo e localização 
SIZE = 5MB,							--tamanho do BD
MAXSIZE = 15MB,						--tamanho MAXIMO do BD
FILEGROWTH = 10%					--tamanho de crescimento
)
--OBS:Caso nao inserir on primary, o banco será criado no diretorio padrao, para saber ou modificar o diretorio padrao basta ir em:
--Pesquisador de Objetos, botao Direito no Servidor, Propriedades, Configurações de Banco de Dados.

--ATENÇÃO: As tabelas que contem chaves FK, devem ser criadas depois da tabela que ela faz referencia
GO
USE db_Biblioteca
GO
CREATE TABLE tbl_Autores(
	ID_Autor SMALLINT PRIMARY KEY,
	Nome_Autor VARCHAR(50),
	Sobrenome_Autor VARCHAR(60)
)

CREATE TABLE tbl_Editoras(
	ID_Editora SMALLINT PRIMARY KEY IDENTITY,
	Nome_Editora VARCHAR(50) NOT NULL
)

CREATE TABLE tbl_Livros(
	ID_Livro SMALLINT IDENTITY (100,1) CONSTRAINT pk_ID_Livro PRIMARY KEY, 			--transformando em chave pk(constraint nomeada)
	Nome_Livro VARCHAR(50) NOT NULL,
	ISBN VARCHAR(30) CONSTRAINT uq_ISBN UNIQUE NOT NULL,							--constraint UNIQUE nomeada
	ID_Autor SMALLINT CONSTRAINT fk_ID_Autor FOREIGN KEY REFERENCES tbl_Autores ON DELETE CASCADE ON UPDATE CASCADE,	--transformando em chave fk(Constrait nomeada)
	Data_Pub DATE NOT NULL,
	Preco_Livro SMALLMONEY NOT NULL
	--CONSTRAINT pk_ID_Livro PRIMARY KEY (ID_Livro), 
	--CONSTRAINT uq_ISBN UNIQUE (ISBN),
)
----------------------------------ALTERAR/EXCLUIR COLUNAS/CONSTRAINTS-----------------------------------
USE db_Biblioteca 

DROP TABLE nome_tabela --EXCLUIR TABELA	

ALTER TABLE tbl_Livros
DROP COLUMN ID_Autor	--EXCLUIR COLUNA

ALTER TABLE tbl_Livros
ADD ID_Autor SMALLINT  --ADICIONAR COLUNA 

ALTER TABLE tbl_Livros 
ALTER COLUMN ID_Autor SMALLINT NULL	--ALTERAR TIPO DE DADOS DA COLUNA (executado para tirar o nulo)

ALTER TABLE tbl_Livros			
ADD PRIMARY KEY(ID_Livro)		--ADICIONANDO CONSTRAINT (nome aleatorio),  chave PK

ALTER TABLE tbl_Livros			
ADD CONSTRAINT pk_ID_Livro PRIMARY KEY (ID_Livro)--ADICIONANDO CONSTRAINT (nomeadas), chave PK

ALTER TABLE tbl_Livros
ADD FOREIGN KEY (ID_Autor)		--ADICIONANDO CONSTRAINT(nome aleatorio),  chave FK
REFERENCES tbl_Autores			

ALTER TABLE tbl_Livros--
ADD CONSTRAINT fk_ID_Autor FOREIGN KEY (ID_Autor) --ADICIONANDO CONSTRAINT (nomeada), chave FK
REFERENCES tbl_Autores --REFERENCIA DE QUAL TABELA ELA É PK

ALTER TABLE tbl_Livros		
DROP CONSTRAINT fk_ID_Autor	--EXCLUIR CONSTRAINT (nome_da_constraint)

use db_Biblioteca
ALTER TABLE tbl_Livros--**Executado
ADD ID_Editora SMALLINT NULL --CRIANDO A COLUNA (caso ela nao exista)		
CONSTRAINT fk_ID_Editora FOREIGN KEY (ID_Editora) --DEFININDO A CONSTRAINT 
REFERENCES tbl_Editoras ON DELETE CASCADE ON UPDATE CASCADE --on delete/update cascade, permite poder deletar/atualizar caso estiver chave estrangeira na tabela
										                    --ao deletar/atualizar, altomaticamente todas registros que tiver refencia a ele tambem será deletado/atualizado.

----------------------------INSERIR DADOS----UM/LOTE-------------------------------
INSERT INTO tbl_Autores(ID_Autor, Nome_Autor, Sobrenome_Autor)
VALUES	(1,'Daniel', 'Barret'),
(6,'Ze ninguem', null)
GO
INSERT INTO tbl_Autores(ID_Autor, Nome_Autor, Sobrenome_Autor)
VALUES	(2,'Gerald', 'Carter'), (3,'Mark', 'Sobell'),
(4,'William', 'Stanek'), (5,'Richard', 'Blum')
GO
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('Prentice Hall')
INSERT INTO tbl_Editoras(Nome_Editora) VALUES ('O´Reilly'),('Microssoft Press'),('Wiley'), ('Outro'),('Visual Studio')
GO
INSERT INTO tbl_Livros (Nome_Livro, ISBN, Data_Pub, Preco_Livro, ID_Autor, ID_Editora)
VALUES ('SSH livro A', 111111111, '20161231', 23.50, 3, 2) 
GO
INSERT INTO tbl_Livros (Nome_Livro, ISBN, Data_Pub, Preco_Livro, ID_Autor, ID_Editora)
VALUES ('Linux comand livro B', 222222222, '20160620', 30.50, 4, 1), 
('C# articles livro C', 333333333 , '20160804', 10.50, 2, 4),
('Java libro D', 444444444, '20160214', 45.50, 1, 3),
('SQL SERVER libro E', 555555555, '20160114', 70.50, 5, 5),
('ASP.NET', 666666666, '20160620', 1.50, null, 6), 
('Mobile android JAVA', 777777777 , '20160804', 77.30, null, 2)

select * from tbl_Livros
select * from tbl_Autores
select * from tbl_Editoras
-----------

-------------------------------CONSULTAS----------------------------------------------
USE db_Biblioteca

SELECT Sobrenome_Autor FROM tbl_Autores	--Mostrar UMA coluna da TABELA

SELECT Sobrenome_Autor, ID_Autor FROM tbl_Autores --Mostrar Duas Colunas da Tabela

SELECT * FROM tbl_Livros			--mostra todos os registros da tabela

SELECT Nome_Autor + ' ' + Sobrenome_Autor FROM tbl_Autores --Concatenação de Strings

SELECT 'MEU LIVRO É ' + Nome_Livro FROM tbl_Livros

SELECT COUNT(*) FROM tbl_Livros		--mostra a quantidade de registros da tabela

SELECT COUNT(Nome_Livro) FROM tbl_Livros --mostra a quantidade de registros da coluna

SELECT MAX (Preco_Livro) FROM tbl_Livros --mostra o valor maximo da coluna

SELECT MIN (Preco_Livro) FROM tbl_Livros --mostra o valor minimo da coluna

SELECT AVG (Preco_Livro) FROM tbl_Livros	--mostra os valores medios (Soma todos valores e divide pela quantidade)

SELECT SUM (Preco_Livro) AS "Preço Maximo" FROM tbl_Livros --mostra o resultado da soma de todos valores da coluna

SELECT LEN(Nome_Editora) FROM tbl_Editoras --mostra o tamanho dos caracteres de cada registro da coluna

SELECT UPPER(Nome_Editora) FROM tbl_Editoras --mostra os registro em maiusculo

SELECT LOWER(Nome_Editora) FROM tbl_Editoras --exibe registros em minusculo

SELECT SUBSTRING(Nome_Editora, 1,3) FROM tbl_Editoras --exibe parte dos registros

SELECT * FROM tbl_Livros
WHERE Preco_Livro BETWEEN 10.00 AND 30.00	--mostra todos valores ENTRE X e Y

SELECT * FROM tbl_Autores WHERE ID_Autor IN (1,4) --mostrar todos valores da tabelas autores onde o id é 1 e 4

SELECT * FROM tbl_Autores WHERE ID_Autor NOT IN (1,4)--retorna os valores diferentes de 1 e 4

SELECT Nome_Livro AS Livro, ISBN FROM tbl_Livros --mostrar as colunas
WHERE ISBN BETWEEN '100000000' AND '300000000'	--dos valores ENTRE ... E ...

SELECT * FROM tbl_Autores ORDER BY Nome_Autor ASC	--Mostra as colunas ordenada de forma CRESCENTE pelo Nome_Autor 

SELECT * FROM tbl_Autores ORDER BY Nome_Autor DESC	--Mostra as colunas ordenada de forma DESCRECENTE pelo Nome_Autor 

SELECT DISTINCT Sobrenome_Autor FROM tbl_Autores  --DISTINCT = Mostrar registros que são distintos (que não se repetem)

SELECT * FROM tbl_Autores ORDER BY NEWID() --Mostra as colunas de forma aleatoria
SELECT TOP 1 * FROM tbl_Autores ORDER BY NEWID() --Mostra um registro(tupla) aleatorio

SELECT * FROM tbl_Livros WHERE Preco_Livro = 23.50 --WHERE Mostrar somente as colunas onde tem o valor igual a X,
SELECT * FROM tbl_Livros WHERE Nome_Livro = 'livro 2' 

SELECT * FROM tbl_Livros WHERE ID_Livro>101 AND ID_Autor<2	--Mostrar as colunas que tiver as duas condições verdadeiras
SELECT * FROM tbl_Livros WHERE ID_Livro>101 OR ID_Autor<2	--Mostrar as colunas que tiver uma das condicao verdadeiras

SELECT * FROM tbl_Livros
SELECT TOP(2) ID_Autor FROM tbl_Livros --Mostra somentes os primeiros registros conforme a quantidade 

SELECT TOP 10 PERCENT ID_Autor, Nome_Livro FROM tbl_Livros --Mostra 10% de todos registros da lista começando com os 1º da lista

SELECT TOP(2) WITH TIES ID_Autor, Nome_Livro FROM tbl_Livros --WithTies, Retornara mais de 2 valores se houver repetidos entre os listados
ORDER BY ID_Autor DESC

SELECT ID_Autor AS Autor FROM tbl_Livros --AS = Adiciona o nome(Alias,Apelido) para coluna quando exibido
SELECT ID_Autor AS Autor, Nome_Livro AS Livros  FROM tbl_Livros	--Adicionando varias Alias(nome Alternativo) para varias colunas

SELECT Nome_Autor FROM tbl_Autores		
UNION								--une os registro de duas ou mais tabelas trazendo em uma so Coluna
SELECT Nome_Livro FROM tbl_Livros

SELECT ID_Autor FROM tbl_Autores		
UNION ALL							--ALL une todos registros, sem filtrar(incluindo repetidos)
SELECT ID_Autor FROM tbl_Livros

SELECT Nome_Livro FROM tbl_Livros	--Mostrar nome dos livros que começa com S
WHERE Nome_Livro LIKE 'S%'

SELECT Nome_Livro FROM tbl_Livros	--Mostrar nome dos livros que começa com S ou L e não termine em T
WHERE Nome_Livro LIKE '[LS]%[^T]'

SELECT Nome_Livro FROM tbl_Livros	--Mostrar nome dos livros que termina com B
WHERE Nome_Livro LIKE '%B'

SELECT Nome_Livro FROM tbl_Livros	--Mostrar nome dos livros onde a 2º começa com Q e a 5º com S 
WHERE Nome_Livro LIKE '_Q__S%'

SELECT Nome_Livro FROM tbl_Livros	--Mostrar nome dos livros que NÃO começa com S
WHERE Nome_Livro NOT LIKE 'S%'

SELECT * FROM tbl_Livros INNER JOIN tbl_Autores	--Junção de tabelas		
ON tbl_Livros.ID_Autor = tbl_Autores.ID_Autor	--INNER JOIN mostra todas tabelas, menos as que tiver campos nulos

SELECT tbl_Livros.Nome_Livro, tbl_Livros.ISBN, tbl_Autores.Nome_Autor -- selecionar tabelas e campos
FROM tbl_Livros INNER JOIN tbl_Autores			--INNER JOIN indica quais tabelas ira se juntar
ON tbl_Livros.ID_Autor = tbl_Autores.ID_Autor	-- Indicar quais sao os relacionamentos

SELECT L.Nome_Livro, L.ISBN, E.Nome_Autor			--O Resultado será o mesmo da de cima
FROM tbl_Livros AS L INNER JOIN tbl_Autores	AS E	--Atribui um nome alternativo para diminuiçao do codigo
ON L.ID_Autor = E.ID_Autor

SELECT * FROM tbl_Livros LEFT JOIN tbl_Autores	--LEFT JOIN: traz os dados que estão relacionados + todos os dados-	
ON tbl_Livros.ID_Autor = tbl_Autores.ID_Autor	--da tabela esquerda que não estão relacionados(campos nulos)

SELECT * FROM tbl_Livros LEFT JOIN tbl_Autores			
ON tbl_Livros.ID_Autor = tbl_Autores.ID_Autor
WHERE tbl_Autores.ID_Autor IS NULL				--Ira trazer apenas os campos que for nulo

SELECT * FROM tbl_Autores RIGHT JOIN tbl_Livros	--RIGHT JOIN: traz os dados que estão relacionados + todos os dados-	
ON tbl_Livros.ID_Autor = tbl_Autores.ID_Autor	--da tabela a direita(Incluindo os nulos)

SELECT LI.Nome_livro, LI.ID_Autor, Au.Nome_Autor
FROM tbl_Livros AS Li
FULL JOIN tbl_Autores AS Au
ON LI.ID_Autor = AU.ID_Autor
--WHERE LI.ID_Autor IS NULL		--usando WHERE IS NULL, trara somentes os valores nulos 
--OR AU.ID_Autor IS NULL
--------(atalho de consultas)---------------VIEWS/EXIBIÇÕES---------------------------------------------------
CREATE VIEW vw_LivroAutores AS SELECT		--CRIAR VIEW
tbl_Livros.Nome_Livro AS LIVRO, tbl_Autores.Nome_Autor AS AUTOR --terá nome do livro e do autor
FROM tbl_Livros INNER JOIN tbl_Autores ON tbl_Livros.ID_Autor = tbl_Autores.ID_Autor

SELECT LIVRO, AUTOR FROM vw_LivroAutores	--CONSULTAR VIEW
--where LIVRO LIKE 'S%'

ALTER VIEW vw_LivroAutores AS SELECT		--ALTERAR VIEW
tbl_Livros.Nome_Livro AS livro, tbl_Autores.Nome_Autor AS autor, Preco_Livro AS valor
FROM tbl_Livros INNER JOIN tbl_Autores ON tbl_Livros.ID_Autor = tbl_Autores.ID_Autor

SELECT * FROM vw_LivroAutores

DROP VIEW vw_LivroAutores					--EXCLUIR VIEW

---------------------------------COPIA DE TABELAS E COLUNAS--------------SELECT INTO------------------
SELECT *				--SELECIONA TODAS COLUNAS
INTO Backup_livros		--NOMEIA A NOVA TABELA
FROM tbl_Livros			--DE QUAL TABELA SERA COPIADA

SELECT Nome_Livro, ISBN --SELECIONEI AS COLUNAS
INTO Livro_ISBN			--CRIAR UMA NOVA TABELA
FROM tbl_Livros			--DE ONDE VAI SAIR AS INFORMAÇOES DAS COLUNAS
WHERE ID_Livro > 100	--WHERE nao e obrigadorio, SERA COPIADOS TODOS QUE ESTIVER NA CONDICAO


-------------------------------EXCLUIR/INSERIR E  ALTERAR DADOS ------------------------------------
TRUNCATE TABLE  tbl_Livros		--apaga todos registros da tabela

DELETE FROM tbl_Livros
WHERE Nome_Livro = 'SSH LIVRO A'	--excluir um registro

UPDATE tbl_Livros				
SET ISBN = 123456789			--mudar informaçoes de UM campo de UM registro
WHERE ISBN = 222222222			

UPDATE tbl_Livros
SET ISBN = 662662662,
    Nome_Livro = 'LIVRO F',		--mudar informaçoes de VARIOS campo de UM registro
    Preco_Livro = 100.00
WHERE ID_Livro = 104

UPDATE tbl_Livros
SET Nome_Livro = 'Mossoró X'	--mudar informaçoes de registros se for uma das condição
WHERE ID_Livro = 102 OR ISBN = 444444444

UPDATE tbl_Livros
SET Nome_Livro = 'TESTE'		--mudar informaçoes de registro se for as duas condiçoes
WHERE Nome_Livro =  'Mossoró X' AND ID_Editora = 3

UPDATE tbl_Livros				--mudar informaçoes de registros definidos
SET Preco_Livro = 200.00
WHERE ID_Livro IN (101,102,103,104)

UPDATE tbl_Livros
SET Preco_Livro = 500.00,
	Nome_Livro = 'MUDOU'
WHERE Nome_Livro NOT IN ('livro B', 'livro A') --mudar todas informaçoes menos as citadas

----------------------------------INDEX/INDICES-------------------------------------------
USE db_Biblioteca
CREATE INDEX indice_nome_livro		--criando indice
ON tbl_Livros(Nome_Livro)

---------------------------------REGRAS-------------------------------------------

CREATE RULE rl_preco AS @VALOR > 1.00 --Criar regra, dando nome, e uma @variavel

DROP RULE rl_preco	--Excluir Regra

EXECUTE SP_BINDRULE rl_preco, 'tbl.Livros.Preco_Livro' --vinculando a regra a coluna

EXECUTE SP_UNBINDRULE 'tabela.coluna';﻿ --desvincular a regra da coluna

UPDATE tbl_Livros		--teste
SET Preco_Livro = 0.90
WHERE ID_Livro = 105

-------------------------------------BACKUP BANcO DE DADOS---------------------------
BACKUP DATABASE db_NomeDoBanco					--Criar backup
TO DISK = 'C:\arquivos\NomeQualquer.bak'
GO

USE MASTER										--liberar o banco
RESTORE DATABASE BANCO_BACKUP 
FROM DISK='C:\BACKUP\BANCO_BACKUP-FULL.BAK'		--Restaurar Backup
GO

------------------------------------COLLATIONS(COLAÇÃO ou AGRUPAMENTOS)---------------------------------------

SELECT * FROM fn_helpcollations() --opçoes de agrupamentos disponivel neste sistema

SELECT SERVERPROPERTY('Collation')  --Exibe a colação usada no momento no sistema

SELECT DATABASEPROPERTYEX('db_Biblioteca','collation') AS colação --Exibe a colação de um banco especifico

ALTER DATABASE db_Biblioteca COLLATE Latin1_General_CI_AS --Alterar esquema de agrupamento do banco de dados

SELECT * FROM tbl_Livros ORDER BY Nome_Livro COLLATE Icelandic_CI_AI --Apenas Exibe na colação descrita

-------------------------------CONVERSÃO DE TIPO DE DADOS----------------------------------------------

SELECT 'O preço do Livro '+ Nome_Livro + 'é de R$' +
CAST(Preco_Livro AS VARCHAR(6)) AS ITEM FROM tbl_Livros WHERE ID_Autor = 2

SELECT 'O preço do Livro '+ Nome_Livro + 'é de R$' +
CONVERT(VARCHAR(6), Preco_Livro) AS ITEM FROM tbl_Livros WHERE ID_Autor = 2

SELECT 'A data de publicação é '+
CONVERT(VARCHAR(20), Data_Pub) FROM tbl_Livros

SELECT 'A data de publicação é '+
CONVERT(VARCHAR(20), Data_Pub, 103) FROM tbl_Livros

--https://msdn.microsoft.com/pt-br/library/ms187928.aspx


-------------------------------------------------------------------------------------
--sp_helpdb db_Biblioteca			--informa tamanho,taxa de crescimento e local do DB
--sp_help tbl_Autores				--tras informações da tabela
--IDENTITY (100,1)	= inicio, incremento

------------------------SQL Constraints--------------------------------------

--NOT NULL		= PRENCHIMENTO OBRIGATORIO
--UNIQUE		= ÚNICO, DADOS NUNCA SE REPETEM EX:CAMPO CPF
--PRIMARY KEY	= CHAVE PRIMÁRIA
--FOREIGN KEY	= CHAVE ESTRANGEIRA
--CHECK			= LIMITAR UMA FAIXA DE VALORES
--DEFAULT		= INSERIR UM VALOR PADRAO

--		SQL - STRUCTURED QUERY LANGUAGE
--			É uma linguagem utilizada para banco de dados relacionais, baseada e inspirada em algerabra relacional. 
--			Utiliza como subconjuntos principais o DML, DDL, DCL, DTL e DQL.
-------------------------------------------------------------------------------------------------------------------------			
--			-FUNÇÕES DO SQL
			
--			*Permite o acesso de dados em SGBDR(Sistema gerenciamento de banco de dados relacional);
--			*Permite Definir os dados no banco de dados e manipulá-los
--			*Pode ser embutido em outras linguagens usando módulos SQL, e bibliotecas, etc.
--			*Permite criar e excluir banco de dados e tabelas.
--			*Permite a criacão de Visões(Exibições),Stored Procedures e funções em um banco de dados
--			*Permite configurar permições de acesso em tabelas, procedimentos e visões.
-------------------------------------------------------------------------------------------------------------------------			
--			-GRUPOS DE COMANDOS
--			*DDL - Dada Definition Language(Linguagem de Definição de Dados)
--				É utilizado para realizar inclusões, consultas, exclusões e alterações de dados
--				/comandos principais:
--				CREATE 	= Cria uma nova tabela,visão ou outro objeto no BD
--				ALTER 	= Modifica um objeto existente no BD, como uma tabela.
--				DROP 	= Exclui uma tabela inteira, uma exibição de uma tabela ou outro objeto no BD.
--			*DML - Data Manipulation Language(Linguagem de Manipulação de dados)
--				Permite ao desenvolvedor definir tabelas e elementos associados.
--				/comandos principais:
--				INSERT = Cria um registro(linha),Insere uma informação nova no BD;
--				UPDATE = Modifica registros, atualiza registros ja existentes no BD;
--				DELETE = Exclui registros				
--			*DCL - Data Control Language(Linguagem de Controle de Dados)
--				Controla os aspectos de autorização de dados e a utilização de licenças por usuários
--				/comandos principais:
--				GRANT = Dá privilégios a um usuário
--				REVOKE = Retira Privilégios fornecidos a um usuário
--			*DQL - Data Query Language (Linguagem de Consulta de Dados)
--				O mais importante dentre estes, pois consultas são realizadas a todo instante.
--				/comandos:
--				SELECT = Obtém registros especificados de uma ou mais tabelas.
-------------------------------------------------------------------------------------------------------------------------				
--			-COMPOSIÇÃO DE UM BANCO DE DADOS
			
--			*TABELAS
--				>Objetos onde são armazenado os dados em um banco de dados relacional
--				>Uma tabela é uma coleção de entradas de dados relacionados e consiste em linhas e colunas
--			*CAMPOS(colunas)
--				>Representam os atributos dos dados, como Nome, Data de Nascimento, CPF, Salario, Etc.
--				>Um campo é uma coluna em um tabela que mantém informações específicas sobre cada registro. 
--			*REGISTROS(linhas ou tuplas)
--				>Cada entrada individual em uma tabela.Trata-se de um conjunto de campos
--				relacionados que caracterizam os dados de uma entidade única.
-------------------------------------------------------------------------------------------------------------------------
--			-CATEGORIAS DE TIPOS DE DADOS
--				https://msdn.microsoft.com/pt-br/library/ms187752.aspx
-------------------------------------------------------------------------------------------------------------------------
--			-ALGUNS TIPOS DE DADOS MAIS COMUNS
--				char(n) = String de caracteres de tamanho fixo, máximo de 8000 caracteres
--				varchar(n) = String de caracteres de tamanho variável, máximo de 8000 caracteres
--				varchar(max) =	Sequência de caracteres de tamanho variável. Máximo 1.073.741.824 caracteres
				
--				nchar(n) = Dados Unicode de tamanho fixo, máximo de 4000 caracteres
--				nvarchar(n)= Dados Unicode de tamanho variável, máximo de 4000 caracteres
--				nvarchar(max)= Dados Unicode de tamanho variável, máximo 1.073.741.824 caracteres
--				text = cadeia de caracteres de tamanho váriavel. até 2gb de dados.
				
--				bit = Dados inteiros com um valor de 1 ou 0, ou NULL. O tamanho de armazenamento é 1 bit. TRUE e FALSE podem ser convertidos para os bit.
--				tinyint = Dados inteiros de 0 a 255. O tamanho de armazenamento é 1 byte.
--				smallint = Dados inteiros de –32.768 a 32.767. O tamanho de armazenamento é de 2 bytes.
--				integer = Dados inteiros de –2.147.483.648 a 2.147.483.647. O tamanho é de 4 bytes.
--				bigint = Dados inteiros de (–9,223,372,036,854,775,808) a (9,223,372,036,854,775,807). O tamanho é 8 bytes.
--				smallmoney = Valores de dados monetários DE -214.748,3648 a 214.748,3647. Tamanho 4 bytes
--				money = -922.337.203.685.477,5808 a 922.337.203.685.477,5807. Tamanho 8 bytes
				
--				real = Dados de número de precisão flutuantes de–3.40E+38 a 3.40E+38.O tamanho de armazenamento é de 4 bytes.
--				float = Dados de número de ponto flutuante de –1.79E +308 a 1.79E+308.O tamanho de armazenamento é de 8 bytes.

--				datetime = Dados de data e hora de 1/01/1753 a 31/12/9999, com precisão de 3,33 milissegundos. tamanho 8 bytes
--				smalldatetime = De 01-01-1900 a 06-06-2079 com precisão de 1 min. Tamanho 4 bytes.
--				date = data apenas = de 01-01-0001 a 31-12-9999. tamanho 3 bytes
--				time = Hora apenas = precisão de até 100 nanossegundos, tamanho 3-5 bytes.

CREATE DATABASE db_test
USE db_test
CREATE TABLE tbl_Produtos (
	CodProduto TINYINT,
	NomeProduto VARCHAR(20),
	Preco MONEY,
	Quant TINYINT,
	Total AS (Preco * Quant) --Total sera calculado altomaticamente, sem presisar colocar valor no insert
) 
----campos calculados-------------------------------
USE db_test
INSERT INTO tbl_Produtos VALUES (1, 'Mouse', 15.00, 2)
INSERT INTO tbl_Produtos VALUES (2, 'Teclado', 23.00, 1)
INSERT INTO tbl_Produtos VALUES (3, 'Fone', 49.00, 1)
INSERT INTO tbl_Produtos VALUES (4, 'PenDriver', 25.00, 3)
INSERT INTO tbl_Produtos VALUES (5, 'SD Card', 29.00, 2)
INSERT INTO tbl_Produtos VALUES (6, 'DVD-R', 1.30, 11)

select * from tbl_Produtos
select SUM(Total) from tbl_Produtos


-----COMANDO ADICIONAIS DE INFORMAÇÕES----------
select db_name(dbid) from master..sysprocesses where spid=@@SPID --EXIBE O BANCO ATUAL Q ESTOU CONECTADO

sp_helpconstraint tbl_Autores --EXIBE INFORMAÇOES SOBRE CONSTRAINTS DA TABELA
exec sp_helptext tbl_Autores


---34- subqueries/SUBCONSULTAS---

--SELECT CL.Nome_Cliente AS CLIENTE, PR.Preco_Produto * CO.Quantidade AS TOTAL
--FROM Clientes as CL
--INNER JOIN Compras AS CO
--ON CL.ID_Cliente = CO.ID_Cliente
--INNER JOIN Produtos as PR
--ON CO.ID_Produto = PR.ID_Produto
----GROUP BY CL.Nome_Cliente --Ira ocorrer Erro por conta do PR.Preco_Produto * CO.Quantidade porque não fazem parte do group by

--ENTAO ULTILIZAR SUBCONSULTA

--SELECT Resultado.Cliente, SUM(Resultado.Total) AS Total FROM
--	(SELECT CL.Nome_Cliente AS CLIENTE, PR.Nome_Produto, PR.Preco_Produto * CO.Quantidade AS TOTAL
--	FROM Clientes as CL
--	INNER JOIN Compras AS CO
--	ON CL.ID_Cliente = CO.ID_Cliente
--	INNER JOIN Produtos as PR
--	ON CO.ID_Produto = PR.ID_Produto) AS Resultado
--GROUP BY Resultado.Cliente