# Asphault - Assembly Fault Injection Vulnerability Detector

- [Asphault - Assembly Fault Injection Vulnerability Detector](#asphault---assembly-fault-injection-vulnerability-detector)
  - [Project Introduction](#project-introduction)
    - [Usage](#usage)
  - [Generating sample files](#generating-sample-files)
    - [Requirements](#requirements)
    - [Compiling](#compiling)
  - [Patterns](#patterns)
    - [Fault.BRANCH](#faultbranch)
      - [Insecure Example](#insecure-example)
      - [Secure Example](#secure-example)
      - [Implementation](#implementation)
  - [Structure](#structure)
    - [main.py](#mainpy)
    - [Parser.py](#parserpy)
    - [Analysis.py](#analysispy)
      - [Branch Class](#branch-class)
      - [Analyzer Class](#analyzer-class)
      - [Utility](#utility)

## Project Introduction

Asphault is a tool created to automatically detect fault injection vulnerabilities within ARM32 assembly. The current method of analysis requires an assembly file; however, the aim of this tool is to support the analysis of compiled binaries.

### Usage

```bash
python3 main.py [target file]
```

## Generating sample files

### Requirements

In order to generate sample files, a C compiler is needed. In the case of this project, `CC 11.3.0` or `>` should work fine:

```terminal
cc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

### Compiling

If a compiler is already present, then create a high-level example of the vulnerability pattern in question. Meaning, create a new C file and write a simple example of the pattern there. Once completed, compile the file in the following manner:

```bash
cc -S filename.c -o assembly_filename.s
```

Which should then generate an assembly (`.s`) file to use with `Parser.py`.

## Patterns

### Fault.BRANCH

The first vulnerability to automatically detect is `FAULT.BRANCH`. This involves the usage of trivial values for boolean operations within critical conditional statements.

#### Insecure Example

The vulnerable pattern identified is the following:

```asm
movl $1, -4(%rbp)
cmpl $1, -4(%rbp)
jne .L2
```

Where `%rbp` is the stack pointer. Since this trivial value is an integer, a subtraction of 4 bytes is necessary to store the integer type. Hence, `$1` is moved to the top of the stack.
For an attacker, it is easier to manipulated the trivial value 1 to bypass a critical condition.

#### Secure Example

A secured pattern would contain a non-trivial value:

```asm
movl $15525, -4(%rbp)
cmpl $15525, -4(%rbp)
jne .L2
```

#### Implementation

In progress...

## Structure

Asphault (currently) is separated between two modules: `Parser.py` and `Analyzer.py`.

### main.py

The entrypoint to the program. `main.py` serves as a central location to utilize both modules.

### Parser.py

Main parsing module. Intended to parse 32-bit ARM assembly code. It combs through the source code and creates objects depending on what it encounters. Once the source code is transformed into a list of objects, it can be more easily worked with to discover patterns. It uses Python’s type hints to be more transparent.

`Locations` are spots in the code that can be referenced and jumped to. Example: .LC0 and main.

`IntegerLiterals` are integers. In 32-bit syntax, these are prefaced with a “#”

`StringLiterals` are strings. These are prefaced by a location and .ascii.

`Registers` are ARM registers.

`Instructions` are assembly instructions. They are composed of the string representation and a list of the arguments, which are further parsed into IntegerLiterals, StringLiterals and Registers.

There are certain features that need to be added such as parsing memory locations, which are found inside straight brackets (“[“ and “]”). Since these are offset to register values or memory locations, this will take some work.

### Analysis.py

Performs static analysis on a program's instructions to detect fault injection vulnerabilities.

As of today's writing (06/19/2023), there are only two classes:

- Branch
- Analyzer

Planned Updates/Additions:

- Constant
- DefaultFail
- TBD

#### Branch Class

The `Branch` class represents a branch object used for branch analysis. It contains the following attributes:

- `trivial_values`: A list of trivial integer values that are considered vulnerable.
- `pattern`: A list of patterns to match instructions. The patterns are used to identify vulnerable branches.
- `vulnerable_instructions`: A list of vulnerable instructions found during analysis.
- `current_vulnerable`: A list of instructions currently identified as vulnerable.
- `is_vulnerable`: A boolean flag indicating whether a branch vulnerability is detected.

The `Branch` class provides the following methods:

- `branch_analysis(line)`: Analyzes the given instruction line for branch vulnerability.
- `strip_line(line)`: Strips the given instruction line for vulnerabilities.
- `contains_trivial_numeric_value(value)`: Checks if the given value is a trivial numeric value.
- `update_vulnerable_instructions()`: Updates the list of vulnerable instructions with the current vulnerable instructions.

#### Analyzer Class

The `Analyzer` class performs static analysis on a program's instructions using the `Branch` class. It has the following attributes:

- `parsed_data`: The parsed data object containing the program instructions.
- `branch_detector`: An instance of the `Branch` class used for branch analysis.

The `Analyzer` class provides the following methods:

- `static_analysis()`: Performs static analysis on the program instructions.
- `print_analysis_results()`: Prints the analysis results.

#### Utility

To use the Branch Vulnerability Analyzer, follow these steps:

1. Instantiate a `Parser` object and pass the parsed program instructions to the `Analyzer` constructor.
2. Call the `static_analysis()` method of the `Analyzer` object to perform static analysis on the program instructions.
3. Call the `print_analysis_results()` method of the `Analyzer` object to print the analysis results.

If any branch vulnerabilities are detected, the program will display the vulnerable lines of code.

Note: The provided code assumes the existence of other classes (`Instruction`, `Location`, and `Parser`) which are not included in the code snippet. Make sure to define or import these classes before using the Branch Vulnerability Analyzer.
