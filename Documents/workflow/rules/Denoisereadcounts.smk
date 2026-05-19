#PoN
#If you have normal samples run
rule createreadcountpanelofnormals:
    input:
        bam = expand("data/bams/normal/{sample}.bam", sample=normal_bam)
    output:
        pon = "output/.pon.hdf5"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/createreadcountpanelofnormals.log"
    threads: 1


#If you have read counts and PoN then run
rule denoisereadcounts:
    input:
        hdf5="output/{sample}.tumor_counts.hdf5", sample=tumor_read_counts
    output:
        std_copy_ratio="{sample}.standardizedCR.tsv",
        denoised_copy_ratio="{sample}.denoisedCR.tsv"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/{sample}.denoisereadcounts.log"
    threads: 1
    params:
        extra="",  # optional
        java_opts=""  # optional
    resources:
        mem_mb=1024
    wrapper:
        "v7.6.0/bio/gatk/denoisereadcounts"



