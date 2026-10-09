# EPP622-2026 / Test 2: Professional SNP Calling Pipeline

This project implements a pipeline to identify and evaluate **5,000 engineered SNPs** in the *Saccharomyces cerevisiae* genome. 

---

* **Student Name:** Areli Daniela Gonzalez Sandoval
* **Compute Server:** Linux cluster, UTK property. 
* **Repository URL:** [EPP622-2026-SNPCalling](https://github.com/AreliDGS/EPP622-2026-SNPCalling)

---

### Laboratory Test Index

The pipeline documentation is divided into independent modules, use the links below to navigate through each analysis phase:

#### Initial phase and workspace setup
* [0. Environment setup and data preparation](0.-Environment-setup-and-data-preparation)
  * *Directory infrastructure, symbolic links to raw datasets, and environment verification.*

#### Quality control and read preprocessing
* [1. Initial quality control (FastQC + MultiQC)](1.-Initial-quality-control-\(FastQC-+-MultiQC\))
  * *Analysis of raw samples A, B, C, and D.*
* [2. Read trimming and filtering (fastp)](2.-Read-trimming-and-filtering-\(fastp\))
  * *Adapter removal and manual overriding of the poly-G tail clipping mechanism.*

#### Alignment and variant calling
* [3. Alignment to reference genome (bwa-mem2)](3.-Alignment-to-reference-genome-\(bwa-mem2\))
  * *Mapping reads against the s. cerevisiae reference and metrics extraction via samtools.*
* [4. Raw variant calling (bcftools)](4.-Raw-variant-calling-\(bcftools\))
  * *Genotyping and initial identification of raw SNPs and indels using mpileup.*
* [5. Stringent variant filtering (bcftools filter)](5.-Stringent-variant-filtering-\(bcftools-filter\))
  * *Comparative analysis between gentle and stringent filtration thresholds.*

#### Validation and critical assessment
* [6. Evaluation against the truth set](6.-Evaluation-against-the-truth-set)
  * *Performance benchmarking metrics (precision, recall, F1-score), verification of false positives/negatives via JBrowse 2

#### Human vs IA
Reflexion of learning bioinformatics and the impact of AI in education


---
## Paths for instructor review

The following path locations target the report files:

*   **Pre-trimming MultiQC report:** `/lustre/isaac24/proj/UTK0505/agonza84/EPP622-2026-SNPCalling/results/01_multiqc_raw_report.html`
*   **Post-trimming MultiQC report:** `/lustre/isaac24/proj/UTK0505/agonza84/EPP622-2026-SNPCalling/results/02_multiqc_trimmed_report.html`
*   **BWA-MEM2 alignment MultiQC report:** `/lustre/isaac24/proj/UTK0505/agonza84/EPP622-2026-SNPCalling/results/03_multiqc_alignment_report.html`
*   **BCFtools stats - RAW SNP set:** `/lustre/isaac24/proj/UTK0505/agonza84/EPP622-2026-SNPCalling/results/04_variant_calling/yeast_data.raw.stats.txt`
*   **BCFtools stats - GENTLE filtered set:** `/lustre/isaac24/proj/UTK0505/agonza84/EPP622-2026-SNPCalling/results/05_filtering/yeast_data.gentle.stats.txt`
*   **BCFtools stats - STRINGENT filtered set:** `/lustre/isaac24/proj/UTK0505/agonza84/EPP622-2026-SNPCalling/results/05_filtering/yeast_data.stringent.stats.txt`

