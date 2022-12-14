#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------

if [ -z "${TRIMMOMATIC_ARGS}" ] ; then
    echo 1>&2 "# Skipping read trimming"
    exit
fi

# ------------------------------------------------------------------------
# 
# 131. Trim the specified FASTQ file by using the following command
# code on the command line. This generates a new file that has been
# appropriately trimmed. Key parameters are explained in the table
# following the code.
# 
#     trimmomatic SE -threads 20 -trimlog trim_summary \
#         input.fastq.gz output.fastq.gz ILLUMINACLIP:TruSeq3-SE:2:30:1
# 
# 132. Repeat Step 131 as necessary until all files have been trimmed.
# 
# ------------------------------------------------------------------------

echo 1>&2 "# Trim the reads"

rm -rf ${TRIMMED}
mkdir -p ${TRIMMED}

for input_fq in ${INPUTS}/*.fastq.gz ; do
    output_fq=${TRIMMED}/$(basename $input_fq)
    trim_summary=${TRIMMED}/$(basename $input_fq .fastq.gz).txt
    (
	set -x
	trimmomatic SE \
		    -threads ${THREADS} \
		    -trimlog $trim_summary \
		    $input_fq $output_fq \
		    ${TRIMMOMATIC_ARGS}
    )
done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."

