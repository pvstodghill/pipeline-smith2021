#! /bin/bash

# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

# Raw-read files
FASTQ_FILES=local/*.fastq.gz

# The genome sequence
GENOME_FNA=local/genome.fna

# ------------------------------------------------------------------------

# Uncomment to get packages from HOWTO
PACKAGES_FROM=howto

# # Uncomment to use conda
# PACKAGES_FROM=conda
# CONDA_ENV=pipeline-smith2021

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------
