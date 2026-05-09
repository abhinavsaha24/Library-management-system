# LIBRARY MANAGEMENT SYSTEM - SQL CODE

---

## CREATE DATABASE

```sql
CREATE DATABASE library_system;
USE library_system;
```

---

## CREATE TABLES

### Authors Table
```sql
CREATE TABLE authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    author_name VARCHAR(100) NOT NULL,
    birth_year INT
);
```

### Books Table
```sql
CREATE TABLE books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    book_title VARCHAR(150) NOT NULL,
    author_id INT NOT NULL,
    publication_year INT,
    total_copies INT,
    FOREIGN KEY (author_id) REFERENCES authors(author_id)
);
```

### Members Table
```sql
CREATE TABLE members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    member_name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(10),
    registration_date DATE
);
```

### Issued Books Table
```sql
CREATE TABLE issued_books (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT NOT NULL,
    member_id INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (book_id) REFERENCES books(book_id),
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);
```

---

## SAMPLE DATA

### Authors
```sql
INSERT INTO authors (author_name, birth_year) VALUES
('J.K. Rowling', 1965),
('George R.R. Martin', 1948),
('J.R.R. Tolkien', 1892);
```

### Books
```sql
INSERT INTO books (book_title, author_id, publication_year, total_copies) VALUES
('Harry Potter and the Philosopher''s Stone', 1, 1998, 5),
('A Game of Thrones', 2, 1996, 3),
('The Fellowship of the Ring', 3, 1954, 4);
```

### Members
```sql
INSERT INTO members (member_name, email, phone, registration_date) VALUES
('Abhinav Kumar', 'abhinav@email.com', '9800000001', '2025-01-15'),
('Aryan Singh', 'priya@email.com', '9800000002', '2025-02-20'),
('Rohan Sharma', 'rohan@email.com', '9800000003', '2025-03-10');
```

### Issued Books
```sql
INSERT INTO issued_books (book_id, member_id, issue_date, return_date, status) VALUES
(1, 1, '2025-03-01', '2025-03-15', 'returned'),
(2, 2, '2025-03-05', NULL, 'issued'),
(3, 1, '2025-02-20', '2025-03-10', 'returned');
```

---

## IMPORTANT QUERIES

### Query 1: All Books with Author Names
```sql
SELECT b.book_title, a.author_name, b.publication_year
FROM books b
JOIN authors a ON b.author_id = a.author_id;
```

**Output:** Shows book title, who wrote it, and when it was published.

---

### Query 2: Books Currently Issued (Not Returned)
```sql
SELECT b.book_title, m.member_name, ib.issue_date
FROM issued_books ib
JOIN books b ON ib.book_id = b.book_id
JOIN members m ON ib.member_id = m.member_id
WHERE ib.status = 'issued';
```

**Output:** Shows which books are out with members and since when.

---

### Query 3: Member's Borrowing History
```sql
SELECT b.book_title, ib.issue_date, ib.return_date, ib.status
FROM issued_books ib
JOIN books b ON ib.book_id = b.book_id
WHERE ib.member_id = 1;
```

**Output:** Shows all books borrowed by a specific member and return status.

---

### Query 4: Books by Author Name
```sql
SELECT b.book_title, b.total_copies
FROM books b
JOIN authors a ON b.author_id = a.author_id
WHERE a.author_name = 'J.K. Rowling';
```

**Output:** Shows all books written by a specific author.

---

## HOW TO RUN

1. Open MySQL command line or workbench
2. Copy and paste the database creation code first
3. Create each table one by one
4. Insert sample data
5. Run the queries to see results

All code is tested and ready to use!

