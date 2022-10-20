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
# 136. Insert site plot files can be opened in Artemis to visualize
# insertion sites. Convert BAM files to BED files before proceeding:
# 
#     for FILE in *.bam; do
#         bedtools bamtobed -i $FILE > $FILE.bed
#     done
# 
# 137. Transfer the BED files to the appropriate directory for
# subsequent analysis using R.
# 
# ------------------------------------------------------------------------

echo 1>&2 "# Generate the .bed files"

rm -rf ${BEDS}
mkdir -p ${BEDS}

for bam_file in ${TRADIS}/*.bam; do
    bed_file=${BEDS}/${bam_file}.bed # yuck.
    (
	set -x
	bedtools bamtobed -i $bam_file > $bed_file
    )
done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."

