from datetime import datetime
from os import makedirs, path

from Parser import Parser, Instruction
from utils import BranchV1, BranchV2, ConstantCoding

# TODO: Add support for Arm32
# movs	r3, #1
# str	r3, [r7, #4]
# ldr	r3, [r7, #4]
# cmp	r3, #1
# bne	.L2

timestamp = datetime.now()
directory_name = f"./out/analysis_{timestamp.day}_{timestamp.month}_{timestamp.year}_{timestamp.hour}{timestamp.minute}{timestamp.second}{str(timestamp.microsecond)[:3]}"

class Analyzer():
    def __init__(self, filename: str, parsed_data: Parser, total_lines: int, out_directory: str) -> None:
        """
        Represents an analyzer object used for static analysis.

        Args:
        - parsed_data (Parser): The parsed data object containing the program instructions.
        """
        self.filename = filename
        self.parsed_data = parsed_data
        self.branchV1_detector = BranchV1(filename, total_lines, directory_name)
        self.branchV2_detector = BranchV2(filename, total_lines, directory_name)
        self.constant_detector = ConstantCoding(filename, total_lines, directory_name, sensitivity=4)
        if self.create_directory():
            self.static_analysis()
        
    def create_directory(self) -> bool:
        """
        Create directory with timestamp
        """        
        print(f"Creating Directory...")
        makedirs(f"{directory_name}")
        
        if path.exists(directory_name):
            print(f"Directory Created\n\n")
            return True
        
        print(f"Error: Did not create directory\n\n")
        return False
        
    def static_analysis(self) -> None:
        """
        Performs static analysis on the program instructions.
        """
        for line in self.parsed_data.program:
            if type(line) == Instruction:
                self.branchV1_detector.analysis(line)
                self.branchV2_detector.analysis(line)
                self.constant_detector.analysis(line)
                
    def save_and_print_analysis_results(self) -> None:
        """
        Saves results and prints important details.
        """
        print(f"Saving Results...\n\n")
        
        print(f"Saving Branch-V1...")
        self.branchV1_detector.save_and_print_results()
        print(f"Saved")
        
        print(f"Saving Branch-V2...")
        self.branchV2_detector.save_and_print_results()
        print(f"Saved")
        
        print(f"Saving ConstantCoding...")
        self.constant_detector.save_and_print_results()
        print(f"Saved")
        