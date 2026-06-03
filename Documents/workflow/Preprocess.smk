#If you have fasta and from WGS (bins), pass reference genome to -R
if config["seq_type"] == "WGS":
    rule preprocess_interval_WGS:
        input:
            reference = config["fasta"]
        output:
            interval = "output/preprocessedintervals.interval_list"
        conda:
            "envs/gatk.yml"
        params:
            bin_length = config["bin_length"]#specified in config
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
if config["seq_type"] == "WES":
    rule preprocess_interval_WES:
        input:
            reference = 'data/reference/hs38DH.fa',
            intervals = 'data/reference/Aurora_US.Exome_2019.bed'
        output:
            interval = "output/preprocessedintervals.interval_list"
        conda:
            "envs/gatk.yml"
        params:
            padding = config["padding"], #inputs padding specified in the config file 
            java_opts = config ["java_opts"] #user must be able to specify 
        threads: 1
        log:
            "logs/gatk/preprocess-interval/preprocessedintervals.log"
        shell:
            "gatk --java-options '{params.java_opts}' PreprocessIntervals "
            "-R {input.reference} "
            "-L {input.intervals} "
            "--bin-length 200 "
            "--padding {params.padding} "
            "--interval-merging-rule OVERLAPPING_ONLY "
            "-O {output.interval} "
