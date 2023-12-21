import re

class Register():
    def __init__(self, name: str):
        self.name: str = name
        self.value : int | None = None
        if not self.is_register(name) and self.is_decimal(name):
            self.value = int(name[1:])
            
        
    def is_register(self, name: str) -> bool:
        # Naming conventions vary.
        if name[0] == '%' or re.match(r"[re]?([acdb]x|[isb]p|[sd]i)|[acdb][hl]|[sb]pl|[sd]il", name, re.IGNORECASE) or re.match(r"\b(R[0-9]|R1[0-5])\b", name, re.IGNORECASE):
            return True
        return False

    def is_decimal(self, name: str) -> bool:
        if name[0] == '$':
            return True
        return False
    
    def is_stack_pointer(self, name: str) -> bool:
        pattern = r"-[0-9]{1,2}\(%?rbp\)"

        if re.search(pattern, name):
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
            result += num & 1
            num >>= 1
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

class Address():
    def __init__(self, value: str):
        self.value = value
        self.arguments = self.set_arguments(value[1:-1])
    
    # The address can be in the format of:
    # str	r0, [fp, #-16]
    # or
	# str	r2, [r3]
    # It could either have a single register or a register and an offset.
    def set_arguments(self, value: str):
        args = {}
        indicator = value.find(',')
        
        args["register"] = Register(value[:indicator-1]) if indicator != -1 else Register(value)
        
        if indicator != -1:
            # The string has two args
            # The +2 here is because of the ', #' that will be at index "indicator"
            args["offset"] = IntegerLiteral(int(value[value.index('#')+1:]))
        
        return args
        
    def __str__(self) -> str:
        return self.value

class Architecture():
    def __init__(self, line: str | None, instruction: Instruction | None) -> None:
        self.name: str = ""
        self.identifier = line
        self.instruction = instruction
        self.is_determined: bool = False
        
        pass
    
    def architecture_found(self, name: str):
        self.name = name
        self.is_determined = True
    
    def determine_architecture(self, line: str, instruction: Instruction | None) -> None:
        # If the function was not invoked by a register/instruction
        if instruction is None:
            # Might be an identifier
            if re.match(r"\s*\.arch\s+arm", line):
                self.architecture_found("arm")
                self.identifier = line
                
        # If the function is invoked with an instruction
        else:            
            # Check instruction name for arm uniques
            if re.match(r"\bLDR|STR|(B|BL|BX|BLX)(EQ|NE|CS|HS|CC|LO|MI|PL|VS|VC|HI|LS|GE|LT|GT|LE|AL)?\b", instruction.name, re.IGNORECASE):
                self.architecture_found("arm")
                self.instruction = instruction

                return
            # Check instruction name for x86 uniques
            elif re.match(r"\b(MOV[L|Q]|CALL|RET|INT|LEA|PUSH[Q?]|POP|INC|DEC|JMP|JE|JNE|JG|JL|JGE|JLE|JA|JB|JAE|JBE)\b", instruction.name, re.IGNORECASE):
                self.architecture_found("x86")
                self.instruction = instruction
                return
            # Check the possible ARM register names AKA
            for arg in instruction.arguments:
                if type(arg) is Register:
                    if re.match(r"\b(R[0-9]|R1[0-5])\b", arg.name, re.IGNORECASE):
                        self.architecture_found("arm")
                        self.instruction = instruction
                        return
                    elif re.match(r"\b(EAX|EBX|ECX|EDX|ESI|EDI|EBP|ESP|RAX|RBX|RCX|RDX|RSI|RDI|RBP|RSP)\b", arg.name, re.IGNORECASE):
                        self.architecture_found("x86")
                        self.instruction = instruction
                        return
                        
            
            

class Parser:
    def __init__(self, file: str):
        self.filename : str = file
        self.program : list[Location | StringLiteral | Instruction] = []
        self.total_lines: int = 0
        
        self.arch = Architecture(line=None, instruction=None)
        
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
                if not s.startswith(('0','1','2','3','4','5','6','7','8','9')):
                    program.append(Location(s[0:-1], line_number))
                else:
                    break
            # Line is a string literal
            elif s.startswith(".string") or s.startswith(".ascii"):
                program.append(StringLiteral(s[s.find('"'):-1], line_number))
            #! Might not be necessary to include this case...
            # Explicit architecture specifier
            elif s.startswith(".arch") and not self.arch.is_determined:
                self.arch.determine_architecture(line, instruction=None)
            # Identity of compiler, everything from this point is metadata
            elif s.startswith(".ident"):
                break
            # Line is an instruction
            else:
                program.append(self.parseArguments(s, line_number))
            
            line_number += 1
        self.program = program
        self.total_lines = line_number

    def parseArguments(self, line: str, line_number: int):
        s = re.split(r'\s+(?![^\[]*\])', line) # split line into tokens
        instruction = s[0] # first token is line instruction
        arguments = []
        for args in s[1:]:
            
            # ! Check for address or memory location before replacing
            if '[' in args or ']' in args:
                # is memory location
                addr = args if '!' not in args else args[:-1]
                arguments.append(Address(addr))
                if s[-1] == args:
                    break
            
            # Remove commas
            arg = args.replace(',', '')
            # Remove { and } from arguments, only relevant for push/pop
            arg = arg.replace('{', '')
            arg = arg.replace('}', '')
            
            # Check if a number
            if self.isNumber(arg):
                arguments.append(IntegerLiteral(int(arg[1:] if arg.startswith('#') or arg.startswith('$') else arg)))
            # ! This notation can also be used in ARM for LDR
            elif re.search(r"\.long|\.value", instruction) and self.isNumber(arg):
                # in case its a global variable
                arguments.append(IntegerLiteral(int(arg)))
            elif arg[0] == ".":
                arguments.append(Location(arg, line_number))
            # check if a location
            elif instruction in ['.global', '.type', '.size', 'bl']:
                arguments.append(Location(arg, line_number))
            # Must be register (checking first condition since that's not part of if-case)
            elif '[' not in args and ']' not in args:
                register = Register(arg)
                arguments.append(register)

        instruction_out = Instruction(instruction, arguments, line_number)
        if not self.arch.is_determined:
            self.arch.determine_architecture(line, instruction_out)
        return instruction_out

    def __str__(self) -> str:
        s = ""
        for line in self.program:
            s += str(line) + "\n"
        return s

    def isNumber(self, num: str) -> bool:
        if num.isdigit() or (num.startswith('#') or num.startswith('$')):
            return True
        else:
            return False
