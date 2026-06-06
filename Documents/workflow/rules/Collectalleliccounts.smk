#If you have BAM, interval list and fasta then run
rule collectalleliccounts_normal:
    input:
        norm_bam = "data/bams/normal/{sample}.bam",
        intervals = config["intervals"],
        reference = config["fasta"]
    output:
        normal_counts ="output/normal_counts/{sample}.normal_alleliccounts.tsv"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/{sample}.collectalleliccountsnormal.log"
    threads: 1
    params:
        #extra="",  # optional
        java_opts_allelic=config["java_opts_allelic"]  # optional
    resources:
        mem_mb=1024,
    shell:
        "gatk --java-options '{params.java_opts_allelic}' CollectAllelicCounts "
        "-L {input.intervals} "
        "-I {input.norm_bam} "
        "-R {input.reference} "
        "-O {output.normal_counts}"

#If you have BAM, interval list and fasta then run
rule collectalleliccounts_tumor:
    input:
        tumor_bam = "data/bams/tumor/{sample}.bam",
        intervals = config["intervals"],
        reference = config["fasta"]
    output:
        tumor_counts="output/tumor_counts/{sample}.tumor_alleliccounts.tsv"
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
        "-I {input.tumor_bam} "
        "-R {input.reference} "
        "-O {output.tumor_counts}"

