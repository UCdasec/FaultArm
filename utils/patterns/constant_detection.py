from os import path
from datetime import datetime
from typing import List, Union
from rich.table import Table
from rich.console import Console

from Parser import Instruction, Location, IntegerLiteral, Register
from constants import pattern_list, trivial_values

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
        self.vulnerable_instructions: List[List[Instruction]] = []
        self.is_vulnerable = False
        self.location_in_between = False # to mark if there is a location in between a pattern
        
        # Hamming weight sensitivity compared to zero
        self.sensitivity = sensitivity
    
    def analysis(self, line: Union[Instruction, Location]) -> None:
        self.vulnerable_line: Union[Instruction, Location] = line
        self.is_vulnerable = False
        
        if type(line) == Instruction and len(line.arguments) > 1:
            # if lineStack is a global variable, clear it
            if len(self.lineStack) == 1 and type(self.lineStack[0]) == Location:
                self.lineStack.clear()

            for arg in line.arguments:
                # If it's any qualifying mov instruction
                if line.name in self.pattern[0:6]:
                    # If it's argument is an integer # | $
                    if type(arg) == IntegerLiteral:
                        # Found numerical variable stored
                        if arg.hammingWeight() < self.sensitivity or arg.value in self.trivial_values:
                            # Vulnerable
                            # Only save here if arm. x86 saves on next if (checking if moving to stack)
                            if self.architecture == 'arm':
                                if len(self.lineStack) > 0 and line.line_number - self.lineStack[-1].line_number > 1:
                                    self.lineStack.clear()
                                self.lineStack.append(line)
                            self.is_vulnerable = True
                    elif type(arg) == Register:
                        # Check if is a stack location:
                        if arg.is_stack_pointer(arg.name) and self.is_vulnerable:
                            # Save vulnerable line
                            self.vulnerable_instructions.append([self.vulnerable_line])

                # in case we hit an str, we check if the previous line is a mov instruction with the same register and value of 0
                elif (line.name in ['str', 'strh', 'strb']) and len(self.lineStack) >= 1 and type(self.lineStack[-1]) == Instruction:
                    if line.arguments[0].name == self.lineStack[-1].arguments[0].name:
                        # if its not the very next line, check if location in between
                        if self.vulnerable_line.line_number - self.lineStack[-1].line_number > 1:
                            # if space of one line and that space is a location, we mark as potentially vulnerable
                            if self.vulnerable_line.line_number - self.lineStack[-1].line_number == 2 and self.location_in_between:
                                self.lineStack.append(line)
                                self.vulnerable_instructions.append(self.lineStack.copy())
                                self.lineStack.clear()
                                self.location_in_between = False

                            # else, not a valid constant detection
                            else:
                                self.lineStack.clear()
                        # else, potential vulnerable detection
                        else:
                            self.lineStack.append(line)
                            self.vulnerable_instructions.append(self.lineStack.copy())
                            self.lineStack.clear()

        # if it's a location, push to lineStack
        elif type(line) == Location:
            if len(self.lineStack) == 0:
                self.lineStack.append(line)
            elif len(self.lineStack) >= 1:
                if line.line_number - self.lineStack[-1].line_number > 1:
                    self.lineStack.clear()
                    self.lineStack.append(line)
                elif line.line_number - self.lineStack[-1].line_number == 1:
                    self.location_in_between = True

        # if it's a global variable, i.e., .value or .long
        elif line.name in self.pattern[3:]:
            for arg in line.arguments:
                # check if integer literal
                if type(arg) == IntegerLiteral:
                    if arg.hammingWeight() < self.sensitivity or arg.value in self.trivial_values:
                        # Vulnerable
                        # if previous line was a location
                        if 1 <= len(self.lineStack) <= 2 and type(self.lineStack[0]) == Location:
                            if self.vulnerable_line.line_number - self.lineStack[0].line_number == 1:
                                self.lineStack.append(self.vulnerable_line)
                            elif self.lineStack[-1].name in self.pattern[3:]:
                                self.lineStack[-1] = self.vulnerable_line
                            self.vulnerable_instructions.append(self.lineStack.copy())
                        # likely part of array
                        else:
                            self.vulnerable_instructions.append([self.vulnerable_line])

        # if lineStack is a global variable, clear it
        elif len(self.lineStack) == 2 and type(self.lineStack[0]) == Location:
            self.lineStack.clear()
            x = 5



    def print_results(self, console: Console) -> None:
        """
        Just prints the results of the analysis.
        """

        if len(self.vulnerable_instructions) > 0:
            # Found Branch Vulnerability
            console.print("[bright_red]VULNERABILITY DETECTED[/bright_red]\n")
            table = Table(title="ConstantCoding Vulnerabilities")
            
            table.add_column(header="Line #", justify="center")
            table.add_column(header="Instructions")

            for lines in self.vulnerable_instructions:
                table.add_section()
                for line in lines:
                    table.add_row(f"{line.line_number}", f"{line.name} {', '.join(str(arguments) for arguments in line.arguments) if type(line) == Instruction else ''}")

            console.print(table)
            console.print("\n")
        else:
            console.print(f"[green]No ConstantCoding vulnerability detected![/green]")
    
    def save_and_print_results(self, console: Console) -> None:
        """
        Prints the results of the analysis.
        """
        # Call print
        self.print_results(console)
        
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
                file.write("CONSTANT CODING VULNERABILITY DETECTED\n\n")
                
                file.write("[Line #] [Opcode]\n")
                
                for line in self.vulnerable_instructions:
                    file.write(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}\n")
                file.write("\n")
                    
            else:
                file.write(f"SECURED FILE - NO BRANCH VULNERABILITIES")