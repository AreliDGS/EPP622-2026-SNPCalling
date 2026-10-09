#!/bin/bash

# Exit immediately if any command or pipe fails
set -euo pipefail

# Initialize output subdirectory structure
mkdir -p results/04_variant_calling

# === Phase 1: Generate Explicit BAM Input List ===
echo "results/03_alignment/Sample_A.sorted.bam" > results/04_variant_calling/bam_list.txt
echo "results/03_alignment/Sample_B.sorted.bam" >> results/04_variant_calling/bam_list.txt
echo "results/03_alignment/Sample_C.sorted.bam" >> results/04_variant_calling/bam_list.txt
echo "results/03_alignment/Sample_D.sorted.bam" >> results/04_variant_calling/bam_list.txt

# === Phase 2: Joint Variant Calling (Piping mpileup straight to call) ===
bcftools mpileup \
  -Ou \
  -q 5 \
  -b results/04_variant_calling/bam_list.txt \
  -f data/reference/s_cerevisiae_ref.fasta \
  -a AD,ADF,ADR,DP,SP | \
bcftools call \
  -m \
  -v \
  -Oz \
  -o results/04_variant_calling/yeast_data.raw.vcf.gz

# Extract initial diagnostics baseline
bcftools stats results/04_variant_calling/yeast_data.raw.vcf.gz > results/04_variant_calling/yeast_data.raw.stats.txt

# === Phase 3: Site-level and Genotype Quality Filtering ===
bcftools filter \
  -i 'TYPE="snp" & INFO/MQ>=40 & FORMAT/DP>=10' \
  -Oz \
  -o results/04_variant_calling/yeast_data.filteredMQ40DP10.vcf.gz \
  results/04_variant_calling/yeast_data.raw.vcf.gz

# Extract post-filter diagnostics
bcftools stats results/04_variant_calling/yeast_data.filteredMQ40DP10.vcf.gz > results/04_variant_calling/yeast_data.filteredMQ40DP10.stats.txt

# === Phase 4: Isolation of Strict Biallelic SNPs ===
bcftools view \
  --types snps \
  -m2 \
  -M2 \
  -Oz \
  -o results/04_variant_calling/yeast_data.filteredMQ40DP10Biallelic.vcf.gz \
  results/04_variant_calling/yeast_data.filteredMQ40DP10.vcf.gz

# Extract final biological dataset diagnostics
bcftools stats results/04_variant_calling/yeast_data.filteredMQ40DP10Biallelic.vcf.gz > results/04_variant_calling/yeast_data.filteredMQ40DP10Biallelic.stats.txt
