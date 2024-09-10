from enum import Enum


class BinaryModes(Enum):
    # NOTE: These values match their Capstone Modes (CS_MODE) counterparts
    B32 = 4
    B64 = 8
    UNKNOWN = 9

    @staticmethod
    def from_elf_class(elf_class: int):
        if elf_class == 32:
            return BinaryModes.B32
        elif elf_class == 64:
            return BinaryModes.B64
        else:
            return BinaryModes.UNKNOWN