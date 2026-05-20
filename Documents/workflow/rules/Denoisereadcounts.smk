#PoN
#If you have normal samples run
rule createreadcountpanelofnormals:
    input:
        bam = expand("output/{sample}.normal_counts.hdf5", sample=NORMAL_SAMPLES)
    output:
        pon = "output/pon.hdf5"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/createreadcountpanelofnormals.log"
    threads: 1
    shell:
        "gatk CreateReadCountPanelOfNormals "
        "-I {input.bam} "
        "-O {output.pon} "


#If you have read counts and PoN then run
rule denoisereadcounts:
    input:
        hdf5 ="output/{sample}.tumor_counts.hdf5",
        pon = "output/pon.hdf5"
    output:
        std_copy_ratio="output/{sample}.standardizedCR.tsv",
        denoised_copy_ratio="output/{sample}.denoisedCR.tsv"
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



