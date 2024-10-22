# Use the official Python image as a base
FROM python:3.11-slim

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache
    
# Set working directory
WORKDIR /app

# Install Poetry
RUN pip install poetry

#Copy locustfile.py
COPY locustfile.py /app/locustfile.py

# Copy the pyproject.toml
COPY pyproject.toml /app/pyproject.toml

# Install dependencies using Poetry
RUN poetry install --no-root --verbose && rm -rf $POETRY_CACHE_DIR

# Copy the entrypoint script
COPY entrypoint.sh /app/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /app/entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/app/entrypoint.sh"]