# New Patterns Found x86

## Using function arguments/parameters (registers) for comparison of trivial values

If certain values are passed to functions, then the `movl` statement will target the respective register for function parameters, in this case: `%edi`

```asm
movl %edi, -4(%rbp)
cmpl $1, -4(%rbp)
jne .L3
```

## Multiple assignments before comparison

There can be multiple pushes onto the stack before executing a comparison.
Although, in this case, the operation is not that of equality. It is worth keeping this in mind.

```asm
subq $32, %rsp
movl $1, -20(%rbp)
movl $8, -16(%rbp)
movl $10, -12(%rbp)
movl -16(%rbp), %eax
cmpl -12(%rbp), %eax
jge .L7
```

## Multiple assignments before system call

Here we have a couple of pushes to the stack, then moving stack values to registers, finally arriving onto function parameter register (`%edi`), then using that within a call, then AND `%eax` to see if it's zero and take the jump.

```asm
movl $0, -8(%rbp)
movl $12, -4(%rbp)
movl -8(%rbp), %eax
movl %eax, %edi
call branch_check
testl %eax, %eax
jne .L9
```

## Notes

It might be worth keeping track of `movl` instructions onto stack, then compared the location for which `cmpl` is pointing to.

Need a way to keep track of register values (?) possibly.
