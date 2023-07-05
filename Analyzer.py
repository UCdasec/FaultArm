from typing import List
from datetime import datetime
from os import makedirs, path

from Parser import *

# TODO: Add support for Arm32
# movs	r3, #1
# str	r3, [r7, #4]
# ldr	r3, [r7, #4]
# cmp	r3, #1
# bne	.L2

timestamp = datetime.now()
directory_name = f"./out/{timestamp.day}_{timestamp.month}_{timestamp.year}_{timestamp.hour}{timestamp.minute}{timestamp.second}{timestamp.microsecond}"


class BranchV1():
    def __init__(self, filename: str, total_lines: int, out_directory: str) -> None:
        """
        Represents a branch object used for fault.branch analysis/detection.

        Attributes:
        - trivial_values (List[int]): List of trivial integer values.
        - pattern (List[str | List[str]]): List of patterns to match instructions.
        - vulnerable_instructions (List[List[Instruction]]): List of vulnerable instructions.
        - current_vulnerable (List[Instruction]): List of instructions currently identified as vulnerable.
        - is_vulnerable (bool): Flag indicating if a branch vulnerability is detected.
        """
        self.trivial_values: List[int] = [0, 1, -1, 2, -2]
        self.pattern: List[str | List[str]] = ['movl', 'cmpl', ['jne', 'je', 'jz', 'jnz']]
        self.vulnerable_instructions: List[List[Instruction]] = []
        self.current_vulnerable: List[Instruction] = []
        self.is_vulnerable = False
        
        self.filename = filename
        self.total_lines = total_lines
        self.out_directory = out_directory
        
    def branch_analysis(self, line: Instruction) -> None:
        """
        Analyzes the given instruction line for branch vulnerability.

        Args:
        - line (Instruction): The instruction line to analyze.
        """
        if line.name == self.pattern[0]:
            if len(self.current_vulnerable) > 0: self.current_vulnerable.clear()
            self.strip_line(line)
        elif line.name == self.pattern[1]:
            # Check previous line & arg 0 value
            if self.current_vulnerable and self.current_vulnerable[0].arguments[0].value == line.arguments[0].value:
                self.strip_line(line)
        elif line.name in self.pattern[2]:
            if len(self.current_vulnerable) > 1:
                self.strip_line(line)
                    
    def strip_line(self, line: Instruction) -> None:
        """
        Strips the given instruction line for vulnerabilities.

        Args:
        - line (Instruction): The instruction line to strip.
        """
        for args in line.arguments:
            # If argument is Location, reached JNE.
            # Add line to vuln arr
            if type(line.arguments[0]) == Location and line.name in self.pattern[2]:
                self.current_vulnerable.append(line)
                self.update_vulnerable_instructions()
                return

            # If not location, must be decimal val
            # Check for trivial value
            if self.contains_trivial_numeric_value(args.value):
                # Add line to vuln arr
                self.current_vulnerable.append(line)
        
    def contains_trivial_numeric_value(self, value: int) -> bool:
        """
        Checks if the given value is a trivial numeric value.

        Args:
        - value (int): The value to check.

        Returns:
        - bool: True if the value is trivial, False otherwise.
        """
        if value in self.trivial_values:
            return True
        return False
    
    def update_vulnerable_instructions(self) -> None:
        """
        Updates the list of vulnerable instructions with the current vulnerable instructions.
        """
        if not self.is_vulnerable: self.is_vulnerable = True
        self.vulnerable_instructions.append(self.current_vulnerable.copy())
        self.current_vulnerable.clear()
        
    def save_and_print_branch_results(self) -> None:
        """
        Prints the results of the analysis.
        """
        # File Header
        header = f"Analyzed file: {self.filename}\n" 
        header += f"{datetime.now().ctime()}\n"
        header += f"Lines Analyzed: {self.total_lines}\n"
        header += f"Vulnerable Lines: {sum(len(sub_arr) for sub_arr in self.vulnerable_instructions)}\n\n"
        header += f"BranchV1 Results:\n\n"
        
        with open(path.join(directory_name, "branch_v1.txt"), 'w') as file:
            file.write(header)
            
            if self.is_vulnerable:
                # Found Branch Vulnerability
                print("BRANCH-V1 VULNERABILITY DETECTED")
                file.write("BRANCH-V1 VULNERABILITY DETECTED\n\n")
                print("Printing vulnerable lines...\n")
                
                print("[Line #] [Opcode]\n")
                file.write("[Line #] [Opcode]\n")
                
                for vulns in self.vulnerable_instructions:
                    for line in vulns:
                        print(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}")
                        file.write(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}\n")
                    print("\n")
                    file.write("\n")
                    
                print(f"All vulnerable lines printed.")
            else:
                print(f"SECURED FILE - NO BRANCH VULNERABILITIES")
                file.write(f"SECURED FILE - NO BRANCH VULNERABILITIES")
        
