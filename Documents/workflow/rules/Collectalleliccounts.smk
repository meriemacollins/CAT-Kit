#Normal
#If you have BAM, interval list and fasta then run
rule collectalleliccounts_normal:
    input:
        bam = "data/bams/normal/{sample}.bam",
        intervals= "output/preprocessedintervals.list",
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
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectalleliccounts"

#Tumor
#If you have BAM, interval list and fasta then run
rule collectalleliccounts_tumor:
    input:
        bam = "data/bams/tumor/{sample}.bam",
        intervals = "output/preprocessedintervals.list",
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
        java_opts=""  # optional
    resources:
        mem_mb=1024
    wrapper:
        "v7.6.0/bio/gatk/collectalleliccounts"
