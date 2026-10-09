#!/bin/bash

# Exit immediately if any command, undefined variable, or pipe fails
set -euo pipefail

# Define paths
OUTPUT_TRIM="results/02_trimmed"
OUTPUT_QC="results/02_fastqc_trimmed"

# Create required subdirectories for clean data organization
mkdir -p "$OUTPUT_TRIM"
mkdir -p "$OUTPUT_QC"

# === Phase 1: Running fastp trimming across all samples ===

# Process each sample with fastp. We have already identified a Poly-G/Adapter contamination, use `--trim_poly_g` for detection. Add `--detect_adapter_for_pe`; adapter detection for paired-end data. 

for sample in A B C D; do
    echo "Processing Sample ${sample}..."
    fastp \
        -i data/raw/Sample_${sample}_R1.fastq.gz \
        -I data/raw/Sample_${sample}_R2.fastq.gz \
        -o "${OUTPUT_TRIM}/Sample_${sample}_R1.trimmed.fastq.gz" \
        -O "${OUTPUT_TRIM}/Sample_${sample}_R2.trimmed.fastq.gz" \
        --html "${OUTPUT_TRIM}/fastp_report_Sample_${sample}.html" \
        --json "${OUTPUT_TRIM}/fastp_report_Sample_${sample}.json" \
        --trim_poly_g \
        --detect_adapter_for_pe \
        --thread 4
done

# === Phase 2: Running Post-Trimming Quality Control ===

# Now we execute FastQC on the cleaned outputs (post-trimming)
fastqc -o "$OUTPUT_QC" -t 4 ${OUTPUT_TRIM}/*.trimmed.fastq.gz

# Compile our report, comparative post-trimming MultiQC evaluation report
multiqc "$OUTPUT_QC" -o results/ -n 02_multiqc_trimmed_report

echo "Trimming and post-QC processing completed successfully."
