import argparse

from Parser import Parser
from Analyzer import Analyzer

def main():
    parser = argparse.ArgumentParser(description='Parse an x86 assembly file and look for vulnerable patterns.')
    parser.add_argument('file', metavar='filename', type=str, nargs=1, help='the target filename')
    args = parser.parse_args()
    
    # Parse file
    parsed_data = Parser(args.file[0])
    
    # print(f"ARCHITECTURE DETECTED: {parsed_data.arch.name}\n")
    
    # print(parsed_data)
    analyzed_data = Analyzer(args.file[0], parsed_data, parsed_data.total_lines, "./out/")
    
    # Print results
#     analyzed_data.save_and_print_analysis_results()
    analyzed_data.just_print_analysis_results()

    # Add total lines analyzed, total vulnerable lines, lines for each vulnerability.
    #printing analytical results
    print(f"Total lines analyzed: {parsed_data.total_lines}\n")
    analyzed_data.print_total_vulnerable_lines()
    print(f"\nPercentage of lines vulnerable: {round(float(analyzed_data.get_total_vulnerable_lines()/parsed_data.total_lines)*100,2)}%")

if __name__ == "__main__":
    main()