rule trim:
    input:
        "/Users/zhaoj11/Documents/BinPipeline/fastq/MV1D1964032_R1.fastq.gz",
        "/Users/zhaoj11/Documents/BinPipeline/fastq/MV1D1964032_R2.fastq.gz"
    output:
        r1="results/trimmed/MV1D1964032_R1.fastq.gz",
        r2="results/trimmed/MV1D1964032_R2.fastq.gz",
        merged="results/trimmed/MV1D1964032_merged.fastq.gz"
    log:
        "logs/fastp-trim/MV1D1964032.log"
    threads: 1
    conda:
        "../envs/fastp.yaml"
    shell:
        """
        fastp \
            --in1 {input[0]} \
            --in2 {input[1]} \
            --out1 {output.r1} \
            --out2 {output.r2} \
            -q 20 -m --merged_out {output.merged} \
            > {log} 2>&1
        """


rule fq2fa:
    input:rules.trim.output
    ouput:
        fa_files="results/trimmed_fasta/"
    log:"logs/fq2fa/seqtk/{sample}.log"
    threads:1
    conda:
         "../envs/seqtk.yaml"
    shell:
	"seqtk"
	" --threads {threads}"
	" seq -a {output.merged} > 



