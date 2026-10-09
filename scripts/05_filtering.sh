#!/bin/bash

# Exit immediately if any command or pipe fails
set -euo pipefail

mkdir -p results/05_filtering

# --- Gentle Filtering Workflow ---
bcftools filter \
  -e 'QUAL<20 | INFO/DP<5' \
  -Oz \
  -o results/05_filtering/yeast_data.gentle.vcf.gz \
  results/04_variant_calling/yeast_data.raw.vcf.gz

bcftools stats results/05_filtering/yeast_data.gentle.vcf.gz > results/05_filtering/yeast_data.gentle.stats.txt

# --- Stringent Filtering Workflow ---
bcftools filter \
  -e 'QUAL<30 | INFO/DP<10 | INFO/MQ<40' \
  -Oz \
  -o results/05_filtering/yeast_data.stringent.vcf.gz \
  results/04_variant_calling/yeast_data.raw.vcf.gz

bcftools stats results/05_filtering/yeast_data.stringent.vcf.gz > results/05_filtering/yeast_data.stringent.stats.txt
