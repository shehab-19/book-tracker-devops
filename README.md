# Book Tracker Application

A simple Flask application for tracking your reading list. You can add books, mark them as read, and remove them from your list.

## Features

- Add new books with title and author
- Mark books as read
- Delete books from the list
- Modern, responsive UI
- Flash messages for user feedback
- AJAX-powered interactions
- Confirmation dialogs for deletions

## Setup

1. Clone the repository
2. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

3. Install dependencies:
```bash
pip install flask flask-mysqldb python-dotenv
```

4. Copy `.env.example` to `.env` and update with your MySQL credentials:
```bash
cp .env.example .env
```

5. Create a MySQL database named 'bookstore' (or your chosen name)

6. Run the application:
```bash
python app.py
```

7. Visit `http://localhost:5000` in your browser

## Structure

- `app.py`: Main Flask application
- `templates/index.html`: HTML template
- `static/css/style.css`: Styling
- `static/js/main.js`: Client-side interactions
- `.env`: Configuration (create from .env.example)

## Error Handling

The application includes comprehensive error handling for:
- Database operations
- Input validation
- User feedback via flash messages

## UI/UX Features

- Clean, modern design
- Responsive layout
- Animated flash messages
- Smooth transitions
- Confirmation dialogs
- AJAX updates for read status