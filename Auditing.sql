USE master;
-- Start: Create Server Audit and enable it
CREATE SERVER AUDIT [ServerAudit-APUBSPLDB] TO FILE (
											FILEPATH = 'M:\APUBSPLDB-Audits\', 
											MAXSIZE= 1 GB, 
											MAX_ROLLOVER_FILES = 5,
											RESERVE_DISK_SPACE = OFF)
WITH 
(
	QUEUE_DELAY = 1000,
	ON_FAILURE = FAIL_OPERATION
) 
ALTER SERVER AUDIT [ServerAudit-APUBSPLDB] WITH (STATE = ON);
-- End: Create Server Audit and enable it

-- Start: Create Server Audit Specification
CREATE SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB];
ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(SUCCESSFUL_LOGIN_GROUP);
ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(LOGIN_CHANGE_PASSWORD_GROUP);
ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(FAILED_LOGIN_GROUP);
ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(LOGOUT_GROUP);


ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(DATABASE_CHANGE_GROUP);
ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(DATABASE_PERMISSION_CHANGE_GROUP);
ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(DATABASE_OBJECT_OWNERSHIP_CHANGE_GROUP);
ALTER SERVER AUDIT SPECIFICATION [ServerAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD 
	(DATABASE_OBJECT_PERMISSION_CHANGE_GROUP);
-- End: Create Server Audit Specification

-- Start: Create Database Audit Specification --
USE APUBSPLDB;
CREATE DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB];

ALTER DATABASE AUDIT SPECIFICATION [DatabaseAuditSpecification-APUBSPLDB] FOR SERVER AUDIT [ServerAudit-APUBSPLDB] ADD
	(SELECT, UPDATE, INSERT, DELETE, EXECUTE, RECEIVE, REFERENCES ON DATABASE::APUBSPLDB BY [public]);
-- End: Create Database Audit Specification --