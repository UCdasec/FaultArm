# Testing Vulnerability Detection

In order to test the functionality and accuracy of the tool, researchers created example files in C. These files were used to generate example files in assembly, which are then used as input for the tool.

Examples vary in range of complexity in order to test the robust pattern detection.

## Example

Example C files were generated by researchers independently. After all examples were created and merged, the assembly files were then generated using the compiler specified at root README.

## Testing Specifications

Test are generated by more than one researcher: the pattern developer and any other available researcher. This is to decrease the potential for bias in the patterns and further improve the tool.

After all tests are generated, these are then documented and labeled.