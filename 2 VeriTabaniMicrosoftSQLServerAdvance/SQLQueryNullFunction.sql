DECLARE @DefaultCategoryId int
SELECT TOP 1 @DefaultCategoryId=CategoryId
FROM Categories ORDER BY CategoryID

--PRINT @DefaultCateforyId

SELECT 
	ProductName,CategoryID,ISNULL(CategoryId, @DefaultCategoryId)
FROM Products