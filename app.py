import os
from flask import Flask, render_template, request, redirect, url_for, jsonify, flash
from flask_mysqldb import MySQL
from dotenv import load_dotenv
from MySQLdb.cursors import DictCursor  # Import DictCursor

app = Flask(__name__)

load_dotenv()

# Configure Flask app
app.secret_key = os.environ.get('SECRET_KEY', os.urandom(24))

# Configure MySQL from environment variables
app.config['MYSQL_HOST'] = os.environ.get('MYSQL_HOST', 'localhost')
app.config['MYSQL_USER'] = os.environ.get('MYSQL_USER', 'default_user')
app.config['MYSQL_PASSWORD'] = os.environ.get('MYSQL_PASSWORD', 'default_password')
app.config['MYSQL_DB'] = os.environ.get('MYSQL_DB', 'default_db')

# Initialize MySQL
mysql = MySQL(app)

# Create the database table if it doesn't exist
def init_db():
    with app.app_context():
        cur = mysql.connection.cursor()
        cur.execute('''
            CREATE TABLE IF NOT EXISTS books (
                id INT AUTO_INCREMENT PRIMARY KEY,
                title VARCHAR(255) NOT NULL,
                author VARCHAR(255) NOT NULL,
                `read` BOOLEAN NOT NULL DEFAULT 0
            );
        ''')
        mysql.connection.commit()
        cur.close()

# Call init_db when the app is created
init_db()

# Home route - Display all books
@app.route('/')
def index():
    try:
        cur = mysql.connection.cursor(DictCursor)  # Use DictCursor
        cur.execute('SELECT * FROM books ORDER BY id DESC')
        books = cur.fetchall()
        cur.close()
        return render_template('index.html', books=books)
    except Exception as e:
        flash(f'Error loading books: {str(e)}', 'error')
        return render_template('index.html', books=[])

# Add a new book
@app.route('/add', methods=['POST'])
def add():
    title = request.form.get('title', '').strip()
    author = request.form.get('author', '').strip()
    
    if not title or not author:
        flash('Both title and author are required!', 'error')
        return redirect(url_for('index'))
    
    try:
        cur = mysql.connection.cursor()
        cur.execute('INSERT INTO books (title, author) VALUES (%s, %s)', (title, author))
        mysql.connection.commit()
        cur.close()
        flash('Book added successfully!', 'success')
    except Exception as e:
        flash(f'Error adding book: {str(e)}', 'error')
    
    return redirect(url_for('index'))

# Mark a book as read
@app.route('/read/<int:id>')
def read(id):
    try:
        cur = mysql.connection.cursor()
        cur.execute('UPDATE books SET `read` = 1 WHERE id = %s', (id,))
        mysql.connection.commit()
        cur.close()
        
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return jsonify({'success': True})
            
        flash('Book marked as read!', 'success')
    except Exception as e:
        flash(f'Error updating book: {str(e)}', 'error')
        if request.headers.get('X-Requested-With') == 'XMLHttpRequest':
            return jsonify({'success': False, 'error': str(e)})
    
    return redirect(url_for('index'))

# Delete a book
@app.route('/delete/<int:id>')
def delete(id):
    try:
        cur = mysql.connection.cursor()
        cur.execute('DELETE FROM books WHERE id = %s', (id,))
        mysql.connection.commit()
        cur.close()
        flash('Book deleted successfully!', 'success')
    except Exception as e:
        flash(f'Error deleting book: {str(e)}', 'error')
    
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)