
#rule createworkspace:
    #output:

#If you have reference fasta create sequencing dictionary
#rule create_sequence_dictionary:
  #  input:
 #       '{reference}.fasta'
  #  output:
 #       '{reference}.fasta.dict'
 #   params:
        # Optional parameters. Omit if unused.
 #       java_options = '-Xmx4g'
 #   threads: 1
 #   resources: RAM = 4
 #   log: 'logs/gatk/create-sequence-dictionary/{reference}.log'
 #   wrapper:
  #      'http://dohlee-bio.info:9193/gatk/reference/create_sequence_dictionary'

#If you have fasta and from WGS (bins)
rule preprocess_interval:
    input:
        reference = '.fasta'
    output:
        '.intervals.list'
    params:
        #extra = '',
        #interval_list = '',
        bin_length = '1000',
    threads: 1
    log: 'logs/gatk/preprocess-interval/preprocessed.intervals.list.log'
    wrapper:
        'http://dohlee-bio.info:9193/gatk/intervals/preprocess-intervals'

     gatk PreprocessIntervals \
          -R reference.fa \
          --bin-length 1000 \
          --padding 0 \
          -O preprocessed_intervals.interval_list

#if you have fasta and from WES (padding)
rule preprocess_interval:
    input:
        reference = '.fasta'
    output:
        '.intervals.list'
    params:
        #extra = '',
        #interval_list = '',
        padding = '250',
    threads: 1
    log: 'logs/gatk/preprocess-interval/preprocessed.intervals.list.log'
    wrapper:
        'http://dohlee-bio.info:9193/gatk/intervals/preprocess-intervals'

     gatk PreprocessIntervals \
          -R reference.fa \
          -L intervals.interval_list \
          --bin-length 0 \
          --padding 250 \
          -O preprocessed_intervals.interval_list


#Normal
#If you have normal BAM and interval list then run
rule collectreadcounts:
    input:
        bam=["mapped/a.bam"],
        intervals=["a.interval_list"],
    output:
        counts="a.counts.hdf5",
    log:
        "logs/gatk/collectreadcounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectreadcounts"

#Tumor
#If you have tumor BAM and interval list then run
rule collectreadcounts:
    input:
        bam=["mapped/a.bam"],
        intervals=["a.interval_list"],
    output:
        counts="a.counts.hdf5",
    log:
        "logs/gatk/collectreadcounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectreadcounts"

#PoN 
#If you have normal samples run 
rule createreadcountoanelofnormals:
    input:
        bam=["mapped/a.bam"],
    output: 
        pon="a.pon.hdf5",
    log:
        "logs/gatk/createreadcountpanelofnormals.log",
    threads: 1


#If you have read counts and PoN then run 
rule denoisereadcounts:
    input:
        hdf5=["a.counts.hdf5"],
    output:
        std_copy_ratio="a.standardizedCR.tsv",
        denoised_copy_ratio="a.denoisedCR.tsv",
    log:
        "logs/gatk/denoisereadcounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/denoisereadcounts"

#Normal
#If you have BAM, interval list and fasta then run 
rule collectalleliccounts:
    input:
        bam=["mapped/a.bam"],
        intervals=["a.interval_list"],
        ref="ref/genome.fasta"
    output:
        counts="a.counts.tsv",
    log:
        "logs/gatk/collectalleliccounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectalleliccounts"

#Tumor
#If you have BAM, interval list and fasta then run 
rule collectalleliccounts:
    input:
        bam=["mapped/a.bam"],
        intervals=["a.interval_list"],
        ref="ref/genome.fasta"
    output:
        counts="a.counts.tsv",
    log:
        "logs/gatk/collectalleliccounts.log",
    threads: 1
    params:
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/collectalleliccounts"

#If you have 
rule modelsegments_denoise_input:
    input:
        denoised_copy_ratios="a.denoisedCR.tsv",
    output:
        "a.den.modelFinal.seg",
        "a.n.cr.seg",
    log:
        "logs/gatk/modelsegments_denoise.log",
    threads: 1
    params:
        #prefix="a.den.test",
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/modelsegments"

rule call_copy_ratio_segments:
    input:
        copy_ratio_seg="a.cr.seg",
    output:
        called_copy_ratio_seg="a.called.seg",
        igv_seg="a.called.igv.seg",
    log:
        "logs/gatk/call_copy_ratio_segments.log",
    threads: 1
    params:
        #prefix="a.den.test",
        extra="",  # optional
        java_opts="",  # optional
    resources:
        mem_mb=1024,
    wrapper:
        "v7.6.0/bio/gatk/callcopyratiosegments"
