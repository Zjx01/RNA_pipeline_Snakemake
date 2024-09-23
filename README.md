# Metatranscriptomics Workflow 


## Introduction 

## Getting Started
### 1. Make Directory & Git Clone the repository 
```text
mkdir RNA_pipeline_snakemake
cd RNA_pipline_snakemake
git clone 
```

### 2. Make Sure you have snakemake and conda environment installed

- Taking the VCU apollo cluster as an example, you should activate your conda environment with snakemake installed.
```text
module load miniforge
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
3. 
