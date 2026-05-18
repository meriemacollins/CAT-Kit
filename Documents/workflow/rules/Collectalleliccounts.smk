#Normal
#If you have BAM, interval list and fasta then run
rule collectalleliccounts:
    input:
        bam=["mapped/a.bam"],
        intervals=["a.interval_list"],
        ref="ref/genome.fasta"
    output:
        counts="a.counts.tsv",
    log:
        "logs/gatk/collectalleliccounts.log",
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
rule collectalleliccounts:
    input:
        bam=["mapped/a.bam"],
        intervals=["a.interval_list"],
        ref="ref/genome.fasta"
    output:
        counts="a.counts.tsv",
    log:
        "logs/gatk/collectalleliccounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectalleliccounts"
