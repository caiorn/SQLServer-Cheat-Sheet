Use Empresa
go
------------------------------------------------------------------
--a - receba o código do funcionário e retorne seu nome, sobrenome e cargo
create proc usp_BuscaFuncionario
	@nome_Func varchar(100)
as
	select Nome, Sobrenome, Cargo from Funcionarios where Nome like '%' + @nome_Func + '%'
go
exec usp_BuscaFuncionario 'a'
------------------------------------------------------------------
--b – inserir um registro na tabela fornecedores.
create proc usp_InserirFornecedores
	@empresa varchar(100),
	@contato varchar(100),
	@cargo varchar(100),
	@endereco varchar(100),
	@cidade varchar(100),
	@cep varchar(100),
	@pais varchar(100)
as
	insert into Fornecedores (Empresa, Contato, Cargo, Endereco, Cidade, CEP, Pais) values (@empresa, @contato, @cargo, @endereco, @cidade, @cep, @pais)
go
exec usp_InserirFornecedores 'Empresa 1', 'Gil', 'Diretor', 'Rua A', 'São Paulo', '02246-020', 'Brasil'

------------------------------------------------------------------
--c - inserir valores na tabela detalhePed. Use transações que verifiquem a existência ou não do número do pedido e do código do produto.
create proc usp_InserirDetalhesPedido
	@numPed int,
	@codProd int,
	@preco money,
	@qtde int,
	@desconto float
as
	if((select COUNT(*) from Pedidos where NumPed = @numPed) != 0 And (select COUNT(*) from Produtos where CodProd = @codProd) != 0)
	begin
		insert into DetalhesPed (NumPed, CodProd, Preco, Qtde, Desconto) values (@numPed, @codProd, @preco, @qtde, @desconto)
	end
go

exec usp_InserirDetalhesPedido '10868', 40, 18.40, 2, 0.80
------------------------------------------------------------------
--d – aumentar o preço de determinado produto, de acordo com o percentual fornecido.
--Solicitar o código e o percentual de aumento, se nenhum código for informado, aumentar
--todos os produtos.

create proc usp_PrecoPercentual
	@codProd int,
	@percentual decimal(10,2)
as
	declare @aumento decimal(10,2)
	set @aumento = (@percentual / 100.0)
		
	if(@codProd = 0)
		update Produtos set Preco += (@aumento * Preco)
	else
		update Produtos set Preco += (@aumento * Preco) where CodProd = @codProd

go
exec usp_PrecoPercentual  '0','50'