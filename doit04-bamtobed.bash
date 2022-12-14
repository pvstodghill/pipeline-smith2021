#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

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
    name=$(basename ${bam_file}) # yuck.
    bed_file=${BEDS}/${name}.bed
    (
	set -x
	bedtools bamtobed -i $bam_file > $bed_file
    )
done

# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."

