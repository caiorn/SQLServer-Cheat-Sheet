--use master
--IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'db_testesIntermediario')
--	BEGIN
--		ALTER DATABASE db_testesIntermediario SET SINGLE_USER WITH ROLLBACK IMMEDIATE
--		DROP DATABASE db_testesIntermediario
--	END

--create database db_testesIntermediario
--go
--use db_testesIntermediario
--go
create table #test
(
	id_t int primary key identity (1,1),
	name_t varchar(50) not null,
	gender_t char(1) not null check(upper(gender_t) = 'M' or upper(gender_t)= 'F'),
	date_t date not null,
	money_t smallmoney not null,
	active_t bit not null
)

truncate table #test;


--insert random
declare @quantity int = 900 --quantidade de registros que deseja ter na base de dados
declare @firstName varchar(20) = 'Fulano ';
declare @FromDate date = '1980-01-01', @ToDate date = '1999-12-31';
declare @moneyMin int = 1000, @moneyMax INT = 5000;
declare @randomDate date,
		@randomGender char,
		@randomBit bit,	
		@randomMoney smallmoney;		
while  ((SELECT COUNT(id_t) from #test) < @quantity)
	begin
		declare @nameIncrement varchar(20) = @firstName;
		set @nameIncrement += CONVERT(varchar(8), (SELECT COUNT(id_t) from #test) + 1);
		set @randomDate = dateadd(day, rand(checksum(newid()))*(1+datediff(day, @FromDate, @ToDate)), @FromDate)
		set @randomGender = CASE WHEN CAST(RAND() * 2 as int) = 0  THEN 'M'  ELSE 'F' END
		set @randomBit = CONVERT(bit, ROUND(RAND() * 1, 0))
		set @randomMoney = ROUND((@moneyMin + (@moneyMax - @moneyMin) * RAND()), -2) -- (-2)arredonda deixando os dois ultimos numeros 0 (ex: 1245 = 1200, 1265 = 1300)
		insert into #test (name_t, gender_t , date_t, active_t, money_t) 
					values (@nameIncrement,
								  @randomGender,
											 @randomDate,
													@randomBit,
															  @randomMoney);
	end	
select * from #test

return;

--TESTES e CURIOSIDADES--------------------------------------------------------------------------------------------

select * from #test where sum(money_t)


--update sem where
 --forma 1
 UPDATE #test SET name_t = CASE WHEN name_t = 'Fulano 1' THEN 'name updated' ELSE name_t  END

 --forma 2 
 UPDATE	T SET	T.name_t = 'MANSAO' FROM #test T JOIN (SELECT 'Fulano 2' AS name_t) T2 ON T.name_t = T2.name_t


--test
select id_t, name_t, Convert(char, date_t, 101) as 'Data Nascimento',
	case DATEPART(weekday, date_t)
		when 1 then 'Domingo'
		when 2 then 'Segunda'
		when 3 then 'Terça'
		when 4 then 'Quarta'
		when 5 then 'Quinta'
		when 6 then 'Sexta'
		when 7 then 'Sábado'
	end as 'Dia da Semana' from #test;


select char(90) --65 ate 90 = A-Z
select char(rand()*26+65) --randon char A-Z

 --id do ultimo registro
select IDENT_CURRENT('#test') + IDENT_INCR('#test')
