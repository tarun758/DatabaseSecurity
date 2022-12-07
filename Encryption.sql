USE APUBSPLDB;

-- Start: Create Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'PZmG4ykx69KBgwmGXq18nQ1m21xsAlYn';
-- End: Create Master Key

-- Start: Create Certificate that is protected by the MasterKey
CREATE CERTIFICATE APUBSPLDBCertificateMasterKeyProtected
	WITH SUBJECT = 'APUBSPLDB Certificate (MasterKey Protected) - Self Signed';
-- End: Create Certificate that is protected by the MasterKey

-- Start: Create Certificate that is protected by a Password
CREATE CERTIFICATE APUBSPLDBCertificatePasswordProtected
	ENCRYPTION BY PASSWORD = 'Tu2QyKbNaWTaDUkCxaXXAQFR67334Y'
	WITH SUBJECT = 'APUBSPLDB Certificate (Password Protected) - Self Signed';
-- End: Create Certificate that is protected by a Password

-- Start: Create an Asymmetric Key that is Protected by the Master Key
CREATE ASYMMETRIC KEY APUBSPLDBAsymmetricKeyMasterKeyProtected
	WITH ALGORITHM = RSA_2048
-- End: Create an Asymmetric Key that is Protected by the Master Key

-- Start: Create an Asymmetric Key that is Protected with a Password
CREATE ASYMMETRIC KEY APUBSPLDBAsymmetricKeyPasswordProtected
	WITH ALGORITHM = RSA_2048
	ENCRYPTION BY PASSWORD = 'xdCE4TAM7YZ99xTf27cUSXW74WGJOMK';
-- End: Create an Asymmetric Key that is Protected with a Password

-- Start: Create Database Encryption Key and enable TDE
CREATE DATABASE ENCRYPTION KEY WITH ALGORITHM = AES_256
	ENCRYPTION BY SERVER CERTIFICATE APUBSPLDBCertificateMasterKeyProtected;
ALTER DATABASE APUBSPLDB SET ENCRYPTION ON;
-- End: Create Database Encryption Key and enable TDE

-- Start: Column Level Encryption for PaymentCardNumber in Member Table Using EncryptByPassphrase
UPDATE [Member] set PaymentCardNumberEncrypted = 
	ENCRYPTBYPASSPHRASE('xdCE4TAM7YZ99xTf27cUSXW74WGds3JOMK', PaymentCardNumberEncrypted) where Member.MemberID = 1;
-- End: Column Level Encryption for PaymentCardNumber in Member Table Using EncryptByPassphrase

-- Start: Column Level Encryption for PaymentCardNumber in Member Table Using ENCRYPTBYCERT
UPDATE [Member] SET PaymentCardNumberEncrypted = 
	ENCRYPTBYCERT(CERT_ID('APUBSPLDBCertificateMasterKeyProtected'), PaymentCardNumberEncrypted) where Member.MemberID = 2;
-- END: Column Level Encryption for PaymentCardNumber in Member Table Using ENCRYPTBYCERT

-- Start: Column Level Encryption for PaymentCardNumber in Member Table Using ENCRYPTBYAssymetricKey
UPDATE [Member] SET PaymentCardNumberEncrypted = 
	ENCRYPTBYASYMKEY(AsymKey_ID('APUBSPLDBAsymmetricKeyMasterKeyProtected'), PaymentCardNumberEncrypted) where Member.MemberID = 3;
-- Start: Column Level Encryption for PaymentCardNumber in Member Table Using ENCRYPTBYAssymetricKey