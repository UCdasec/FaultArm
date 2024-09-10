# Architecture and Compilers

- [Architecture and Compilers](#architecture-and-compilers)
  - [Overivew](#overivew)
    - [Compiler](#compiler)
  - [Architectures](#architectures)
  - [Cross-compiling](#cross-compiling)
    - [ARM](#arm)
    - [RISC-V](#risc-v)
    - [x86](#x86)
  - [Tool Chain Conventions](#tool-chain-conventions)

## Overivew

FaultHunter_ASM Currently supports the x86 architecture. All assembly files have been generated using the `cc` compiler with the `-S` flag.

> The generated assembly files are written/compiled as x86 assembly

The goal is to support both `x86` and `ARM` architectures.

**NOTE:** As of Spring 2024, the focus of the tool as been shifted to `ARM` and `RISC-V` architectures.

### Compiler

For further development the compiler of choice will be `gcc`:

```
gcc (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

## Architectures

With `gcc` as our compiler of choice, all of the generated assembly files will remain compiled/written as `x86` assembly. We can start cross-compiling C files utilizing `arm-none-eabi-gcc`.

## Cross-compiling

In order to compile the dataset, scripts will be provided in order to have both x86 and ARM examples; however, in case of needing manual compilation, the following is the command that will be used to compile files:

### ARM

```bash
arm-none-eabi-gcc -S -o filename.s /path/to/filename.c
```

```bash
arm-none-eabi-gcc --specs=nosys.specs -o filename /path/to/filename.c
```

### RISC-V
The RISC-V GCC toolchain and its installation instructions can be found at this [link](https://github.com/riscv-collab/riscv-gnu-toolchain). Once you have installed the toolchain successfully, you can  create Assembly binaries with the following command:
```bash
riscv64-unknown-elf-gcc -S -o filename.s /path/to/filename.c
```
### x86

```bash
gcc -S -o filename.s /path/to/filename.c
```

## Tool Chain Conventions

Tool chains have  a loose name convention like **arc [-vendor] [-os] - eabi**


    arch - refers to target architecture (which in our case is ARM)

    vendor - refers to toolchain supplier

    os - refers to the target operating system

    eabi - refers to Embedded Application Binary Interface

 
some illustrations as follows :

**arm-none-eabi** - This tool chain targets for ARM architecture, has no vendor, does not target an operating system and complies with the ARM EABI.

**arm-none-linux-gnueabi** - This toolchain targets the ARM architecture, has no vendor, creates binaries that run on the Linux operating system, and uses the GNU EABI. It is used to target ARM-based Linux systems.

> https://web.archive.org/web/20160410104337/https://community.freescale.com/thread/313490#comment-354077