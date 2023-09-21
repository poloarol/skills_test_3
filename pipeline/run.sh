snakemake \
    --snakefile ./workflow/Snakefile \
    --latency-wait 1800 \
    --timestamp \
    --cores $1 \
    -R all