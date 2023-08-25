# How can I add more patterns to FaultHunter_ASM?

- [How can I add more patterns to FaultHunter\_ASM?](#how-can-i-add-more-patterns-to-faulthunter_asm)
  - [Overview](#overview)
  - [Workflow:](#workflow)
    - [1. Create a new file in the `utils` directory](#1-create-a-new-file-in-the-utils-directory)
    - [2. Add the file as an export in the `__init__.py` file.](#2-add-the-file-as-an-export-in-the-__init__py-file)
    - [3. Implement pattern/class logic:](#3-implement-patternclass-logic)
    - [4. Import to `Analyzer`](#4-import-to-analyzer)
    - [5. Use your pattern](#5-use-your-pattern)
    - [6. Profit](#6-profit)


## Overview

All patterns are added and managed through the `Analyzer` class.

```py
# Analyzer.py

class Analyzer():
    def __init__(self, filename: str, parsed_data: Parser, total_lines: int, out_directory: str) -> None:
        """
        Represents an analyzer object used for static analysis.

        Args:
        - parsed_data (Parser): The parsed data object containing the program instructions.
        """
        self.filename = filename
        self.parsed_data = parsed_data
        
        # ! Outdated branch pattern detection
        # self.branchV1_detector = BranchV1(filename, total_lines, directory_name)
        self.branchV2_detector = BranchV2(filename, total_lines, directory_name)
        self.constant_detector = ConstantCoding(filename, total_lines, directory_name, sensitivity=4)
        if self.create_directory():
            self.static_analysis()
```

The constructor for the `Anlyzer` class declares and initializes the patterns to use. As seen here:

```py
self.branchV2_detector = BranchV2(filename, total_lines, directory_name)
self.constant_detector = ConstantCoding(filename, total_lines, directory_name, sensitivity=4)
```

The patterns themselves, however, are classes created in the `/utils/` directory. As of the time of writing, all patterns are stored here.
If you want to create a new pattern, simply create a new `.py` file in this directory and export it through the package initialization (`__init__.py`).

## Workflow:
### 1. Create a new file in the `utils` directory
### 2. Add the file as an export in the `__init__.py` file.
 
Example:
```py
    from .branch_detection import *
    from .constant_detection import *
```
### 3. Implement pattern/class logic:
   
   The static analysis is done by feeding each line into the patterns:

   ```py
   # Analyzer.py

   def static_analysis(self) -> None:
        """
        Performs static analysis on the program instructions.
        """
        for line in self.parsed_data.program:
            if type(line) == Instruction:
                # self.branchV1_detector.analysis(line)
                self.branchV2_detector.analysis(line)
                self.constant_detector.analysis(line)
   ```

   Apart from this, you may notice that each pattern/class contains an `analysis` method. It is important to look at the structure of the previously implemented patterns to mimic such structure.

   For instance, all patterns should **AT LEAST** have the following methods:

   ```py
   def analysis(self, line: Instruction) -> None:
        """
        Analyzes the given instruction line for x vulnerability.

        Args:
        - line (Instruction): The instruction line to analyze.
        """
        pass
        
        
    def save_and_print_results(self) -> None:
        """
        Prints the results of the analysis.
        """
        pass
   ``` 

   *(And a constructor... obviously...)*
   
   > As of the time of this writing, there is no parent `PATTERN` class; however, it is in development.



### 4. Import to `Analyzer`

Now that you have your own pattern, simply import it in the `Analyzer.py` file to start using it!

    ```py
    from utils import BranchV1, BranchV2, ConstantCoding
    ```

### 5. Use your pattern

There are certain spots where you MUST place your pattern.

- The Constructor:

  ```py
  # Patterns
  self.branchV2_detector = BranchV2(filename, total_lines, directory_name)
  self.constant_detector = ConstantCoding(filename, total_lines, directory_name, sensitivity=4)

  # ...
  if self.create_directory():
    self.static_analysis()
  ```

- The `static_analysis` method:

    ```py
    for line in self.parsed_data.program:
        if type(line) == Instruction:
            # Patterns
            self.branchV2_detector.analysis(line)
            self.constant_detector.analysis(line)
    ```

- The `save_and_print_analysis_results` method:

    ```py
    print(f"Saving Branch-V2...")
    self.branchV2_detector.save_and_print_results()
    print(f"Saved")
    
    print(f"Saving ConstantCoding...")
    self.constant_detector.save_and_print_results()
    print(f"Saved")
    ```

### 6. Profit

Not really, but congratulations! Now your pattern has been added.