#!/bin/bash

# Exit immediately if any command, undefined variable, or pipe fails
set -euo pipefail

# ========= Step 1 =========
# Create the subdirectory for QC output files
mkdir -p ../results/01_fastqc_raw

# ========= Step 2 =========
# Execute FastQC across all raw datasets, by calling `fastqc`
# -o: Specifies the directory for output files
# -t 4: Allocates 4 parallel processing threads to speed up runtime
# data/raw/*.fastq.gz: Indicates the location and format of the input files
fastqc -o ../results/01_fastqc_raw -t 4 ../data/raw/*.fastq.gz

# ========= Step 3 =========
# Call `multiqc` to compile all diagnostic summaries into a single report
# results/01_fastqc_raw/: Targets the folder containing the FastQC logs
# -o results/: Sets the output target directory 
# -n 01_multiqc_raw_report: Defines the name of the generated HTML report
multiqc ../results/01_fastqc_raw/ -o ../results/ -n 01_multiqc_raw_report
