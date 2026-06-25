rule create_json:
    input:
        seg = "output/sandbox/{sample}.modelFinal.seg",
        denoised_copy_ratio ="output/{sample}.denoisedCR.tsv",
        counts = "output/{sample}.filtered_tumor_counts.tsv",
        hets = "output/sandbox/{sample}.hets.tsv"
    output:
        json = "output/cnvloh_dir/{sample}_cnvloh_output_WES-GATK.json"
    conda:
        "../envs/cnv-bokeh.yml"
    log:
        "logs/json/{sample}.json.log"
    threads: 1
    resources:
        mem_mb=1024
    params:
        software="GATK",  # optional
        data_type=config["seq_type"],
        sample_name = config["sample_name"],
        case_name = config["case_name"],
        sample_type = config["sample_type"],
    shell:
        "python3 py_json/cnvloh2json.py "
        "--sample-name {params.sample_name} "
        "--case-name {params.case_name} "
        "--modelsegs-file {input.seg} "
        "--sample-type {params.sample_type} "
        "--case-name {params.sample_name} " 
        "--cnvloh-dir output/cnvloh_dir "
        "--denoised-file {input.denoised_copy_ratio} "
        "--counts-file {input.counts} "
        "--hets-file {input.hets} "
        "--software {params.software} "
        "--data-type {params.data_type} "
     
    
