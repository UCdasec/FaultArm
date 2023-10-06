# Compiler Optimization | Examples Retrospect

- [Compiler Optimization | Examples Retrospect](#compiler-optimization--examples-retrospect)
  - [Introduction](#introduction)
  - [Inlining Functions](#inlining-functions)
    - [Example](#example)
  - [Constant Propagation and Dead Code Elimination](#constant-propagation-and-dead-code-elimination)
    - [Example](#example-1)
  - [When Functions and Conditionals Are Not Skipped](#when-functions-and-conditionals-are-not-skipped)
    - [Examples](#examples)


## Introduction

When we compile C code with optimization flags like `-O1`, `-O2`, or `-O3`, the compiler performs various optimizations to improve the performance or reduce the size of the generated code. This can sometimes lead to surprising results, such as functions and conditionals not appearing in the assembly output for `main`.

## Inlining Functions

One common optimization is function inlining. In this optimization, the compiler replaces a function call with the body of the function itself, thereby eliminating the overhead of a function call. This is often done for small and simple functions.

### Example

Consider the following C function:

```c
void foo(int* bar) {
    *bar = 1;
}
```

When compiled with optimization, the function call to `foo` may be replaced by its body, effectively setting `*bar = 1` directly in the calling function (`main` in this case).

## Constant Propagation and Dead Code Elimination

Another set of optimizations are constant propagation and dead code elimination. If the compiler can determine at compile-time what the outcome of a conditional will be, it may remove the conditional altogether.

### Example

```c
if (*bar == 1) {
    printf("True branch\n");
} else {
    printf("False branch\n");
}
```

If the compiler knows that `*bar` will always be 1, it may remove the conditional and only include the code for the "true" branch.

## When Functions and Conditionals Are Not Skipped

There are scenarios where these optimizations won't take place:

1. **Complexity**: If the function is too complex to inline, the compiler will likely keep the function call. Complexity often times refers to the usage of runtime data to perform calculations or operations.
2. **Dynamic Behavior**: If the outcome of a function or conditional depends on runtime information that the compiler cannot predict, then the function and conditional will not be optimized out.
3. **Side Effects**: Functions with side effects that are observable (e.g., I/O operations, volatile variables) are generally not optimized out.

### Examples 

```c
#include <stdio.h>

int foo(int *password) {
    *password += 1;
    // Simulate some password checking logic
    if (*password == 1) {
        return 0;  // Correct password
    } else {
        return 1;  // Incorrect password
    }
}

int main(void) {
    int password = (int)getchar();  // Dynamic password

    // Call the function to check the password
    if (foo(&password) == 1) {
        printf("Access granted.\n");
    } else {
        printf("Access denied.\n");
        return 1;
    }

    return 0;
}

```

In this example, `foo` is unlikely to be optimized due to the runtime nature of the `password`. Apart from this, `foo` is performing modifications and checks that depend on the runtime value of password.


```c
#include <stdio.h>
#include <time.h>

void foo(int* bar) {
    *bar = time(NULL) % 2;  // Dynamic behavior based on current time
}

int main(void) {
    int result;
    foo(&result);
    if (result == 1) {
        printf("True branch\n");
    } else {
        printf("False branch\n");
    }
    return 0;
}
```

Similarly to the previous example, `foo` is unlikely to be optimized out because it depends on runtime information.
