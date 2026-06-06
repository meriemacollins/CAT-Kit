#PoN
#If you have normal samples run
rule createreadcountpanelofnormals:
    input:
       hdf5 = expand("output/{sample}.normal_counts.hdf5", sample=NORMAL_SAMPLES)
    output:
        pon = "output/pon.hdf5"
    conda:
        "../envs/gatk.yml"
    log:
        "logs/gatk/createreadcountpanelofnormals.log"
    threads: 1
    params: 
        flags = lambda wildcards, input: " ".join([f"-I {f}" for f in input.hdf5])
    shell:
        "gatk CreateReadCountPanelOfNormals "
        "{params.flags} "
        "-O {output.pon} "

#If you have read counts and PoN then run
rule denoisereadcounts:
    input:
        hdf5 ="output/{sample}.tumor_counts.tsv",
        pon = "output/pon.hdf5"
    output:
        std_copy_ratio="output/{sample}.standardizedCR.tsv",
        denoised_copy_ratio="output/{sample}.denoisedCR.tsv"
    conda:
        "../envs/gatk.yml"
    log:
        "logs/gatk/{sample}.denoisereadcounts.log"
    threads: 1
    params:
        extra="",  # optional
        java_opts_denoise=config["java_opts_denoise"]  
    shell:
        "gatk --java-options '{params.java_opts_denoise}' DenoiseReadCounts "
        "-I {input.hdf5} "
        "--count-panel-of-normals {input.pon} "
        "--standardized-copy-ratios {output.std_copy_ratio} "
        "--denoised-copy-ratios {output.denoised_copy_ratio}  "
 



