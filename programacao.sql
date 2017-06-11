
--atribua um número inteiro e imprima seu sucessor e seu antecessor.
declare @input int = 623;
print 'Número: ' +CAST(@input as varchar)
print 'Antecessor: '+ CAST(@input - 1 as varchar);
print 'Sucessor: '+CONVERT(varchar, @input + 1)

--atribua um valor a uma variavel e informar se ele é divisível por 10, por 5, por 2 ou se não é divisível por nenhum destes. 
declare @v1 int = 320
if @v1 % 10 = 0
	print 'é divisivel por 10'
if @v1 % 5 = 0
	print 'é divisivel por 5'
if @v1 % 2 = 0
	print 'é divisivel por 2'


--receber 2 numeros e imprimir qual e o maior e qual e o menor ou se sao iguais
declare @n1 int = 5
	   ,@n2 int = 6;
if @n1 > @n2
	print cast(@n1 as varchar) + ' é o maior que ' + cast(@n2 as varchar)
else if @n2 > @n1 
	print cast(@n2 as varchar) + ' é o maior que ' + cast(@n1 as varchar)
else
	print cast(@n1 as varchar) + ' é igual ' + cast(@n2 as varchar)


--Receber tres numeros e imprimi-los em ordem descrescente.
declare @a int = 18, @b int = 25, @c int = 26
declare @aStr varchar(10) = CAST(@a as varchar) ,@bStr varchar(10) = CAST(@b as varchar) ,@cStr varchar(10) = CAST(@c as varchar);
if @a > @b	
	if @b > @c
		print @aStr + char(13) + @bStr + char(13) + @cStr
	else
		if @a > @c
			print @aStr + char(13) + @cStr + char(13) + @bStr
		else
			print @cStr + char(13) + @aStr + char(13) + @bStr
else 
	if @b > @c
		if @a > @c
			print @bStr + char(13) + @aStr + char(13) + @cStr
		else
			print @bStr + char(13) + @cStr + char(13) + @aStr
	else
		print @cStr + char(13) + @bStr + char(13) + @aStr

--Mostre todos os números inteiros múltiplos de 10, de 0 a 1000.
DECLARE @a int = 0
WHILE @a <= 1000
begin
	print @a
	set @a = @a + 10
end

--imprimir os 6 aleatorios entre 0 e 61(sorteio mega-sena)
declare @dezena int, @i int = 0
while @i < 6
	begin
		set @dezena = (RAND() * 60) + 1 --(1 até 60)
		print @dezena
		set @i += 1
	end
print 'Boa Sorte'

--Receber um valor qualquer do teclado e imprimir esse valor com reajuste de 10,5% acima
declare @valor smallmoney = 1000.0,
        @reajuste float =  10.5
declare @novoValor smallmoney = @valor * (@reajuste / 100 + 1)
print @novoValor 

--Informar um preço de um produto e calcular novo preço com desconto de 9%
declare @price decimal(7,2) = 1000,
		@percentage int = 9;
declare @newPrice decimal(7,2) = @price - (@price * (@percentage / 100.0)) 
print @newPrice

--Atribua um preco a um produto e deixe ele com o preco de 80% em relacao ao preco original
declare @price decimal(7,2) = 1000,
		@percentage int = 80;
declare @newPrice decimal(7,2) = @price * (@percentage / 100.0)
print @newPrice

--Receber um nome e imprimir o tamanho total dele e as 4 primeiras letras do nome.
declare @nome varchar(20) = 'Janaina';
print len(@nome)
print substring(@nome, 1, 4)


--exibir um nome de trás pra frente
declare @nome varchar(20) = 'Caio Souza',
        @nomeInverso varchar(20) = '',
		@c int = 0;
while @c < LEN(@nome)
begin
	set @nomeInverso += SUBSTRING(@nome, LEN(@nome) - @c, 1)
	set @c += 1;
end
print @nomeInverso
print 'ou'
print reverse(@nome)


