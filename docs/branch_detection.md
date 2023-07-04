# Detecting Branch Vulnerabilities in x86 Assembly

- [Detecting Branch Vulnerabilities in x86 Assembly](#detecting-branch-vulnerabilities-in-x86-assembly)
  - [Requirements](#requirements)
    - [Generating Assembly Files](#generating-assembly-files)
  - [Branch Pattern in x86](#branch-pattern-in-x86)
  - [Detection](#detection)
    - [Parse](#parse)
    - [Analysis](#analysis)
    - [Analysis Flowchart](#analysis-flowchart)
  - [Proposed Changes (06262023)](#proposed-changes-06262023)
    - [Ignore Stack](#ignore-stack)
    - [Pattern](#pattern)
    - [Flowchart](#flowchart)
  - [References](#references)

*Branch* is a fault injection vulnerability pattern that arises from the usage of booleans for sensitive decisions [1]. `Booleans` refers to trivial numerical values such as `0` or `1`. Such values are commonly used to determine the successful, or unsuccessful, completion of an operation.

While there are methods to detect such vulnerable patterns in C source code [2], there is a lack of detection in lower levels of programming architecture. The expansion of pattern detection onto assembly removes the current limitation of needing source code in order to detect vulnerabilities. With identified assembly patterns, the only required source is a binary, or compiled, file.

## Requirements

The current vulnerability detection process requires an assembly source file as an input.

In the case of this proof-of-concept, all assembly files were generated from C source files.

### Generating Assembly Files

Generating assembly files involves compiling existing C source code, for which a C compiler is needed. All compilation for this project was done with `CC 11.3.0`.

```terminal
cc (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

The compilation of C to generate assembly is done so by calling the C compiler using the `-S` flag:

```bash
cc -S filename.c -o assembly_filename.s
```

This directs the compiler to generate assembly source (`assembly_filename.s`) from the provided C source (`filename.c`).

## Branch Pattern in x86

By comparing multiple assembly files generated from secured and unsecured C sources, a clear pattern was identified:

```asm
movl $1, -4(%rbp)
cmpl $1, -4(%rbp)
jne .L2
```

The pattern represents a jump, or conditional, statement. The compiler first moves (`movl`) `1` to the top of the stack (`-4(%rbp)`), then compares `1` to the valued stored at the top of the stack (`1`). Finally, the result of this operation (`1-1`) is checked, and if the result is `0` (`jne`), then a jump is performed towards the location of `.L2`.

These instructions, occurring in a consecutive manner, showcase a clear branch vulnerability, if and only if they contain trivial numerical values, or booleans (i.e. `0` or `1`).

A secured example for this pattern would contain a non-trivial numerical value:

```asm
movl $15525, -4(%rbp)
cmpl $15525, -4(%rbp)
jne .L2
```

Non-trivial numerical values are more difficult to set by fault injection [1].

## Detection

### Parse

The detection process operates by going over all lines of the provided assembly file.

The analysis starts by detecting whether the current line is an instruction line. Instruction lines are lines that contain instructions, or opcode. While this definition may appear circular, this distinction is needed as lines could also be locations, or strings rather than instructions.

To accomplish this, the first and last character(s) of a line are examined. In the case of the first characters being `.string`, then the line would be considered as a string and discarded. On the other hand, if the line ends with a colon `:`, then the line would be considered a location. The following depicts a location and a string lines, respectively:

```asm
.LC0:
    .string "Executing critical code..."
```

Once the parser has identified all instructions, the analyzer goes through all of them line-by-line.

### Analysis

If the current line contains the first instruction in the identified pattern (`movl`), then the value and destination of such instruction are considered. If such value is identified as trivial (`0`, `-1`, `1`, `-2`, `2`), then the current line is remembered. Otherwise, the line is disregarded and the process continues until it finds the beginning of the pattern.

```asm
movl $1, -4(%rbp)
```

Following a vulnerable `movl`, if the subsequent line contains the second instruction in the identified pattern (`cmpl`) **and** their values and destinations match, meaning that the `cmpl` instruction contains the same trivial value as `movl` and the location where `movl` was pointing to, then the current line is also remembered. Otherwise, the current and previous lines are disregarded and the search for the first instruction of the pattern starts again.

```asm
cmpl $1, -4(%rbp)
```

Finally, if the subsequent instruction to `cmpl` is a jump, `jne` **or** `je`, then all three lines are remembered and a new search begins for more pattern occurrences. If the subsequent instruction is not a jump, all previous lines are disregarded and a new search for the initial instruction pattern begins.

```asm
jne .L2
```

### Analysis Flowchart

```mermaid
flowchart TD

A(Start) --> B{"Is current line an instruction line?"}
B -- Yes --> C{"Does the line start with .string?"}
B -- No --> D{"Does the line end with ':'?"}
C -- Yes --> E(End - Discard line as string)
C -- No --> D
D -- Yes --> F(End - Discard line as location)
D -- No --> G{Is the line the first instruction in the identified pattern?}
G -- Yes --> H{Is the value trivial?}
G -- No --> B
H -- Yes --> I(Memorize current line)
H -- No --> B
I --> J{Is the subsequent line the second instruction in the identified pattern?}
J -- Yes --> K{Do the values of both instructions match?}
J -- No --> B
K -- Yes --> L(Memorize current line)
K -- No --> B
L --> M{"Is the subsequent instruction a jump (jne or je)?"}
M -- Yes --> N(Memorize all three lines)
M -- No --> B
N --> B

```

Essentially, the pattern to identify is a push of a trivial numerical value onto the stack, a comparison of such value against itself, and the presence of a jump afterwards. If such pattern occurs, then a branch vulnerability was detected.

## Proposed Changes (06262023)

The pattern described above, while effective for simple examples, does not detect more robust applications of the pattern. Consequently, a new approach is proposed.

### Ignore Stack

The previous pattern proposes analyzing data pushed onto the stack before the comparison and jump. In further retrospect, the data before the comparison and jump *can* be irrelevant to the vulnerability.

> *Branch* is a fault injection vulnerability pattern that arises from the usage of booleans for sensitive decisions [1].

All we should be looking at is the booleans utilized for sensitive decisions. Which, in the case for x86 assembly, is the following:

```asm
cmpl value, [stack]
jne location
```

In the very essence of this vulnerability, these are the most imperative instructions. If we are comparing a value from the stack to a trivial numerical value, and then checking if this operation resulted in zero, we can be confident that a trivial/boolean value was used for a decision.

### Pattern

```asm
cmpl $1, -4(%rbp)
jne .L2
```

The process starts by scanning the first line of the program. If the line is an instruction line, the process proceeds to analyze it. If it is not an instruction line, the line is disregarded, and the process moves on to scan the next line.

For an instruction line, the process checks if the instruction is `CMPL` If it is not, the line is disregarded, and the process moves on to scan the next line. If the instruction is `CMPL`, the process checks if the value in the `CMPL` operation is trivial. If it is trivial, the current line is stored. If it is not trivial, the line is disregarded.

The tool then checks if the `CMPL` operation is followed by a `JNE` instruction. If the `JNE` instruction is present, the process verifies if a `CMPL` instruction has already been stored. If there is a `CMPL` already stored, the current line is stored. Otherwise, the line is disregarded.

> The `JNE` instruction subsequent to a `CMPL` using a trivial value, implies that the second value in the `CMPL` operation is also trivial. Hence, the instruction becomes flagged.
>
> For instance:
>
> ```asm
> cmpl $1, -4(%rbp)
> jne .L2
> ```
>
> This pattern implies that the value stored at `-4(%rbp)` *CAN* be trivial, since the `JNE` operations checks for `1 - [stack value] != 0`. It is also worth noting that this pattern also applies if `JE`, `JZ`, or `JNZ` are used.

After storing the line, the process checks if two instructions have already been stored, as this would signify a completed pattern. If two instructions are stored, they are moved to a permanent storage, and the temporary storage is cleared. If less than two instructions are stored, the process moves back to scanning the next line.

The process continues in this manner, scanning and analyzing lines until there are no more lines to scan.

### Flowchart

```mermaid
flowchart TD

Read_Line("Scan Next Line")
Read_Line --> Instruction_Line

Disregard("Disregard Line") --> Read_Line

Instruction_Line{"Is the current line an instruction line?"}
Instruction_Line -- Yes --> Compare{"Is the instruction CMPL?"}
Instruction_Line -- No --> Disregard

Compare -- No --> Jump{"Is the instruction JNE?"}
Jump -- Yes --> After_Compare{"Is a CMPL instruction stored?"}
After_Compare -- Yes --> Store
After_Compare -- No --> Disregard


Compare -- Yes --> Trivial{"Is the value in the CMPL operation trivial?"}


Trivial -- Yes --> Store("Store Line")
Trivial -- No --> Disregard

Store --> Pattern_Complete{"Are there two instructions stored?"}
Pattern_Complete -- Yes --> Store_Permanent("`Permanently Store Instructions
&
Clear Temporary Storage`")
Pattern_Complete -- No --> Read_Line

Store_Permanent --> Read_Line
```

## References

[1]: M. Witteman, "Secure application programming in the presence of side channel attacks," Riscure, Tech. Rep., Aug 2017. [Online]. Available: <https://www.riscure.com/uploads/2017/08/Riscure> Whitepaper Side Channel Patterns.pdf

[2]: L. Reichling, I. Warsame, S. Reilly, A. Brownfield, N. Niu and B. Wang, "FaultHunter: Automatically Detecting Vulnerabilities in C against Fault Injection Attacks," 2022 IEEE/ACM International Conference on Big Data Computing, Applications and Technologies (BDCAT), Vancouver, WA, USA, 2022, pp. 271-276, doi: 10.1109/BDCAT56447.2022.00045.
