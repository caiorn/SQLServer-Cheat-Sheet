create database db_Escola
go
use db_Escola
go
create table tbl_Alunos
(
	id smallint primary key identity,
	nome varchar(100),
	nota1 tinyint,
	nota2 tinyint,
	nota3 tinyint,
	nota4 tinyint
)
insert into tbl_Alunos values ('Caio', 9, 8, 6, 8), ('Test', 7, 5, 3, 9)

--UDFs(Funções definida pelo usuario)
----------------------------------------------------------
--Função Escalar (retorna apenas um unico valor especifico)
create function calcularMedia (@nome varchar(30)) returns real --calculas a media com a nota4 com peso 2
as
begin
	declare @media real;
	select @media = (nota1 + nota2 + nota3 + nota4 * 2) / 5 from tbl_Alunos where nome = @nome
	return @media
end

select dbo.calcularMedia('Caio')
-----------------------------------------------------------
--Funções com valor de Tabela Embutidas (retorna uma tabela)
use db_Biblioteca
create function tabelaComPrecoAcima(@p as real) returns table
as
	return (select L.Nome_Livro, A.Nome_Autor, E.Nome_Editora from tbl_Livros as L
			inner join tbl_Autores as A on L.ID_Autor = A.ID_Autor
			inner join tbl_Editoras as E on L.ID_Editora = E.ID_Editora where L.Preco_Livro > @p)


select Nome_Livro, Nome_Autor from tabelaComPrecoAcima(40)
select * from tbl_Livros
-----------------------------------------------------------
--Funções com valor de Tabela com varias instruções (retorna uma result set)
create function multi_tabelas() 
	returns @tabela table (			--retornara essa tabela especifica
		Nome_Livro varchar(50),
		Data_Pub date,
		Nome_Editora varchar(50),
		Preco_Livro money
	)
as
	begin
		insert into @tabela (Nome_Livro, Data_Pub, Nome_Editora, Preco_Livro)
			select L.Nome_Livro, L.Data_Pub, E.Nome_Editora, L.Preco_Livro from tbl_Livros as L
			inner join tbl_Editoras as E on L.ID_Editora = E.ID_Editora

		return
	end

select * from multi_tabelas()