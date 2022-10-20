#! /bin/bash

# Raw-read files
FASTQ_FILES=local/*.fastq.gz

# The genome sequence
GENOME_FNA=local/genome.fna



# ------------------------------------------------------------------------

if [ -e ${HOME}/miniconda3/condabin/conda ] ; then
    export HOWTO_CONDA_CMD=${HOME}/miniconda3/condabin/conda
fi

if [ -e /programs/docker/bin/docker1 ] ; then
    export HOWTO_DOCKER_CMD=/programs/docker/bin/docker1
fi

# Uncomment to get packages from HOWTO
PACKAGES_FROM=howto

# Override the default number of threads (nproc --all)
#THREADS=32
