#If you have
rule modelsegments_denoise_input:
    input:
        denoised_copy_ratio ="output/{sample}.denoisedCR.tsv",
        tumor_counts = "output/{sample}.tumor_alleliccounts.tsv",
        normal_counts = "output/{sample}.normal_alleliccounts.tsv"    
    output:
         seg = "output/{sample}.den.modelFinal.seg",
         cr_seg ="output/{sample}.n.cr.seg"
    conda:
        "envs/gatk.yml"
    log:
        "logs/gatk/modelsegments_denoise_{sample}.log"
    threads: 1
    params:
        prefix="{sample}.den.test",
        extra="",  # optional
        java_opts_model =config['java_opts_model']  # optional
    shell:
        "gatk --java-options '{params.java_opts_model}' ModelSegments "
        "--denoised-copy-ratios {input.denoised_copy_ratio} "
        "--allelic-counts {input.tumor_counts} "
        "--normal-allelic-counts {input.normal_counts}"
        "--output {output.} "
        "--output-prefix {params.prefix}"

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

