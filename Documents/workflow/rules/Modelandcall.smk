#If you have
rule modelsegments_denoise_input:
    input:
        denoised_copy_ratio ="output/{sample}.denoisedCR.tsv",
        tumor_counts = "output/tumor_counts/{sample}.tumor_alleliccounts.tsv",
        normal_counts = lambda wc: f"output/normal_counts/{PAIRS[wc.sample]}.normal_alleliccounts.tsv"
    output:
         seg = "output/sandbox/{sample}.modelFinal.seg",
         cr_seg ="output/sandbox/{sample}.cr.seg",
         hets = "output/sandbox/{sample}.hets.tsv"
    conda:
        "../envs/gatk.yml"
    log:
        "logs/gatk/modelsegments_denoise_{sample}.log"
    threads: 1
    params:
        prefix= "{sample}", 
        extra="",  # optional
        java_opts_model =config['java_opts_model']  # optional
    shell:
        "gatk --java-options '{params.java_opts_model}' ModelSegments "
        "--denoised-copy-ratios {input.denoised_copy_ratio} "
        "--allelic-counts {input.tumor_counts} "
        "--normal-allelic-counts {input.normal_counts} "
        "--number-of-changepoints-penalty-factor 1.25 "
        "--kernel-variance-allele-fraction 0.025 "
        "--kernel-variance-copy-ratio 0.0 "
        "--kernel-scaling-allele-fraction 1.0 "
        "--smoothing-credible-interval-threshold-allele-fraction 2.0 "
        "--smoothing-credible-interval-threshold-copy-ratio 2.0 "
        "--output output/sandbox/ "
        "--output-prefix {params.prefix} "

rule call_copy_ratio_segments:
    input:
        copy_ratio_seg="output/sandbox/{sample}.cr.seg"
    output:
        called_copy_ratio_seg="output/{sample}.called.seg",
        igv_seg="output/{sample}.called.igv.seg"
    conda:
        "../envs/gatk.yml"
    log:
        "logs/gatk/call_copy_ratio_segments_{sample}.log"
    threads: 1
    params:
        extra="",  # optional
        java_opts=""  # optional
    resources:
        mem_mb=1024
    wrapper:
        "v7.6.0/bio/gatk/callcopyratiosegments"




 #threads: 1
  #  params:
 #       prefix= "{sample}",
  #      extra="",  # optional
  #      java_opts_model =config['java_opts_model']  # optional
  #  shell:
  #      "gatk --java-options '{params.java_opts_model}' ModelSegments "
  #      "--denoised-copy-ratios {input.denoised_copy_ratio} "
  #      "--allelic-counts {input.tumor_counts} "
  #      "--normal-allelic-counts {input.normal_counts} "
  #      "--output-prefix {params.prefix} "
  #      "O output_dir"