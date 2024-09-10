from enum import Enum


class Architectures(Enum):
    ARM = 0
    X86 = 3
    UNKNOWN = 9

    @staticmethod
    def from_elf_machine(elf_machine: str):
        if "ARM" in elf_machine:
            return Architectures.ARM
        elif "X86" in elf_machine:
            return Architectures.X86
        else:
            return Architectures.UNKNOWN