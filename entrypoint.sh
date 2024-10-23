#!/bin/sh -l

# Set the locustfile path
if [ -z "$INPUT_LOCUSTFILE" ]; then
    file="/app/locustfile.py"  # Default locustfile path
else
    file="/github/workspace/$INPUT_LOCUSTFILE"  # User-provided locustfile path
fi

# Set the pyproject.toml file path
if [ -z "$INPUT_REQUIREMENTS" ]; then
    requirements="/app/pyproject.toml"  # Default pyproject.toml path
else
    requirements="/github/workspace/$INPUT_REQUIREMENTS"  # User-provided pyproject.toml path
fi

# Check if the pyproject.toml file exists
if [ ! -f "$requirements" ]; then
    echo "Error: pyproject.toml file not found at $requirements"
    exit 1
fi

# Change directory to where pyproject.toml is located
cd "$(dirname "$requirements")"

# Install dependencies using Poetry (no --file option needed)
poetry install --no-root --verbose && rm -rf $POETRY_CACHE_DIR

# Run Locust tests with provided options
poetry run locust -f "$file" --headless -u "${INPUT_USERS:-5}" -r "${INPUT_RATE:-5}" --run-time "${INPUT_RUNTIME:-10s}" -H "$INPUT_URL" --loglevel "${INPUT_LOGLEVEL:-INFO}"