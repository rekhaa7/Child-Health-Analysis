# Child Health Data Analysis

This repository contains SAS code and dataset files used for analyzing a subset of participants in a South African study on the health of children.

## Files

- btt.dat: Raw data file containing child health information.
- ChildHealthAnalysis.sas: SAS program used to read and analyze the dataset.
- FullDocument.pdf: Pdf file containing code, output and explaination.

## Usage
1. Open `ChildHealthAnalysis.sas` in SAS Studio or any SAS environment.
2. Update the `infile` path in the code if needed:
   ```sas
   infile '/path/to/btt.dat';
