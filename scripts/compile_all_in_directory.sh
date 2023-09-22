#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -lt 3 ]; then
    echo "Usage: $0 <architecture> <source_directory> <destination_directory>"
    echo "Supported architectures: arm, x86"
    exit 1
fi

# Source directory containing C files
source_dir="$2"

# Destination directory for assembly files
dest_dir="$3"

# Target architecture
architecture="$1"

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory does not exist: $source_dir"
    exit 1
fi

# Check if the destination directory exists, create it if not
if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi

# Determine the compiler based on the specified architecture
if [ "$architecture" = "arm" ]; then
    compiler="arm-linux-gnueabi-gcc"
elif [ "$architecture" = "x86" ]; then
    compiler="gcc"
else
    echo "Unsupported architecture: $architecture"
    exit 1
fi

# Compile all C files in the source directory to assembly in the destination directory
for file in "$source_dir"/*.c; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        assembly_file="$dest_dir/${filename%.c}.s"
        
        # Compile to assembly using the selected compiler
        "$compiler" -S "$file" -o "$assembly_file"
        
        if [ $? -eq 0 ]; then
            echo "Compiled $file to $assembly_file"
        else
            echo "Error compiling $file"
        fi
    fi
done
