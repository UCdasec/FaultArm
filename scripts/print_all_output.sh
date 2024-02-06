#!/bin/bash

# Check if a directory is provided
if [ $# -lt 1 ]; then
    echo "Usage: $0 <source_directory>"
    exit 1
fi

# Resolve absolute path of the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Source directory
SOURCE_DIRECTORY="$1"

# Output file name
OUTPUT_FILE="../out/output.txt"

# Loop through each .s file in the directory
find "$SOURCE_DIRECTORY" -type f -name '*.s' | while read -r file; do
    # Run the Python program and append the output to output.txt
    echo "Processing $file..."
    python3 "../main.py" "$file" >> "$OUTPUT_FILE"
done

echo "Processing complete. Output saved in $OUTPUT_FILE."
