---Brazil’de bulunan müþterilerin Þirket Adý, TemsilciAdi, Adres, Þehir, Ülke bilgileri

SELECT companyname,contactname,address,city,country FROM customers
WHERE country='Brazil';

-- Brezilya’da olmayan müþteriler

SELECT companyname,contactname,address,city,country FROM customers
WHERE country!='Brazil';

-- Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müþteriler

SELECT companyname,contactname,address,city,country FROM customers
WHERE country='Brazil' OR country='France' OR country='Germany';

-- Faks numarasýný bilmediðim müþteriler

SELECT companyname,contactname,fax FROM customers
WHERE fax IS NULL;

-- Londra’da ya da Paris’de bulunan müþterilerim

SELECT companyname,contactname,address,city,country FROM customers
WHERE city='Londra' OR city='Paris';

-- Müþterilerimin içinde en uzun isimli müþteri

SELECT CompanyName,len(companyname) FROM Customers
ORDER BY LEN(CompanyName) DESC

--Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müþteriler

SELECT c.CompanyName,c.ContactName,c.City,c.ContactTitle FROM customers as c
WHERE city='México D.F.' AND c.ContactTitle='Owner';

--C ile baþlayan ürünlerimin isimleri ve fiyatlarý

SELECT ProductName,UnitPrice FROM products 
WHERE productname LIKE 'C%';

--Adý (FirstName) ‘A’ harfiyle baþlayan çalýþanlarýn (Employees); Ad, Soyad ve Doðum Tarihleri

SELECT firstname,lastname,birthdate FROM employees
WHERE firstname LIKE 'A%';

--Ýsminde ‘RESTAURANT’ geçen müþterilerimin þirket adlarý

SELECT companyname FROM customers
WHERE companyname LIKE '%Restaurant%';

--1963 ve 1952 yýlýnda doðum günü olan çalýþanlarým

SELECT * FROM Employees
WHERE YEAR(BirthDate) IN (1952, 1963);

--BUGÜN DOÐUM GÜNÜ OLAN ÇALIÞANLARIM

SELECT * FROM Employees
WHERE MONTH(BirthDate) = MONTH(GETDATE())
AND DAY(BirthDate) = DAY(GETDATE());

--50$ VE 100$ ARASINDA BÝRÝM FÝYATI BULUNAN ÜRÜNLER NELERDÝR

SELECT ProductName,UnitPrice FROM Products
WHERE UnitPrice BETWEEN 50 AND 100

--1 temmuz 1996 ile 31 Aralýk 1996 tarihleri arasýndaki sipariþlerin (Orders), SipariþID (OrderID) ve SipariþTarihi (OrderDate) --bilgileri

SELECT orderid,orderdate FROM orders
WHERE orderdate BETWEEN '1996-07-01' AND '1996-12-31'
ORDER BY orderdate ASC

--EN PAHALI ÜRÜNÜMÜN ADI NEDÝR

SELECT productId,productName,unitPrice FROM Products
WHERE UnitPrice=(SELECT MAX(unitPrice) FROM Products)

--EN UCUZ 5 ÜRÜNÜ GETÝRÝN

SELECT TOP 5 * FROM Products
ORDER BY UnitPrice ASC

--EN UCUZ 5 ÜRÜNÜN ORTALAMA FÝYATI

SELECT AVG(t.UnitPrice) FROM (
    SELECT TOP 5 UnitPrice FROM Products
    ORDER BY UnitPrice ASC
) AS t;

--ÜRÜN ADLARININ HEPSÝNE ÖN EK OLARAK PR EKLE VE BÜYÜK HARF OLARAK YAZDIR

SELECT UPPER('PR-' + ProductName) AS ModifiedProductName
FROM Products;

--1997 yýlý þubat ayýnda kaç sipariþim var?

SELECT COUNT(OrderId) AS [Sipariþ Adedi]  FROM Orders
WHERE YEAR(OrderDate)=1997 AND MONTH(OrderDate)=2

--1997 yýlýnda sipariþ veren müþterilerimin contactname ve telefon numarasý

SELECT customers.contactname, customers.phone,OrderDate FROM orders
INNER JOIN customers ON orders.CustomerID = customers.customerid
WHERE YEAR(OrderDate) = 1997;

--Taþýma ücreti 40 üzeri olan sipariþlerim

SELECT * FROM orders WHERE freight>40;

--Geciken sipariþlerim?

SELECT * FROM orders
WHERE shippeddate>requireddate

--10248 nolu sipariþte satýlan ürünlerin adý, kategorisinin adý, adedi

SELECT products.productname,categories.categoryname,[Order Details].Quantity FROM products
INNER JOIN categories ON products.categoryid=categories.categoryid
INNER JOIN [Order Details]ON products.productid=[Order Details].productid
WHERE [Order Details].orderid=10248;


--40. 3 numaralý ID ye sahip çalýþanýn 1997 yýlýnda sattýðý ürünlerin adý ve adeti

SELECT orders.employeeid,products.productname,[Order Details].quantity FROM orders
INNER JOIN [Order Details]ON [Order Details].orderid=orders.orderid
INNER JOIN products ON [Order Details].productid=products.productid
WHERE orders.employeeid=3 AND YEAR(orderdate)=1997

--1997 yýlýnda bir defasinda en çok satýþ yapan çalýþanýmýn ID,Ad soyad

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

--En pahalý ürünümün adý,fiyatý ve kategorisin adý nedir?

SELECT productname,unitprice,categories.categoryname FROM products
INNER JOIN categories ON products.categoryid=categories.categoryid
WHERE unitprice=(SELECT MAX(unitprice) FROM products);

--Sipariþi alan personelin adý,soyadý, sipariþ tarihi, sipariþ ID. Sýralama sipariþ tarihine göre

SELECT e.firstname, e.lastname, o.orderdate, o.orderid FROM orders o 
INNER JOIN employees e ON o.employeeid = e.employeeid 
ORDER BY o.orderdate DESC;

--SON 5 sipariþimin ortalama fiyatý ve order_id nedir?

SELECT TOP 5 orders.orderid, AVG([Order Details].unitprice*[Order Details].quantity)  FROM orders
INNER JOIN [Order Details] ON orders.orderid=[Order Details].orderid
GROUP BY orders.orderid
ORDER BY orders.orderdate DESC;

--En çok satýlan ürünün adý,kategorisi ve tedarikçi adý
SELECT TOP 1 products.productname,categories.categoryname,suppliers.companyname,SUM([Order Details].quantity) FROM products
INNER JOIN suppliers ON products.supplierid=suppliers.supplierid
INNER JOIN categories ON products.categoryid=categories.categoryid
INNER JOIN [Order Details] ON products.productid=[Order Details].productid
GROUP BY [Order Details].productid,categories.categoryname,products.productname,suppliers.companyname
ORDER BY SUM([Order Details].quantity) DESC