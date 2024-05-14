SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ertun�
-- Create date: 2024-15-02
-- Description:	B�t�n M��teri Bilgisi getiren prosed�rler
-- =============================================
ALTER PROCEDURE SelectAllCustomersFilteredCountry2
	-- Add the parameters for the stored procedure here
	@Country nvarchar(50)= 'Germany',
	@City nvarchar(50)= 'Berlin'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Customers
	WHERE City=@City AND Country=@Country
END
GO

EXEC SelectAllCustomersFilteredCountry2 'Spain','Madrid'
