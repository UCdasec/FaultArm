# Optimization Levels

FaultHunter ASM is intended to handle ARM Assembly files of all optimization levels. As such, the tool is designed to 
anticipate all possible optimization level configurations.
The purpose of this document is to present information on all the possible optimization levels  that our choice of compiler,
`arm_eabi_none_gcc`, provides when compiling C files to ARM assembly.

For information on what optimization levels are in the context of compiling C to ARM Assembly, please refer to this
page [here](https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html).

## Optimization Level Markers

After compiling a C file to ARM using one of the possible optimization options, the corresponding `.s` assembly file 
will generate a set of compiler attributes referred to as `eabi_attribute`s near the top of the assembly file. The 
following table indicates the distinction in relevant `eabi_attribute`s between each of the different optimization levels
offered by the `arm_eabi_none_gcc` compiler.

|  Optimization  | `.eabi_attribute 30` | `.eabi_attribute 23` |
|:--------------:|:--------------------:|:--------------------:|
|       O0       |          6           |          3           |
|       O1       |          1           |          3           |
|       O2       |          2           |          3           |
|       Og       |          1           |          3           |
|       Os       |          4           |          3           |
|     Ofast      |          2           |          1           |

## Notes

- **Current Scope :** The current scope of ASM FaultHunter extends to O0, O1, and O2 levels of optimization. But it is
expected that in the future, support will be extended to other optimization levels as well.


- **O1 and Og :** The optimization levels O1 and Og are indistinguishable from one another purely based on `eabi_attribute`s.
At this time, the scope of this program does not test for Og optimization, and so it is to be assumed that if `eabi_attribute 30`
and `eabi_attribute 23` are 1 and 3 respectively, it is optimization level O1.