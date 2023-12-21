# FaultHunter_ASM - Assembly Fault Injection Vulnerability Detector

- [FaultHunter\_ASM - Assembly Fault Injection Vulnerability Detector](#faulthunter_asm---assembly-fault-injection-vulnerability-detector)
  - [Project Introduction](#project-introduction)
    - [Usage](#usage)
  - [Generating sample files](#generating-sample-files)
    - [Requirements](#requirements)
    - [Compiling](#compiling)
  - [Patterns](#patterns)
  - [Structure](#structure)
    - [main.py](#mainpy)
    - [Parser.py](#parserpy)
    - [Analysis.py](#analysispy)
      - [Analyzer Class](#analyzer-class)
      - [Utility](#utility)

## Project Introduction

FaultHunter_ASM is a tool created to automatically detect fault injection vulnerabilities within ARM and x86 assembly. The current method of analysis requires an assembly file; however, the aim of this tool is to support the analysis of compiled binaries.

### Usage

```bash
python3 main.py [target_assembly_file]
```

## Generating sample files

### Requirements

In order to generate sample files, a C compiler is needed. In the case of this project, we use `gcc-arm-none-eabi-10.3-2021.10`:

```terminal
arm-none-eabi-gcc (15:9-2019-q4-0ubuntu1) 9.2.1 20191025 (release) [ARM/arm-9-branch revision 277599]
Copyright (C) 2019 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

### Compiling

If a compiler is already present, then create a high-level example of the vulnerability pattern in question. Meaning, create a new C file and write a simple example of the pattern there. Once completed, compile the file in the following manner:

```bash
arm-none-eabi-gcc -S filename.c -o assembly_filename.s
```

Which should then generate an assembly (`.s`) file to use with our tool.

## Patterns

For information regarding the currently supported patterns, please look at `/docs/pattern_documentation`.

We currently support the following patterns:
- Branch
- ConstantCoding
- LoopCheck


## Structure

FaultHunter_ASM (currently) is separated between two modules: `Parser.py` and `Analyzer.py`.

### main.py

The entrypoint to the program, `main.py`, serves as a central location to utilize both modules. All we do in this file is import the modules and utilize them.

### Parser.py

Main parsing module. Intended to parse assembly code. It combs through the source code and creates objects depending on what it encounters. Once the source code is transformed into a list of objects, it can be more easily worked with to discover patterns. It uses Python’s type hints to be more transparent.

`Locations` are spots in the code that can be referenced and jumped to. Example: .LC0 and main.

`IntegerLiterals` are integers. In 32-bit syntax, these are prefaced with a “#”

`StringLiterals` are strings. These are prefaced by a location and .ascii.

`Registers` are ARM registers.

`Instructions` are assembly instructions. They are composed of the string representation and a list of the arguments, which are further parsed into IntegerLiterals, StringLiterals and Registers.

There are certain features that need to be added such as parsing memory locations, which are found inside straight brackets (“[“ and “]”). Since these are offset to register values or memory locations, this will take some work.

### Analysis.py

Performs static analysis on a program's instructions to detect fault injection vulnerabilities.

#### Analyzer Class

The `Analyzer` class performs static analysis on a program's instructions using the different pattern classes. It has the following attributes:

- `filename`: The name of the file being analyzed.
- `parsed_data`: The parsed data object containing the program instructions.
- `totla_lines`: The amount of lines in the assembly file.
- `out_directory`: A path to output analysis results.
- `X_detector`: An instance of the respective `X` pattern class used for pattern analysis.

The `Analyzer` class provides the following methods:

- `create_directory`: Creates a directory with the current timestamp.
- `static_analysis()`: Performs static analysis on the program instructions.
- `just_print_analysis_results()`: Prints the analysis results.
- `save_and_print_analysis_results`: Saves and prints the analysis results.
- `print_total_vulnerable_lines`: Prints the total number of vulnerable lines found.
- `get_total_vulnerable_lines`: Returns the number of vulnerable lines for all patterns in the current file.

#### Utility

To use the Branch Vulnerability Analyzer, follow these steps:

1. Instantiate a `Parser` object and pass the provided assembly file.
2. Pass the output from `Parser` to the `Analyzer` constructor.
3. Call the `static_analysis()` method of the `Analyzer` object to perform static analysis on the program.
4. Call one of the `print_analysis_results()` method of the `Analyzer` object to print the analysis results.

If any vulnerabilities are detected, the program will display:
- Line number
- Instruction
- Pattern
