# Assembly Parser

- [Assembly Parser](#assembly-parser)
  - [Project Introduction](#project-introduction)
    - [Usage](#usage)
    - [Thoughts](#thoughts)
  - [Generating sample files](#generating-sample-files)
    - [Requirements](#requirements)
    - [Compiling](#compiling)
  - [Patterns](#patterns)
    - [Fault.BRANCH](#faultbranch)
      - [Insecure Example](#insecure-example)
      - [Secure Example](#secure-example)
      - [Implementation](#implementation)

## Project Introduction

Parser is a simple intended to parse 32-bit ARM assembly code. It combs through the source code and creates objects depending on what it encounters. Once the source code is transformed into a list of objects, it can be more easily worked with to discover patterns. It uses Python’s type hints to be more transparent.

Locations are spots in the code that can be referenced and jumped to. Example: .LC0 and main.

IntegerLiterals are integers. In 32-bit syntax, these are prefaced with a “#”

StringLiterals are strings. These are prefaced by a location and .ascii.

Registers are ARM registers.

Instructions are assembly instructions. They are composed of the string representation and a list of the arguments, which are further parsed into IntegerLiterals, StringLiterals and Registers.

There are certain features that need to be added such as parsing memory locations, which are found inside straight brackets (“[“ and “]”). Since these are offset to register values or memory locations, this will take some work.

### Usage

```bash
python3 Parser.py [target file]
```

### Thoughts

There currently is an object-oriented structure for the parser. All is parsed and stored in the respective classes, with initializing the parser class first, then the rest when needed.

~~I am thinking of tapping into the Instruction class, or rather where it is invoked, and as it reads instructions, it also checks for this specific vulnerability.~~

Maintaining the current modular aspect of the parser remains a priority. Consequently, the proposition is to process the parsed data through different classes, which will maintain the object-oriented nature of the codebase.

While rudimentary at best, I am planning to detect instructions like `movl` and `cmpl` with values such as `$1` or `$0`, as these are most commonly used for boolean representations. Meaning, if the instruction `movl` moves a `$1` to the top of the stack and the compares it to itself (`$1`), we can identify a vulnerability there. Of course, we need to also look for a subsequent jump instruction, but future iterations will handle that feature.

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
