--�nce verimizi bo�altt�k ve template bir tablo olu�turduk.olmayan bir ko�ul ile

SELECT CompanyName,ContactName
INTO MyTempTable
FROM Customers
WHERE 1=0;


--kolon tipleri �nemli ismi farkl� olabilir.

--M��teri bilgisini ald�k
INSERT INTO MyTempTable(CompanyName,ContactName)
SELECT CompanyName,ContactName FROM Customers
WHERE ContactName IS NOT NULL;

--Tedarik�i bilgisi ald�k ve birle�tirmi� olduk
INSERT INTO MyTempTable(CompanyName,ContactName)
SELECT CompanyName,ContactName FROM Suppliers
WHERE ContactName IS NOT NULL;

SELECT * FROM MyTempTable

DROP TABLE MyTempTable