# directory into which the results are written.
#DATA=.
#DATA=data # default

# ------------------------------------------------------------------------

# Raw-read files
FASTQ_FILES=local/*.fastq.gz
# Meta-data for read files 
SAMPLES_TSV=local/samples.tsv

# The genome sequence ...
GENOME_FNA=local/genome.fna
# ... and annotation
GENOME_GFF=local/genome.gff

# ------------------------------------------------------------------------

# if set, run trimmomatic with these args
TRIMMOMATIC_ARGS="ILLUMINACLIP:${PIPELINE}/inputs/TruSeq3-SE.fa:2:30:1 MINLEN:36"

# ------------------------------------------------------------------------

# Uncomment to get packages from HOWTO
PACKAGES_FROM=howto

# # Uncomment to use conda
# PACKAGES_FROM=conda
# CONDA_ENV=pipeline-smith2021

#THREADS=$(nproc --all)

# ------------------------------------------------------------------------
