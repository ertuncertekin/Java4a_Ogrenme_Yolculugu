---Brazil�de bulunan m��terilerin �irket Ad�, TemsilciAdi, Adres, �ehir, �lke bilgileri

SELECT companyname,contactname,address,city,country FROM customers
WHERE country='Brazil';

-- Brezilya�da olmayan m��teriler

SELECT companyname,contactname,address,city,country FROM customers
WHERE country!='Brazil';

-- �lkesi (Country) YA Spain, Ya France, Ya da Germany olan m��teriler

SELECT companyname,contactname,address,city,country FROM customers
WHERE country='Brazil' OR country='France' OR country='Germany';

-- Faks numaras�n� bilmedi�im m��teriler

SELECT companyname,contactname,fax FROM customers
WHERE fax IS NULL;

-- Londra�da ya da Paris�de bulunan m��terilerim

SELECT companyname,contactname,address,city,country FROM customers
WHERE city='Londra' OR city='Paris';

-- M��terilerimin i�inde en uzun isimli m��teri

SELECT CompanyName,len(companyname) FROM Customers
ORDER BY LEN(CompanyName) DESC

--Hem Mexico D.F�da ikamet eden HEM DE ContactTitle bilgisi �owner� olan m��teriler

SELECT c.CompanyName,c.ContactName,c.City,c.ContactTitle FROM customers as c
WHERE city='M�xico D.F.' AND c.ContactTitle='Owner';

--C ile ba�layan �r�nlerimin isimleri ve fiyatlar�

SELECT ProductName,UnitPrice FROM products 
WHERE productname LIKE 'C%';

--Ad� (FirstName) �A� harfiyle ba�layan �al��anlar�n (Employees); Ad, Soyad ve Do�um Tarihleri

SELECT firstname,lastname,birthdate FROM employees
WHERE firstname LIKE 'A%';

--�sminde �RESTAURANT� ge�en m��terilerimin �irket adlar�

SELECT companyname FROM customers
WHERE companyname LIKE '%Restaurant%';

--1963 ve 1952 y�l�nda do�um g�n� olan �al��anlar�m

SELECT * FROM Employees
WHERE YEAR(BirthDate) IN (1952, 1963);

--BUG�N DO�UM G�N� OLAN �ALI�ANLARIM

SELECT * FROM Employees
WHERE MONTH(BirthDate) = MONTH(GETDATE())
AND DAY(BirthDate) = DAY(GETDATE());

--50$ VE 100$ ARASINDA B�R�M F�YATI BULUNAN �R�NLER NELERD�R

SELECT ProductName,UnitPrice FROM Products
WHERE UnitPrice BETWEEN 50 AND 100

--1 temmuz 1996 ile 31 Aral�k 1996 tarihleri aras�ndaki sipari�lerin (Orders), Sipari�ID (OrderID) ve Sipari�Tarihi (OrderDate) --bilgileri

SELECT orderid,orderdate FROM orders
WHERE orderdate BETWEEN '1996-07-01' AND '1996-12-31'
ORDER BY orderdate ASC

--EN PAHALI �R�N�M�N ADI NED�R

SELECT productId,productName,unitPrice FROM Products
WHERE UnitPrice=(SELECT MAX(unitPrice) FROM Products)

--EN UCUZ 5 �R�N� GET�R�N

SELECT TOP 5 * FROM Products
ORDER BY UnitPrice ASC

--EN UCUZ 5 �R�N�N ORTALAMA F�YATI

SELECT AVG(t.UnitPrice) FROM (
    SELECT TOP 5 UnitPrice FROM Products
    ORDER BY UnitPrice ASC
) AS t;

--�R�N ADLARININ HEPS�NE �N EK OLARAK PR EKLE VE B�Y�K HARF OLARAK YAZDIR

SELECT UPPER('PR-' + ProductName) AS ModifiedProductName
FROM Products;

--1997 y�l� �ubat ay�nda ka� sipari�im var?

