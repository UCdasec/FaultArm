#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <compiler_type> <path_to_c_file> <destination_directory>"
    echo "Compiler type: 'arm' for arm-linux-gnueabi-gcc, 'x86' for gcc"
    exit 1
fi

# Extract the arguments
compiler_type=$1
c_file_path=$2
dest_dir=$3

# Check if the C file exists
if [ ! -f "$c_file_path" ]; then
    echo "Error: C file '$c_file_path' does not exist."
    exit 1
fi

# Check if the destination directory exists
if [ ! -d "$dest_dir" ]; then
    echo "Error: Destination directory '$dest_dir' does not exist."
    exit 1
fi

# Determine the compiler to use
if [ "$compiler_type" == "arm" ]; then
    compiler="arm-linux-gnueabi-gcc"
elif [ "$compiler_type" == "x86" ]; then
    compiler="gcc"
else
    echo "Error: Invalid compiler type. Choose 'arm' or 'x86'."
    exit 1
fi

# Extract the filename without the extension
filename=$(basename -- "$c_file_path")
filename_noext="${filename%.*}"

# Loop through all optimization levels and compile
for opt_level in O0 O1 O2 O3 Os Ofast Og; do
    output_filename="${filename_noext}_${opt_level}.s"
    output_path="${dest_dir}/${output_filename}"

    # Compile the C file
    $compiler -S -${opt_level} "$c_file_path" -o "$output_path"

    # Check if the compilation was successful
    if [ $? -eq 0 ]; then
        echo "Successfully compiled '$c_file_path' with -${opt_level} optimization. Output saved to '$output_path'."
    else
        echo "Failed to compile '$c_file_path' with -${opt_level} optimization."
    fi
done
