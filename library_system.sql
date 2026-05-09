-- ==========================================
-- DBMS PROJECT: LIBRARY MANAGEMENT SYSTEM
-- STUDENT: Abhinav Kumar (Roll No: 1024031186)
-- COURSE: UCS310 – DBMS
-- ==========================================

-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS LibraryDBMS;
USE LibraryDBMS;

-- 2. CREATE TABLES (Relational Schema)

-- Authors Table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Bio TEXT
);

-- Books Table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    AuthorID INT,
    PublishedYear INT,
    CopiesAvailable INT DEFAULT 1,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE SET NULL
);

-- Members Table
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    JoinDate DATE DEFAULT (CURRENT_DATE)
);

-- Issued_Books Table (Mapping Table)
CREATE TABLE Issued_Books (
    IssueID INT AUTO_INCREMENT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    IssueDate DATE DEFAULT (CURRENT_DATE),
    ReturnDate DATE,
    Status ENUM('Issued', 'Returned') DEFAULT 'Issued',
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE
);


-- 3. INSERT SAMPLE DATA

INSERT INTO Authors (Name, Bio) VALUES 
('J.K. Rowling', 'British author, best known for the Harry Potter series.'),
('George Orwell', 'English novelist, known for 1984 and Animal Farm.'),
('R.K. Narayan', 'Indian writer known for his works set in the fictional South Indian town of Malgudi.');

INSERT INTO Books (Title, AuthorID, PublishedYear, CopiesAvailable) VALUES 
('Harry Potter and the Sorcerer''s Stone', 1, 1997, 5),
('1984', 2, 1949, 3),
('Animal Farm', 2, 1945, 2),
('Malgudi Days', 3, 1943, 4);

INSERT INTO Members (Name, Email, Phone, JoinDate) VALUES 
('Rohan Sharma', 'rohan@example.com', '9876543210', '2023-01-15'),
('Priya Singh', 'priya@example.com', '8765432109', '2023-03-22'),
('Amit Kumar', 'amit@example.com', '7654321098', '2023-06-10');


-- 4. BASIC QUERIES & JOINS

-- View all books with their author names (JOIN)
SELECT b.BookID, b.Title, a.Name AS Author, b.CopiesAvailable
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID;

-- 5. GROUP BY & HAVING

-- Find members who have borrowed more than 1 book
SELECT m.Name, COUNT(i.IssueID) AS BooksBorrowed
FROM Members m
JOIN Issued_Books i ON m.MemberID = i.MemberID
GROUP BY m.MemberID, m.Name
HAVING COUNT(i.IssueID) > 1;


-- 6. ADVANCED FEATURE: TRIGGER
-- This trigger automatically decreases CopiesAvailable when a book is issued.
DELIMITER //
CREATE TRIGGER After_Book_Issue
AFTER INSERT ON Issued_Books
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Issued' THEN
        UPDATE Books 
        SET CopiesAvailable = CopiesAvailable - 1 
        WHERE BookID = NEW.BookID;
    END IF;
END;
//
DELIMITER ;


-- 7. ADVANCED FEATURE: STORED PROCEDURE & TRANSACTION
-- This procedure safely issues a book using a transaction. It rolls back if out of stock.
DELIMITER //
CREATE PROCEDURE IssueBookProcess(IN p_BookID INT, IN p_MemberID INT, IN p_ReturnDate DATE)
BEGIN
    DECLARE v_Copies INT;
    
    -- Start Transaction
    START TRANSACTION;
    
    -- Check available copies
    SELECT CopiesAvailable INTO v_Copies FROM Books WHERE BookID = p_BookID;
    
    IF v_Copies > 0 THEN
        -- Insert issue record (Trigger will handle the count deduction)
        INSERT INTO Issued_Books (BookID, MemberID, IssueDate, ReturnDate, Status) 
        VALUES (p_BookID, p_MemberID, CURRENT_DATE, p_ReturnDate, 'Issued');
        
        -- Commit the transaction if successful
        COMMIT;
        SELECT 'Book issued successfully.' AS Message;
    ELSE
        -- Rollback if no copies are available
        ROLLBACK;
        SELECT 'Error: Book is currently out of stock.' AS Message;
    END IF;
END;
//
DELIMITER ;

-- Test the Stored Procedure Example:
-- CALL IssueBookProcess(1, 1);
