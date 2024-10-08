# MetaGenomics Workflow 


## Introduction 

## Getting Started
### 1. Make Directory & Git Clone the repository 
```text
mkdir RNA_pipeline_snakemake
cd RNA_pipline_snakemake
git clone git@github.com:Zjx01/RNA_pipeline_Snakemake.git
```

### 2. Make Sure you have snakemake and conda environment installed

- Taking the VCU apollo cluster as an example, you should activate your conda environment with snakemake installed.
```text
module load miniforge3
conda activate snakemake
```

- Simple installation for snakemake, if you have not done it yet
- More details can be found at: https://snakemake.readthedocs.io/en/stable/getting_started/installation.html
```text
conda install -n base -c conda-forge mamba
mamba create -c conda-forge -c bioconda -n snakemake snakemake
mamba activate snakemake
snakemake --help
```

### To run the workflow
```text
# Dry Run 
snakemake  --use-conda --rerun-triggers mtime  --rerun-incomplete -np
# Running 
snakemake  --use-conda --rerun-triggers mtime  --rerun-incomplete 
```