class BranchV2():
    def __init__(self, filename: str, total_lines: int, out_directory: str) -> None:
        """
        Represents a branch object used for fault.branch analysis/detection.

        Attributes:
        - trivial_values (List[int]): List of trivial integer values.
        - pattern (List[str | List[str]]): List of patterns to match instructions.
        - vulnerable_instructions (List[List[Instruction]]): List of vulnerable instructions.
        - current_vulnerable (List[Instruction]): List of instructions currently identified as vulnerable.
        - is_vulnerable (bool): Flag indicating if a branch vulnerability is detected.
        """
        self.trivial_values: List[int] = [0, 1, -1, 2, -2]
        self.pattern: List[str | List[str]] = ['cmpl', ['jne', 'je', 'jnz', 'jz']]
        self.vulnerable_instructions: List[List[Instruction]] = []
        self.current_vulnerable: List[Instruction] = []
        self.is_vulnerable = False
        
        self.filename = filename
        self.total_lines = total_lines
        self.out_directory = out_directory
        
    def branch_analysis(self, line: Instruction) -> None:
        """
        Analyzes the given instruction line for branch vulnerability.

        Args:
        - line (Instruction): The instruction line to analyze.
        """
        if line.name == self.pattern[0]:
            if len(self.current_vulnerable) > 0: self.current_vulnerable.clear()
            self.strip_line(line)
        elif line.name in self.pattern[1]:
            if len(self.current_vulnerable) > 0:
                self.strip_line(line)
                    
    def strip_line(self, line: Instruction) -> None:
        """
        Strips the given instruction line for vulnerabilities.

        Args:
        - line (Instruction): The instruction line to strip.
        """
        for args in line.arguments:
            # If argument is Location, reached JUMP.
            # Add line to vuln arr
            if type(line.arguments[0]) == Location and line.name in self.pattern[1]:
                self.current_vulnerable.append(line)
                self.update_vulnerable_instructions()
                return

            # If not location, must be decimal val
            # Check for trivial value
            if self.contains_trivial_numeric_value(args.value):
                # Add line to vuln arr
                self.current_vulnerable.append(line)
        
    def contains_trivial_numeric_value(self, value: int) -> bool:
        """
        Checks if the given value is a trivial numeric value.

        Args:
        - value (int): The value to check.

        Returns:
        - bool: True if the value is trivial, False otherwise.
        """
        if value in self.trivial_values:
            return True
        return False
    
    def update_vulnerable_instructions(self) -> None:
        """
        Updates the list of vulnerable instructions with the current vulnerable instructions.
        """
        if not self.is_vulnerable: self.is_vulnerable = True
        self.vulnerable_instructions.append(self.current_vulnerable.copy())
        self.current_vulnerable.clear()
        
    def save_and_print_branch_results(self) -> None:
        """
        Prints the results of the analysis.
        """
        # File Header
        header = f"Analyzed file: {self.filename}\n" 
        header += f"{datetime.now().ctime()}\n"
        header += f"Lines Analyzed: {self.total_lines}\n"
        header += f"Vulnerable Lines: {sum(len(sub_arr) for sub_arr in self.vulnerable_instructions)}\n\n"
        header += f"BranchV2 Results:\n\n"
        
        with open(path.join(directory_name, "branch_v2.txt"), 'w') as file:
            file.write(header)
            
            if self.is_vulnerable:
                # Found Branch Vulnerability
                print("BRANCH-V2 VULNERABILITY DETECTED")
                file.write("BRANCH-V2 VULNERABILITY DETECTED\n\n")
                print("Printing vulnerable lines...\n")
                
                print("[Line #] [Opcode]\n")
                file.write("[Line #] [Opcode]\n")
                
                for vulns in self.vulnerable_instructions:
                    for line in vulns:
                        print(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}")
                        file.write(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}\n")
                    print("\n")
                    file.write("\n")
                    
                print(f"All vulnerable lines printed.")
            else:
                print(f"SECURED FILE - NO BRANCH VULNERABILITIES")
                file.write(f"SECURED FILE - NO BRANCH VULNERABILITIES")

class Analyzer():
    def __init__(self, filename: str, parsed_data: Parser, total_lines: int, out_directory: str) -> None:
        """
        Represents an analyzer object used for static analysis.

        Args:
        - parsed_data (Parser): The parsed data object containing the program instructions.
        """
        self.filename = filename
        self.parsed_data = parsed_data
        self.branchV1_detector = BranchV1(filename, total_lines, out_directory)
        self.branchV2_detector = BranchV2(filename, total_lines, out_directory)
        if self.create_directory():
            self.static_analysis()
        
    def create_directory(self) -> bool:
        """
        Create directory with timestamp
        """        
        print(f"Creating Directory...")
        makedirs(f"{directory_name}")
        
        if path.exists(directory_name):
            print(f"Directory Created\n\n")
            return True
        
        print(f"Error: Did not create directory\n\n")
        return False
        
    def static_analysis(self) -> None:
        """
        Performs static analysis on the program instructions.
        """
        for line in self.parsed_data.program:
            if type(line) == Instruction:
                self.branchV1_detector.branch_analysis(line)
                self.branchV2_detector.branch_analysis(line)
                
    def save_and_print_analysis_results(self) -> None:
        """
        Saves results and prints important details.
        """
        print(f"Saving Results...\n\n")
        
        print(f"Saving Branch-V1...")
        self.branchV1_detector.save_and_print_branch_results()
        print(f"Saved")
        
        print(f"Saving Branch-V2...")
        self.branchV2_detector.save_and_print_branch_results()
        print(f"Saved")
        