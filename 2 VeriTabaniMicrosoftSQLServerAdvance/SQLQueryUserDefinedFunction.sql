-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ertunç Ertekin
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION f_NetSale
(
	-- Add the parameters for the function here
	@unitprice money,
	@quantity smallint,
	@discount real
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @netsale real
	SET @netsale=0

	-- Add the T-SQL statements to compute the return value here
	SET @netsale=@unitprice*@quantity*(1-@discount)

	-- Return the result of the function
	RETURN @netsale

END
GO

select *,dbo.f_NetSale(unitprice,Quantity,Discount) as netsale from [Order Details]
