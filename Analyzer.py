from typing import List

from Parser import *

# Got data...

# movl $1, -4(%rbp)
# cmpl $1, -4(%rbp)
# jne .L2

class Branch():
    def __init__(self) -> None:
        self.trivial_values: List[int] = [0, 1, -1, 2, -2]
        self.pattern: List[str | List[str]] = ['movl', 'cmpl', ['jne', 'je']]
        self.vulnerable_instructions: List[List[Instruction]] = []
        self.current_vulnerable: List[Instruction] = []
        self.is_vulnerable = False
        
    def branch_analysis(self, line: Instruction) -> None:
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
        for args in line.arguments:
            # If argument is Location, reached JNE.
            # Add line to vuln arr
            if type(line.arguments[0] == Location) and line.name in self.pattern[2]:
                self.current_vulnerable.append(line)
                self.update_vulnerable_instructions()
                return

            # If not location, must be decimal val
            # Check for trivial value
            if self.contains_trivial_numeric_value(args.value):
                # Add line to vuln arr
                self.current_vulnerable.append(line)
        
    def contains_trivial_numeric_value(self, value: int) -> bool:
        if value in self.trivial_values:
            return True
        return False
    
    def update_vulnerable_instructions(self) -> None:
        if not self.is_vulnerable: self.is_vulnerable = True
        self.vulnerable_instructions.append(self.current_vulnerable.copy())
        self.current_vulnerable.clear()

class Analyzer():
    def __init__(self, parsed_data: Parser) -> None:
        self.parsed_data = parsed_data
        self.branch_detector = Branch()
        self.static_analysis()
        
    def static_analysis(self) -> None:
        for line in self.parsed_data.program:
            if type(line) == Instruction:
                self.branch_detector.branch_analysis(line)
        self.analysis_results()
                
    def analysis_results(self) -> None:
        if self.branch_detector.is_vulnerable:
            # Found Branch Vulnerability
            print("BRANCH VULNERABILITY DETECTED")
            print("Printing vulnerable lines...")
            for vulns in self.branch_detector.vulnerable_instructions:
                for line in vulns:
                    print(line)