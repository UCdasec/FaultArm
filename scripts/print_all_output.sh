#!/bin/bash

# Check if a directory is provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <source_directory> <output_file_name>"
    exit 1
fi

DIRECTORY=$1
OUTPUT_FILE_NAME=$2

# Loop through each .s file in the directory
for file in "$DIRECTORY"/*.s; do
    # Check if file exists
    if [ -f "$file" ]; then
        echo "Processing $file..."
        # Run the Python program and append the output to output.txt
        python main.py "$file" >> $OUTPUT_FILE_NAME.txt
    fi
done

echo "Processing complete. Output saved in $OUTPUT_FILE_NAME.txt."
