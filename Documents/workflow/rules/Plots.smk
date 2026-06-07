rule plot_interactive_cnvloh:
    input:
        json = "output/cnvloh_dir/{sample}_cnvloh_output_WES-GATK.json"
    output:
        html = "output/cnvloh_dir/{sample}_interactive.html"
    conda:
        "../envs/json.yml"
    log:
        "logs/json/{sample}.html.log"
    threads: 1
    resources:
        mem_mb=1024
    shell:
        "python3 py_json/plot_interactive_cnvloh.py "
        "--cnvloh-json {input.json} "
        "--cnvloh-dir output/cnvloh_dir "
        "--genome-info py_json/genome-info_GRCh38.json"



#python3 py_json/plot_interactive_cnvloh.py \
#--cnvloh-json output/cnvloh_dir/AUR-AG12-TTM1_cnvloh_output_WES-GATK.json \
#--cnvloh-dir output/cnvloh_dir \
#--genome-info py_json/genome-info_GRCh38.json