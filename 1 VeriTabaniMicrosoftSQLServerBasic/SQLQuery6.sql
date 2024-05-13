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
WHERE CategoryID = 12;

SELECT * FROM Categories;

UPDATE Categories SET CategoryName='Bilgisayar',Description='Ekran Kartý vs' 
WHERE CategoryID=10;  --update ettik

TRUNCATE TABLE Categories2 --Tabloyu sýfýrlar ilk haline getirir.id'ler 1 den baþlar.

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
WHERE BirthDate BETWEEN '1948-11-06' AND '1958-01-11';