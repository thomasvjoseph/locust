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

# Set the HTML output file path
if [ -z "$INPUT_HTML_REPORT" ]; then
    html_report="example.html"  # Default HTML report filename
else
    html_report="$INPUT_HTML_REPORT"  # User-provided HTML report filename
fi

# Check if the pyproject.toml file exists
if [ ! -f "$requirements" ]; then
    echo "Error: pyproject.toml file not found at $requirements"
    exit 1
fi

# Change directory to where pyproject.toml is located
cd "$(dirname "$requirements")"

# Install dependencies using Poetry
poetry install --no-root --verbose && rm -rf $POETRY_CACHE_DIR

# Run Locust tests with provided options, outputting results to an HTML file
poetry run locust -f "$file" --headless -u "${INPUT_USERS:-5}" -r "${INPUT_RATE:-5}" --run-time "${INPUT_RUNTIME:-10s}" -H "$INPUT_URL" --loglevel "${INPUT_LOGLEVEL:-INFO}" --html="$html_report"

# Check if HTML report file exists and move it to the correct location
if [ -f "$html_report" ]; then
    # Check if the destination is different from the source
    if [ -d "/github/workspace" ]; then
        if [ "/github/workspace/$html_report" != "$(pwd)/$html_report" ]; then
            cp "$html_report" /github/workspace/
            echo "HTML report $html_report copied to /github/workspace/"
        else
            echo "HTML report $html_report is already in the destination directory, no need to copy."
        fi
    else
        echo "Warning: /github/workspace does not exist, no copy needed as the file is already in the current directory."
    fi
else
    echo "Error: HTML report file $html_report not found"
    exit 1
fi