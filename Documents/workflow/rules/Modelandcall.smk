#If you have
rule modelsegments_denoise_input:
    input:
        denoised_copy_ratios="a.denoisedCR.tsv"
    output:
        "a.den.modelFinal.seg",
        "a.n.cr.seg"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/modelsegments_denoise.log"
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
        copy_ratio_seg="a.cr.seg"
    output:
        called_copy_ratio_seg="a.called.seg",
        igv_seg="a.called.igv.seg"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/call_copy_ratio_segments.log"
    threads: 1
    params:
        #prefix="a.den.test",
        extra="",  # optional
        java_opts=""  # optional
    resources:
        mem_mb=1024
    wrapper:
        "v7.6.0/bio/gatk/callcopyratiosegments"

