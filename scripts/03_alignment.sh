#!/bin/bash

# Exit immediately if any command or pipe fails
set -euo pipefail

# Create subdirectory for alignment output
mkdir -p results/03_alignment

#Index the reference genome for BWA-MEM2
echo "Indexing reference genome for BWA-MEM2"
bwa-mem2 index data/reference/s_cerevisiae_ref.fasta
echo "Reference genome indexing completed."
echo "If you skip this step, you will get a ERROR!"

# === SAMPLE A ALIGNMENT + DIAGNOSTICS ===

echo "Processing alignment for sample A"
bwa-mem2 mem -t 4 data/reference/s_cerevisiae_ref.fasta \
    results/02_trimmed/Sample_A_R1.trimmed.fastq.gz \
    results/02_trimmed/Sample_A_R2.trimmed.fastq.gz | \
    samtools sort -@ 4 -o results/03_alignment/Sample_A.sorted.bam -

samtools index results/03_alignment/Sample_A.sorted.bam

samtools stats -@ 4 results/03_alignment/Sample_A.sorted.bam > results/03_alignment/Sample_A.stats.txt
samtools flagstat -@ 4 results/03_alignment/Sample_A.sorted.bam > results/03_alignment/Sample_A.flagstat.txt
samtools coverage results/03_alignment/Sample_A.sorted.bam > results/03_alignment/Sample_A.coverage.txt

# === SAMPLE B ALIGNMENT + DIAGNOSTICS ===
echo "Processing alignment for sample B"
bwa-mem2 mem -t 4 data/reference/s_cerevisiae_ref.fasta \
    results/02_trimmed/Sample_B_R1.trimmed.fastq.gz \
    results/02_trimmed/Sample_B_R2.trimmed.fastq.gz | \
    samtools sort -@ 4 -o results/03_alignment/Sample_B.sorted.bam -

samtools index results/03_alignment/Sample_B.sorted.bam

samtools stats -@ 4 results/03_alignment/Sample_B.sorted.bam > results/03_alignment/Sample_B.stats.txt
samtools flagstat -@ 4 results/03_alignment/Sample_B.sorted.bam > results/03_alignment/Sample_B.flagstat.txt
samtools coverage results/03_alignment/Sample_B.sorted.bam > results/03_alignment/Sample_B.coverage.txt

# === SAMPLE C ALIGNMENT + DIAGNOSTICS ===
echo "Processing alignment for sample C"
bwa-mem2 mem -t 4 data/reference/s_cerevisiae_ref.fasta \
    results/02_trimmed/Sample_C_R1.trimmed.fastq.gz \
    results/02_trimmed/Sample_C_R2.trimmed.fastq.gz | \
    samtools sort -@ 4 -o results/03_alignment/Sample_C.sorted.bam -

samtools index results/03_alignment/Sample_C.sorted.bam

samtools stats -@ 4 results/03_alignment/Sample_C.sorted.bam > results/03_alignment/Sample_C.stats.txt
samtools flagstat -@ 4 results/03_alignment/Sample_C.sorted.bam > results/03_alignment/Sample_C.flagstat.txt
samtools coverage results/03_alignment/Sample_C.sorted.bam > results/03_alignment/Sample_C.coverage.txt

# === SAMPLE D ALIGNMENT + DIAGNOSTICS ===
echo "Processing alignment for sample D"
bwa-mem2 mem -t 4 data/reference/s_cerevisiae_ref.fasta \
    results/02_trimmed/Sample_D_R1.trimmed.fastq.gz \
    results/02_trimmed/Sample_D_R2.trimmed.fastq.gz | \
    samtools sort -@ 4 -o results/03_alignment/Sample_D.sorted.bam -

samtools index results/03_alignment/Sample_D.sorted.bam

samtools stats -@ 4 results/03_alignment/Sample_D.sorted.bam > results/03_alignment/Sample_D.stats.txt
samtools flagstat -@ 4 results/03_alignment/Sample_D.sorted.bam > results/03_alignment/Sample_D.flagstat.txt
samtools coverage results/03_alignment/Sample_D.sorted.bam > results/03_alignment/Sample_D.coverage.txt

# === Get report with MULTIQC ===
echo "Compiling final alignment metrics report with MultiQC"
multiqc results/03_alignment/ -o results/ -n 03_multiqc_alignment_report

echo "Genomic alignment pipeline completed successfully."
