SELECT 
	OrderID,Quantity,
	CASE
		WHEN Quantity>30 THEN 'Adet 30 dan büyüktür.'
		WHEN Quantity<30 THEN 'Adet 30 dan küçüktür.'
		ELSE 'Adet 30 dan küçüktür.'
	END AS QuantitiyText
FROM [Order Details]

SELECT 
	ProductName,CategoryID,
	CASE
	WHEN CategoryID IS NULL THEN (SELECT TOP 1 CategoryId FROM Categories)
	ELSE CategoryID
	END AS Category
FROM Products