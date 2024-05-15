SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER AfterInsert
   ON  Employees
   AFTER INSERT
AS 
BEGIN
	DECLARE @EmployeeID int,@EmployeeFirstName  nvarchar(20),@employeelastname nvarchar(20)
	SELECT @EmployeeID=EmployeeId,@EmployeeFirstName=firstname,@employeelastname=LastName FROM inserted

	DECLARE @Note nvarchar(200)
	SET @Note=CONVERT(nvarchar(30),GETDATE()) + 'tarih ve saat de personel kaydý gerçekleþtirildi.'
	
	SELECT * FROM inserted

END

