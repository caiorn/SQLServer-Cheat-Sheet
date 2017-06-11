--=======================================EXEMPLO 1========================================================================
CREATE TABLE #Pessoa
(
      id INT IDENTITY(1,1) PRIMARY KEY
    , nome VARCHAR(50)
    , sexo	CHAR(1) NOT NULL CHECK(upper(sexo) = 'M' or upper(sexo)= 'F')
    , dataNascimento DATE
		,dia AS (DAY(dataNascimento))
		,mes AS (MONTH(dataNascimento))
		,ano AS (YEAR(dataNascimento))
    , idade AS (DATEDIFF(DAY,dataNascimento,getdate())/365)
    , altura FLOAT
    , peso FLOAT
    , imc AS CAST ((peso / (altura * altura)) AS DECIMAl(4,1))
)
--=======================================EXEMPLO 2========================================================================
CREATE TABLE #Descontos(
	salario_bruto	SMALLMONEY NOT NULL
	,porcentagem	TINYINT
		,desconto_salario AS CAST (salario_bruto * (porcentagem / 100.0) AS SMALLMONEY) 
		,salario_liquido AS CAST (salario_bruto * (1 - (porcentagem / 100.0)) AS DECIMAL(7,2)) --campo calculado 
)
--=======================================EXEMPLO 3========================================================================
CREATE TABLE #Adicao(
	salario_atual	SMALLMONEY NOT NULL
	,porcentual		TINYINT
		,valor_adicionado AS CAST (salario_atual * (porcentual / 100.0) AS MONEY) 
		,valor_total	AS CAST (salario_atual * (1 + (porcentual / 100.0)) AS SMALLMONEY)
)
--===============================================================================================================
INSERT INTO #Pessoa VALUES	 ('João', 'M', '1947-07-22', 1.87, 82)
							,('Caio', 'M', '24-05-1996', 1.72, 64)

INSERT INTO #Descontos Values (1500, 50),
							(1000, 25)
							
INSERT INTO #Adicao Values	(1500, 50),
							(1000, 25)


SELECT * FROM #Pessoa
SELECT * FROM #Descontos
SELECT * FROM #Adicao
