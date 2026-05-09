# PROJECT REPORT: LIBRARY MANAGEMENT SYSTEM

---

**Student Name:** Abhinav Kumar  
**Roll No:** 1024031186  
**Batch:** 2C81  
**Project Title:** Library Management System Using MySQL  
**Date:** May 5, 2026

---

## 1. INTRODUCTION

During our database course, we were asked to create a complete database system for a real-world scenario. I chose to build a Library Management System because most smaller libraries still use manual processes, making it really hard to track books and members efficiently. Honestly, I've seen librarians struggle to find basic book availability, so this felt like a practical problem to solve.

A library management system is software that stores and organizes information about books, members, and borrowing records. Instead of keeping track of everything on paper or in separate spreadsheets, everything is in one organized database that's easy to search and update.

In this report, I'll explain:
- Why this project was needed
- How I designed the database (and the mistakes I made along the way)
- The SQL code I wrote
- How the system works
- What I actually learned from building it

---

## 2. THE PROBLEM

When I visited a local library, I noticed several issues with how they manage records:

**Manual Record Keeping:** Staff keeps borrowing records in notebooks and spreadsheets, which is slow and error-prone. Sometimes handwriting is barely readable.

**Hard to Search:** If someone wants to know if a book is available, staff has to flip through logs or search multiple documents.

**No Reports:** The library can't easily tell which books are most popular or which members borrow most frequently.

**Data Scattered:** Information about authors, books, and members is all mixed together, making it confusing.

**Human Errors:** Without a structured system, it's easy to enter the same data twice or lose information.

I realized that a well-designed database could solve all these problems.

---

## 3. OUR SOLUTION & OBJECTIVES

I decided to build a database system that would:

**Primary Goal:** Store and organize library data in one place so staff can instantly find or update information without panicking when there's a long queue of students.

**Specific Objectives:**
1. Create a database that tracks authors, books, members, and borrowing records separately.
2. Link the data together so we can ask questions like "Which books did member X borrow?" or "Which book is still borrowed and overdue?"
3. Make searching fast and accurate.
4. Prevent duplicate information (no author name stored twice).
5. Create useful queries that answer common library questions.

---

## 4. DATABASE DESIGN

### Entities and Tables

I identified that the library needs to track 4 main things:

**Authors:** Who wrote the books
- Stores: author name, birth year (or just a short bio)

**Books:** What's available in the library
- Stores: book title, who wrote it, publication year, how many copies

**Members:** People with library memberships
- Stores: member name, email, phone, registration date

**Issued Books:** Records of every borrowing
- Stores: which book, who borrowed it, when issued, when returned, current status

### Relationships

- **One author can write many books** (1:M relationship)
- **One book can be borrowed many times** (1:M relationship)
- **One member can borrow many books** (1:M relationship)

This structure ensures:
- No repetition (each author's name stored once)
- Easy updates (change book info in one place)
- Complete history (all borrowing records preserved)

---

## 5. DATABASE IMPLEMENTATION

### SQL Structure

I created the database using standard SQL code:

```sql
CREATE DATABASE IF NOT EXISTS LibraryDBMS;
USE LibraryDBMS;
```

Then I created four tables with these key fields:

**Authors:** AuthorID (PK), Name, Bio
**Books:** BookID (PK), Title, AuthorID (FK), PublishedYear, CopiesAvailable
**Members:** MemberID (PK), Name, Email, Phone, JoinDate
**Issued_Books:** IssueID (PK), BookID (FK), MemberID (FK), IssueDate, ReturnDate, Status

### Sample Data

I inserted realistic test data:
- 3 authors (J.K. Rowling, George Orwell, R.K. Narayan)
- Books like Harry Potter, 1984, Malgudi Days
- 3 members including myself (Rohan, Priya, Amit)
- Borrowing records showing issued and returned books

### Queries

I tested some important queries:
1. **Find all books with author names** - Uses JOIN to combine books with author information.
2. **Find members who borrowed more than 1 book** - Uses GROUP BY and HAVING.
3. **Trigger Implementation** - Added a trigger `After_Book_Issue` to automatically decrease the book count when it's issued.
4. **Stored Procedure** - Added `IssueBookProcess` to handle the transaction safely and rollback if a book is out of stock.

---

## 6. KEY FEATURES & BENEFITS

**Instant Search:** Instead of manually checking, staff can find any book in seconds using a SQL query.

**Accurate Records:** Data is organized logically, preventing duplicate entries and mistakes.

**History Tracking:** Every borrowing and return is recorded, so the library can see patterns and track overdue books.

**Scalable:** The design works whether the library has 10 books or 10,000 books - no restructuring needed.

---

## 7. CHALLENGES FACED

**Challenge 1: Structuring Data Properly**
Initially, I thought about putting everything in one big table. But I quickly realized that would create a lot of repetition (like repeating an author's bio for every single book they wrote). Separating it into multiple tables and connecting them with Foreign Keys solved this.

**Challenge 2: Writing Correct JOINs**
Getting SQL JOINs right took some practice. Sometimes I'd run a query and get way too many rows because I messed up the ON condition. Testing with small sample data helped me debug this.

**Challenge 3: Figuring out the Stored Procedure**
To be honest, the stored procedure for issuing a book was the trickiest part. I wanted to make sure the system checked if a book was actually available before issuing it. Learning how to use START TRANSACTION, COMMIT, and ROLLBACK was a bit confusing at first, but it makes the database way more robust.

---

## 8. LEARNING OUTCOMES

Building this project taught me:

1. **Database Design Matters** - Good structure prevents problems. Bad structure causes major headaches later when writing queries.
2. **Relationships Are Powerful** - By linking tables together, I can ask complex questions.
3. **Simplicity Works Best** - I realized that a clean relational schema is much easier to manage than an overcomplicated one.
4. **Triggers and Procedures are useful** - Before this, I thought we'd do everything in the backend (Python), but pushing some logic like stock-deduction directly into the database via triggers feels much cleaner and safer.

---

## 9. FUTURE IMPROVEMENTS

If I had more time to develop this further:
1. **Fine Management** - Calculate automatic late fees for overdue books using a chron job or event scheduler.
2. **Reservations** - Allow members to reserve books currently issued to others.
3. **Login System** - Add authentication so only authorized librarians can issue books.

---

## 10. CONCLUSION

The Library Management System I built solves real problems that libraries face. Instead of manual, error-prone record keeping, the database makes information organized, searchable, and reliable. 

This project showed me that databases aren't just theoretical course material - they're extremely practical tools. I feel much more confident writing SQL, creating schemas, and integrating it with a web interface.

---

**Total Pages:** ~5 pages (submission-ready length)
