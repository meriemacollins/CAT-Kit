#Normal
#If you have normal BAM and interval list then run
rule collectreadcounts_norm:
    input:
        bam = "mapped/a.bam",
        intervals = "a.interval_list",
    output:
        counts="a.counts.hdf5",
    log:
        "logs/gatk/collectreadcounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectreadcounts"

#Tumor
#If you have tumor BAM and interval list then run
rule collectreadcounts_tumor:
    input:
        bam=["mapped/a.bam"],
        intervals=["a.interval_list"],
    output:
        counts="a.counts.hdf5",
    log:
        "logs/gatk/collectreadcounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectreadcounts"


