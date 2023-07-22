import os
import glob

def count_lines(file_path):
    print(f"Reading file: {file_path}")
    with open(file_path, 'r') as f:
        lines = f.readlines()
    return len(lines)

def find_asm_files(directory_path):
    return glob.glob(directory_path + '**/*.s', recursive=True)

def total_lines_in_asm_files(directory_path):
    asm_files = find_asm_files(directory_path)
    total_lines = sum(count_lines(file) for file in asm_files)
    return total_lines

directory_path = 'c_tests/'
print(f'Total lines in assembly files: {total_lines_in_asm_files(directory_path)}')
