rule filtered_intervals_normal:
    input:
        intervals = "output/preprocessedintervals.interval_list",
        hdf5 = expand("output/{sample}.normal_counts.hdf5", sample=NORMAL_SAMPLES)
    output:
        filtered_intervals = "output/targets.filtered.interval_list"
    log:
        "logs/gatk/filterintervals.log"
    threads: 1
    conda:
        "../envs/gatk.yml"
    params: 
        flags = lambda wildcards, input: " ".join([f"-I {f}" for f in input.hdf5])
    resources:
        mem_mb=1024,
    shell:
        "gatk FilterIntervals "
        "-L {input.intervals} "
        "{params.flags} "
        "--interval-merging-rule OVERLAPPING_ONLY "
        "-O {output.filtered_intervals} "
