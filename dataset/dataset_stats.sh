#!/bin/bash

grand_total_lines=0
grand_total_files=0

# Iterate over each subdirectory in the current directory only
for dir in $(find . -maxdepth 1 -type d); do
    total_lines=0
    total_files=0

    # Create an array of all .s files in the current directory
    files=($(find "$dir" -maxdepth 2 -type f -name '*.s'))

    # If there are no .s files in the directory, skip this iteration
    if [ ${#files[@]} -eq 0 ]; then
        continue
    fi

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
    echo "Directory: $dir"
    echo "Total files: $total_files"
    echo "Total lines in all .s files: $total_lines"
    echo "-----------------------------------------"

    ((grand_total_lines += total_lines))
    ((grand_total_files += total_files))
done

echo "Grand total files: $grand_total_files"
echo "Grand total lines in all .s files: $grand_total_lines"