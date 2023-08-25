# Document Purpose

The intention behind this document is to outline the limitations associated with converting patterns from their higher-level C versions to assembly code. In situations where the high-level structure or abstraction cannot be effectively translated to assembly, this document provides explanations for these discrepancies.

## DefaultFail

**DefaultFail** presents a unique scenario due to the absence of direct equivalents to the high-level language constructs such as `else` or `default`.

Several guidelines can be followed to identify potential instances of `default` cases:


- **Unconditional Execution Block**: The default block executes when none of the preceding cases are true. In assembly, this can be recognized as a section of code following a sequence of conditional jump instructions `(jxx)` without associated jump conditions.

```assembly
cmpl	$2, -4(%rbp)
je	.L2
cmpl	$2, -4(%rbp)
jg	.L3
cmpl	$0, -4(%rbp)
je	.L4
cmpl	$1, -4(%rbp)
je	.L5
jmp	.L3
```

- **Fall-through after Cases**: When code immediately follows a sequence of conditional jumps without any corresponding conditions, it may indicate the presence of a default case.

- **Label without Corresponding Jump**:  In the switch block, you might encounter a label that isn't the target of any conditional jump. While all cases within a switch statement typically correspond to specific conditions, the default block activates when none of these conditions are met

```assembly
jmp	.L3
```

- **Comparison with a Full Set of Values**: If the range of values being switched upon is known, and comparisons `(cmp)` and jumps `(je, jne, etc.)` are present for all values except one code block at the end, it likely signifies a default block.

> Occasionally, the compiler might optimize the code in a manner that breaks direct correspondence between high-level cases and assembly code (e.g., using a jump table). 

Identifying a default case may necessitate more advanced analysis, potentially involving techniques like symbolic execution, data-flow analysis, or other methods to comprehend the underlying logic being implemented.

### Note:
It's important to note that due to the significant level of uncertainty in this process, it can generate numerous false positives. These false positives could lead to decreased accuracy and precision in identifying actual default cases.