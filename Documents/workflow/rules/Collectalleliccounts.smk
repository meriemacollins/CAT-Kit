#Normal
#If you have BAM, interval list and fasta then run
rule collectalleliccounts_normal:
    input:
        bam = "data/bams/normal/{sample}.bam",
        intervals = 'data/reference/Aurora_US.Exome_2019.bed',
        reference = "data/reference/hs38DH.fa"
    output:
        counts="output/{sample}.normal_alleliccounts.tsv"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/{sample}.collectalleliccountsnormal.log"
    threads: 1
    params:
        extra="",  # optional
        java_opts_allelic=config["java_opts_allelic"]  # optional
    resources:
        mem_mb=1024,
    shell:
        "gatk --java-options '{params.java_opts_allelic}' CollectAllelicCounts "
        "-L {input.intervals} "
        "-I {input.bam} "
        "-R {input.reference} "
        "-O {output.counts}"

#Tumor
#If you have BAM, interval list and fasta then run
rule collectalleliccounts_tumor:
    input:
        bam = "data/bams/tumor/{sample}.bam",
        intervals = 'data/reference/Aurora_US.Exome_2019.bed',
        reference = "data/reference/hs38DH.fa"
    output:
        counts="output/{sample}.tumor_alleliccounts.tsv"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/{sample}.collectalleliccountstumor.log"
    threads: 1
    params:
        extra="",  # optional
        java_opts_allelic=config["java_opts_allelic"]  # optional
    resources:
        mem_mb=1024
    shell:
        "gatk --java-options '{params.java_opts_allelic}' CollectAllelicCounts "
        "-L {input.intervals} "
        "-I {input.bam} "
        "-R {input.reference} "
        "-O {output.counts}"

