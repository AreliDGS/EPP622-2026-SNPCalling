#!/bin/bash
# scripts/06_evaluation.sh
set -euo pipefail

# Create the folder to save outputs
mkdir -p results/06_evaluation

# Referene paths
TRUTH_VCF="/lustre/isaac24/proj/UTK0505/test2/check/truth_snps.vcf"
EVAL_SCRIPT="data/reference/evaluate_snps_v4.py"

# --- Phase 1: Raw set Cross-Comparison ---
echo "--- Phase 1: Raw set Cross-Comparison ---"
python3 $EVAL_SCRIPT \
    --truth "$TRUTH_VCF" \
    --calls results/04_variant_calling/yeast_data.raw.vcf.gz \
    --all-samples \
    --tag raw \
    --outdir results/06_evaluation/raw_eval

# --- Phase 2: Gentle set Cross-Comparison ---
echo "--- Phase 2: Gentle set Cross-Comparison ---"
python3 $EVAL_SCRIPT \
    --truth "$TRUTH_VCF" \
    --calls results/05_filtering/yeast_data.gentle.vcf.gz \
    --all-samples \
    --tag gentle \
    --outdir results/06_evaluation/gentle_eval

# --- Phase 3: Strict Set Cross-Comparison ---
echo "--- Phase 3: Strict Set Cross-Comparison ---"
python3 $EVAL_SCRIPT \
    --truth "$TRUTH_VCF" \
    --calls results/05_filtering/yeast_data.stringent.vcf.gz \
    --all-samples \
    --tag strict \
    --outdir results/06_evaluation/strict_eval

# --- Phase 4: Directory final structure ---
echo "--- Phase 4: Directory final structure ---"
tree -LF 2 . > results/06_evaluation/directory_structure.txt

echo "Step 6 evaluation commands completed successfully."
