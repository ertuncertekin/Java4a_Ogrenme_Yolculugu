--Deðiþken Tanýmlama
DECLARE @Category nvarchar(50)
SET @Category='Condiments'
PRINT @Category;

SELECT * FROM Products AS P
INNER JOIN Categories AS C ON P.CategoryID=C.CategoryID
WHERE C.CategoryName=@Category