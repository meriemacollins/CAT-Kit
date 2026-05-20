#If you have
rule modelsegments_denoise_input:
    input:
        denoised_copy_ratio="output/{sample}.denoisedCR.tsv"
    output:
        "output/{sample}.den.modelFinal.seg",
        copy_ratio_seg="output/{sample}.n.cr.seg"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/modelsegments_denoise_{sample}.log"
    threads: 1
    params:
        #prefix="a.den.test",
        extra="",  # optional
        java_opts=""  # optional
    resources:
        mem_mb=1024
    wrapper:
        "v7.6.0/bio/gatk/modelsegments"

rule call_copy_ratio_segments:
    input:
        copy_ratio_seg="output/{sample}.n.cr.seg"
    output:
        called_copy_ratio_seg="output/{sample}.called.seg",
        igv_seg="output/{sample}.called.igv.seg"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/call_copy_ratio_segments_{sample}.log"
    threads: 1
    params:
        #prefix="a.den.test",
        extra="",  # optional
        java_opts=""  # optional
    resources:
        mem_mb=1024
    wrapper:
        "v7.6.0/bio/gatk/callcopyratiosegments"

