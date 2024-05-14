--önce verimizi boþalttýk ve template bir tablo oluþturduk.olmayan bir koþul ile

SELECT CompanyName,ContactName
INTO MyTempTable
FROM Customers
WHERE 1=0;


--kolon tipleri önemli ismi farklý olabilir.

--Müþteri bilgisini aldýk
INSERT INTO MyTempTable(CompanyName,ContactName)
SELECT CompanyName,ContactName FROM Customers
WHERE ContactName IS NOT NULL;

--Tedarikçi bilgisi aldýk ve birleþtirmiþ olduk
INSERT INTO MyTempTable(CompanyName,ContactName)
SELECT CompanyName,ContactName FROM Suppliers
WHERE ContactName IS NOT NULL;

SELECT * FROM MyTempTable

DROP TABLE MyTempTable