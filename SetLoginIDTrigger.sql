USE [APUBSPLDB]
GO
/****** Object:  Trigger [dbo].[SetLoginID]    Script Date: 8/23/2022 2:12:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [SetLoginID] ON [Member] AFTER INSERT AS
BEGIN
	SET NOCOUNT ON
	UPDATE [Member] SET [LoginID] = CONCAT(REPLACE([Name], ' ', ''), CAST(RAND()*14307+214 AS INT), '@apubspl.com')
END