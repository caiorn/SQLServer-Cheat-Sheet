USE MASTER
	GO
IF EXISTS (SELECT 1 FROM SYSDATABASES WHERE name = 'db_Agenda')
	DROP DATABASE db_Agenda
	GO
CREATE DATABASE db_Agenda
	GO
USE db_Agenda
	GO
CREATE TABLE tbl_Pais (
	id_pais		SMALLINT	NOT NULL CONSTRAINT pk_id_pais		PRIMARY KEY	IDENTITY	--existem 193 países (2º a ONU)
	,sigla_pais	CHAR(3)				 CONSTRAINT uq_sigla_pais	UNIQUE
	,nome_pais	VARCHAR(50)	NOT NULL CONSTRAINT uq_nome_pais	UNIQUE
	,ddi_pais	VARCHAR(6)	NOT NULL													--n pode ser pk porque se repetem
)

CREATE TABLE tbl_Estado (
	id_estado	 TINYINT		NOT NULL CONSTRAINT pk_id_estado	PRIMARY KEY IDENTITY
	,sigla_uf	 CHAR(2)				 CONSTRAINT uq_sigla_uf		UNIQUE
	,nome_estado VARCHAR(20)	NOT NULL CONSTRAINT uq_nome_estado	UNIQUE
	,pais_id	 SMALLINT		NOT NULL CONSTRAINT fk_pais_id		FOREIGN KEY REFERENCES tbl_Pais (id_pais) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE tbl_Cidade (
	id_cidade		SMALLINT	NOT NULL CONSTRAINT pk_id_cidade	PRIMARY KEY IDENTITY
	,nome_cidade	VARCHAR(50) NOT NULL CONSTRAINT uq_nome_cidade	UNIQUE
	,estado_id		TINYINT		NOT NULL CONSTRAINT fk_estado_id	FOREIGN KEY REFERENCES tbl_estado (id_estado) ON DELETE CASCADE ON UPDATE CASCADE
	,ddd_cidade		TINYINT		NOT NULL
)

CREATE TABLE tbl_Operadora (
	id_operadora	TINYINT		NOT NULL CONSTRAINT pk_id_operadora	PRIMARY KEY IDENTITY
	,nome_operadora	VARCHAR(20)	NOT NULL CONSTRAINT uq_nome_operadora UNIQUE
	,ddd_operadora	TINYINT		NOT NULL
)

CREATE TABLE tbl_Contato (
	id_contato		SMALLINT	NOT NULL CONSTRAINT pk_id_contato PRIMARY KEY IDENTITY
	,nome_contato	VARCHAR(80)	NOT NULL
	,numero_fone	VARCHAR(15)	NOT NULL
	,operadora_contato	TINYINT	CONSTRAINT fk_operadora_contato FOREIGN KEY	REFERENCES tbl_Operadora (id_operadora)	ON DELETE CASCADE ON UPDATE CASCADE
	,cidade_contato	SMALLINT	NOT NULL CONSTRAINT fk_cidade_contato	FOREIGN KEY REFERENCES tbl_Cidade (id_cidade)
)

	
INSERT INTO tbl_Pais VALUES	('USA', 'Estados Unidos', '+1'),	('ARG', 'Argentina',	'+54')
							,('CAN', 'Canadá',	'+1'),			('THA', 'Tailândia',	'+66')							
							,('PRT', 'Portugal',	'+351'),	('TUR', 'Turquia',	'+90')								
							,('MEX', 'México',		'+484'),	('CHI', 'China',	'+86')					
							,('JPN', 'Japão',	'+81'),			('DEU', 'Alemanha',	'+49')				
							,('ESP', 'Espanha', '+34'),			('GBR', 'Inglaterra (Reino Unido)', '+44')
							,('BRA', 'Brasil',	'+55'),			('RUS', 'Rússia',	'+7')				
							,('FRA', 'França',	'+33'),			('ZAF', 'Africa do Sul', '+27')


INSERT INTO tbl_Estado	VALUES	('AC',	'Acre',		13)			,('MA', 'Maranhão',	 13)			,('RJ', 'Rio de Janeiro',	13)
								,('AL', 'Alagoas',	13)			,('MT', 'Mato Grosso',	 13)		,('RN', 'Rio Grande do Norte',	13)
								,('AP', 'Amapá',	13)			,('MS', 'Mato Grosso do Sul', 13)	,('RS', 'Rio Grande do Sul',	13)
								,('AM', 'Amazonas',	13)			,('MG', 'Minas Gerais',	 13)		,('RO', 'Rondônia',		 13)
								,('BA', 'Bahia',	13)			,('PA', 'Pará',		13)				,('RR', 'Roraima',		 13)
								,('CE', 'Ceará',	13)			,('PB', 'Paraíba',	13)				,('SC', 'Santa Catarina',	13)
								,('DF', 'Distrito Federal',	13)	,('PR', 'Paraná',	13)				,('SP',	'São Paulo',	13)
								,('ES', 'Espírito Santo',	13)	,('PE', 'Pernambuco',	 13)		,('SE', 'Sergipe',		13)
								,('GO', 'Goiás',	 13)		,('PI', 'Piauí',		 13)		,('TO', 'Tocantins',	13)
					
								--		Capitais				outras cidades				outras cidades
INSERT INTO tbl_Cidade VALUES	 ('Rio Branco',1, 68)		,('Brasiléia',1, 68)		,('Xapuri',1, 68)				--Acre	           
								,('Maceió',2, 82)			,('Arapiraca',2, 82)		,('Penedo',2, 82)				--Alagoas	           								
								,('Macapá',3, 96)			,('Oiapoque',3, 96)			,('Santana',3, 96)				--Amapá	           								
								,('Manaus',4, 92)			,('Parintins',4, 92)		,('Tefé',4, 97)					--Amazonas	       
								,('Salvador',5, 71)			,('Feira de Santana',5, 75)	,('Itabuna',5, 73)				--Bahia	           
								,('Fortaleza',6, 85)		,('Sobral',6, 88)			,('Canindé',6, 85)				--Ceará	           
								,('Brasília',7, 61)																		--Distrito Federal   
								,('Vitória',8, 27)			,('Vila Velha',8, 27)		,('Serra',8, 28)				--Espírito Santo	   
								,('Goiânia',9, 62)			,('Jataí',9, 64)			,('Trindade',9, 62)				--Goiás	           
								,('São Luís',10, 98)		,('Imperatriz',10, 99)		,('Caxias',10, 99)				--Maranhão	       
								,('Cuiabá',11, 65)			,('Sinop',11, 66)			,('Diamantino',11, 65)			--Mato Grosso     	
								,('Campo Grande',12, 67)	,('Dourados',12, 67)		,('Bonito',12, 67)				--Mato Grosso do Sul
								,('Belo Horizonte',13, 31)	,('Caldas',13, 35)			,('Juiz de Fora',13, 32)		--Minas Gerais	   
								,('Belém',14, 91)			,('Marabá',14, 94)			,('Castanhal',14, 91)			--Pará	           
								,('João Pessoa',15, 83)		,('Pombal',15, 83)			,('Bananeiras',15, 83)			--Paraíba	           
								,('Curitiba',16, 41)		,('Maringá',16, 44)			,('Foz do Iguaçu',16, 45)		--Paraná	           
								,('Recife',17, 81)			,('Petrolina',17, 87)		,('Olinda',17, 81)				--Pernambuco	       
								,('Teresina',18, 86)		,('Parnaíba',18, 86)		,('Bom Jesus',18, 89)			--Piauí	           
								,('Rio de Janeiro',19, 21)	,('Niterói',19, 21)			,('Angra dos Reis',19, 24)		--Rio de Janeiro	   
								,('Natal',20, 84)			,('Agua Nova',20, 84)		,('Acari',20, 84)				--Rio Grande do Norte
								,('Porto Alegre',21, 51)	,('Rio Grande',21, 53)		,('Canoas',21, 51)				--Rio Grande do Sul	
								,('Porto Velho',22, 69)		,('Vilhena',22, 69)			,('Cacoal',22, 69)				--Rondônia	       
								,('Boa Vista', 23, 95)		,('Mucajaí', 23, 95)		,('Bonfim', 23, 95)				--Roraima	           
								,('Florianópolis', 24, 48)  ,('Joinville', 24, 47)		,('Balneário Camboriú', 24, 47)	--Santa Catarina	   
								,('São Paulo', 25, 11)		,('Guarulhos', 25, 11)		,('Americana', 25, 19)			--São Paulo	       
								,('Aracaju', 26, 79)		,('Lagarto', 26, 79)		,('Itabaiana', 26, 79)			--Sergipe         	
								,('Palmas', 27, 63)			,('Gurupi', 27, 63)		  	,('Arraias', 27, 63)			--Tocantins	     
									
INSERT INTO tbl_Operadora VALUES	('Vivo', 15)
									,('Oi', 31)
									,('Tim' , 41) 
									,('Claro' , 21)
									,('Nextel' , 99)

select * from tbl_Cidade

INSERT INTO tbl_Contato	VALUES ('Rorger',	'95845-3521', 1, 24)
							  ,('Jose Bt',	'96842-8896', 3, 12)
							  ,('Maria',	'99875-4521', 4, 5)
							  ,('Joao',		'97452-9452', 2, 21)
							  ,('Francisco','91134-2143', 1, 16)
							  

RETURN
-- SELECTS INNER JOINS 

--										INNER JOINS 1 TABELA
-- busque o nome do estado e do pais
SELECT E.nome_estado, P.nome_pais FROM tbl_Estado AS E
INNER JOIN tbl_Pais  AS P ON P.id_pais = E.pais_id

--										INNER JOINS 2 TABELAS
--busque os nomes da cidade e seus respectivos estado e pais
SELECT nome_cidade, nome_estado, nome_pais FROM tbl_Cidade
INNER JOIN tbl_Estado ON tbl_Estado.id_estado = tbl_Cidade.estado_id
INNER JOIN tbl_Pais ON tbl_Pais.id_pais = tbl_Estado.pais_id

--										INNER JOIN 3 TABELAS
--busque todos os contatos e sua localidade(cidade, estado e pais)
SELECT nome_contato, nome_cidade, nome_estado, nome_pais from tbl_Contato
INNER JOIN tbl_Cidade ON tbl_Cidade.id_cidade = tbl_Contato.id_contato
INNER JOIN tbl_Estado ON tbl_Estado.id_estado = tbl_Cidade.id_cidade
INNER JOIN tbl_Pais ON tbl_Pais.id_pais = tbl_Estado.pais_id

--										INNER JOIN 4 TABELAS
--busque respectivamente o Nome do Contato, DDi do Pais, DDD da Operadora, DDD da cidade, e Numero de telefone, pela ordem do ddd da operadora 
SELECT nome_contato, ddi_pais, ddd_operadora, ddd_cidade, numero_fone FROM tbl_Contato
INNER JOIN tbl_Operadora ON tbl_Contato.operadora_contato = tbl_Operadora.id_operadora
INNER JOIN tbl_Cidade ON tbl_Contato.cidade_contato = tbl_Cidade.id_cidade 
INNER JOIN tbl_Estado ON tbl_Cidade.estado_id = tbl_Estado.id_estado
INNER JOIN tbl_Pais ON  tbl_Estado.pais_id = tbl_Pais.id_pais
ORDER BY ddd_operadora
				
	






----Estado		   Sigla    Capital	        Região
----Acre	            AC	Rio Branco	    Norte
----Alagoas	            AL	Maceió	        Nordeste
----Amapá	            AP	Macapá	        Norte
----Amazonas	        AM	Manaus	        Norte
----Bahia	            BA	Salvador	    Nordeste
----Ceará	            CE	Fortaleza	    Nordeste
----Distrito Federal    DF	Brasília	    Centro-Oeste
----Espírito Santo	    ES	Vitória	        Sudeste
----Goiás	            GO	Goiânia	        Centro-Oeste
----Maranhão	        MA	São Luís	    Nordeste
----Mato Grosso     	MT	Cuiabá	        Centro-Oeste
----Mato Grosso do Sul	MS	Campo Grande	Centro-Oeste
----Minas Gerais	    MG	Belo Horizonte	Sudeste
----Pará	            PA	Belém	        Norte
----Paraíba	            PB	João Pessoa	    Nordeste
----Paraná	            PR	Curitiba	    Sul
----Pernambuco	        PE	Recife	        Nordeste
----Piauí	            PI	Teresina	    Nordeste
----Rio de Janeiro	    RJ	Rio de Janeiro	Sudeste
----Rio Grande do Norte	RN	Natal	        Nordeste
----Rio Grande do Sul	RS	Porto Alegre	Sul
----Rondônia	        RO	Porto Velho	    Norte
----Roraima	            RR	Boa Vista	    Norte
----Santa Catarina	    SC	Florianópolis	Sul
----São Paulo	        SP	São Paulo	    Sudeste
----Sergipe         	SE	Aracaju	        Nordeste
----Tocantins	        TO	Palmas	        Norte

