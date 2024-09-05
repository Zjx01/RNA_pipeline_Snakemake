from snakemake.remote.HTTP import RemoteProvider as HTTPRemoteProvider
HTTP = HTTPRemoteProvider()

rule human_filter_reference:
    input:
        HTTP.remote("https://ftp.ensembl.org/pub/release-110/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz")
    output:
        "resources/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz"
    shell:
        "mv {input} {output}"


rule human_filter_bowtie2_index:
    input: rules.bush_et_al_2020_human_filter_reference.output
    output:
        multiext(
            "resources/Homo_sapiens.GRCh38.dna.primary_assembly",
            ".1.bt2",
            ".2.bt2",
            ".3.bt2",
            ".4.bt2",
            ".rev.1.bt2",
            ".rev.2.bt2"
        )
    log: "logs/bush_et_all_2020_human_filter/bowtie2/index.log"
    threads: 30
    resources: mem_mb=lambda wildcards, input, attempt: max(input.size_mb * 4 * attempt, 40960)
    conda: "envs/bowtie2.yaml"
    shell:
        "bowtie2-build"
        " --threads {threads}"
        " {input}"
        " resources/Homo_sapiens.GRCh38.dna.primary_assembly"
        " &> {log}"


