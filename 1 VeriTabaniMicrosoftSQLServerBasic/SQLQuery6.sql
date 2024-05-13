SELECT * FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryID IN (1,2,3) AND UnitPrice >= 20
ORDER BY UnitPrice ASC;

SELECT DISTINCT(Country) FROM Customers ;--Çoklayanlarý Yok Ettik

SELECT TOP 5 Categories.CategoryName FROM Categories;  --ÝLK 5 Kaydý getirdik --Top 20 PERCENT Ýlk yüzde 20lik kaydý getir.

SELECT * FROM Products
WHERE Products.UnitsInStock>60;

SELECT * FROM Employees
WHERE BirthDate='1958-01-09';

SELECT * FROM Customers --ülke almanya þehir berlin veya köln
WHERE Country='Germany' AND (City='Berlin' OR City='Köln');

SELECT * FROM Customers --ülke almanya þehir berlin olmayanlar
WHERE Country='Germany' AND NOT City='Berlin';

SELECT * FROM Customers
ORDER BY CompanyName ASC;

SELECT Country,City FROM Customers --Ülkeye göre sýraladýk. sonra ülkenin þehirlerine göre sýraladýk.
ORDER BY Country ASC,City ASC;

SELECT DISTINCT TOP 5 Country FROM Customers  --
WHERE Region IS NOT NULL
ORDER BY Country DESC;

INSERT INTO Categories (CategoryName,[Description],Picture)
VALUES(
'Cozmetik','Kozmetik ürünleri parfüm vs','0x1523678163781273761893'
);

INSERT INTO Categories (CategoryName,[Description],Picture)
VALUES(
'Mobilya',DEFAULT,'0x15236SADSS'  --default verdiðimiz '---' yi girmiþ olduk.
);

DELETE FROM Categories  --12 nolu id'ye sahip kategoriyi sildik
WHERE CategoryID = 13;

SELECT * FROM Categories;

UPDATE Categories SET CategoryName='Bilgisayar',Description='Ekran Kartý vs' 
WHERE CategoryID=10;  --update ettik

TRUNCATE TABLE Categories2; --Tabloyu sýfýrlar ilk haline getirir.id'ler 1 den baþlar.

SELECT * FROM Products
WHERE UnitPrice = (SELECT MIN(UnitPrice) FROM Products); --subquerry

SELECT MAX(UnitPrice) FROM Products;

SELECT TOP 1 * FROM Products --EN UCUZU GETÝRDÝM DESC EN pahalý olurdu
ORDER BY UnitPrice ASC;

--Null olanlar da sayýlýr)
SELECT COUNT(*) FROM Products
WHERE Discontinued=1;

SELECT COUNT(UnitsOnOrder) FROM Products; --kolon girersem vermez

SELECT AVG(UnitPrice) AS [ORTALAMA FÝYAT] FROM Products
WHERE Discontinued=1;

SELECT SUM(UnitPrice) AS [TOPLAM FÝYAT] FROM Products
WHERE Discontinued=0;

SELECT * FROM Customers
WHERE CompanyName LIKE 'alfred%';

SELECT * FROM Customers
WHERE CompanyName LIKE '%a';

SELECT * FROM Customers
WHERE CompanyName LIKE '%cia%';

SELECT * FROM Customers
WHERE CompanyName LIKE '_r%'; --ilk harf ne olursa olsun ikinci harfi r olsun sonrasý ne olursa olsun her bir '_' bir karakteri temsil eder

SELECT * FROM Customers
WHERE CompanyName LIKE '[a-d]%'; --a ve d harfiyle baþlayanlarý getirir

SELECT * FROM Customers
WHERE Country IN ('Mexico','UK','Türkiye');

SELECT * FROM Categories
WHERE CategoryID IN (1,3,5);

SELECT * FROM Products
WHERE UnitPrice BETWEEN 18 AND 29;

SELECT * FROM Employees --Tarih aralýðýna göre getirdik
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


--UNÝON KAVRAMI--ÝKÝ SELECT YAPISINI BÝRLÝKTE GETÝRÝR, DISTINCT UYGULAR

SELECT Customers.CompanyName,City FROM Customers
UNION
SELECT Suppliers.CompanyName,City FROM Suppliers
ORDER BY City ;

--UNÝON KAVRAMI--ÝKÝ SELECT YAPISINI BÝRLÝKTE GETÝRÝR, DISTINCT UYGULAMAZ
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;

--SUB QUERY KAVRAMI --TEDARÝKÇÝLERÝN ÜLKELERÝDEN OLAN MÜÞTERÝLERÝ GETÝR DEDÝK

SELECT DISTINCT Country FROM Suppliers;

SELECT * FROM Customers
WHERE Country IN (SELECT DISTINCT Country FROM Suppliers); --BÝRDEN ÇOK SONUÇ DÖNDÜRDÜÐÜ ÝÇÝN IN KULLANDIM

SELECT * FROM Customers  --Country = (SELECT TOP 1 Country FROM Suppliers ORDER BY Country DESC) TEK SONUÇ DÖNDÜRDÜÐÜ ÝÇÝN '=' KULLANDIM
WHERE Country = (SELECT TOP 1 Country FROM Suppliers ORDER BY Country DESC);

--GROUP BY Hangi ülkeden ve þehirden kaç müþterim var
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

--Ürün Bazlý Ortalama Fiyat
SELECT OrderId,AVG(Quantity*UnitPrice) AS Total FROM [Order Details] 
GROUP BY OrderID
ORDER BY Total DESC;

--Ürün Adedi Bazlý Ortalama
SELECT OrderId,AVG(Quantity*UnitPrice)/SUM(Quantity) AS Total FROM [Order Details] 
GROUP BY OrderID
ORDER BY Total DESC;

--Group By ifadelerinde HAVING ile filtreleme kullanýyoruz where ile deðil.
SELECT Country,COUNT(CustomerID) AS [COUNT] FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID)>3;--3'ten fazla müþterim olan ülkeleri sýrala dedik.

--SELECT'TEN SONRA WHERE KULLANILIP SONRA GROUP BY KULLANILABÝLÝR. DÝÐERÝ KULLANILAMAZ
SELECT Country,City,COUNT(CustomerID) AS [COUNT] FROM Customers
GROUP BY Country,City
HAVING COUNT(CustomerID)>2 AND Country IN ('Brazil','France') --Þehir Bazlý Gördük
ORDER BY [COUNT] DESC;

--DÝÐER KULLANIM

SELECT Country,City,COUNT(CustomerID) AS [COUNT] FROM Customers
WHERE Country IN ('Brazil','France')
GROUP BY Country,City
HAVING COUNT(CustomerID)>2 --Þehir Bazlý Gördük
ORDER BY [COUNT] DESC;