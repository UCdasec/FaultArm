import os
import glob

def count_lines(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    return len(lines)

def find_c_files(directory_path):
    return glob.glob(directory_path + '**/*.c', recursive=True)

def find_asm_files(directory_path):
    return glob.glob(directory_path + '**/*.s', recursive=True)

def count_files_and_lines(directory_path):
    c_files = find_c_files(directory_path)
    asm_files = find_asm_files(directory_path)

    total_c_lines = sum(count_lines(file) for file in c_files)
    total_asm_lines = sum(count_lines(file) for file in asm_files)

    total_lines = total_c_lines + total_asm_lines

    stats = {
        'c_file_count': len(c_files),
        'asm_file_count': len(asm_files),
        'total_c_lines': total_c_lines,
        'total_asm_lines': total_asm_lines,
        'total_lines': total_lines
    }

    return stats, c_files, asm_files

directory_path = 'c_tests/'
stats, c_files, asm_files = count_files_and_lines(directory_path)

print(f"Number of C files: {stats['c_file_count']}")
print(f"Number of Assembly files: {stats['asm_file_count']}")
print(f"Total lines in C files: {stats['total_c_lines']}")
print(f"Total lines in Assembly files: {stats['total_asm_lines']}")
print(f"Total lines overall: {stats['total_lines']}")

print(f"\n\nAssembly Files:")

for file in asm_files:
    print(f"{file} - {count_lines(file)} lines")

print(f"\n\nC Files:")

for file in c_files:
    print(f"{file} - {count_lines(file)} lines")
