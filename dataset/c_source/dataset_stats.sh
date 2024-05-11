#!/bin/bash

total_lines=0
total_files=0

# Find all .c files recursively and iterate over them
while IFS= read -r file; do
    if [ -e "$file" ]; then
        lines=$(cat "$file" | sed '/^\s*\/\/\|\/\*.*\*\//d; /^\s*$/d' | wc -l)
        
        # Calculate the number of dots needed based on the file name length and alignment width
        dots_count=$((40 - ${#file}))
        dots=$(printf "%*s" "$dots_count" | tr ' ' '.')

        printf "File: %s%s Lines: %1s\n" "$file" "$dots" "$lines"
        ((total_lines += lines))
        ((total_files++))
    fi
done < <(find . -type f -name "*.c")

echo
echo "Total files: $total_files"
echo "Total lines in all C files: $total_lines"

