# Automatically Detecting Fault Injection Vulnerabilities in Arm32 Assembly

## `Parser.py`

Parser documentation can be found at the root of the project.

### Proposed change (Deprecated)

Usage of [Capstone](https://www.capstone-engine.org/lang_python.html) a dissambling engine for python.

Snippets taken from official documentation:

```py
# test1.py
from capstone import *

CODE = b"\x55\x48\x8b\x05\xb8\x13\x00\x00"

md = Cs(CS_ARCH_X86, CS_MODE_64)
for i in md.disasm(CODE, 0x1000):
    print("0x%x:\t%s\t%s" %(i.address, i.mnemonic, i.op_str))
```

If ran, it results in the following:

```bash
$ python test1.py

0x1000:	push	rbp
0x1001:	mov	rax, qword ptr [rip + 0x13b8]
```

While we already have a working parser, making the transition to `Capstone` would provide for a more stable foundation.

## FAULT.BRANCH

The first vulnerability to automatically detect is `FAULT.BRANCH`. This involves the usage of trivial valuas for boolean operations within critical conditional statements.

The vulnerability is represented in C in the following manner:

```c
int result = 1;
if (result == 1)
{
    printf("Executing critical code...");
}
else
{
    printf("Exiting out...");
    return 1;
}
```

Which is then represented as such in Arm32 Assembly:

```assembly
movl	$1, -4(%rbp)
cmpl	$1, -4(%rbp)
jne	.L2
```

For an attacker, it is easier to manipulated the trivial value 1 to bypass a critical condition.

A secured example would include the following:

```c
int result = 0x3ca5;

// Non-trivial numerical value
if (result == 0x3ca5)
{
    printf("Executing critical code...");
}
else
{
    printf("Exiting out...");
    return 1;
}
```

Which is then represented as such in Arm32 Assembly:

```assembly
movl	$15525, -4(%rbp)
cmpl	$15525, -4(%rbp)
jne	.L2
```

Non-trivial numerical values are more difficult to set by fault injection. Sensitive choices should therefore not be coded as boolean value, but rather as a non-trivial numerical value.

## ARM32 Comp

arm32

```bash
arm-linux-gnueabihf-gcc -S -o output.s input.c
```