import argparse

from Parser import Parser
from Analyzer import Analyzer

def main():
    parser = argparse.ArgumentParser(description='Parse an ARM assembly file and look for vulnerable patterns.')
    parser.add_argument('file', metavar='filename', type=str, nargs=1, help='the target filename')
    args = parser.parse_args()
    parsed_data = Parser(args.file[0])
    # print(parsed_data)
    analyzed_data = Analyzer(parsed_data)

if __name__ == "__main__":
    main()