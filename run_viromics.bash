#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
echo $SCRIPT_DIR
#execute from the desired output directory
if [ ! -f config.yaml ]; then
	echo "No 'config' file found, exitting"
	exit 1
fi

if [ ! -f sample_reads.tsv ]; then
	echo "Required file 'sample_reads.tsv' not present.  This file associates sample names with fastq read files.  Exitting."
	exit 1
fi

mkdir -p logs

snakemake -s $SCRIPT_DIR/workflow/Snakefile --use-conda  --rerun-incomplete --rerun-triggers mtime --configfile config.yaml -j 100 $@
## YOU NEED TO conda install -c conda-forge -c bioconda snakemake-executor-plugin-slurm FIRST