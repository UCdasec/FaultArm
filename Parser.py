class Register():
    def __init__(self, name: str):
        self.name: str = name
        self.value : int | None = None
        if not self.is_register(name) and self.is_decimal(name):
            self.value = int(name[1:])
            
        
    def is_register(self, name: str) -> bool:
        if name[0] == '%':
            return True
        return False

    def is_decimal(self, name: str) -> bool:
        if name[0] == '$':
            return True
        return False
    
    def __str__(self) -> str:
        return self.name 

class IntegerLiteral():
    def __init__(self, val: int):
        self.value : int = val

    def hammingWeight(self) -> int:
        num : int = self.value
        result : int = 0
        while(num > 0):
            result += 1
            num >> 1
        return result

    def __str__(self) -> str:
        return str(self.value)

class StringLiteral():
    def __init__(self, value: str, line_number: int):
        self.value : str = value
        self.line_number: int = line_number

    def __str__(self) -> str:
        return self.value

class Location():
    def __init__(self, name: str, line_number: int):
        self.name : str = name
        self.line_number: int = line_number
    
    def __str__(self) -> str:
        return self.name

class Instruction():
    def __init__(self, name: str, arguments: list[Register | IntegerLiteral | Location], line_number: int):
        self.name : str = name
        self.line_number: int = line_number
        self.arguments : list[Register | IntegerLiteral | Location] = arguments

    def __str__(self) -> str:
        if len(self.arguments) > 0:
            s = ""
            for arg in self.arguments:
                s += str(arg) + ","
            return self.name + ", " + s[:-1]
        else:
            return self.name

# TODO
class Address():
    def __init__(self, value: str):
        self.value = value    

class Parser:
    def __init__(self, file: str):
        self.filename : str = file
        self.program : list[Location | StringLiteral | Instruction] = []
        self.parseFile()

    def parseFile(self):
        print(f"Parse Starting\n\n")
        print(f"Reading file: {self.filename}")
        with open(self.filename) as f:
            lines: list[str] = f.readlines()
        print(f"File read successfully!\n\n")
        
        print(f"Processing assembly data...")
        self.isolateSections(lines)
        print(f"Assembly data processed successfully!\n\n")

    def isolateSections(self, lines: list[str]):
        program = []
        line_number = 1
        for line in lines:
            s = line.strip()
            # Line is a location 
            if s.endswith(':'):
                program.append(Location(s[0:-1], line_number))
            # Line is a string literal
            elif s.startswith(".string") or s.startswith(".ascii"):
                program.append(StringLiteral(s[s.find('"'):-1], line_number))
            # Line is an instruction
            else:  
                program.append(self.parseArguments(s, line_number))
            
            line_number += 1
        self.program = program

    def parseArguments(self, line: str, line_number: int):
        s = line.split()
        instruction = s[0]
        arguments = []
        for args in s[1:]:
            # Remove commas
            arg = args.replace(',', '')
            # Remove { and } from arguments, only relevant for push/pop
            arg = arg.replace('{', '')
            arg = arg.replace('}', '')
            # TODO
            # Check if memory location
            if '[' in arg or ']' in arg:
                break
            # Check if a number
            if arg[0] == '#' and self.isNumber(arg[1:]):
                arguments.append(IntegerLiteral(int(arg[1:])))
            ## TODO
            ## Check if Location
            ## TODO check for locations without '.' like main
            if arg[0] == ".":
                arguments.append(Location(arg, line_number))
            # Must be register
            else:
                arguments.append(Register(arg))

        return Instruction(instruction, arguments, line_number)

    #def locateInstruction(self, name: str) -> Instruction:
     #   for 

    def __str__(self) -> str:
        s = ""
        for line in self.program:
            s += str(line) + "\n"
        return s

    def isNumber(self, num: str) -> bool:
        if num.isdigit() or (num.startswith('-') and num[1:].isdigit()):
            return True
        else:
            return False
