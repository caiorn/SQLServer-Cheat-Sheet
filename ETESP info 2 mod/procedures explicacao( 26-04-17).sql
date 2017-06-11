USE Empresa
go
create proc usp_contaCliente
@nomeBusca varchar(50)
as
declare @contagem int, @mensagem char(100)
select @contagem = COUNT(*) from Clientes
	where nome like '%' + @nomeBusca + '%'
	if @contagem = 0
		begin
			select @mensagem = 'Nenhum cliente contém "' + @nomeBusca + '"'
		end
	else
		select @mensagem = 'Foram encontrados '+CONVERT(char(3), @contagem) + 'clientes'
	

	print @mensagem

go
create procedure usp_insereDetalhesPed
@numPed int,
@codPed int,
@preco int,
@qtde int,
@desconto dec (17,2)
as
	if(@numPed <> 0) or (@codPed <> 0)
		insert DetalhesPed values (@numPed, @codPed, @preco, @qtde, @desconto)
	else
		print 'Valores incorretos'
		
return;
exec usp_contaCliente 'ana'
exec usp_insereDetalhesPed 10248 , 2, 3000, 6, 10
