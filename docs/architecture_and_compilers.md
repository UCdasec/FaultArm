# Architecture and Compilers

- [Architecture and Compilers](#architecture-and-compilers)
  - [Overivew](#overivew)
    - [Compiler](#compiler)
  - [Architectures](#architectures)
  - [Cross-compiling](#cross-compiling)
    - [ARM](#arm)
    - [x86](#x86)

## Overivew

FaultHunter_ASM Currently supports the x86 architecture. All assembly files have been generated using the `cc` compiler with the `-S` flag.

> The generated assembly files are written/compiled as x86 assembly

The goal is to support both `x86` and `ARM` architectures.

### Compiler

For further development the compiler of choice will be `gcc`:

```
gcc (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

## Architectures

With `gcc` as our compiler of choice, all of the generated assembly files will remain compiled/written as `x86` assembly. We can start cross-compiling C files utilizing `arm-linux-gnueabi-gcc`, a popular GNU C compiler.

## Cross-compiling

In order to compile the dataset, scripts will be provided in order to have both x86 and ARM examples; however, in case of needing manual compilation, the following is the command that will be used to compile files:

### ARM

```bash
arm-linux-gnueabi-gcc -S -o filename.s /path/to/filename.c
```

### x86

```bash
gcc -S -o filename.s /path/to/filename.c
```
