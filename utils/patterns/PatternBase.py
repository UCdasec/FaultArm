#--------------------------
#   PatternBase
#--------------------------
#  PatternBase Class acts as a base for all patterns, whicb allows for generics and virtual methods

from os import path
from datetime import datetime
from typing import List
from rich.table import Table
from rich.console import Console

from Parser import Instruction
from constants import pattern_list, trivial_values

class PatternBase:

    @property
    def name(self):
        return self._name
    
    @property
    def filename(self):
        return self._filename
    
    @property
    def total_lines(self):
        return self._total_lines
    
    @property
    def directory_name(self):
        return self._directory_name
    
    @property
    def architecture(self):
        return self._architecture
    
    @property
    def optimization(self):
        return self._optimization
    
    @property
    def sensitivity(self):
        return self._sensitivity

    @property
    def pattern(self):
        return self._pattern

    @property
    def trivial_values(self):
        return self._trivial_values
    
    @property
    def vulnerable_instructions(self):
        return self._vulnerable_instructions
    
    
    
    def __init__(self, filename: str, pattern_name: str, architecture: str, optimization: str, total_lines: int, directory_name: str, sensitivity: int = 3) -> None:
        """
        Represents a pattern object used for fault.pattern analysis/detection.

        Attributes:
        - pattern (List[str | List[str]]): List of patterns to match instructions.
        - vulnerable_instructions (List[List[Instruction]]): List of vulnerable instructions.
        - current_vulnerable (List[Instruction]): List of instructions currently identified as vulnerable.
        - is_vulnerable (bool): Flag indicating if a pattern vulnerability is detected.
        """
        self._name = pattern_name
        self._pattern: List[str | List[str]] = pattern_list[architecture][pattern_name]
        self._trivial_values = trivial_values["integers"]
        self._vulnerable_instructions: List[List[Instruction]] = []
        self.current_vulnerable: List[Instruction] = []
        self.is_vulnerable = False
        
        self._filename = filename
        self._total_lines = total_lines
        self._directory_name = directory_name
        self._architecture = architecture
        self._optimization = optimization

        # Hamming weight sensitivity compared to zero
        self._sensitivity = sensitivity
        

    def analysis(self, line: Instruction) -> None:
        """
        Analyzes the given instruction line for vulnerabilities.

        Args:
        - line (Instruction): The instruction line to analyze.
        """
        pass

        
    def contains_trivial_numeric_value(self, value: int) -> bool:
        """
        Checks if the given value is a trivial numeric value.

        Args:
        - value (int): The value to check.

        Returns:
        - bool: True if the value is trivial, False otherwise.
        """
        if value in self._trivial_values:
            return True
        return False

    def print_results(self, console: Console) -> None:
        """
        Prints the results of the analysis.
        """
        if self.is_vulnerable:
            # Found Vulnerability
            console.print("[bright_red]VULNERABILITY DETECTED[/bright_red]\n")

            # Build Table
            table = Table(title="{} Vulnerabilities".format(self.name.capitalize()))
            
            table.add_column(header="Line #", justify="center")
            table.add_column(header="Instructions")

            for vulns in self.vulnerable_instructions:
                table.add_section()
                for line in vulns:
                    table.add_row(f"{line.line_number}", f"{line.name} {', '.join( "\\" + str(arguments) if str(arguments)[0] == "[" else str(arguments) for arguments in line.arguments) if type(line) == Instruction else ''}")

            console.print(table)
            console.print("\n")
        else:
            console.print("[green]No {} vulnerability detected![/green]".format(self.name.capitalize()))

    def save_and_print_results(self, console: Console) -> None:
        """
        Prints the results of the analysis and stores to a file.
        """
        # Call Print
        self.print_results(console)
        
        # File Header
        header = f"Analyzed file: {self.filename}\n" 
        header += f"{datetime.now().ctime()}\n"
        header += f"Lines Analyzed: {self.total_lines}\n"
        header += f"Vulnerable Lines: {sum(len(sub_arr) for sub_arr in self.vulnerable_instructions)}\n\n"
        header += "{} Results:\n\n".format(self.name.capitalize())
        
        with open(path.join(self.directory_name, "{}.txt".format(self.name.capitalize())), 'w') as file:
            file.write(header)
            
            if self.is_vulnerable:
                # Found Vulnerability
                file.write("{} VULNERABILITY DETECTED\n\n".format(self.name.upper()))
                
                file.write("[Line #] [Opcode]\n")
                
                for vulns in self.vulnerable_instructions:
                    for line in vulns:
                        file.write(f"{line.line_number} {line.name} {', '.join(str(arguments) for arguments in line.arguments)}\n")
                    file.write("\n")
                    
            else:
                file.write("SECURED FILE - NO {} VULNERABILITIES".format(self.name.upper()))