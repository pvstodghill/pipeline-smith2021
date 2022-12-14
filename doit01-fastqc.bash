#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------
# 
# 130. Process all FASTQ files on the command line by using the following command:
# 
#     fastqc -t [THREADS] *.fastq.gz
# 
# ------------------------------------------------------------------------

echo 1>&2 "# Run fastqc"

rm -rf ${FASTQC}
mkdir -p ${FASTQC}

fastqc -t ${THREADS} -o ${FASTQC} ${INPUTS}/*.fastq.gz

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."

