#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=5
#SBATCH --partition=cpu
#SBATCH --mem=40G
#SBATCH --output=./mg_test
#SBATCH --time  800:0 
 

module load miniforge3/23.3.1
conda activate snakemake


#SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
#echo $SCRIPT_DIR
#execute from the desired output directory
#if [ ! -f config.yaml ]; then
#	echo "No 'config' file found, exitting"
#	exit 1
#fi

#if [ ! -f sample_reads.tsv ]; then
#	echo "Required file 'sample_reads.tsv' not present.  This file associates sample names with fastq read files.  Exitting."
#	exit 1
#fi

mkdir -p logs
snakemake --unlock
snakemake  --use-conda --rerun-triggers mtime  --rerun-incomplete



