from flask import Flask, send_file, request, jsonify
import mysql.connector
from mysql.connector import Error
import os

app = Flask(__name__)

# Configure your MySQL connection details here
DB_CONFIG = {
    'host': 'localhost',
    'user': 'root',
    'password': 'Abhinav123#',  # <--- password
    'database': 'LibraryDBMS'
}

def get_db_connection():
    try:
        conn = mysql.connector.connect(**DB_CONFIG)
        if conn.is_connected():
            return conn
    except Error as e:
        print(f"Error connecting to MySQL: {e}")
    return None

@app.route('/')
def index():
    # Serve the static HTML file
    return send_file('index.html')

@app.route('/api/books', methods=['GET'])
def get_books():
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Database connection failed'}), 500
    
    cursor = conn.cursor(dictionary=True)
    query = """
        SELECT b.BookID, b.Title, a.Name AS Author, b.PublishedYear, b.CopiesAvailable
        FROM Books b
        LEFT JOIN Authors a ON b.AuthorID = a.AuthorID
    """
    cursor.execute(query)
    books = cursor.fetchall()
    
    # Add a simple status logic based on copies
    for book in books:
        book['Status'] = 'Available' if book['CopiesAvailable'] > 0 else 'Out of Stock'
        
    cursor.close()
    conn.close()
    return jsonify(books)

@app.route('/api/books', methods=['POST'])
def add_book():
    data = request.json
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Database connection failed'}), 500
    
    try:
        cursor = conn.cursor()
        # Simple logic: check if author exists, if not, create
        cursor.execute("SELECT AuthorID FROM Authors WHERE Name = %s", (data['author'],))
        author_res = cursor.fetchone()
        
        if author_res:
            author_id = author_res[0]
        else:
            cursor.execute("INSERT INTO Authors (Name) VALUES (%s)", (data['author'],))
            author_id = cursor.lastrowid
            
        # Insert book
        cursor.execute(
            "INSERT INTO Books (Title, AuthorID, PublishedYear, CopiesAvailable) VALUES (%s, %s, %s, %s)",
            (data['title'], author_id, data['year'], data['copies'])
        )
        conn.commit()
        return jsonify({'message': 'Book added successfully!'})
    except Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/members', methods=['POST'])
def add_member():
    data = request.json
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Database connection failed'}), 500
    
    try:
        cursor = conn.cursor()
        cursor.execute(
            "INSERT INTO Members (Name, Email, Phone) VALUES (%s, %s, %s)",
            (data['name'], data['email'], data['phone'])
        )
        conn.commit()
        return jsonify({'message': 'Member added successfully!'})
    except Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        conn.close()

@app.route('/api/issue', methods=['POST'])
def issue_book():
    data = request.json
    conn = get_db_connection()
    if not conn:
        return jsonify({'error': 'Database connection failed'}), 500
    
    try:
        cursor = conn.cursor()
        # Call the stored procedure we created
        cursor.callproc('IssueBookProcess', [data['book_id'], data['member_id'], data.get('return_date')])
        conn.commit()
        
        # MySQL stored procedures return result sets. Let's fetch the message.
        for result in cursor.stored_results():
            message = result.fetchone()[0]
            if "Error" in message:
                return jsonify({'error': message}), 400
            else:
                return jsonify({'message': message})
                
        return jsonify({'message': 'Book issued!'})
    except Error as e:
        return jsonify({'error': str(e)}), 500
    finally:
        cursor.close()
        conn.close()

if __name__ == '__main__':
    print("Starting Flask server at http://localhost:5000")
    print("WARNING: Ensure MySQL is running and the database is initialized.")
    app.run(debug=True, port=5000)
