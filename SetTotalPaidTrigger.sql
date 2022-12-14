USE [APUBSPLDB]
GO
/****** Object:  Trigger [dbo].[SetTotalPaid]    Script Date: 8/23/2022 4:16:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[SetTotalPaid] on [dbo].[NumberOfCopiesPurchasedPerBook] AFTER INSERT AS BEGIN 
SET NOCOUNT ON
	UPDATE [NumberOfCopiesPurchasedPerBook] SET [TotalPaid] = 
		(SELECT [Price] FROM [Book] WHERE [BookID] = NumberOfCopiesPurchasedPerBook.BookID) - 
		((SELECT [Price] FROM [Book] WHERE [BookID] = NumberOfCopiesPurchasedPerBook.BookID) * 
		((SELECT CAST([Discount] AS FLOAT) FROM [Category] WHERE [CategoryName] = (SELECT CategoryName FROM Book WHERE BookID = NumberOfCopiesPurchasedPerBook.BookID))) / CAST(100 AS FLOAT)) + 
		(SELECT [Price] FROM [Book] WHERE [BookID] = NumberOfCopiesPurchasedPerBook.BookID) * 
		(SELECT CAST([Tax] AS FLOAT) FROM [Category] WHERE [CategoryName] = (SELECT CategoryName FROM Book WHERE BookID = NumberOfCopiesPurchasedPerBook.BookID)) / CAST(100 AS FLOAT);
END