#PoN
#If you have normal samples run
rule createreadcountoanelofnormals:
    input:
        bam = "mapped/a.bam"
    output:
        pon = "a.pon.hdf5"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/createreadcountpanelofnormals.log"
    threads: 1


#If you have read counts and PoN then run
rule denoisereadcounts:
    input:
        hdf5="a.counts.hdf5"
    output:
        std_copy_ratio="a.standardizedCR.tsv",
        denoised_copy_ratio="a.denoisedCR.tsv"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/denoisereadcounts.log"
    threads: 1
    params:
        extra="",  # optional
        java_opts=""  # optional
    resources:
        mem_mb=1024
    wrapper:
        "v7.6.0/bio/gatk/denoisereadcounts"

