# Benchmarks and Analysis - ASM FaultHunter

## Purpose

The purpose of this document is to provide information on how to run an analysis of the application through benchmarks. An analysis of ASM FaultHunter aims to provide a report of how well (in terms of precision and recall) the application identifies vulnerabilities in Assembly, with an in-depth list of all lines indentified, misidentified, or failed to be identified. 
The primary script for this is the shell script `scripts/run_on_dataset.sh`. If all pre-requisites are in place, running this script is enough to produce the output, a final report in the form of a `.xlsx`  file.

## Pre-requisites

The pre-requisites of running this script is the
1. Existence of the dataset consisting of `.s` Assembly files, found in the root folder of the repository `dataset`.
   - The dataset must be organized in terms of optimization levels, `dataset/op_0`, `dataset/op_1`, `dataset/op_2` and so on, and all `.s` files must be within these optimization levels.
2. The existence `out` and `out/Analysis` folders.
3. The `Dataset_Labelling.xlsx` file stored in the `out/Analysis` folder, populated with labelling of faults in the dataset in the correct format.

## Output

If the shell script runs successfully, you will see a file `analysis.xlsx` in `out/Analysis`. This file is the final report generated from running the script. This file can be moved in or out of the folder after it has been generated.

## Troubleshooting / Debugging

If in case there are any errors, pay attention to which lines in the terminal that the shell script was executed in the error occurred. The file name of the file for which the error occurred will be mentioned. The python script `scripts/get_analysis.py` is main script that creates the report, and so most errors should be able to be traced to back to that file.