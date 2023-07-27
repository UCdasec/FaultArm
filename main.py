import argparse

from Parser import Parser
from Analyzer import Analyzer

def main():
    parser = argparse.ArgumentParser(description='Parse an x86 assembly file and look for vulnerable patterns.')
    parser.add_argument('file', metavar='filename', type=str, nargs=1, help='the target filename')
    args = parser.parse_args()
    parsed_data = Parser(args.file[0])
    # print(parsed_data)
    analyzed_data = Analyzer(args.file[0], parsed_data, parsed_data.total_lines, "./out/")
    
    # Print results
    analyzed_data.save_and_print_analysis_results()
    
    # TODO: Add further analytical results
    # Add total lines analyzed, total vulnerable lines, lines for each vulnerability.

if __name__ == "__main__":
    main()