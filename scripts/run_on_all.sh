#!/bin/bash

# Check for correct number of arguments
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <path_to_python_program> <source_directory> <output_directory>"
    exit 1
fi

PYTHON_PROGRAM="$1"
SOURCE_DIR="$2"
OUTPUT_DIR="$3"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Find all .s files recursively and run the python program on them
find "$SOURCE_DIR" -type f -name "*.s" | while read file; do
    # Get a unique output filename by replacing slashes with underscores
    OUTPUT_FILE=$(echo "$file" | sed 's/^\.\///;s/\//_/g')
    
    # Run the Python program and save the output
    python "$PYTHON_PROGRAM" "$file" > "$OUTPUT_DIR/$OUTPUT_FILE.out"
done

echo "Processing complete!"
