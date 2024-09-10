import re
from subprocess import check_output
from capstone import *
from rich.console import Console
from elftools.elf.elffile import ELFFile

from constants import Architectures, BinaryModes, optimization_levels

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
        self.arguments : list[Register | Address | IntegerLiteral | Location] = arguments

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
        
        args["register"] = Register(value[:indicator]) if indicator != -1 else Register(value)
        
        if indicator != -1:
            # The string has two args
            # The +2 here is because of the ', #' that will be at index "indicator"
            try:
                args["offset"] = IntegerLiteral(int(value[value.index('#')+1:]))
            except ValueError:
                args["offset"] = IntegerLiteral(int(value[value.index('#')+1:], 16))
        
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
    def __init__(self, file: str, console: Console):
        self.filename : str = file
        self.program : list[Location | StringLiteral | Instruction] = []
        self.total_lines: int = 0
        
        self.arch = Architecture(line=None, instruction=None)
        self.opt : str = "O0"
        self.is_binary = False
        
        self.parseFile(console)

    def parseFile(self, console: Console):
        console.log(f"Reading file: {self.filename}")
        lines: list[str] = []
            
            # Source file parsing
        if self.__is_file_source(self.filename):
            with open(self.filename, mode="r") as source_file:
                lines = source_file.readlines()
        else:
            self.is_binary = True
            with open(self.filename, mode="rb") as binary_file:
                elf_file = ELFFile(binary_file)
                text_section = elf_file.get_section_by_name(".text")
                data_section = elf_file.get_section_by_name(".data")
                rodata_section = elf_file.get_section_by_name(".rodata")
                # Sections print for debugging
                # for section in e.iter_sections():
                #     print(hex(section["sh_addr"]), section.name)

                # Code
                ops = text_section.data()
                addr = text_section["sh_addr"]

                # Global Vars
                dops = data_section.data()
                daddr = data_section["sh_addr"]

                # Strings
                rdops = rodata_section.data()
                rdaddr = rodata_section["sh_addr"]

                # Determine architecture and mode for Capstone
                file_target_system = self.__determine_binary_architecture(elf_file)
                self.arch.architecture_found(file_target_system.name.lower())
                file_mode = None
                if file_target_system == Architectures.ARM:
                    file_mode = CS_MODE_ARM
                else:
                    file_mode = self.__determine_binary_mode(elf_file).value

                md = Cs(file_target_system.value, file_mode)
                # Dissassemble and store lines
                lines = []
                for i in md.disasm(code=ops, offset=addr):
                    lines.append("{} {}".format(i.mnemonic, i.op_str))
                    # print("0x%x:\t%s\t%s" %(i.address, i.mnemonic, i.op_str))
        console.log(f"[green]File read successfully![/green]\n")

        
        console.log(f"Processing assembly data:")
        self.isolateSections(lines)
        console.log(f"[green]Assembly data processed successfully![/green]\n")

    def isolateSections(self, lines: list[str]):
        program = []
        line_number = 1

        # For determining optimization level
        attribute_1 = None
        attribute_2 = None
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
            # if line starts with .eabi_attribute 30, we get 1st attribute for optimization level
            elif s.startswith(".eabi_attribute 30") and not self.is_binary:
                attribute_1 = self.get_eabi_attribute(s)
            # if line starts with .eabi_attribute 23, we get 2nd attribute for optimization level
            elif s.startswith(".eabi_attribute 23") and not self.is_binary:
                attribute_2 = self.get_eabi_attribute(s)
            # Line is an instruction
            else:
                program.append(self.parseArguments(s, line_number))
            line_number += 1

        # if we successfully received both attributes, we can assign an optimization level to the program
        if attribute_1 and attribute_2:
            self.opt = optimization_levels[(attribute_1, attribute_2)]

        self.program = program
        self.total_lines = line_number

    def parseArguments(self, line: str, line_number: int):
        s = re.split(r'\s+(?![^\[]*\])', line) # split line into tokens
        instruction = s[0] # first token is line instruction
        arguments = []
        for args in s[1:]:
            
            # ! "@" Check if the args is a comment
            if "@" in args:
                # Ignore the rest of the args, because they're comments
                # The presence of a `@' anywhere on a line indicates 
                # the start of a comment that extends to the end of that line.
                break
            
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
                try:
                    arguments.append(IntegerLiteral(int(arg[1:] if arg.startswith('#') or arg.startswith('$') else arg)))
                except ValueError:
                    arguments.append(IntegerLiteral(int(arg[1:] if arg.startswith('#') or arg.startswith('$') else arg, 16)))

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

    def get_eabi_attribute(self, s: str):
        tag_pattern = r'eabi_attribute (\d+), (\d+)'
        tag_match = re.search(tag_pattern, s)
        if tag_match:
            tag_value = int(tag_match.group(1))
            if tag_value in [30, 23]:
                return int(tag_match.group(2))
        else:
            return None
        
    def __is_file_source(self, file_path: str):
        """Uses `file` command on the provided file path and determines its type from the command output

        Args:
            file_path (str): Path to the file being analyzed
        """
        file_output = check_output(["file", file_path]).decode()

        if re.match(r".*ASCII\stext\s.*", file_output):
            # File is source
            return True
        return False

    def __determine_binary_mode(self, elf_file: ELFFile):
        return BinaryModes.from_elf_class(elf_file.elfclass)
    
    def __determine_binary_architecture(self, elf_file: ELFFile):
        return Architectures.from_elf_machine(elf_file.header.get("e_machine", ""))
