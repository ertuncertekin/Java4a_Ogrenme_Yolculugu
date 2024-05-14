--Foreign Key'leri Birleþtirip Basit Sorgu Yapmayý Amaçlýyor
CREATE VIEW ProductsByCategoriesAndSuppliers 
AS
SELECT ProductName,Categories.CategoryName,Suppliers.CompanyName FROM Products
INNER JOIN categories ON Products.CategoryID=Categories.CategoryID
INNER JOIN suppliers ON Products.SupplierID=Suppliers.SupplierID;

SELECT * FROM  ProductsByCategoriesAndSuppliers;

SELECT ProductName,CategoryName FROM  ProductsByCategoriesAndSuppliers
WHERE CategoryName='Condiments'
ORDER BY ProductName;

--View Düzeltme Ýþlemi
ALTER VIEW ProductsByCategoriesAndSuppliers 
AS
SELECT ProductID,Categories.CategoryName,Suppliers.CompanyName FROM Products
INNER JOIN categories ON Products.CategoryID=Categories.CategoryID
INNER JOIN suppliers ON Products.SupplierID=Suppliers.SupplierID;

--View Silme Ýþlemi
DROP VIEW ProductsByCategoriesAndSuppliers;