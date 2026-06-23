#Normal
#If you have normal BAM and interval list then run
rule filteredreadcounts_normal:
    input:
        bam = "data/bams/normal/{sample}.bam",
        intervals = "output/targets.filtered.interval_list"
    output:
        counts = "output/{sample}.filtered_normal_counts.hdf5"
    log:
        "logs/gatk/{sample}.filteredreadcountsnormal.log"
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
rule filteredreadcounts_tumor:
    input:
        bam = "data/bams/tumor/{sample}.bam", 
        intervals = "output/targets.filtered.interval_list"
    output:
        counts = "output/{sample}.filtered_tumor_counts.tsv"
    log:
        "logs/gatk/{sample}.filteredreadcountstumor.log"
    threads: 1
    params:
        extra="--format TSV",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v3.5.2/bio/gatk/collectreadcounts"
