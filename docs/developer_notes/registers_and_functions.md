- [x86 Assembly: Calling Convention](#x86-assembly-calling-convention)
  - [32-bit x86 Architecture (cdecl)](#32-bit-x86-architecture-cdecl)
  - [64-bit x86 Architecture (x86\_64)](#64-bit-x86-architecture-x86_64)
  - [Additional Information](#additional-information)
- [ARM Assembly: Calling Convention](#arm-assembly-calling-convention)
  - [ARM (32-bit)](#arm-32-bit)
  - [ARM64 (64-bit, AArch64)](#arm64-64-bit-aarch64)
  - [Additional Information](#additional-information-1)


## x86 Assembly: Calling Convention

In x86 assembly, the method of passing arguments to functions is defined by the **calling convention**.

### 32-bit x86 Architecture (cdecl)
In the 32-bit x86 architecture, the standard calling convention, known as `cdecl`, is predominantly used. This convention dictates that all arguments are passed **on the stack**.

### 64-bit x86 Architecture (x86_64)
For the 64-bit x86 architecture, the calling convention evolves, and registers are primarily used to pass arguments. The convention used by many UNIX-like operating systems, such as Linux, is known as the **System V AMD64 ABI**. Under this convention, argument passing is as follows:

- `RDI` : First integer or pointer argument
- `RSI` : Second integer or pointer argument
- `RDX` : Third integer or pointer argument
- `RCX` : Fourth integer or pointer argument
- `R8`  : Fifth integer or pointer argument
- `R9`  : Sixth integer or pointer argument

> **Note**: After the first six integer or pointer arguments, subsequent arguments are passed on the stack.

For **floating point arguments**, they're passed in the XMM registers, starting with `XMM0`.

### Additional Information
Different operating systems or environments may adopt slightly varied conventions. For example, the Windows x86_64 calling convention utilizes a distinct set of registers (`RCX`, `RDX`, `R8`, `R9`) for the initial four integer or pointer arguments.

Of course! The ARM architecture has its own calling conventions and is a bit different from x86. Here's a structured and visually appealing version for a README.md focused on the ARM calling convention:


## ARM Assembly: Calling Convention

The ARM architecture, prevalent in many mobile and embedded systems, has specific conventions for function calling and argument passing.

### ARM (32-bit)

In the ARM 32-bit architecture, the convention for passing arguments to functions and returning results is defined mainly by the **AAPCS (ARM Architecture Procedure Call Standard)**.

- `R0` - `R3` : Used to pass the first four integer or pointer arguments.
- `R4` - `R8`, `R10`, `R11` : Callee-saved registers; they need to be preserved across function calls.
- `R9` : Platform specific (can be callee-saved or used for passing arguments).
- `R12` (or `IP` for Intra-Procedure call scratch register) : Used as a temporary workspace.
- `R14` (or `LR` for Link Register) : Holds the return address of the function.
- `R13` (or `SP` for Stack Pointer) : Points to the current location within the stack.

> **Note**: Arguments beyond the first four are passed on the stack. Floating-point arguments are passed using `S0`-`S15` (single precision) and `D0`-`D7` (double precision) registers.

### ARM64 (64-bit, AArch64)

For the 64-bit ARM architecture, also known as AArch64:

- `X0` - `X7` : Used to pass the first eight integer or pointer arguments.
- `X8` - `X30` : General purpose registers.
- `X31` or `SP` : Stack Pointer.
- `V0` - `V7` : Used for passing and returning floating point arguments.

> **Note**: As with 32-bit ARM, arguments exceeding the ones passed in registers are passed on the stack.

### Additional Information

The exact calling convention can vary based on the specific variant of ARM and the operating system in use. The above conventions are generalized and follow common practices.
