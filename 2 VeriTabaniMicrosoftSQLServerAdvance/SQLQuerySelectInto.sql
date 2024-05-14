SELECT * FROM Customers;

--Bir tabloyu ba�ka bir tablo olu�turup ona aktar�yor

SELECT *
INTO Customers2
FROM Customers;

--�stedi�imiz kolonlara g�re kopyalama yap�yoruz
SELECT CompanyName,ContactName,City,Country
INTO Customers2
FROM Customers;

DROP TABLE Customers2;

--Ko�ul koyup ona g�re de kopyalayabiliriz
SELECT CompanyName,ContactName,City,Country
INTO Customers2
FROM Customers
WHERE Country='Mexico'

--�nemli i�lemler yapmadan �nce kontrol ama�l� h�zl�ca kullanabiliyoruz.