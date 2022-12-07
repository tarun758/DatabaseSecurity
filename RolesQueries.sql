USE APUBSPLDB;

-- Start: Role for MembersRole -- 
CREATE ROLE [MembersRole];
GRANT SELECT ON [Member]	TO MembersRole;
GRANT SELECT ON [Book]		TO MembersRole;
GRANT UPDATE ON [Member](
						[Name],
						[City], 
						[Street], 
						[Postcode], 
						[PhoneNumber],
						[PaymentCardNumberEncrypted]
						)
			TO MembersRole;

GRANT SELECT ON dbo.UndeletedTransactionsView						TO	[MembersRole];
GRANT UPDATE, DELETE ON [Transaction]								TO	[MembersRole];
GRANT SELECT, UPDATE, DELETE ON [NumberOfCopiesPurchasedPerBook]	TO	[MembersRole];
--- End: Role for Members --

--- Start: Role for Book Store Administrators --
CREATE ROLE BookStoreAdministratorsRole;
GRANT SELECT, UPDATE, INSERT, DELETE	ON	[Book]				TO [BookStoreAdministratorsRole];
GRANT SELECT, UPDATE, INSERT, DELETE	ON	[Publisher]			TO [BookStoreAdministratorsRole];
GRANT SELECT, UPDATE, INSERT, DELETE	ON	[Author]			TO [BookStoreAdministratorsRole];
GRANT SELECT, UPDATE, INSERT, DELETE	ON	[AuthoredBooks]		TO [BookStoreAdministratorsRole];
GRANT SELECT, UPDATE, INSERT, DELETE	ON	[Publisher]			TO [BookStoreAdministratorsRole];
GRANT SELECT, UPDATE, INSERT, DELETE	ON	[BooksPublished]	TO [BookStoreAdministratorsRole];
GRANT SELECT, UPDATE, INSERT, DELETE	ON	[Category]			TO [BookStoreAdministratorsRole];
GRANT SELECT, INSERT, UPDATE			ON	[Member]			TO [BookStoreAdministratorsRole];
GRANT SELECT							ON	[Transaction]		TO [BookStoreAdministratorsRole];
--- End: Role for Book Store Administrators --

--- Start: Role for Database Administrators --
CREATE ROLE DatabaseAdministratorsRole;
GRANT ALTER ON DATABASE::[APUBSPLDB] TO [DatabaseAdministratorsRole]; -- only ALTER needed
--- End: Role for Database Administrators --

--- Start: Role for Management --
CREATE ROLE ManagementRole;
GRANT SELECT ON DATABASE::[APUBSPLDB] TO [ManagementRole];
--- End: Role for Management --

-- Start: Assign User PeterCarter to ManagementRole --
ALTER ROLE ManagementRole ADD MEMBER PeterCarter;
-- End: Assign User PeterCarter to ManagementRole --

-- Start: Assign User RajRaj to DatabaseAdministratorsRole --
ALTER ROLE DatabaseAdministratorsRole ADD MEMBER RajRaj;
-- End: Assign User RajRaj to DatabaseAdministratorsRole --

-- Start: Assign User AdamMuhammad to [BookStoreAdministratorsRole] --
ALTER ROLE [BookStoreAdministratorsRole] ADD MEMBER [AdamMuhammad];
-- End: Assign User AdamMuhammad to [BookStoreAdministratorsRole] --

-- Start: Assign User IanStirk to MembersRole --
ALTER ROLE [MembersRole] ADD MEMBER [IanStirk];
-- End: Assign User IanStirk to MembersRole --

-- Start: Assign User DaudSalim to MembersRole --
ALTER ROLE [MembersRole] ADD MEMBER [DaudSalim];
-- End: Assign User DaudSalim to MembersRole --