--exibir cada parte de um nome separado por espaço
declare @nome varchar(50) = 'ca sa io b',
	    @i int = 1;
set @nome  = replace(replace(replace(LTRIM(RTRIM(@nome)),' ','<>'),'><',''),'<>',' ') --remove os espaços desnecessarios
while @i <= len(@nome)
begin
	declare @in int = charindex(' ', @nome, @i) 
	if @in = 0
		set @in = len(@nome) + 1
	print substring(@nome, @i, @in - @i) 
	set @i = @in + 1;	
end

--receber um nome e imprimir cada letra em uma linha
declare @nome varchar(20) = 'Caio Souza'
	   ,@i int = 1;
while @i < LEN(@nome)
begin
	print substring(@nome, @i, 1);
	set @i += 1;
end

--atraves de um nome, imprimir cada letra em uma linha formando um diagonal da esquerda para direita
declare @nome varchar(100) = 'caiosouza',
		@i int = 1;
while @i <= len(@nome)
begin
	print space(@i-1) + substring(@nome, @i, 1)
	set @i += 1;
end

--imprimir um nome formando diagonal da direita para esquerda
declare @nome varchar(100) = 'caiosouza',
		@i int = 1;
while @i <= len(@nome)
begin
	print space(len(@nome) - @i-1) + substring(@nome, @i, 1)
	set @i += 1;
end

--atribua um nome  e exiba as 4 forma de triangulo retangulo uma em baixo da outra
declare @nome varchar(20) = 'caio'	 --Saida:
	   ,@i int = 1;					 --C
while @i <= LEN(@nome)				 --Ca
begin								 --Cai
	print substring(@nome, 1, @i);	 --Caio
	set @i += 1;
end

declare @nome varchar(20) = 'caio'								--Saida:
	   ,@i int = 1;												--Caio
while @i <= LEN(@nome)											-- aio
begin															--  io
	print space(@i-1)+substring(@nome, @i, 1+len(@nome) - @i);	--   o
	set @i += 1;
end

declare @nome varchar(20) = 'caio'						  --Saida:
	   ,@i int = 1;										  --   C
while @i <= LEN(@nome)									  --  Ca
begin													  -- Cai
	print space(len(@nome) - @i)+substring(@nome, 1, @i); --Caio
	set @i += 1;
end

declare @nome varchar(20) = 'caio'			  --Saida:
	   ,@i int = 0;							  --Caio
while @i < LEN(@nome)						  --Cai
begin										  --Ca
	print substring(@nome, 1, LEN(@nome)-@i); --C
	set @i += 1;
end

--atribuir um nome a uma variavel e verificar se ela tem as letra a,A,b,B
declare @text varchar(20) = 'Brasil'
if charindex('A', UPPER(@text)) > 0 --forma 1
	print 'contem a letra a'
if LOWER(@text) like '%b%' --forma 2
	print 'contem a letra b'

--atraves de 2 datas, imprimir todas as datas entre elas no formato dd/MM/yyyy
declare @data1 date = '2017-04-20'
       ,@data2 date = '2017-06-23';
	while @data1 <= @data2
	begin		
		set @data1 = dateadd(day, 1, @data1);
		print CONVERT(varchar(10) ,@data1, 103); 
	end

--atribua uma data de nascimento a uma variavel e imprimima a idade
declare @d1 date = '1996-05-15'
	   ,@d2 date = getdate();
if @d1 < @d2
begin
	print datediff(year ,@d1, @d2) -
			CASE WHEN MONTH(@d2) < MONTH(@d1) THEN 1
						 WHEN MONTH(@d2) > MONTH(@d1) THEN 0
						 WHEN DAY(@d2) < DAY(@d1) THEN 1
						 ELSE 0 END
end

--exibir todas datas com os domigos de uma determinada data ate hoje
declare @d1 date = '2017-04-15'
	   ,@d2 date = getdate();
