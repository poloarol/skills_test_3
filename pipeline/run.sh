snakemake \
    --snakefile ./workflow/Snakefile \
    --latency-wait 1800 \
    --cores $1 \
    --jobs 20 \
    -R all