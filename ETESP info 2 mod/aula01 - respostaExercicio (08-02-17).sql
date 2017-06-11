CREATE DATABASE db_Aula080217
GO
USE db_Aula080217
GO

CREATE TABLE Departamentos(
	CodigoDepartamento INT PRIMARY KEY IDENTITY,
	Nome	VARCHAR(50),
	Localizacao	VARCHAR(100)
)

CREATE TABLE Funcionario (
	Codigo INT PRIMARY KEY IDENTITY,
	PrimeiroNome VARCHAR(100),
	SegundoNome VARCHAR(100),
	UltimoNome	VARCHAR(100),
	DataNasci	DATE,
	CPFFunc		VARCHAR(20),
	RGFunc		VARCHAR(20),
	Endereco	VARCHAR(100),
	CEP			VARCHAR(50),
	Cidade		VARCHAR(50),
	Fone		VARCHAR(15),
	Funcao		VARCHAR(20),
	Salario		SMALLMONEY,
	CodigoDepartamento INT FOREIGN KEY REFERENCES Departamentos
)
go
insert into Funcionario (PrimeiroNome, SegundoNome, UltimoNome, Cidade, Salario)
	values ('Joao', 'Binario', 'da silva', 'São Paulo', 1200),
		   ('Jose', 'Capirario', 'bezerra', 'Guarulhos', 1000),
		   ('Jose', 'Bil', 'Nadori', 'Joao Pessoa', 3000)
go		   
insert into Funcionario (PrimeiroNome, UltimoNome, Cidade, Salario, Funcao)
	values ('Biloi', 'Tax', 'Recife', 1200, 'Telefonista')


return
--1 – Listar nome e sobrenome ordenado por sobrenome.
SELECT PrimeiroNome, SegundoNome FROM Funcionario ORDER BY SegundoNome

--2 – Listar todos os campos de funcionários ordenados pela cidade.
SELECT * FROM Funcionario ORDER BY Cidade

--3 – Listar os funcionários que possuem salário superior a R$ 1000,00 ordenados pelo nome completo.
SELECT * FROM Funcionario WHERE Salario > 1000 ORDER BY PrimeiroNome, SegundoNome, UltimoNome
	
-- 4 – Listar a data de nascimento e o primeiro nome dos funcionários ordenados do mais novo para o mais velho.
SELECT * FROM Funcionario ORDER BY DataNasci DESC

--5 – Listar os funcionários como uma listagem telefônica ordenado pelo UltimoNome, PrimeiroNome e SegundoNome.
SELECT * FROM Funcionario ORDER BY UltimoNome, PrimeiroNome, SegundoNome
	
--6 – Liste o total da folha de pagamento.
SELECT SUM(Salario) AS Total FROM Funcionario

--7 – Liste a quantidade de funcionários da empresa.
SELECT COUNT(Codigo) FROM Funcionario

--8 – Liste o salário médio pago pela empresa.
SELECT AVG(Salario) FROM Funcionario

--9 – Liste o nome completo de todos os funcionários que não tenham SegundoNome.
SELECT (PrimeiroNome+' '+UltimoNome) AS 'Nome Completo' FROM Funcionario WHERE SegundoNome is NULL

--10 – Liste os nomes dos funcionários que moram em Recife e que exerçam a função de Telefonista.
SELECT PrimeiroNome From Funcionario WHERE Cidade = 'Recife' AND Funcao = 'Telefonista'