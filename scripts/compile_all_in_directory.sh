#!/bin/bash

# Check if the correct number of arguments are provided
if [ $# -lt 3 ]; then
    echo "Usage: $0 <optimization_level> <source_directory> <destination_directory> [architecture]"
    exit 1
fi

# Optimizaiton Level
optimization_level="$1"

# Source directory containing C files
source_dir="$2"

# Destination directory for assembly files
dest_dir="$3"

# Architecture (optional)
if [ $# -eq 4 ]; then
    architecture="$4"
else
    architecture="arm-none-eabi-gcc" # Default to arm-none-eabi-gcc if architecture is not specified
fi

# Check if the source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Source directory does not exist: $source_dir"
    exit 1
fi

# Check if the destination directory exists, create it if not
if [ ! -d "$dest_dir" ]; then
    mkdir -p "$dest_dir"
fi

# Compile all C files in the source directory and its subdirectories to assembly in the destination directory
find "$source_dir" -name '*.c' -type f | while read -r file; do
    filename=$(basename "$file")
    assembly_file="$dest_dir/$optimization_level/${filename%.c}.s"

    # Create subdirectory for the optimization level in the destination directory if necessary
    mkdir -p "$dest_dir/$optimization_level"

    # Compile to assembly using the selected compiler based on architecture
    if [ "$architecture" == "riscv" ]; then
        riscv64-unknown-elf-gcc -S "$file" -o "$assembly_file" -"$optimization_level"
    else
        arm-none-eabi-gcc -S "$file" -o "$assembly_file" -"$optimization_level"
    fi

    if [ $? -eq 0 ]; then
        echo "Compiled $file to $assembly_file"
    else
        echo "Error compiling $file"
    fi
done


# for file in "$source_dir"/*.c; do
#     if [ -f "$file" ]; then
#         filename=$(basename "$file")

#         if [ ! -d "$dest_dir/x86" ]; then
#             mkdir -p "$dest_dir/x86"
#         fi

#         assembly_file="$dest_dir/x86/${filename%.c}.s"

#         # Compile to assembly using the selected compiler
#         "gcc" -S "$file" -o "$assembly_file"

#         if [ $? -eq 0 ]; then
#             echo "Compiled $file to $assembly_file"
#         else
#             echo "Error compiling $file"
#         fi
#     fi
# done
