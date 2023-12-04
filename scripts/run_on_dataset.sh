#!/bin/bash

# USAGE: Make sure you have the labelling file in the ../out/Analysis folder with the name Dataset_Labelling.xlsx
# ALSO: Make sure the ../dataset, and ../out/Analysis folders exist

# Set the dataset folder path
dataset_folder="../dataset"

# Set the scripts folder path
scripts_folder="../scripts"

# Make a directory for output if not exists
mkdir -p "../out"

# Change to the dataset folder
cd "$dataset_folder" || exit 1

# Find all .s files in the dataset folder and its subfolders except op_2
files=$(find . -type f -name "*.s" -not -path "./op_2/*")

# Iterate over each found file
for file in $files; do
    # Get a unique output filename by replacing slashes with underscores
    OUTPUT_FILE=$(echo "$file" | sed 's/^\.\///;s/\//_/g')
    # Run the python3 command with the current file path
    python3 ../main.py "$file" > "../out/$OUTPUT_FILE.out"
done

# Make a directory for output if not exists
mkdir -p "../out/Analysis"

# Change to the dataset folder
cd "$scripts_folder" || exit 1

# Run the analysis at the end
python3 get_analysis.py -f ../out/ -w ../out/Analysis/

# Delete files with the suffix ".s.out"
find "../out/" -type f -name "*.s.out" -delete