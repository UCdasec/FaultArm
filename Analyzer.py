import os.path
from datetime import datetime
from os import makedirs, path, rmdir

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
        
        # ! Outdated branch pattern detection
        # self.branchV1_detector = BranchV1(filename, total_lines, directory_name)
        self.branchV2_detector = BranchV2(filename, parsed_data.arch, total_lines, directory_name)
        self.constant_detector = ConstantCoding(filename, parsed_data.arch, total_lines, directory_name, sensitivity=4)
        if self.create_directory():
            self.static_analysis()
        
    def create_directory(self) -> bool:
        """
        Create directory with timestamp
        """        
        print(f"Creating Directory...")
        makedirs(f"{directory_name}")
        
        if path.exists(directory_name):
            print(f"Directory Created: {directory_name}\n\n")
            return True
        
        print(f"Error: Did not create directory\n\n")
        return False
        
    def static_analysis(self) -> None:
        """
        Performs static analysis on the program instructions.
        """
        for line in self.parsed_data.program:
            if type(line) == Instruction:
                # self.branchV1_detector.analysis(line)
                self.branchV2_detector.analysis(line)
                self.constant_detector.analysis(line)

    def just_print_analysis_results(self) -> None:
        """
        Just prints important details.
        """
        # remove directory if exists since we are only printing results
        if os.path.isdir(directory_name):
            rmdir(directory_name)

        print(f"Printing Results...\n\n")

        # print(f"Saving Branch-V1...")
        # self.branchV1_detector.save_and_print_results()
        # print(f"Saved")

        print(f"Printing Branch-V2...")
        self.branchV2_detector.just_print_results()

        print(f"Printing ConstantCoding...")
        self.constant_detector.just_print_results()

    def save_and_print_analysis_results(self) -> None:
        """
        Saves results and prints important details.
        """
        print(f"Saving Results...\n\n")
        
        # print(f"Saving Branch-V1...")
        # self.branchV1_detector.save_and_print_results()
        # print(f"Saved")
        
        print(f"Saving Branch-V2...")
        self.branchV2_detector.save_and_print_results()
        print(f"Saved")
        
        print(f"Saving ConstantCoding...")
        self.constant_detector.save_and_print_results()
        print(f"Saved")

    def print_total_vulnerable_lines(self) -> None:
        # total number of vulnerable lines
        total_vulnerable_lines = len(self.branchV2_detector.vulnerable_instructions) + len(self.constant_detector.vulnerable_instructions)
        print(f"Total number of vulnerable lines: {total_vulnerable_lines}")

        # total number of branch faults
        total_branch_faults = len(self.branchV2_detector.vulnerable_instructions)
        print(f"\tTotal number of Branch vulnerabilities: {total_branch_faults}")

        # total number of constant coding faults
        total_constant_faults = len(self.constant_detector.vulnerable_instructions)
        print(f"\tTotal number of Fault vulnerabilities: {total_constant_faults}")

    def get_total_vulnerable_lines(self) -> int:
        return len(self.branchV2_detector.vulnerable_instructions) + len(self.constant_detector.vulnerable_instructions)