use master
GO
IF DB_ID('BibloteksDatabase') IS NOT NULL--Drops the database if it exists
	begin
		ALTER DATABASE BibloteksDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE
		DROP DATABASE BibloteksDatabase
	END

CREATE DATABASE  BibloteksDatabase;--creates the database.

USE BibloteksDatabase;--uses the database
GO
--Below creates tables
Create table Authors(
	Author_ID int IDENTITY(1,1) primary key NOT NULL,--Identity increase the id Automactily.
	Author_Name nvarchar(MAX)
	)


CREATE TABLE BOOKS(
	Books_ID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
	Book_Title nvarchar(Max),
	Author_ID int,
	FOREIGN KEY (Author_ID) references Authors(Author_ID)--Connects to the Primary key
	);

CREATE TABLE Borrowers(
	Borrower_ID int IDENTITY(1,1) primary key,
	Borrower_Name nvarchar(MAX),
	Borrower_Email nvarchar(MAX),
	borowed bit,
	Books_ID int,

	FOREIGN KEY(Books_ID) references BOOKS(Books_ID)
	);

INSERT INTO Authors (Author_Name) --Creates all the data
VALUES 
('J.K Rowling'),
 ('Harper Lee'),
('F. Scott Fitzgerald'),
('Jane Austen'),
('J.D. Salinger')

INSERT INTO BOOKS (Book_Title, Author_ID)
VALUES
('Harry Potter and the Philiospher Stone',1),
('Harry Potter and the Chambers of Secrets',1),
('Harper Lee', 2),
('The Great Gatspy', 3),
('Pride and Prejudice',4),
('The Catcher in the Rye',5)

INSERT INTO Borrowers(Borrower_Name,Borrower_Email,Books_ID, borowed)
VALUES
('John Smith','Johnsmith@google.com',1,1),
('Emma Johnson','Emmajohnson@google.com',2,1),
('Micheal Brown','Michealbrown@google.com',3,1),
('Sophia Davis','Sophiadavis@google.com',4,1),
('William Wilson','Williamwilson@google.com',5,1)

--Below shows all books connected to an author.
--"COUNT" counts how many books they have made.
--STRING_AGG's sure that if there are more than one book a comma will show afterwards for each book and put side by side.
SELECT COUNT(BOOKS.Books_ID) AS AmountOfBooks,Authors.Author_Name as Author, STRING_AGG(BOOKS.Book_Title,', ') as title 
FROM Authors 
Join BOOKS on Authors.Author_ID = BOOKS.Author_ID
GROUP BY Authors.Author_Name

--shows all those who have borrowed books
Select Borrowers.Borrower_Name as Borrower, BOOKS.Book_Title, borowed
From Borrowers
join BOOKS on Borrowers.Books_ID = BOOKS.Books_ID
where borowed = 1

Go
CREATE PROCEDURE TrueOrFalse--Creates the Procedure
AS
BEGIN
	update Borrowers 
	SET borowed = 0
	where Borrower_ID = 1 or Borrower_ID = 4
end;
GO

EXECUTE TrueOrFalse--executes the Procedure
--Shows the changes. Those with zero is false
Select Borrowers.Borrower_Name as Borrower, BOOKS.Book_Title, borowed
From Borrowers
join BOOKS on Borrowers.Books_ID = BOOKS.Books_ID 
where borowed = 1;