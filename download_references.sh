#!/bin/bash

# Define the directory path
directory_path="$HOME/skills_test_3/reference"

# Check if the directory exists
if [ ! -d "$directory_path" ]; then
    # Create the directory if it doesn't exist
    mkdir -p "${directory_path}"
    echo "Directory created: ${directory_path}"
else
    echo "Directory already exists: ${directory_path}"
fi

cd ${directory_path}

wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa
wget ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai
