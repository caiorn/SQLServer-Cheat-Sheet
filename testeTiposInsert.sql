CREATE TABLE #testInsert(	
	data		DATE, -- 2025-12-10
	hora		TIME(0),-- 12:59:59
	dataHora	SMALLDATETIME,-- 1955-12-13 12:43:00
	dataHora2	DATETIME,-- 1998-01-01 23:59:59.997
	boleano		BIT,
	moeda1		SMALLMONEY, --DE -214.748,3648 A 214.748,3647
	moeda2		MONEY, --VALORES MAIORES
	moeda3		DECIMAL(7,2)--MAX: 99999,99
)

INSERT INTO #testInsert (data,			hora,		dataHora,			boleano,	moeda1)
	VALUES		('09/05/1990',	GETDATE(),	'11/05/15 12:00',	'true',		-214748.3648),
				('10-05-1992',	'18:05:32',	'03-10-16 13:00',	'true',		214748.3647 ),
				('2000/05/11',	'16:46:6',	'011116 14:10:50',	'1',		1100.50		 ),
				('1993-12-21',	'17:10',	'2017-21-11 15:5',	'1',		250.65		 ),
				('19850513',  	'14:3',		'20170513',			'false',	800			 ),
				('860612',	  	'9:2',		'2017/05/11',		'0',		6			 )


SELECT * FROM #testInsert


--https://msdn.microsoft.com/pt-br/library/ms187752.aspx
