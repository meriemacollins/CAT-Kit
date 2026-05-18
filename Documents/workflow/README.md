CAT-Kit

GATK CNV workflow streamlined using Snakemake 

channels:
- conda-forge
- bioconda 

dependencies:
- gatk-package-4.6.2.0
- python=3.13.12
- snakemake 9.20.0
- snakemake-wrapper-utils=0.6.2


├── config
│   └── config.yaml
├── data
│   ├── bams
│   └── reference
├── envs
│   └── gatk.yml
├── logs
├── output
├── rules
│   ├── Collectalleliccounts.smk
│   ├── Collectreadcounts.smk
│   ├── Denoisereadcounts.smk
│   ├── Modelandcall.smk
│   └── Preprocess.smk
├── README.md
├── slurm.yaml
└── Snakefile



