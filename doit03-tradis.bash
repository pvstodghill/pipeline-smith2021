#! /bin/bash

. doit-preamble.bash

# ------------------------------------------------------------------------

echo 1>&2 "# Running TraDIS"

rm -rf ${TRADIS}
mkdir -p ${TRADIS}

# ------------------------------------------------------------------------
# 
# 134. Ensure that FASTQ files are in the appropriate directory and
# prepare a list of all FASTQ files to be analyzed:
# 
#     dir *.fastq.gz >filelist.txt
# ------------------------------------------------------------------------

realpath --relative-to=${TRADIS} ${FASTQ_FILES} \
	  > ${TRADIS}/filelist.txt

# ------------------------------------------------------------------------
# 
# 135. Run the following code on the command line. Key parameters are
# explained in the table following the code.
# 
#     bacteria_tradis --smalt --smalt_k 10 --smalt_s 1 --smalt_y 0.92 \
#         --smalt_r -1 -mm 2 -v -f filelist.txt -t TATAAGAGACAG -r genome.fna
# 
# ------------------------------------------------------------------------

cp --archive ${GENOME_FNA} ${TRADIS}/genome.fna

(
    set -x
    cd ${TRADIS}
    bacteria_tradis \
	--smalt \
	--smalt_k 10 \
	--smalt_s 1 \
	--smalt_y 0.92 \
	--smalt_r -1 \
	-mm 2 \
	-v \
	-f filelist.txt \
	-t TATAAGAGACAG \
	-r genome.fna
)

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."

