import os.path
from datetime import datetime
from os import makedirs, path, rmdir
from rich.console import Console

from Parser import Parser, Instruction, Location
from utils import BranchV2, ConstantCoding, LoopCheck, Bypass

timestamp = datetime.now()
directory_name = f"./out/analysis_{timestamp.day}_{timestamp.month}_{timestamp.year}_{timestamp.hour}{timestamp.minute}{timestamp.second}{str(timestamp.microsecond)[:3]}"

class Analyzer():
    def __init__(self, filename: str, parsed_data: Parser, total_lines: int, out_directory: str, console: Console) -> None:
        """
        Represents an analyzer object used for static analysis.

        Args:
        - parsed_data (Parser): The parsed data object containing the program instructions.
        """
        self.filename = filename
        self.parsed_data = parsed_data

        # ! Outdated branch pattern detection
        # self.branchV1_detector = BranchV1(filename, total_lines, directory_name)
        self.branchV2_detector = BranchV2(filename, parsed_data.arch.name, parsed_data.opt, directory_name, directory_name, sensitivity=4)
        self.constant_detector = ConstantCoding(filename, parsed_data.arch.name, parsed_data.opt, total_lines, directory_name, sensitivity=4)
        self.loop_detector = LoopCheck(filename, parsed_data.arch.name, parsed_data.opt, total_lines, directory_name)
        self.bypass_detector = Bypass(filename, parsed_data.arch.name, parsed_data.opt, total_lines, directory_name)
        # TODO: Instantiate a list of detectors, then iterate on detectors for other functions
        # Doing the above avoids the below condition on subsequent function calls
        if parsed_data.arch.name  == "x86":       
            self.bypass_detector = None
        # if self.create_directory(console):
        self.static_analysis()
        
    # def create_directory(self, console: Console) -> bool:
    #     """
    #     Create directory with timestamp
    #     """
    #
    #     console.log(f"Creating Directory:")
    #     makedirs(f"{directory_name}")
    #
    #     if path.exists(directory_name):
    #         console.log(f"Directory Created: {directory_name}\n\n")
    #         return True
    #
    #     console.log(f"Error: Did not create directory\n")
    #     return False
        
    def static_analysis(self) -> None:
        """
        Performs static analysis on the program instructions.expected that in the future, support wlll be extended to other optimization levels as well.

        """
        for line in self.parsed_data.program:
            if type(line) == Instruction:
                self.branchV2_detector.analysis(line)
                self.constant_detector.analysis(line)
                self.loop_detector.analysis(line)
                if self.bypass_detector:
                    self.bypass_detector.analysis(line)
            elif type(line) == Location:
                self.constant_detector.analysis(line)
                self.loop_detector.analysis(line)
                
                

    def print_analysis_results(self, console: Console) -> None:
        """
        Prints important details.
        """
        # remove directory if exists since we are only printing results
        if os.path.isdir(directory_name):
            rmdir(directory_name)

        console.print(f"Printing Results:\n")

        console.print(f"[Pattern] [bright_yellow]Branch-V2[/bright_yellow]\n")
        self.branchV2_detector.print_results(console)
        
        console.print(f"[Pattern] [bright_yellow]ConstantCoding[/bright_yellow]\n")
        self.constant_detector.print_results(console)
        
        console.print(f"[Pattern] [bright_yellow]LoopCheck[/bright_yellow]\n")
        self.loop_detector.print_results(console)

        if self.bypass_detector:
            console.print(f"[Pattern] [bright_yellow]Bypass[/bright_yellow]\n")
            self.bypass_detector.print_results(console)

    def save_and_print_analysis_results(self, console: Console) -> None:
        """
        Saves results and prints important details.
        """
        console.print(f"Saving Results...\n\n")
        
        console.print(f"Saving Branch-V2...")
        self.branchV2_detector.save_and_print_results(console)
        console.print(f"Saved")
        
        console.print(f"Saving ConstantCoding...")
        self.constant_detector.save_and_print_results(console)
        console.print(f"Saved")

        console.print(f"Saving LoopCheck...")
        self.loop_detector.save_and_print_results(console)
        console.print(f"Saved")

        if self.bypass_detector:
            console.print(f"Saving Bypass...")
            self.bypass_detector.save_and_print_results(console)
            console.print(f"Saved")

    def print_total_vulnerable_lines(self, console: Console) -> None:
        # total number of vulnerable lines
        total_vulnerable_lines = (len(self.branchV2_detector.vulnerable_instructions) + len(self.constant_detector.vulnerable_instructions)
                                  + len(self.loop_detector.vulnerable_instructions))
        
        if self.bypass_detector:
            total_vulnerable_lines += len(self.bypass_detector.vulnerable_set)
        print(f"Total number of vulnerable lines: {total_vulnerable_lines}")

        # total number of branch faults
        total_branch_faults = len(self.branchV2_detector.vulnerable_instructions)
        console.print(f"\tTotal number of Branch vulnerabilities: {total_branch_faults}")

        # total number of constant coding faults
        total_constant_faults = len(self.constant_detector.vulnerable_instructions)
        console.print(f"\tTotal number of Constant vulnerabilities: {total_constant_faults}")
        
        # total number of constant coding faults
        total_loop_faults = len(self.loop_detector.vulnerable_instructions)
        console.print(f"\tTotal number of Loop Check vulnerabilities: {total_loop_faults}")

        # total number of bypass faults
        if self.bypass_detector:
            total_bypass_faults = len(self.bypass_detector.vulnerable_set)
            console.print(f"\tTotal number of Bypass vulnerabilities: {total_bypass_faults}")

    def get_total_vulnerable_lines(self) -> int:
        total_lines = (len(self.branchV2_detector.vulnerable_instructions) + len(self.constant_detector.vulnerable_instructions)
                + len(self.loop_detector.vulnerable_instructions))
        
        if self.bypass_detector:
            total_lines += len(self.bypass_detector.vulnerable_set)
        
        return total_lines