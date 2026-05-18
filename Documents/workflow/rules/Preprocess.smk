#If you have fasta and from WGS (bins), pass reference genome to -R
rule preprocess_interval_WGS:
    input:
        reference = '.fasta'
    output:
        interval = '{sample}.preprocessedintervals.list'
    params:
        bin_length = 1000,
    threads: 1
    log: 'logs/gatk/preprocess-interval/preprocessed.intervals.list.log'
    shell:
        "gatk PreprocessIntervals "
         "-R {input.reference}"
         "--bin-length {params.bin_length}"
         "--padding 0"
         "-O {output.interval}"

#if you have fasta and from WES (padding)
rule preprocess_interval_WES:
    input:
        reference = '.fasta'
        intervals = '{sample}.interval_list
    output:
        interval = '{sample}.preprocessedintervals.list'
    params:
        padding = '250',
        java_opts = 'Xmx4g'
    threads: 1
    log: 'logs/gatk/preprocess-interval/preprocessed.intervals.list.log'
    shell:
        "gatk --java-options '{java_opts}' PreprocessIntervals"
        " -R {input.reference}"
        " -L {input.intervals}"
        " --bin-length 0"
        " --padding 250"
        " -O {output.interval} "
