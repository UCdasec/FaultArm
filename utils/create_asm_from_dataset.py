import os
import glob
import subprocess

def count_lines(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    return len(lines)

def compile_c_to_asm(c_file_path):
    asm_file_path = c_file_path.rsplit('.', 1)[0] + '.s'
    subprocess.run(['cc', '-S', c_file_path, '-o', asm_file_path])
    return asm_file_path

def find_c_files(directory_path):
    return glob.glob(directory_path + '**/*.c', recursive=True)

def total_lines_in_c_and_asm_files(directory_path):
    c_files = find_c_files(directory_path)
    total_lines = sum(count_lines(compile_c_to_asm(file)) for file in c_files)
    return total_lines

directory_path = 'c_tests/'
print(f'Total lines in assembly files compiled from C files: {total_lines_in_c_and_asm_files(directory_path)}')
