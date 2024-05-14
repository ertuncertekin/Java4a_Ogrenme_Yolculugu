SELECT 
	OrderID,Quantity,
	CASE
		WHEN Quantity>30 THEN 'Adet 30 dan b�y�kt�r.'
		WHEN Quantity<30 THEN 'Adet 30 dan k���kt�r.'
		ELSE 'Adet 30 dan k���kt�r.'
	END AS QuantitiyText
FROM [Order Details]

SELECT 
	ProductName,CategoryID,
	CASE
	WHEN CategoryID IS NULL THEN (SELECT TOP 1 CategoryId FROM Categories)
	ELSE CategoryID
	END AS Category
FROM Products