USE db_Biblioteca
go

CREATE TRIGGER tgr_test_trigger_after
ON tbl_editoras
AFTER INSERT			--depois de inserir ... faça o codigo a baixo
AS
	print 'Conteudo inserido, Olá mundo'
	select * from tbl_Editoras	
--testes
INSERT INTO tbl_Editoras VALUES ('EditoraY')
----------------------------------------------------------------------
CREATE TRIGGER tgr_test_insteadof --OBS: é possivel somente um trigger INSTEAD OF pro cada operaçao DML (update, delete, insert) por tabela
ON tbl_Autores
--WITH ENCRYPTION
INSTEAD OF INSERT		--ao invés de inserir... faça o codigo a baixo
AS
	set nocount on
	declare @idAutor int,
			@nome varchar(50),
			@sobrenome varchar(70);
	--Capturando valores da (tentativa do insert) 
	select 
		@idAutor = inserted.ID_Autor,  --inserted é uma tabela temporaria
	    @nome = inserted.Nome_Autor,  --(updated nao existe, inserted serve para captura de valores que foram ou estao sendo update tbm) 
	    @sobrenome = inserted.Sobrenome_Autor 
	from inserted
	print cast(@idAutor as varchar)+' '+@nome +' '+@sobrenome
	print 'nada foi inserido'
	
--testes
INSERT INTO tbl_autores values (7, 'NomeEx', 'SobrenomeEx')
select * from tbl_Autores
------------------------------------------------------------------
alter trigger tgr_after_autores
on tbl_autores
after insert, update
as
	if UPDATE(nome_autor)--true = sempre quando executa um insert ou sempre que o nome for alterado
	begin
		select * from inserted
		--print 'O nome do autor foi ou alterado'
	end	
	else 
		print 'O nome do autor nao foi inserido ou modificado'
	declare @nome varchar(100)

--testes
DROP trigger tgr_test_insteadof
insert into tbl_Autores values (13, 'xas', 'blaum')
update tbl_Autores set Nome_Autor = 'juma' where ID_Autor = 7
update tbl_Autores set Sobrenome_Autor = 'Xv' where ID_Autor = 7
-----------------------------------------------------------------------------
alter trigger tgr_afterDel_autores
on tbl_autores
after delete
as
	declare @idDel int,
			@nameDel varchar(100),
			@lastNameDel varchar(100);
	select @idDel = deleted.ID_Autor from deleted
	select @nameDel = deleted.Nome_Autor from deleted
	select @lastNameDel = deleted.Sobrenome_Autor from deleted
	print 'Foi deletado:' +cast(@idDel as varchar) +' '+@nameDel+' '+@lastNameDel
	insert into tbl_Autores (ID_Autor, Nome_Autor, Sobrenome_Autor) 
	select ID_Autor, Nome_Autor, Sobrenome_Autor from deleted
	print 'foi inserido novamente'

--testes
delete from tbl_Autores where Id_Autor = 7
select * from tbl_Autores,
-----------------------------------------------------------------------------

--DESABILITAND/HABILITANDO TRIGGERS
ALTER TABLE tbl_autores disable trigger tgr_test_trigger_insteadof
ALTER TABLE tbl_autores enable trigger tgr_test_trigger_insteadof

--pega informaçoes do trigger
exec sp_helptrigger @tabname = tbl_autores

--buscando informaçoes do trigger no banco todo
use db_Biblioteca
select * from sys.triggers --where is_disabled = 0

--outras informacoes
SELECT 
    sysobjects.name AS trigger_name, 
    OBJECT_NAME(parent_obj) AS table_name,
    OBJECT_DEFINITION(id) AS trigger_definition
FROM sysobjects 
WHERE sysobjects.type = 'TR' 