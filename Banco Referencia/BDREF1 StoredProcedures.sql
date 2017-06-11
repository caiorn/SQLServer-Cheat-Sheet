--Simples Stored Procedure
CREATE PROCEDURE p_LivroValor
AS
	SELECT Nome_Livro, Preco_Livro FROM tbl_Livros

EXEC p_LivroValor
--------------------------------------------------------------
--Mostra os comandos do procedimento armazenado
EXEC sp_helptext p_LivroValor

--------------------------------------------------------------
--Stored Procedure Criptografado 
--(não possivel a visualizaçao do codigo com  sp_helptext)
CREATE PROCEDURE p_LivroISBN
WITH ENCRYPTION
AS
	SELECT Nome_Livro, ISBN from tbl_Livros
--------------------------------------------------------------
--Modificando Stored Procedure
ALTER PROCEDURE teste @num AS INT, @num2 AS INT, @texto AS VARCHAR(30) = 'Valor Padrão'
AS 
	SELECT @texto + CAST(@num + @num2 AS VARCHAR)

EXEC teste 10,5,'Hello World'
EXEC teste 10,5
EXEC teste @texto = 'World', @num = 10, @num2 = 4

------
ALTER PROCEDURE p_LivroValor (@ID INT)
AS
	SELECT Nome_Livro AS Livro, Preco_Livro AS Valor from tbl_Livros WHERE ID_Livro = @ID

EXEC p_LivroValor 100
---------------------------------------------------------------
--Procedure de Insert
CREATE PROCEDURE p_insert_editora @nome VARCHAR(30)
AS
	set nocount on		--evita a contagem de linhas que aparece na mensagem(ex: 1 linha afetadas..)
	INSERT INTO tbl_Editoras VALUES (@nome)

EXEC p_insert_editora 'Abril'
select * from tbl_Editoras
---------------------------------------------------------------
--Procedure de Saida
CREATE PROCEDURE p_saida (@par1 AS INT OUTPUT) --funciona como referencia 
AS
	SET @par1 = (@par1 * 2) --todo valor alterado dentro do codigo  é modificado fora da procedure
	

DECLARE @valor INT = 15
EXEC p_saida @valor output
SELECT @valor
-----------------------------------------------------------------
--Procedure de retorno
ALTER PROCEDURE p_retorno (@a as int, @b as int)
as
	return @b + @a --obs: os parametros de retorno sempre deverá ser int, caso desejar outro retorno ultilizar OUTPUT

declare @resultado int;
exec @resultado = p_retorno 5, 10 --atribuindo o resultado da funçao a variavel
print @resultado