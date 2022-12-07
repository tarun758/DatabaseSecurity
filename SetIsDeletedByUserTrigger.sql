SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER dbo.SetIsUserDeletedToTrue
   ON dbo.[Transaction]
   INSTEAD OF DELETE AS BEGIN 
		SET NOCOUNT ON;
		UPDATE [Transaction]
			SET [IsDeletedByUser] = 1;
END
GO