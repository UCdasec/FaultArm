from os import path
from datetime import datetime
from typing import List

from Parser import Instruction, Location

class BranchV1():
    def __init__(self, filename: str, total_lines: int, directory_name: str) -> None:
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
        self.directory_name = directory_name
        
    def analysis(self, line: Instruction) -> None:
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
        
    def save_and_print_results(self) -> None:
        """
        Prints the results of the analysis.
        """
        # File Header
        header = f"Analyzed file: {self.filename}\n" 
        header += f"{datetime.now().ctime()}\n"
        header += f"Lines Analyzed: {self.total_lines}\n"
        header += f"Vulnerable Lines: {sum(len(sub_arr) for sub_arr in self.vulnerable_instructions)}\n\n"
        header += f"BranchV1 Results:\n\n"
        
        with open(path.join(self.directory_name, "branch_v1.txt"), 'w') as file:
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
                    
                print(f"All vulnerable lines printed.\n\n")
            else:
                print(f"NO BRANCH VULNERABILITIES")
                file.write(f"SECURED FILE - NO BRANCH VULNERABILITIES")
        
class BranchV2():
    def __init__(self, filename: str, total_lines: int, directory_name: str) -> None:
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
        self.directory_name = directory_name
        
    def analysis(self, line: Instruction) -> None:
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
        
    def save_and_print_results(self) -> None:
        """
        Prints the results of the analysis.
        """
        # File Header
        header = f"Analyzed file: {self.filename}\n" 
        header += f"{datetime.now().ctime()}\n"
        header += f"Lines Analyzed: {self.total_lines}\n"
        header += f"Vulnerable Lines: {sum(len(sub_arr) for sub_arr in self.vulnerable_instructions)}\n\n"
        header += f"BranchV2 Results:\n\n"
        
        with open(path.join(self.directory_name, "branch_v2.txt"), 'w') as file:
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
                    
                print(f"All vulnerable lines printed.\n\n")
            else:
                print(f"NO BRANCH VULNERABILITIES")
                file.write(f"SECURED FILE - NO BRANCH VULNERABILITIES")
