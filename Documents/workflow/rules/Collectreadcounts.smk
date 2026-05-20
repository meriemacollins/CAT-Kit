#Normal
#If you have normal BAM and interval list then run
rule collectreadcounts_normal:
    input:
        bam = "data/bams/normal/{sample}.bam",
        intervals = "output/preprocessedintervals.list"
    output:
        counts="output/{sample}.normal_counts.hdf5"
    log:
        "logs/gatk/{sample}.collectreadcountsnormal.log"
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
        bam = "data/bams/tumor/{sample}.bam", 
        intervals ="output/preprocessedintervals.list"
    output:
        counts = "output/{sample}.tumor_counts.hdf5"
    log:
        "logs/gatk/{sample}.collectreadcountstumor.log"
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024
    shell:
        "gatk CollectReadCounts "
        "-I {input.bam} "
        "-L {input.intervals} "
        "--interval-merging-rule OVERLAPPING_ONLY "
        "-O {output.counts} "

    
    

