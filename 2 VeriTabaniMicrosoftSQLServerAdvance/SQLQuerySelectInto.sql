SELECT * FROM Customers;

--Bir tabloyu baþka bir tablo oluþturup ona aktarýyor

SELECT *
INTO Customers2
FROM Customers;

--Ýstediðimiz kolonlara göre kopyalama yapýyoruz
SELECT CompanyName,ContactName,City,Country
INTO Customers2
FROM Customers;

DROP TABLE Customers2;

--Koþul koyup ona göre de kopyalayabiliriz
SELECT CompanyName,ContactName,City,Country
INTO Customers2
FROM Customers
WHERE Country='Mexico'

--Önemli iþlemler yapmadan önce kontrol amaçlý hýzlýca kullanabiliyoruz.