USE APUBSPLDB;

INSERT INTO [Member]([Name], [City], [Street], [Postcode], [PhoneNumber], [Type], [PaymentCardNumberEncrypted]) 
	VALUES 
		('Peter Carter',	'Ipoh',			'Jalan Sultan Yusuf',	'30000',	'01718057245',	'Staff',	CONVERT(varbinary,'4980900704202707')), 
		('Raj Raj',			'Seremban',		'Era Square',			'70200',	'06331806233',	'Staff',	CONVERT(varbinary,'1793201690392834')), 
		('Adam Muhammad',	'Alor Setr',	'Jalan Raja',			'05460',	'05782347934',	'Staff',	CONVERT(varbinary,'1966064582725999')), 
		('Ian Stirk',		'Malacca City',	'Jalan Tun Ali',		'75300',	'89027016495',	'Student',	CONVERT(varbinary,'1496880409335007')), 
		('Daud Salim',		'Kuantan',		'Taman City',			'25300',	'07611958847',	'Student',	CONVERT(varbinary,'1139267429632501'));
		
INSERT INTO [Transaction]([MemberID], [DateOfPurchase]) 
	VALUES 
		('1',	'2020-02-02'), 
		('2',	'2020-02-03'), 
		('3',	'2020-02-04'), 
		('4',	'2020-02-05'), 
		('5',	'2020-02-06');

INSERT INTO [Publisher]([Name], [Address], [Country]) 
	VALUES 
		('SK Publishers',		'G 2850 Jln Sj 5/7 B Taman Jaya',				'Malysia'), 
		('BK Publishers',		'72 A Jalan Persisiran Perling Taman Perling',	'Thailand'), 
		('Carter Publishers',	'Kipmart Tampoi, Taman Tampoi Indah',			'Singapore'), 
		('MTKH Publishers',		'A 19 Mdn Istana 6 Bandar Raya',				'Malysia');

INSERT INTO [Category]([CategoryName], [Discount], [Tax]) 
	VALUES
		('Children',		'10',	'7'), 
		('Science',			'15',	'10'), 
		('Spiritual',		'20',	'15'), 
		('Fiction',			'17',	'13'), 
		('Cooking',			'23',	'17'), 
		('Miscellaneous',	'25',	'20');

INSERT INTO [Author]([Name]) 
	VALUES 
		('Daud Khalid'),
		('Harron Reddy'),
		('Khirthiga Zanib'),
		('Tarun Ali');

INSERT INTO [Book]([Price], [CategoryName], [PublicationDate], [Quantity], [Title])
	VALUES 
		('200',	'Children',			'2015-01-22',	'300',	'Dream Big Little One'), 
		('220',	'Cooking',			'2014-05-20',	'500',	'Tasty Tabel Delights'), 
		('250',	'Science',			'2016-12-15',	'600',	'Divine Reality'), 
		('210',	'Spiritual',		'2018-08-25',	'125',	'Kindfluness'), 
		('270',	'Fiction',			'2020-04-14',	'512',	'The Paying Guests'), 
		('300',	'Miscellaneous',	'2020-02-14',	'714',	'The War of the worlds');

INSERT INTO [AuthoredBooks]([AuthorID], [BookID]) 
	VALUES 
		('1',	'3'), 
		('1',	'6'), 
		('2',	'1'), 
		('3',	'4'), 
		('4',	'5'), 
		('4',	'2');

INSERT INTO [BooksPublished]([BookID], [PublisherID]) 
	VALUES 
		('1',	'2'),
		('2',	'2'),
		('2',	'3'),
		('3',	'4'),
		('4',	'1'),
		('5',	'3'),
		('6',	'4');

INSERT INTO [NumberOfCopiesPurchasedPerBook]([TransactionID], [BookID], [NumberOfCopies]) 
	VALUES 
		('1',	'6',	'1'),
		('1',	'2',	'6'),
		('2',	'2',	'9'),
		('2',	'3',	'10'),
		('3',	'4',	'2'),
		('3',	'5',	'30'),
		('4',	'6',	'28'),
		('5',	'1',	'13');