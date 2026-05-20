#If you have fasta and from WGS (bins), pass reference genome to -R
rule preprocess_interval_WGS:
    input:
        reference = "data/reference/reference.fa"
    output:
        interval = "output/preprocessedintervals.list"
    conda:
        "envs/gatk.yml"
    params:
        bin_length = 1000 #user must be able to specify 
    threads: 1
    log:
        "logs/gatk/preprocess-interval/preprocessedintervals.log"
    shell:
        "gatk PreprocessIntervals "
        "-R {input.reference} "
        "--bin-length {params.bin_length} "
        "--padding 0 "
        "--interval-merging-rule OVERLAPPING_ONLY "
        "-O {output.interval} "

#if you have fasta and from WES (padding)
rule preprocess_interval_WES:
    input:
        reference = 'data/reference/reference.fa',
        intervals = 'data/reference/intervals.bed'
    output:
        interval = "output/preprocessedintervals.list"
    conda:
        "envs/gatk.yml"
    params:
        padding = '250',
        java_opts = '-Xmx4g' #user must be able to specify 
    threads: 1
    log:
        "logs/gatk/preprocess-interval/preprocessedintervals.log"
    shell:
        "gatk --java-options '{params.java_opts}' PreprocessIntervals "
        "-R {input.reference} "
        "-L {input.intervals} "
        "--bin-length 0 "
        "--padding {params.padding} "
        "--interval-merging-rule OVERLAPPING_ONLY "
        "-O {output.interval} "
