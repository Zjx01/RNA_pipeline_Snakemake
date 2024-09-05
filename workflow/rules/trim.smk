rule all:
    input:
        "trimmed/test1_R1.fastq.gz",
        "trimmed/test1_R2.fastq.gz",
        "trimmed/test1_merged.fastq.gz"

rule trim:
    input:
        r1=lambda wildcards: config['sample_reads'][wildcards.sample][0],
        r2=lambda wildcards: config['sample_reads'][wildcards.sample][1]
    output:
        r1="trimmed/{sample}_R1.fastq.gz",
        r2="trimmed/{sample}_R2.fastq.gz",
        merged="trimmed/{sample}_merged.fastq.gz"
    log:
        "logs/fastp-trim/{sample}.log"
    wildcard_constraints:
        ext=r"fastq|fastq\.gz"
    threads: 1
    resources:
        mem_mb=lambda wildcards, input, attempt: max(20480, attempt * 4 * 1000)
    conda:
        "envs/fastp.yaml"
    shell:
        """
        fastp \
            --in1 {input.r1} \
            --in2 {input.r2} \
            --out1 {output.r1} \
            --out2 {output.r2} \
            -q 20 -m --merged_out {output.merged} \
            --html logs/fastp-trim/{wildcards.sample}.html \
            --json logs/fastp-trim/{wildcards.sample}.json \
            > {log} 2>&1
        """

