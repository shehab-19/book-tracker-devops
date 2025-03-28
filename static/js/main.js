// Add fade effect for flash messages
document.addEventListener('DOMContentLoaded', function() {
    const flashMessages = document.querySelectorAll('.flash-message');
    
    flashMessages.forEach(message => {
        // Automatically remove flash messages after 5 seconds
        setTimeout(() => {
            message.style.opacity = '0';
            setTimeout(() => {
                message.remove();
            }, 500);
        }, 5000);
    });

    // Add smooth hover effects to all interactive elements
    const interactiveElements = document.querySelectorAll('button, .mark-read, .delete');
    interactiveElements.forEach(element => {
        element.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
        });
        
        element.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });

    // Form validation and enhancement
    const addBookForm = document.querySelector('.add-book-form');
    if (addBookForm) {
        addBookForm.addEventListener('submit', function(e) {
            const titleInput = this.querySelector('input[name="title"]');
            const authorInput = this.querySelector('input[name="author"]');

            // Trim whitespace
            titleInput.value = titleInput.value.trim();
            authorInput.value = authorInput.value.trim();

            // Basic validation
            if (titleInput.value.length < 1 || authorInput.value.length < 1) {
                e.preventDefault();
                alert('Please fill in all fields');
                return;
            }
        });
    }

    // Add animation when marking a book as read
    const markReadButtons = document.querySelectorAll('.mark-read');
    markReadButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            const listItem = this.closest('li');
            listItem.style.transition = 'all 0.3s ease';
            listItem.style.backgroundColor = '#e8f5e9';
            // The actual state change will happen when the page reloads
        });
    });

    // Add book list item hover effects
    const bookItems = document.querySelectorAll('li:not(.empty-message)');
    bookItems.forEach(item => {
        item.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-2px)';
            this.style.boxShadow = '0 4px 8px rgba(0,0,0,0.1)';
        });
        
        item.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = '0 2px 4px rgba(0,0,0,0.1)';
        });
    });
});

// Add smooth scrolling to top when adding a new book
if (document.querySelector('.flash-message')) {
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
}