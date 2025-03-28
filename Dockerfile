# Stage 1: Build stage
FROM python:3.9-alpine as builder

# Set working directory
WORKDIR /app

# Install system dependencies for MySQL and Flask
RUN apk add --no-cache --virtual .build-deps gcc musl-dev mariadb-connector-c-dev

# Copy application files
COPY . .

# Install Python dependencies
RUN pip install --no-cache-dir --prefix=/install flask flask-mysqldb python-dotenv

# Stage 2: Runtime stage
FROM python:3.9-alpine

# Set working directory
WORKDIR /app

# Install runtime dependencies for MySQL
RUN apk add --no-cache mariadb-connector-c

# Copy only the installed Python packages from the builder stage
COPY --from=builder /install /usr/local

# Copy application files
COPY app.py .
COPY templates templates/
COPY static static/

# Set environment variables
ENV FLASK_APP=app.py \
    FLASK_ENV=production \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create a non-root user
RUN adduser -D appuser
USER appuser

# Expose port
EXPOSE 5000

# Run the application
CMD ["flask", "run", "--host=0.0.0.0"]