set @d1 = dateadd(day,  1 - DATEPART(WEEKDAY, @d1), @d1);
print @d1
while @d1 < @d2
begin
	set @d1 = dateadd(weekday, 7, @d1);
	print @d1
end

--exibir todos os anos e o nome do dia da semana onde cairam todos dias 24 de maio a partir de uma data inicial ate uma data final
declare @dateStart date = '1996-05-24',
		@dateEnd date = getdate();
set @dateStart = dateadd(month, 5 - month(@dateStart), @dateStart);
set @dateStart = dateadd(day, 24 - day(@dateStart), @dateStart);
print CAST(year(@dateStart) as char(4)) +' '+ datename(weekday, @dateStart)
while @dateStart <= @dateEnd
begin
	set @dateStart = dateadd(year, 1, @dateStart)
	print CAST(year(@dateStart) as char(4)) +' '+ datename(weekday, @dateStart)
end

--atraves de uma data de nascimento exibir total de mes, semanas, horas, minutos e segundos separadamente
declare @dataNasc date = '1996-05-24'
	print 'De '+datename(day, @dataNasc)+'/'+datename(month, @dataNasc)+'/'+datename(year, @dataNasc) +' Ate Hoje Você ja viveu:'
	print CAST(datediff(month, @dataNasc, getdate()) as varchar(5)) + ' Meses.'
	print CAST(datediff(week, @dataNasc, getdate()) as varchar(6)) + ' Semanas.'
	print CAST(datediff(day, @dataNasc, getdate()) as varchar(7)) + ' Dias.'
	print CAST(datediff(hour, @dataNasc, getdate()) as varchar(8)) + ' Horas.'
	print CAST(datediff(minute, @dataNasc, getdate()) as varchar(9)) + ' Minutos.'
	print CAST(datediff(second, @dataNasc, getdate()) as varchar(10)) + ' Segundos.'

--exibir numeros de 1 ate 10 em um unico select
DECLARE @t TABLE (m INT)
DECLARE @i INT
SET @i=1
WHILE (@i<=10)
BEGIN
  INSERT INTO @t SELECT @i
  SET @i=@i+1
END 
SELECT m FROM @t

--exibir numeros entre 0 e 10 de ordem crescente e ordem descrecente ao lado em uma tabela com 2 colunas
declare @t table (crescente int not null, descrecente int not null)
declare @c int = 1;
while @c <> 10
begin
	insert into @t values (@c, 10 - @c)	--ou insert into @t select @c, (10 - @c)
	set @c = @c + 1
end
select * from @t

--------------------------------------------Testes--------------------------------------------------------------
--Colunas computadas
create table #test3 (  
  ativo bit null,
  statusf as CASE
    WHEN ativo is not null and ativo <> 0 THEN 'Ativo'
    WHEN ativo is null  THEN 'Nao Definido'
    ELSE 'Inativo' END
)
insert into #test3 (ativo) values (1), (null), (0)
select * from #test3

--Encontrando ID´s faltantes
DECLARE @t1 TABLE (id INT) --CRIAÇÃO DA TABELA
INSERT INTO @t1 VALUES (1),(2),(3),(4),(8),(20),(22) --CARGA DE DADOS 
--QUERY CTE
;WITH Lacunas (faltante, maxid)
AS
(
 SELECT 1 AS faltante, (select max(id) from @t1)
 UNION ALL
 SELECT faltante + 1, maxid FROM Lacunas
 WHERE faltante < maxid
)
SELECT faltante
FROM Lacunas
LEFT OUTER JOIN @t1 t1 on t1.id = Lacunas.faltante
WHERE t1.id is NULL

--formas de verificar se retornou uma coluna
set nocount on

if (select '') = '' --true
if (select '') is not null --true
if (select '') is null --false
if exists (select null)	 --true
declare @tbl table (id int)
if exists (select * from @tbl) --false
	print 'existe'
