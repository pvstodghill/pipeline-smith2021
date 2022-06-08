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
# ------------------------------------------------------------------------

echo 1>&2 "# Run SorTnSeq"

rm -rf ${SORTNSEQ}
mkdir -p ${SORTNSEQ}

cp --archive SorTn-seq/*.R ${SORTNSEQ}/

set -x
cd ${SORTNSEQ}/
set +x

# ------------------------------------------------------------------------
# 
# 138. Obtain the RefSeq .gff file for the organism of interest and
# update the corresponding 'genome.  prefix' variable in
# SorTnSeq_format_features.R.
# 
# 
# 139. Run SorTnSeq_format_features.R to generate a new feature table
# ('[genome.prefix]_feature- s_sortnseq.xlsx') that specifies
# intergenic regions as well as RefSeq features.
# 
# ------------------------------------------------------------------------

cp --archive ../../SorTn-seq/example_dataset/GCF_002847015.1_ASM284701v1_genomic.gff .
(
    set -x
    Rscript --version
    Rscript --vanilla SorTnSeq_format_features.R
)



# ------------------------------------------------------------------------
# 
# 140. Run the SorTnSeq_insertion_counts.R script to generate the
# following files:
# 
# - 'SorTnSeq_table_reads.xlsx': ...
# - 'SorTnSeq_table_insertion_index.xlsx': ...
# - 'SorTnSeq_table_unique_insertions.xlsx': ...
# - 'SorTnSeq_all_features_by_sample.xlsx': ...
# 
# ------------------------------------------------------------------------

cp --archive ../../SorTn-seq/example_dataset/sample_metadata.xlsx .
cp --archive ../../SorTn-seq/example_dataset/bam .
unpigz bam/*.gz

(
    set -x
    Rscript --vanilla SorTnSeq_insertion_counts.R
)

# ------------------------------------------------------------------------
# 
# 141. Run the SorTnSeq_analysis.R script to generate the following
# files:
# 
# - 'SorTnSeq_bcv_plot.pdf': ...
# - 'SorTnSeq_enrichment_depleted.pdf':
# - 'volcano_depleted-low.pdf', 'volcano_depleted-high.pdf' and
#   'volcano_depleted-input.pdf': ...
# - 'SorTnSeq_results_depleted_unique_insertions.xlsx': ...
#
# ------------------------------------------------------------------------

(
    set -x
    Rscript --vanilla SorTnSeq_analysis.R
)
# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."
