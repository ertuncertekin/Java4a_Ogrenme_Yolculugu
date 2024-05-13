SELECT * FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryID IN (1,2,3) AND UnitPrice >= 20
ORDER BY UnitPrice ASC;

SELECT DISTINCT(Country) FROM Customers ;--�oklayanlar� Yok Ettik

SELECT TOP 5 Categories.CategoryName FROM Categories;  --�LK 5 Kayd� getirdik --Top 20 PERCENT �lk y�zde 20lik kayd� getir.

SELECT * FROM Products
WHERE Products.UnitsInStock>60;

SELECT * FROM Employees
WHERE BirthDate='1958-01-09';

SELECT * FROM Customers --�lke almanya �ehir berlin veya k�ln
WHERE Country='Germany' AND (City='Berlin' OR City='K�ln');

SELECT * FROM Customers --�lke almanya �ehir berlin olmayanlar
WHERE Country='Germany' AND NOT City='Berlin';

SELECT * FROM Customers
ORDER BY CompanyName ASC;

SELECT Country,City FROM Customers --�lkeye g�re s�ralad�k. sonra �lkenin �ehirlerine g�re s�ralad�k.
ORDER BY Country ASC,City ASC;

SELECT DISTINCT TOP 5 Country FROM Customers  --
WHERE Region IS NOT NULL
ORDER BY Country DESC;

INSERT INTO Categories (CategoryName,[Description],Picture)
VALUES(
'Cozmetik','Kozmetik �r�nleri parf�m vs','0x1523678163781273761893'
);

INSERT INTO Categories (CategoryName,[Description],Picture)
VALUES(
'Mobilya',DEFAULT,'0x15236SADSS'  --default verdi�imiz '---' yi girmi� olduk.
);

DELETE FROM Categories  --12 nolu id'ye sahip kategoriyi sildik
WHERE CategoryID = 13;

SELECT * FROM Categories;

UPDATE Categories SET CategoryName='Bilgisayar',Description='Ekran Kart� vs' 
WHERE CategoryID=10;  --update ettik

TRUNCATE TABLE Categories2; --Tabloyu s�f�rlar ilk haline getirir.id'ler 1 den ba�lar.

SELECT * FROM Products
WHERE UnitPrice = (SELECT MIN(UnitPrice) FROM Products); --subquerry

SELECT MAX(UnitPrice) FROM Products;

SELECT TOP 1 * FROM Products --EN UCUZU GET�RD�M DESC EN pahal� olurdu
ORDER BY UnitPrice ASC;

--Null olanlar da say�l�r)
SELECT COUNT(*) FROM Products
WHERE Discontinued=1;

SELECT COUNT(UnitsOnOrder) FROM Products; --kolon girersem vermez

SELECT AVG(UnitPrice) AS [ORTALAMA F�YAT] FROM Products
WHERE Discontinued=1;

SELECT SUM(UnitPrice) AS [TOPLAM F�YAT] FROM Products
WHERE Discontinued=0;

SELECT * FROM Customers
WHERE CompanyName LIKE 'alfred%';

SELECT * FROM Customers
WHERE CompanyName LIKE '%a';

SELECT * FROM Customers
WHERE CompanyName LIKE '%cia%';

SELECT * FROM Customers
WHERE CompanyName LIKE '_r%'; --ilk harf ne olursa olsun ikinci harfi r olsun sonras� ne olursa olsun her bir '_' bir karakteri temsil eder

SELECT * FROM Customers
WHERE CompanyName LIKE '[a-d]%'; --a ve d harfiyle ba�layanlar� getirir

SELECT * FROM Customers
WHERE Country IN ('Mexico','UK','T�rkiye');

SELECT * FROM Categories
WHERE CategoryID IN (1,3,5);

SELECT * FROM Products
WHERE UnitPrice BETWEEN 18 AND 29;

SELECT * FROM Employees --Tarih aral���na g�re getirdik
WHERE BirthDate BETWEEN; '1948-11-06' AND '1958-01-11';

SELECT * FROM Products;
SELECT * FROM Categories;