SELECT COUNT(OrderId) AS [Sipari� Adedi]  FROM Orders
WHERE YEAR(OrderDate)=1997 AND MONTH(OrderDate)=2

--1997 y�l�nda sipari� veren m��terilerimin contactname ve telefon numaras�

SELECT customers.contactname, customers.phone,OrderDate FROM orders
INNER JOIN customers ON orders.CustomerID = customers.customerid
WHERE YEAR(OrderDate) = 1997;

--Ta��ma �creti 40 �zeri olan sipari�lerim

SELECT * FROM orders WHERE freight>40;

--Geciken sipari�lerim?

SELECT * FROM orders
WHERE shippeddate>requireddate

--10248 nolu sipari�te sat�lan �r�nlerin ad�, kategorisinin ad�, adedi

SELECT products.productname,categories.categoryname,[Order Details].Quantity FROM products
INNER JOIN categories ON products.categoryid=categories.categoryid
INNER JOIN [Order Details]ON products.productid=[Order Details].productid
WHERE [Order Details].orderid=10248;


--40. 3 numaral� ID ye sahip �al��an�n 1997 y�l�nda satt��� �r�nlerin ad� ve adeti

SELECT orders.employeeid,products.productname,[Order Details].quantity FROM orders
INNER JOIN [Order Details]ON [Order Details].orderid=orders.orderid
INNER JOIN products ON [Order Details].productid=products.productid
WHERE orders.employeeid=3 AND YEAR(orderdate)=1997

--1997 y�l�nda bir defasinda en �ok sat�� yapan �al��an�m�n ID,Ad soyad

SELECT TOP 1 
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName
FROM 
    Employees e
JOIN 
    Orders o ON e.EmployeeID = o.EmployeeID
WHERE 
    YEAR(o.OrderDate) = 1997
GROUP BY 
    e.EmployeeID,
    e.FirstName,
    e.LastName
ORDER BY 
    COUNT(o.OrderID) DESC;

--VEYA

SELECT TOP 1
    employees.employeeid,
    employees.firstname,
    employees.lastname,
    SUM([Order Details].quantity) AS TotalQuantity
FROM 
    orders
INNER JOIN 
    [Order Details] ON orders.orderid = [Order Details].orderid
INNER JOIN 
    employees ON orders.employeeid = employees.employeeid
WHERE 
    YEAR(orderdate) = 1997
GROUP BY 
    employees.employeeid,
    employees.firstname,
    employees.lastname
ORDER BY
    SUM([Order Details].quantity) DESC;

--En pahal� �r�n�m�n ad�,fiyat� ve kategorisin ad� nedir?

SELECT productname,unitprice,categories.categoryname FROM products
INNER JOIN categories ON products.categoryid=categories.categoryid
WHERE unitprice=(SELECT MAX(unitprice) FROM products);

--Sipari�i alan personelin ad�,soyad�, sipari� tarihi, sipari� ID. S�ralama sipari� tarihine g�re

SELECT e.firstname, e.lastname, o.orderdate, o.orderid FROM orders o 
INNER JOIN employees e ON o.employeeid = e.employeeid 
ORDER BY o.orderdate DESC;

--SON 5 sipari�imin ortalama fiyat� ve order_id nedir?

SELECT TOP 5 orders.orderid, AVG([Order Details].unitprice*[Order Details].quantity)  FROM orders
INNER JOIN [Order Details] ON orders.orderid=[Order Details].orderid
GROUP BY orders.orderid
ORDER BY orders.orderdate DESC;

--En �ok sat�lan �r�n�n ad�,kategorisi ve tedarik�i ad�
SELECT TOP 1 products.productname,categories.categoryname,suppliers.companyname,SUM([Order Details].quantity) FROM products
INNER JOIN suppliers ON products.supplierid=suppliers.supplierid
INNER JOIN categories ON products.categoryid=categories.categoryid
INNER JOIN [Order Details] ON products.productid=[Order Details].productid
GROUP BY [Order Details].productid,categories.categoryname,products.productname,suppliers.companyname
ORDER BY SUM([Order Details].quantity) DESC