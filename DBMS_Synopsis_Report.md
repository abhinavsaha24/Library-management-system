# 1. TITLE PAGE

**Project Title:** Library Management System  
**Course:** UCS310 – Database Management Systems (DBMS)  
**Student Name:** Abhinav Kumar  
**Roll No:** 1024031186  
**Batch:** 2C81  
**Instructor:** Shivani Goswami  
**Academic Year:** 2025-2026  

---

# 2. INTRODUCTION

Libraries handle a massive amount of data every day, from tracking books to managing members and keeping records of who borrowed what. When I started thinking about this project, I realized that doing all this manually using ledgers or Excel sheets is extremely inefficient. 

In this project, we tried to build a streamlined **Library Management System (LMS)** using a relational database (MySQL). The main goal was to design a backend that actually makes sense and accurately models how a real college or public library operates. We needed a DBMS because data needs to be structured, easily searchable, and most importantly, consistent. Nobody wants a system where a book shows as "available" when someone already took it home.

---

# 3. PROBLEM STATEMENT

If a library doesn't use a proper database, they face several annoying issues:
- **Data Redundancy:** Keeping the same member's details in multiple registers.
- **Inconsistency:** A book's title might be updated in the main inventory but not in the issue logs.
- **Slow Searching:** Trying to manually find if a specific book is available takes way too much time.
- **Lack of Tracking:** It's hard to track overdue books or calculate fines without automated queries.

We needed a system that acts as a central hub, ensuring all these problems are handled automatically by the database itself.

---

# 4. OBJECTIVES

For this project, my main objectives were:
1. **ER Modeling:** To visually map out the entities (Books, Members, Authors) and how they interact.
2. **Relational Schema:** To convert the ER diagram into actual tables with proper primary and foreign keys.
3. **Normalization:** To apply up to 3rd Normal Form (3NF) to ensure our tables don't have redundant data.
4. **SQL Implementation:** To write functional queries for daily library tasks.
5. **Data Consistency:** To use constraints, triggers, and transactions to make sure the data doesn't break if something goes wrong.

---

# 5. PROPOSED SYSTEM

The system I've designed is essentially a backend-first approach to managing a library. It works by linking members to the books they borrow through an "Issued_Books" table. 

**Key Features:**
- Librarians can add new books and register new members.
- The system prevents a member from borrowing a book if it's out of stock.
- We keep a clear record of issue dates and expected return dates.
- We use SQL triggers to automatically update the available book count whenever someone borrows or returns a book. 

---

# 6. DATABASE DESIGN

### Entity-Relationship (ER) Diagram Explanation
When designing the ER diagram, I broke the system down into four main entities:
- **Authors:** Stores author details. (1 to Many relationship with Books)
- **Books:** Stores book details, copies available, and is linked to Authors.
- **Members:** Stores user data (students/staff).
- **Issued_Books:** This is a mapping/transaction table that links Members and Books. (Many to Many relationship resolved into two 1:M relationships).

### Relational Schema
- `Authors (AuthorID [PK], Name, Bio)`
- `Books (BookID [PK], Title, AuthorID [FK], PublishedYear, CopiesAvailable)`
- `Members (MemberID [PK], Name, Email, Phone, JoinDate)`
- `Issued_Books (IssueID [PK], BookID [FK], MemberID [FK], IssueDate, ReturnDate, Status)`

---

# 7. NORMALIZATION

To make sure the database is efficient, I normalized it up to 3NF. Here's a simple explanation of what I did:

- **1NF (First Normal Form):** I made sure every column holds atomic values. For example, instead of having a "PhoneNumbers" column with multiple numbers, each member gets a single primary phone number.
- **2NF (Second Normal Form):** I ensured there are no partial dependencies. Everything in the `Books` table depends entirely on the `BookID`, not just part of a composite key.
- **3NF (Third Normal Form):** I removed transitive dependencies. For instance, instead of storing the Author's Name directly in the `Books` table (which would duplicate the name if the author has multiple books), I created a separate `Authors` table and just used `AuthorID` in the books table.

---

# 8. SQL IMPLEMENTATION

The implementation handles all core CRUD operations. 
- **DDL:** `CREATE DATABASE`, `CREATE TABLE` with appropriate constraints (NOT NULL, UNIQUE, FOREIGN KEY).
- **DML:** `INSERT` statements to populate sample data.
- **DQL:** Complex `SELECT` queries using `JOIN` to see which member borrowed which book.
- **Aggregations:** Using `GROUP BY` and `HAVING` to find things like "Members who have borrowed more than 1 book".

*(Note: The actual SQL code is provided in the separate .sql file)*

---

# 9. ADVANCED FEATURES

To make this a proper DBMS project, I didn't just stop at basic tables. I added a few advanced concepts:

1. **Stored Procedure:** I wrote a procedure called `IssueBookProcess` that takes a BookID and MemberID, and handles the logic of issuing a book in one go.
2. **Trigger:** I created a trigger `After_Book_Issue` that automatically deducts 1 from `CopiesAvailable` in the `Books` table whenever a new record is inserted into the `Issued_Books` table.
3. **Transaction (COMMIT/ROLLBACK):** When issuing a book, the system uses a transaction. If the book is out of stock, the transaction rolls back, ensuring we never have negative book copies. If successful, it commits.

---

# 10. FRONTEND

For the frontend, I kept things simple and clean. It's built using standard HTML and CSS. It's not over-designed, but it's neat enough to show during a viva without looking messy. It includes:
- A clean navigation bar.
- Forms to add a new book and a new member.
- A table layout to view all books.
- A dedicated section for issuing books.

*(Note: The actual HTML/CSS code is provided in the separate index.html file)*

---

# 11. TOOLS USED

- **Database:** MySQL
- **Query Language:** SQL
- **Frontend UI:** HTML5, CSS3, JavaScript (for UI toggles)
- **IDE/Environment:** MySQL Workbench, VS Code

---

# 12. EXPECTED OUTCOME & REFLECTIONS

By the end of this project, the database works exactly as intended. The queries execute efficiently, and the system easily handles basic constraints like preventing invalid book issues. 

**Learning Reflections:**
- I honestly struggled a bit with foreign key constraints at first when trying to delete records, but I learned how `ON DELETE CASCADE` works.
- Writing the trigger was the most satisfying part of the project because it felt like the database was finally "thinking" for itself and automating the math for book copies.
- I realized that a good database design (doing the ER diagram and normalization properly) makes writing SQL queries way easier later on.
