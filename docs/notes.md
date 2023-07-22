# Research Notes

## Initial Version of FaultHunter_ASM

### Developer Notes

There currently is an object-oriented structure for the parser. All is parsed and stored in the respective classes, with initializing the parser class first, then the rest when needed.

~~I am thinking of tapping into the Instruction class, or rather where it is invoked, and as it reads instructions, it also checks for this specific vulnerability.~~

Maintaining the current modular aspect of the parser remains a priority. Consequently, the proposition is to process the parsed data through different classes, which will maintain the object-oriented nature of the codebase.

While rudimentary at best, I am planning to detect instructions like `movl` and `cmpl` with values such as `$1` or `$0`, as these are most commonly used for boolean representations. Meaning, if the instruction `movl` moves a `$1` to the top of the stack and the compares it to itself (`$1`), we can identify a vulnerability there. Of course, we need to also look for a subsequent jump instruction, but future iterations will handle that feature.

#### 06/15/2023

Decided to restructure the project to allow for further modularity. With the current implemenation, everything would have to be inside `Parser.py`, which we do not want.

The new strucure will look like this:

- main.py (entrypoint)
- Parser.py (original parser)
- Analyzer.py (Analyzer - Static Analysis)

This structure will keep our inteded modules isolated and scalable.
