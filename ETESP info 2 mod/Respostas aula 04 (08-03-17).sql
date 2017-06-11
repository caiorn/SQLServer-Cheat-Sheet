--Exercícios – Join (aula 4)
--1 - Mostre todos os dados dos clientes que fizeram pedidos em 1996.
select C.*, P.dataPed from Clientes as C left join Pedidos as P 
	on (C.CodCli = P.CodCli) where YEAR(P.DataPed) = 1996

--2 – Apresente todos os nomes dos funcionários que fizeram pedidos para o cliente “Around the horn”.
select distinct(F.Nome) from Funcionarios as F left join Pedidos as P 
	on (F.CodFun = P.CodFun) right join Clientes as C 
		on (P.CodCli = C.CodCli) where C.Nome like 'Around the horn'
--teste real
select * from Pedidos where CodCli like 'AROUt'
select * from Funcionarios where CodFun in(6,8,1,4,3,9)

--3 – Mostre todos os dados dos pedidos feitos pelo cliente “Comércio Mineiro”.
select P.* from Pedidos as P inner join Clientes as C ON P.CodCli = C.CodCli and C.Nome = 'Comércio Mineiro'
--ou somente subquerie
select P.* from Pedidos as P where CodCli = (select CodCli from Clientes where Nome = 'Comércio Mineiro')

--4 – Exiba todos os dados dos funcionários que participaram dos pedidos de setembro de 1996.
--5 – Apresente todos os dados e as categorias de todos os produtos da categoria “laticínios”.
--6 – Exiba todos os dados dos produtos e o número do pedido de que eles fizeram parte da data “1996-07-08”.
--7 – Mostre o nome de todos os funcionários e o número dos pedidos que eles fizeram em “1997-05-01”.
--8 – Mostre o nome do funcionário e todos os dados dos pedidos feitos pelos funcionários com salários maiores que 10000,00.
--9 – Apresente o número dos pedidos feito em maio de 1997 e o nome de todos os clientes desses pedidos.
--10 – Mostre a descrição da categoria e do produto(uma única vez) dos pedidos com quantidade menor ou igual a 10, feitos em 1998, em ordem decrescente das descrições.
--11 – Mostre todos os detalhes dos pedidos entregues em 1997.
--12 – Exiba a descrição da categoria e do produto (uma única vez), atribuindo todas as categorias a todos os produtos.