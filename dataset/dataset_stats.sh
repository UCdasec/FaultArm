#!/bin/bash

total_lines=0
total_files=0

# Create an array of all .s files recursively
files=($(find . -type f -name '*.s'))

for file in "${files[@]}"; do
    lines=$(cat "$file" | sed '/^\s*@/d;/^\s*$/d' | wc -l)

    # Calculate the number of dots needed based on the file name length and alignment width
    dots_count=$((65 - ${#file}))
    dots=$(printf "%*s" "$dots_count" | tr ' ' '.')

    printf "File: %s%s Lines: %1s\n" "$file" "$dots" "$lines"
    ((total_lines += lines))
    ((total_files++))
done

echo    # Add a new line before displaying the total files
echo "Total files: $total_files"
echo "Total lines in all .s files: $total_lines"

