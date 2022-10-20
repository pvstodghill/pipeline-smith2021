#! /bin/bash

# option (a)

. doit-preamble.bash

# option (b)

set -e
set -o pipefail

export LC_ALL=C

if [ -e /programs/docker/bin/docker1 ] ; then
    THREADS=32
else
    THREADS=$(nproc --all)
fi

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

fastqc -t ${THREADS} -o ${FASTQC} ${SRA}/*.fastq.gz

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."

