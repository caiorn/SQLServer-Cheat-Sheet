--Exercício de revisão TLBD II
--Exercícios:
--1 – Faça uma lista de imóveis do mesmo bairro do imóvel 2. Exclua o imóvel 2 da busca.
select * from Imovel 	where CdBairro = 2 and CdImovel not in 
	(select CdImovel from Imovel where CdImovel = 2)

--2 – Faça uma lista que mostre todos os imóveis que custam mais que a média de preço dos imóveis.
select * from Imovel where VlPreco > 
	(select AVG(VlPreco) from Imovel)

--3 – Faça uma lista com todos os compradores que tenham ofertas cadastradas com valor superior a 70 mil.
select * from Comprador where CdComprador in 
	(select CdComprador from Oferta where VlOferta > 70000)

--4 - Faça uma lista com todos os imóveis com oferta superior à média do valor das ofertas.
select * from Imovel where CdImovel in
	(select CdImovel from Oferta where VlOferta > 
		(select AVG(VlOferta) from Oferta))

--5 - Faça uma lista com todos os imóveis com preço superior à média de preço dos imóveis do
--mesmo bairro.
select * from Imovel I where VlPreco >
	(select AVG(VlPreco) from Imovel where CdBairro = I.CdBairro)
		
--6 - Faça uma lista com os imóveis que têm o preço igual ao menor preço de cada vendedor.
select * from Imovel I where VlPreco =
	(select MIN(VlPreco) from Imovel where CdVendedor = I.CdVendedor)

--7 - Faça uma lista com os imóveis que têm o preço igual ao menor de todos os vendedores,
--exceto os imóveis do próprio vendedor.
select CdImovel, NmEndereco, VlPreco from Imovel i where VlPreco = 
	(select MIN(VlPreco) from Imovel where CdVendedor != i.CdVendedor)

--8 - Faça uma lista com as ofertas menores que todas as ofertas do comprador 2, exceto as
--ofertas do próprio comprador.
select cdImovel, cdComprador, vlOferta from Oferta where VlOferta < 
	(select MIN(vlOferta) from Oferta where CdComprador = 2) and CdComprador != 2
