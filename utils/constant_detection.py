from os import path
from datetime import datetime
from typing import List
from math import log

from Parser import Instruction, IntegerLiteral, Register
from constants import pattern_list, trivial_values


def is_all_ones(num: int) -> bool:
    if log(num + 1, 2).is_integer():
        return True
    else:
        return False


class ConstantCoding():
    def __init__(self, filename: str, architecture: str, total_lines: int, directory_name: str, sensitivity: int) -> None:
        self.filename = filename
        self.total_lines = total_lines
        self.directory_name = directory_name
        self.architecture = architecture
        
        # Pattern - Stack Storage
        # movl #, -#(%rsp)
        self.pattern: List[str] = pattern_list[architecture]["constant_coding"]
        self.trivial_values: List[int] = trivial_values["integers"]
        self.lineStack : List[Instruction] = []
        self.vulnerable_instructions: List[Instruction] = []
        self.is_vulnerable = False
        
        # Hamming weight sensitivity compared to zero
        self.sensitivity = sensitivity
    
    def analysis(self, line: Instruction) -> None:
        self.vulnerable_line: Instruction = line
        self.is_vulnerable = False
        
        if len(line.arguments) > 1:
            for arg in line.arguments:
                # If it's MOVL, MOVQ, or MOVW
                if line.name in self.pattern[0:3]:
                    # If it's argument is an integer # | $

                    if type(arg) == IntegerLiteral:
                        # Found numerical variable stored
                        if arg.hammingWeight() < self.sensitivity or arg.value in self.trivial_values or is_all_ones(arg.value):
                            # Vulnerable
                            # Only save here if arm. x86 saves on next if (checking if moving to stack)
                            if self.architecture == 'arm':
                                self.lineStack.append(line)
                            self.is_vulnerable = True
                    elif type(arg) == Register:
                        # Check if is a stack location:
                        if arg.is_stack_pointer(arg.name) and self.is_vulnerable:
                            # Save vulnerable line
                            self.vulnerable_instructions.append(self.vulnerable_line)
                # in case we hit an str, we check if the previous line is a mov instruction with the same register and value of 0
                elif (line.name == 'str' or line.name == 'strh') and len(self.lineStack) >= 1:
                    if line.arguments[0].name == self.lineStack[-1].arguments[0].name:
                        arg_value = self.lineStack[-1].arguments[1]
                        if arg_value.hammingWeight() < self.sensitivity or arg_value.value in self.trivial_values or is_all_ones(arg_value.value):
                            # if its not the very next line, clear stack and ignore
                            if self.vulnerable_line.line_number - self.lineStack[-1].line_number > 1:
                                self.lineStack.clear()
                            # else, potential vulnerable detection
                            else:
                                self.vulnerable_instructions.append(self.lineStack[-1])
                                self.lineStack.clear()

        # if it's a global variable, i.e., .value or .long
        elif line.name in self.pattern[3:]:
            for arg in line.arguments:
                # check if integer literal
                if type(arg) == IntegerLiteral:
                    if arg.hammingWeight() < self.sensitivity or arg.value in self.trivial_values or is_all_ones(arg.value):
                        # Vulnerable
                        self.vulnerable_instructions.append(self.vulnerable_line)
                        self.is_vulnerable = True



    def just_print_results(self) -> None:
        """
        Just prints the results of the analysis.
        """

        if len(self.vulnerable_instructions) > 0:
            # Found Branch Vulnerability
            print("CONSTANT CODING VULNERABILITY DETECTED")
            print("Printing vulnerable lines...\n")

            print("[Line #] [Opcode]\n")

            for line in self.vulnerable_instructions:
                print(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}")
            print("\n")

            print(f"All vulnerable lines printed.\n\n")
        else:
            print(f"NO CONSTANT VULNERABILITIES FOUND")
    
    def save_and_print_results(self) -> None:
        """
        Prints the results of the analysis.
        """
        # File Header
        header = f"Analyzed file: {self.filename}\n" 
        header += f"{datetime.now().ctime()}\n"
        header += f"Lines Analyzed: {self.total_lines}\n"
        header += f"Vulnerable Lines: {len(self.vulnerable_instructions)}\n\n"
        header += f"ConstantCoding Results:\n\n"
        
        with open(path.join(self.directory_name, "constant.txt"), 'w') as file:
            file.write(header)
            
            if len(self.vulnerable_instructions) > 0:
                # Found Branch Vulnerability
                print("CONSTANT CODING VULNERABILITY DETECTED")
                file.write("CONSTANT CODING VULNERABILITY DETECTED\n\n")
                print("Printing vulnerable lines...\n")
                
                print("[Line #] [Opcode]\n")
                file.write("[Line #] [Opcode]\n")
                
                for line in self.vulnerable_instructions:
                    print(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}")
                    file.write(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}\n")
                print("\n")
                file.write("\n")
                    
                print(f"All vulnerable lines printed.\n\n")
            else:
                print(f"NO CONSTANT VULNERABILITIES FOUND")
                file.write(f"SECURED FILE - NO BRANCH VULNERABILITIES")