--INNER JOIN
SELECT ProductId,ProductName,Suppliers.CompanyName,CategoryName,UnitPrice FROM Products
INNER JOIN Categories ON products.CategoryID=Categories.CategoryID
INNER JOIN Suppliers ON Products.SupplierID=Suppliers.SupplierID;


--LEFT JOIN
SELECT P.ProductName,P.CategoryID,C.CategoryName FROM Categories AS C
LEFT JOIN Products P ON P.CategoryID=C.CategoryID;

SELECT Employees.FirstName,* FROM Orders
LEFT JOIN Employees ON Orders.EmployeeID=Employees.EmployeeID;

--RIGHT JOIN
SELECT O.OrderID, o.OrderDate,o.EmployeeID, Employees.FirstName + ' ' + Employees.LastName FROM Orders AS O
RIGHT JOIN Employees ON O.EmployeeID=Employees.EmployeeID;


--UN�ON KAVRAMI--�K� SELECT YAPISINI B�RL�KTE GET�R�R, DISTINCT UYGULAR

SELECT Customers.CompanyName,City FROM Customers
UNION
SELECT Suppliers.CompanyName,City FROM Suppliers
ORDER BY City ;

--UN�ON KAVRAMI--�K� SELECT YAPISINI B�RL�KTE GET�R�R, DISTINCT UYGULAMAZ
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;

--SUB QUERY KAVRAMI --TEDAR�K��LER�N �LKELER�DEN OLAN M��TER�LER� GET�R DED�K

SELECT DISTINCT Country FROM Suppliers;

SELECT * FROM Customers
WHERE Country IN (SELECT DISTINCT Country FROM Suppliers); --B�RDEN �OK SONU� D�ND�RD��� ���N IN KULLANDIM

SELECT * FROM Customers  --Country = (SELECT TOP 1 Country FROM Suppliers ORDER BY Country DESC) TEK SONU� D�ND�RD��� ���N '=' KULLANDIM
WHERE Country = (SELECT TOP 1 Country FROM Suppliers ORDER BY Country DESC);

--GROUP BY Hangi �lkeden ve �ehirden ka� m��terim var
SELECT Country,City,COUNT(CustomerID) AS [COUNT] FROM Customers
GROUP BY Country,City
ORDER BY Country,City;

SELECT * FROM [Order Details];

SELECT OrderId,SUM(Quantity*UnitPrice) AS Total FROM [Order Details]
GROUP BY OrderID
ORDER BY Total DESC;

SELECT OrderId,SUM(Quantity*UnitPrice) AS Total FROM [Order Details]
GROUP BY OrderID
ORDER BY Total DESC;

--�r�n Bazl� Ortalama Fiyat
SELECT OrderId,AVG(Quantity*UnitPrice) AS Total FROM [Order Details] 
GROUP BY OrderID
ORDER BY Total DESC;

--�r�n Adedi Bazl� Ortalama
SELECT OrderId,AVG(Quantity*UnitPrice)/SUM(Quantity) AS Total FROM [Order Details] 
GROUP BY OrderID
ORDER BY Total DESC;

--Group By ifadelerinde HAVING ile filtreleme kullan�yoruz where ile de�il.
SELECT Country,COUNT(CustomerID) AS [COUNT] FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID)>3;--3'ten fazla m��terim olan �lkeleri s�rala dedik.

--SELECT'TEN SONRA WHERE KULLANILIP SONRA GROUP BY KULLANILAB�L�R. D��ER� KULLANILAMAZ
SELECT Country,City,COUNT(CustomerID) AS [COUNT] FROM Customers
GROUP BY Country,City
HAVING COUNT(CustomerID)>2 AND Country IN ('Brazil','France') --�ehir Bazl� G�rd�k
ORDER BY [COUNT] DESC;

--D��ER KULLANIM

SELECT Country,City,COUNT(CustomerID) AS [COUNT] FROM Customers
WHERE Country IN ('Brazil','France')
GROUP BY Country,City
HAVING COUNT(CustomerID)>2 --�ehir Bazl� G�rd�k
ORDER BY [COUNT] DESC;