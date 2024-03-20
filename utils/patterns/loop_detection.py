from os import path
from datetime import datetime
from typing import List
from rich.table import Table
from rich.console import Console

from Parser import Address, Instruction, Location
from constants import pattern_list, branch_opposites

class LoopCheck():
    def __init__(self, filename: str, architecture: str, optimization: str, total_lines: int, directory_name: str) -> None:
        """
        Represents an object used for fault.LOOP analysis/detection.

        Attributes:
        - locations.
        - pattern (List[str | List[str]]): List of patterns to match instructions.
        - vulnerable_instructions (List[List[Instruction]]): List of vulnerable instructions.
        - current_vulnerable (List[Instruction]): List of instructions currently identified as vulnerable.
        - is_vulnerable (bool): Flag indicating if a loop check vulnerability is detected.
        """
        self.locations: List[str] = []
        self.pattern: List[str | List[str]] = pattern_list[architecture]["loop_check"]
        self.vulnerable_instructions: List[List[Instruction]] = []
        self.suspected_vulnerable: List[Instruction] = []
        self.expected_secured: List[Instruction] = []
        self.secured_pattern: List[Instruction] = []
        self.is_vulnerable = False
        self.is_between_relevant_code = False

        self.filename = filename
        self.total_lines = total_lines
        self.directory_name = directory_name
        self.architecture = architecture
        self.optimization = optimization
        
    def analysis(self, line: Instruction | Location) -> None:
        """
        Analyzes the given instruction line for branch vulnerability.

        Args:
        - line (Instruction): The instruction line to analyze.
        """
        if self.architecture == 'arm':
            # Check if line is location
            if type(line) == Location:
                # Save it
                self.locations.append(line.name)
            # If line is an instruction, compare against pattern
            elif type(line) == Instruction:
                # If an LDRxx is found we need to check two scenarios
                if line.name in self.pattern[0]:
                    # Is the 0 < suspected lines < 3? - The pattern was not reached previously
                    if len(self.suspected_vulnerable) < 3:
                        # If there is anything on the suspected list, clear it.
                        if len(self.suspected_vulnerable) > 0: 
                            self.suspected_vulnerable.clear()
                            self.expected_secured.clear()
                            self.secured_pattern.clear()
                        # Store instruction
                        self.suspected_vulnerable.append(line)
                        self.expected_secured.append(line)
                    # If the suspected lines >= 3, then the pattern is continuing
                    else:
                        # Check if it matches the expected secured line
                        if line.name == self.expected_secured[0].name:
                            if (line.arguments[0].name == self.expected_secured[0].arguments[0].name and
                                    line.arguments[1].value == self.expected_secured[0].arguments[1].value):
                                self.secured_pattern.append(line)
                        # If not, disregard and start over
                        else:
                            # if they do not match but all three lines for suspected_vulnerable are recorded, consider it vulnerable
                            if len(self.suspected_vulnerable) == 3:
                                self.vulnerable_instructions.append(self.suspected_vulnerable.copy())
                                self.is_vulnerable = True
                            self.suspected_vulnerable.clear()
                            self.expected_secured.clear()
                            self.secured_pattern.clear()
                    # self.strip_line(line) Don't worry about values yet. Just store the instruction
                # If a CMP is found
                elif line.name in self.pattern[1]:
                    # If the pattern is currently ongoing or the optimization is O1/O2 (in which case, this would be the start)
                    if len(self.suspected_vulnerable) > 0 or self.optimization in ["O1", "O2"]:
                        # If the pattern hasn't reached the end
                        if len(self.suspected_vulnerable) < 3:
                            # If the list is already populated and the optimization if O1/O2
                            if (len(self.suspected_vulnerable) > 0 and line.line_number - self.suspected_vulnerable[-1].line_number > 1
                                    and self.optimization in ["O1", "O2"]):
                                self.suspected_vulnerable.clear()
                                self.expected_secured.clear()
                                self.secured_pattern.clear()
                            # Append line
                            self.suspected_vulnerable.append(line)
                            self.expected_secured.append(line)
                        # self.strip_line(line)
                        # If it ended and we are now looking for secured patterns
                        else:
                            # Check if the list is already populated
                            if len(self.expected_secured) > 0:
                                # Check if it matches the expected secured line
                                if line.name == self.expected_secured[1].name:
                                    if self.optimization == "O0":
                                        if (line.arguments[0].name == self.expected_secured[1].arguments[0].name and
                                                line.arguments[1].value == self.expected_secured[1].arguments[1].value):
                                            self.secured_pattern.append(line)
                                    elif self.optimization in ["O1", "O2"]:
                                        if ([line.arguments[0].name, line.arguments[1].value] == [self.expected_secured[1].arguments[0].name, self.expected_secured[1].arguments[1].value] or
                                                [line.arguments[0].name, line.arguments[1].value] == [self.expected_secured[1].arguments[1].name, self.expected_secured[1].arguments[0].value]):
                                            self.secured_pattern.append(line)
                            # If expected_secure is empty, clear all.
                            else:
                                self.suspected_vulnerable.clear()
                                self.expected_secured.clear()
                                self.secured_pattern.clear()

                elif self.is_branch_instruction(line.name):
                    # The jump/branch instruction was reached
                    # Check if we reached the end of the insecured pattern
                    if len(self.suspected_vulnerable) >= 3:
                        # If end, check for secured list
                        if len(self.secured_pattern) != 2 and self.optimization == "O0":
                            # Vulnerable
                            self.vulnerable_instructions.append(self.suspected_vulnerable.copy())
                            self.suspected_vulnerable.clear()
                            self.expected_secured.clear()
                            self.secured_pattern.clear()
                            self.is_vulnerable = True
                        else:
                            if line.name == self.expected_secured[2] and self.optimization == "O0":
                                # Secured pattern complete. Not insecured, leave
                                self.suspected_vulnerable.clear()
                                self.expected_secured.clear()
                                self.secured_pattern.clear() 
                            else:
                                if line.name in self.pattern[2] and self.optimization in ["O1", "O2"]:
                                    # Secured pattern complete. Not insecured, leave
                                    self.suspected_vulnerable.clear()
                                    self.expected_secured.clear()
                                    self.secured_pattern.clear()
                                else:
                                    # Vulnerable
                                    self.vulnerable_instructions.append(self.suspected_vulnerable.copy())
                                    self.suspected_vulnerable.clear()
                                    self.expected_secured.clear()
                                    self.secured_pattern.clear()
                                    self.is_vulnerable = True
                    # If this condition passes, we are in the backwards branch that is expected in a loop
                    elif ((len(self.suspected_vulnerable) == 2 and self.optimization == "O0")
                          or (len(self.suspected_vulnerable) >= 1 and self.optimization in ["O1", "O2"])):
                        # LAST of insecure pattern
                        # We need to check a few things, though
                        # More specifically, we need to check that this jump/branch is going backwards
                        if line.arguments[0].name in self.locations:
                            # Going back - LOOP Assumption
                            # Store the line as suspect
                            self.suspected_vulnerable.append(line)
                            # Add the expected branch/jump
                            self.expected_secured.append(branch_opposites[self.architecture].get(line.name))
                        else:
                            # not vulnerable
                            self.suspected_vulnerable.clear()
                            self.expected_secured.clear()
                            self.secured_pattern.clear()
                # Instruction not in pattern
                else:
                    # check if pattern is on-going
                    if (len(self.suspected_vulnerable) > 0 and len(self.suspected_vulnerable) < 3):
                        if self.optimization in ['O0', 'O1']:
                            # clean
                            self.suspected_vulnerable.clear()
                            self.expected_secured.clear()
                            self.secured_pattern.clear()

                        elif self.optimization in ['O2']:
                            # check if there is an irrelevant instruction in between
                            if line.line_number - self.suspected_vulnerable[-1].line_number == 1: self.is_between_relevant_code = True
                            else:
                                # clean
                                self.is_between_relevant_code = False
                                self.suspected_vulnerable.clear()
                                self.expected_secured.clear()
                                self.secured_pattern.clear()

                    elif (len(self.suspected_vulnerable) == 3 and self.optimization == "O0") or (len(self.suspected_vulnerable) == 2 and self.optimization in ["O1", "O2"]):
                        # If this is reached, we were looking for secured patterns
                        
                        # TODO: ADD SENSITIVITY HERE
                        
                        # Secured pattern not found, vulnerable.
                        self.vulnerable_instructions.append(self.suspected_vulnerable.copy())
                        self.suspected_vulnerable.clear()
                        self.expected_secured.clear()
                        self.secured_pattern.clear()
                        self.is_vulnerable = True

    def print_results(self, console: Console) -> None:
        """
        Prints the results of the analysis.
        """
        if self.is_vulnerable:
            # Found Branch Vulnerability
            console.print("[bright_red]VULNERABILITY DETECTED[/bright_red]\n")
            table = Table(title="LoopCheck Vulnerabilities")
            
            table.add_column(header="Line #", justify="center")
            table.add_column(header="Instructions")

            line: Instruction
            for vulns in self.vulnerable_instructions:
                table.add_section()
                for line in vulns:
                    arguments: List[str] = []
                    for arg in line.arguments:
                        # ! For address, anything surrounded with "[]", we need to add a backslash \ to escape the tag
                        # This is mainly to let "Rich", the library we use to print tables,
                        # To leave the content with brackets unprocessed, or not rendered.
                        if type(arg) == Address:
                            arguments.append(f"\{arg.value}")
                        else: arguments.append(str(arg))
                    table.add_row(f"{line.line_number}", f"{line.name} {', '.join(str(argument) for argument in arguments)}")

            console.print(table)
            console.print("\n")
        else:
            console.print(f"[green]No LoopCheck vulnerability detected![/green]")


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
        header += f"Vulnerable Lines: {sum(len(sub_arr) for sub_arr in self.vulnerable_instructions)}\n\n"
        header += f"Loop_Check Results:\n\n"
        
        with open(path.join(self.directory_name, "loop_check.txt"), 'w') as file:
            file.write(header)
            
            if self.is_vulnerable:
                # Found Branch Vulnerability
                file.write("LOOP_CHECK VULNERABILITY DETECTED\n\n")
                
                file.write("[Line #] [Opcode]\n")
                
                for vulns in self.vulnerable_instructions:
                    for line in vulns:
                        file.write(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}\n")
                    file.write("\n")
                    
            else:
                file.write(f"SECURED FILE - NO LOOP_CHECK VULNERABILITIES")

        
    def is_branch_instruction(self, instruction_name: str) -> bool:
        # List of common ARM branch instructions
        branch_instructions = [
            "B", "BL", "BX", "BLX", "BEQ", "BNE", "BGT", "BLT",
            "BGE", "BLE", "BCS", "BCC", "BMI", "BPL", "BVS", "BVC", "BAL"
        ]
        
        # Normalize the instruction name to upper case for comparison
        instruction_name = instruction_name.upper()
        
        # Check if the instruction is a branch instruction
        return instruction_name in branch_instructions or instruction_name.startswith("B")

    