#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

# Source directory containing C files
source_dir="$1"

# Destination directory for assembly files
dest_dir="$2"

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory does not exist: $source_dir"
    exit 1
fi

# Check if the destination directory exists, create it if not
if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi


# Compile all C files in the source directory to assembly in the destination directory
for file in "$source_dir"/*.c; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        
        if [ ! -d "$dest_dir/arm" ]; then
            mkdir -p "$dest_dir/arm"
        fi
        
        assembly_file="$dest_dir/arm/${filename%.c}.s"
        
        # Compile to assembly using the selected compiler
        "arm-linux-gnueabi-gcc" -S "$file" -o "$assembly_file"
        
        if [ $? -eq 0 ]; then
            echo "Compiled $file to $assembly_file"
        else
            echo "Error compiling $file"
        fi
    fi
done

for file in "$source_dir"/*.c; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")

        if [ ! -d "$dest_dir/x86" ]; then
            mkdir -p "$dest_dir/x86"
        fi

        assembly_file="$dest_dir/x86/${filename%.c}.s"
        
        # Compile to assembly using the selected compiler
        "gcc" -S "$file" -o "$assembly_file"
        
        if [ $? -eq 0 ]; then
            echo "Compiled $file to $assembly_file"
        else
            echo "Error compiling $file"
        fi
    fi
done
