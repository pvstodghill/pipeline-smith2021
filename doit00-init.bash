#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# Set up
# ------------------------------------------------------------------------

if [ -d ${DATA} ] ; then
    echo 1>&2 "# Removing ${DATA}. Hope that's what you wanted"
    rm -rf ${DATA}
fi

echo 1>&2 "# Initializing ${DATA}/..."
rm -rf ${DATA}/tmp ${INPUTS}
mkdir -p ${DATA}/tmp
mkdir -p ${INPUTS}

echo 1>&2 '# Making copies of raw reads...'
cp --archive ${FASTQ_FILES} ${INPUTS}/

echo 1>&2 '# Making copies of meta-data...'
cp --archive ${SAMPLES_TSV} ${INPUTS}/samples.tsv

echo 1>&2 '# Making copies of genome sequence and annotation...'
cp --archive ${GENOME_FNA} ${INPUTS}/genome.fna
cp --archive ${GENOME_GFF} ${INPUTS}/genome.gff


# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 ''
echo 1>&2 '# Done.'

