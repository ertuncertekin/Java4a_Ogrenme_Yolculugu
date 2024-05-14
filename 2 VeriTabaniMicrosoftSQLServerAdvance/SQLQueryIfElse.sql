DECLARE @CategoryID int
SET @CategoryID=0

IF @CategoryID=0
	BEGIN
	SELECT * FROM Products
	END
ELSE
	BEGIN
SELECT * FROM Products
WHERE CategoryID=@CategoryID
	END