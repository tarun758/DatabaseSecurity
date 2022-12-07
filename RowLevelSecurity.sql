-- Start: Row Level Security to allow members only see thier reocrds
CREATE FUNCTION [dbo].[functionSecurityPredicateAllowMembersOnlyTheirRecords]
	(@MemberName AS VARCHAR(90))
RETURNS TABLE
WITH SCHEMABINDING
AS
	RETURN SELECT 1 AS [functionSecurityPredicateAllowMembersOnlyTheirRecordsResult]
	WHERE @MemberName = USER_NAME() OR USER_NAME() = 'dbo';
-- End: Row Level Security to allow members only see thier reocrds

-- Start: Create Security Policy to allow members only see their records
CREATE SECURITY POLICY [SecurityPolicyAllowMembersOnlyTheirRecords]
ADD FILTER PREDICATE
	[dbo].[functionSecurityPredicateAllowMembersOnlyTheirRecords](REPLACE([Name], ' ', ''))
ON [dbo].[Member]
-- End: Create Security Policy to allow members only see their records

-- Start: Row Level Security to allow members only see thier reocrds
CREATE FUNCTION [dbo].[functionSecurityPredicateAllowMembersOnlyTheirTransactions]
	(@MemberID AS INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
	RETURN SELECT 1 AS [functionSecurityPredicateAllowMembersOnlyTheirTransactionsResult]
	WHERE @MemberID = (SELECT [Member].[MemberID] from [dbo].[Member] WHERE 
		REPLACE([Member].[Name], ' ', '') = USER_NAME()) OR USER_NAME() = 'dbo';
-- End: Row Level Security to allow members only see thier reocrds

-- Start: Create Security Policy to allow members only see their records
CREATE SECURITY POLICY [SecurityPolicyAllowMembersOnlyTheirTransactions]
ADD FILTER PREDICATE
	[dbo].[functionSecurityPredicateAllowMembersOnlyTheirTransactions](MemberID)
ON [dbo].[Transaction]
-- End: Create Security Policy to allow members only see their records