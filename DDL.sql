CREATE DATABASE APUBSPLDB;
USE APUBSPLDB;

CREATE TABLE [Member]
(
	[MemberID]			INT IDENTITY(1,1),
	[Name]				VARCHAR(90)	NOT NULL,
	[City]				VARCHAR(30)	NOT NULL,
	[Street]			VARCHAR(45)	NOT NULL,
	[Postcode]			CHAR(5) NULL,
	[PhoneNumber]		VARCHAR(11) NOT NULL,
	[Type]				VARCHAR(20)	NOT NULL CHECK([Type] = 'Staff' OR ([Type] = 'Student')),
	[LoginID]			VARCHAR(30)	NULL, -- This is Null because it gets set by a trigger --
	[PaymentCardNumberEncrypted]	VARBINARY(1000)	NOT NULL

	CONSTRAINT [PK_Member_MemberID]	PRIMARY	KEY	([MemberID])
);

CREATE TABLE [Transaction]
(
	[TransactionID]		INT IDENTITY(1,1),
	[MemberID]			INT,
	[DateOfPurchase]	DATE DEFAULT CONVERT(DATE, GETDATE()),
	[IsDeletedByUser]	BIT NOT NULL DEFAULT 0	-- 0: False /\/\ 1:True --

	CONSTRAINT	[PK_Transaction_TransactionID]	PRIMARY KEY ([TransactionID]),
	CONSTRAINT	[FK_Transaction_MemberID]		FOREIGN KEY ([MemberID])	REFERENCES	[Member]([MemberID]) 
);

CREATE TABLE [Publisher]
(
	[PublisherID]	INT IDENTITY(1,1),
	[Name]			VARCHAR(90) NOT NULL,
	[Address]		VARCHAR(80) NOT NULL,
	[Country]		VARCHAR(50) NOT NULL

	CONSTRAINT	[PK_Publisher_PublisherID]	PRIMARY KEY	([PublisherID])
);

CREATE TABLE [Category]
(
	[CategoryName]	VARCHAR(70),
	[Tax]			TINYINT	DEFAULT(0)	CHECK([Tax] >= 0 AND [Tax] <= 100),
	[Discount]		TINYINT	DEFAULT(0)	CHECK([Discount] >= 0 AND [Discount] <= 100)

	CONSTRAINT	[PK_Category_CategoryName]	PRIMARY KEY	([CategoryName])
);

CREATE TABLE [Book]
(
	[BookID]			INT	IDENTITY(1,1),
	[Title]				VARCHAR(150) NOT NULL,
	[CategoryName]		VARCHAR(70) NOT NULL,
	[Price]				SMALLINT CHECK([Price] >= 1) NOT NULL,
	[PublicationDate]	DATE NOT NULL,
	[Quantity]			SMALLINT CHECK([Quantity] >= 0) NOT NULL

	CONSTRAINT	[PK_Book_BookID]	PRIMARY KEY	([BookID])
	CONSTRAINT	[FK_Book_Category_CategoryName]	FOREIGN KEY ([CategoryName]) REFERENCES	[Category]([CategoryName])
);

CREATE TABLE [BooksPublished]
(
	[BookID]		INT,
	[PublisherID]	INT

	CONSTRAINT	[PK_BooksPublished_BookIDAndPublisherID]	PRIMARY KEY	([BookID], [PublisherID]),
	CONSTRAINT	[FK_BooksPublished_Book_BookID]				FOREIGN KEY	([BookID])		REFERENCES	[Book]([BookID]),
	CONSTRAINT	[FK_BooksPublished_Publisher_PublisherID]	FOREIGN KEY	([PublisherID])	REFERENCES	[Publisher]([PublisherID])
);

CREATE TABLE [NumberOfCopiesPurchasedPerBook]
(
	[TransactionID]		INT,
	[BookID]			INT,
	[NumberOfCopies]	TINYINT CHECK([NumberOfCopies] >= 1),
	[TotalPaid]			SMALLINT

	CONSTRAINT	[PK_NumberOfCopiesPurchasedPerBook_TransactionIDAndBookID]		PRIMARY KEY	([TransactionID], [BookID]),
	CONSTRAINT	[FK_NumberOfCopiesPurchasedPerBook_Transaction_TransactionID]	FOREIGN KEY	([TransactionID])	REFERENCES	[Transaction]([TransactionID]),
	CONSTRAINT	[FK_NumberOfCopiesPurchasedPerBook_Book_BookID]					FOREIGN	KEY	([BookID])			REFERENCES	[Book]([BookID])
);

CREATE TABLE [Author]
(
	[AuthorID]	INT IDENTITY(1,1),
	[Name]		VARCHAR(90)	NOT NULL

	CONSTRAINT	[PK_Author_AuthorID]	PRIMARY KEY	([AuthorID])
);
	
CREATE TABLE [AuthoredBooks]
(
	[AuthorID]	INT,
	[BookID]	INT

	CONSTRAINT	[PK_AuthoredBooks_AuthorIDAndBookID]	PRIMARY KEY ([AuthorID], [BookID]),
	CONSTRAINT	[FK_AuthoredBooks_Author_AuthorID]		FOREIGN KEY	([AuthorID])	REFERENCES	Author([AuthorID]),
	CONSTRAINT	[FK_AuthoredBooks_Book_BookID]			FOREIGN KEY	([BookID])		REFERENCES	Book([BookID])
);