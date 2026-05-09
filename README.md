# 📚 Library Management System Using MySQL

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![Flask](https://img.shields.io/badge/Flask-API-green.svg)
![MySQL](https://img.shields.io/badge/MySQL-Database-orange.svg)
![HTML/CSS](https://img.shields.io/badge/Frontend-HTML%2FCSS-yellow.svg)

A comprehensive, full-stack **Library Management System** built as an academic DBMS project. It features a robust MySQL backend equipped with advanced database elements (Stored Procedures, Triggers), an interactive frontend, and a Flask API.

This project solves the real-world problem of manual, paper-based library record keeping, providing an efficient, error-free, and searchable digital solution.

---

## ✨ Features

- **📖 View Inventory:** Browse all available books, authors, and real-time stock availability.
- **➕ Add Books & Authors:** Register new books and automatically handle author creations to prevent duplication.
- **👥 Member Management:** Register new students/staff as library members.
- **🔄 Book Issuance:** A secure transaction system that issues books to members and handles stock deduction via automated database triggers and stored procedures.

---

## 🛠️ Technology Stack

- **Frontend:** HTML5, Vanilla CSS, JavaScript (Fetch API)
- **Backend:** Python (Flask)
- **Database:** MySQL
- **Architecture:** Client-Server architecture with RESTful API endpoints

---

## 🗄️ Database Architecture

The system utilizes a fully normalized relational database schema (`LibraryDBMS`) with four primary entities:

1. **Authors:** Stores author details and prevents redundant entries.
2. **Books:** Tracks book titles, publication years, and total copies available.
3. **Members:** Manages library users (name, email, phone, etc.).
4. **Issued_Books:** A transaction log of all borrowed books, linking members to books and tracking issue/return dates.

### Advanced DB Elements Implemented:
- **Foreign Key Constraints:** To ensure referential integrity between tables.
- **Stored Procedure (`IssueBookProcess`):** Safely handles book issuance, including availability checks, within a secure transaction block (COMMIT/ROLLBACK).
- **Trigger (`After_Book_Issue`):** Automatically deducts the available book count when a book is successfully issued.

---

## 🚀 Local Setup & Deployment

Follow these steps to run the project locally on your machine.

### Prerequisites
- **Python 3.8+** installed
- **MySQL Server** running

### 1. Database Initialization
1. Open your MySQL client or terminal.
2. Run the `library_system.sql` script to initialize the database, tables, triggers, and procedures:
   ```sql
   source /path/to/library_system.sql
   ```
3. Update the `DB_CONFIG` dictionary in `app.py` with your MySQL credentials:
   ```python
   DB_CONFIG = {
       'host': 'localhost',
       'user': 'root',
       'password': 'YourPasswordHere',
       'database': 'LibraryDBMS'
   }
   ```

### 2. Backend Setup
Open the root directory in your command prompt, Windows PowerShell, or terminal, and run the following commands:

```bash
# Install the required dependencies
pip install -r requirements.txt

# Alternatively, install manually
pip install flask mysql-connector-python

# Start the Flask server
python app.py
```

### 3. Access the Application
- Open your web browser and navigate to: [http://localhost:5000](http://localhost:5000)

---

## 📝 Documentation
For detailed academic documentation, database design decisions, and ER diagrams, refer to:
- 📄 [`REPORT.md`](REPORT.md) - Full project report.
- 📄 [`DBMS_Synopsis_Report.md`](DBMS_Synopsis_Report.md) - Brief project synopsis.
- 🖼️ [`ER_DIAGRAM.png`](ER_DIAGRAM.png) - Visual database schema.

---

## 👨‍💻 Author
**Abhinav Kumar**  
*Roll No:* 1024031186 | *Batch:* 2C81