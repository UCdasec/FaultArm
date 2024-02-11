from enum import Enum
from typing import List
from datetime import datetime
from os import path
from rich.table import Table
from rich.console import Console

from Parser import Instruction

from constants import pattern_list


class Bypass():
    # The following are the states that the Bypass object can be in depending on the current line of code being analyzed.
    class DetectionState(Enum):
        NO_PATTERN = 0  # No pattern has been detected yet.
        FUNCTION_CALL = 1  # Initial function call has been detected.
        SECURE_REGISTER_STORE = 2  # Register store after function call
        SECURE_REGISTER_LOAD = 3  # Register load after register store
        SECURE_COMPARE = 4  # Compare statement after secure register load
        INSECURE_MOVE = 5  # move statement after function call
        INSECURE_COMPARE = 6  # compare statement after insecure move

    def __init__(self, filename: str, architecture: str, optimization: str, total_lines: int, directory_name: str):
        self.filename = filename
        self.total_lines = total_lines
        self.directory_name = directory_name
        self.architecture = architecture
        self.optimization = optimization
        '''
        Represents the Bypass object used for fault.Bypass analysis/detection.
        
        Attributes:
        current_state (DetectionState) : The current state of the Bypass object. Initialized to DetectionState.NO_PATTERN.
        vulnerable_set (List[List[Instruction]]) : A list of lists of Bypass vulnerabilities found in program.
        line_set (List[Instruction]) : A list of lines of code that are potentially insecure.
        pattern_secure (List[str]) : A list of instructions that are considered secure w.r.t bypass.
        pattern_insecure (List[str]) : A list of instructions that are considered insecure w.r.t. bypass.        
        '''
        self.current_state = self.DetectionState.NO_PATTERN
        self.vulnerable_set: List[List[Instruction]] = []
        self.line_set: List[Instruction] = []
        self.pattern_secure = pattern_list[architecture]["bypass"][0]
        self.pattern_insecure = pattern_list[architecture]["bypass"][1]

    def analysis(self, line: Instruction) -> None:
        '''
        Performs analysis on a each line of code passed to see if it matches a Bypass vulnerability pattern.

        Args:
        line (Instruction) : The line of code to be analyzed.
        '''

        # to detect 'bl' instruction
        if self.current_state == self.DetectionState.NO_PATTERN:
            if line.name in self.pattern_secure[0] or line.name in self.pattern_secure[1]:
                self.current_state = self.DetectionState.FUNCTION_CALL
                self.line_set.append(line)

        # to detect 'str' instruction or 'mov' instruction
        elif self.current_state == self.DetectionState.FUNCTION_CALL:
            # str instruction
            if line.name in self.pattern_secure[1]:
                self.current_state = self.DetectionState.SECURE_REGISTER_STORE
            # mov instruction
            elif line.name in self.pattern_insecure[1]:
                self.current_state = self.DetectionState.INSECURE_MOVE
                self.line_set.append(line)
            # in op1 and op2, the insecure pattern can do CMP directly after BL
            elif line.name in self.pattern_insecure[2] and self.optimization in ['O1', 'O2']:
                self.current_state = self.DetectionState.INSECURE_COMPARE
                self.line_set.append(line)
            # out of pattern
            else:
                self.current_state = self.DetectionState.NO_PATTERN
                self.line_set.clear()

        # to detect 'ldr' instruction
        elif self.current_state == self.DetectionState.SECURE_REGISTER_STORE:
            if line.name in self.pattern_secure[2]:
                self.current_state = self.DetectionState.SECURE_REGISTER_LOAD
            # out of pattern
            else:
                self.current_state = self.DetectionState.NO_PATTERN
                self.line_set.clear()

        # to detect 'cmp' instruction
        elif self.current_state == self.DetectionState.SECURE_REGISTER_LOAD:
            if line.name in self.pattern_secure[3]:
                self.current_state = self.DetectionState.SECURE_COMPARE
            # out of pattern
            else:
                self.current_state = self.DetectionState.NO_PATTERN
                self.line_set.clear()

        # to detect 'beq/ble/bgt/moveq/movgt/movle' instruction. If detected, the line set is secure; no need to add to vulnerable set.
        elif self.current_state == self.DetectionState.SECURE_COMPARE:
            if line.name in self.pattern_secure[4]:
                self.line_set.clear()
                self.current_state = self.DetectionState.NO_PATTERN
            # out of pattern
            else:
                self.current_state = self.DetectionState.NO_PATTERN
                self.line_set.clear()

        # to detect 'cmp' instruction
        elif self.current_state == self.DetectionState.INSECURE_MOVE:
            if line.name in self.pattern_insecure[2]:
                self.current_state = self.DetectionState.INSECURE_COMPARE
                self.line_set.append(line)
            # out of pattern
            else:
                self.current_state = self.DetectionState.NO_PATTERN
                self.line_set.clear()

        # to detect 'beq/ble/bgt/moveq/movgt/movle' instruction. If detected, The line set is insecure; add to vulnerable set.
        elif self.current_state == self.DetectionState.INSECURE_COMPARE:
            if line.name in self.pattern_insecure[3]:
                self.line_set.append(line)
                self.vulnerable_set.append(self.line_set.copy())
                self.line_set.clear()
                self.current_state = self.DetectionState.NO_PATTERN
            # out of pattern
            else:
                self.current_state = self.DetectionState.NO_PATTERN
                self.line_set.clear()

    def print_results(self, console: Console) -> None:
        '''
        Prints the results of the Bypass analysis.
        '''
        if len(self.vulnerable_set) > 0:
            console.print("[bright_red]VULNERABILITY DETECTED[/bright_red]\n")

            # Build Table
            table = Table(title="Bypass Vulnerabilities")

            table.add_column(header="Line #", justify="center")
            table.add_column(header="Instructions")

            for set in self.vulnerable_set:
                table.add_section()
                for line in set:
                    table.add_row(f"{line.line_number}",
                                  f"{line.name} {', '.join(str(arguments) for arguments in line.arguments) if type(line) == Instruction else ''}")

            console.print(table)
            console.print("\n")

            print(f"All vulnerable lines printed.\n\n")
        else:
            console.print(f"[green]No Bypass vulnerability detected![/green]")

    def save_and_print_results(self, console: Console) -> None:
        '''
        Saves the results of the Bypass analysis and prints the results.
        '''
        # Call Print
        self.print_results(console)

        # File Header
        header = f"Analyzed file: {self.filename}\n"
        header += f"{datetime.now().ctime()}\n"
        header += f"Lines Analyzed: {self.total_lines}\n"
        header += f"Vulnerable Lines: {sum(len(line_set) for line_set in self.vulnerable_set)}\n\n"
        header += f"Bypass Results:\n\n"

        with open(path.join(self.directory_name, "Bypass.txt"), 'w') as file:
            file.write(header)

            if len(self.vulnerable_set) > 0:
                # Found Branch Vulnerability
                file.write("BYPASS VULNERABILITY DETECTED\n\n")

                file.write("[Line #] [Opcode]\n")

                for set in self.vulnerable_set:
                    for line in set:
                        file.write(
                            f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}\n")
                    file.write("\n")

            else:
                file.write(f"SECURED FILE - NO BYPASS VULNERABILITIES")
