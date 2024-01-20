import argparse
from rich.text import Text
import time

from Parser import Parser
from Analyzer import Analyzer
from utils import console

def main():
    parser = argparse.ArgumentParser(description='Parse an x86 assembly file and look for vulnerable patterns.')
    parser.add_argument('file', metavar='filename', type=str, nargs=1, help='the target filename')
    args = parser.parse_args()
    
    # Display Banner
    console.print(Text("""
     _____           _ _   _   _             _            
    |  ___|_ _ _   _| | |_| | | |_   _ _ __ | |_ ___ _ __ 
    | |_ / _` | | | | | __| |_| | | | | '_ \| __/ _ \ '__|
    |  _| (_| | |_| | | |_|  _  | |_| | | | | ||  __/ |   
    |_|  \__,_|\__,_|_|\__|_| |_|\__,_|_| |_|\__\___|_|   
    """), style="blue")
    
    # Parse file
    with console.status("Parsing file...", spinner="line"):
        try:
            parsed_data = Parser(args.file[0], console)
        except FileNotFoundError:
            console.print(f"Error: File {args.file[0]} not found.", style="bold red")
            exit(1)

    console.log(f"Architecture Detected: [bright_yellow]{parsed_data.arch.name}[/bright_yellow]\n")
    
    # Analyze parsed data
    with console.status("Analyzing parsed data...", spinner="line"):
        analyzed_data = Analyzer(args.file[0], parsed_data, parsed_data.total_lines, "./out/", console)    
    
    # Print results
    # analyzed_data.save_and_print_analysis_results(console)
    analyzed_data.print_analysis_results(console)

    # Add total lines analyzed, total vulnerable lines, lines for each vulnerability.
    #printing analytical results
    console.print(f"\nTotal lines analyzed: {parsed_data.total_lines}\n")
    analyzed_data.print_total_vulnerable_lines(console)
    console.print(f"\nPercentage of lines vulnerable: {round(float(analyzed_data.get_total_vulnerable_lines()/parsed_data.total_lines)*100,2)}%")

if __name__ == "__main__":
    main()