#! /bin/bash

. $(dirname ${BASH_SOURCE[0]})/doit-preamble.bash

# ------------------------------------------------------------------------

echo 1>&2 "# Run SorTnSeq"

rm -rf ${SORTNSEQ}
mkdir -p ${SORTNSEQ}

PREFIX=bacteria
PIPELINE=$(realpath --relative-to ${SORTNSEQ} ${PIPELINE})

# ------------------------------------------------------------------------

# Stage the data
cp --archive ${GENOME_GFF} ${SORTNSEQ}/${PREFIX}_genomic.gff
#cp --archive .../sample_metadata.xlsx .
cp --archive ${BEDS} ${SORTNSEQ}/beds
cp ${SAMPLES_TSV} ${SORTNSEQ}/samples.tsv

# ------------------------------------------------------------------------

set -x
cd ${SORTNSEQ}/
set +x

# ------------------------------------------------------------------------

# Print the R version
(
    set -x
    Rscript --version
)

# ------------------------------------------------------------------------
# 
# 138. Obtain the RefSeq .gff file for the organism of interest and
# update the corresponding 'genome.  prefix' variable in
# SorTnSeq_format_features.R.
# 
# 
# 139. Run SorTnSeq_format_features.R to generate a new feature table
# ('[genome.prefix]_features_sortnseq.xlsx') that specifies
# intergenic regions as well as RefSeq features.
# 
# ------------------------------------------------------------------------

(
    set -x
    Rscript --vanilla ${PIPELINE}/SorTn-seq/SorTnSeq_format_features.R \
	    ${PREFIX}
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

(
    set -x
    Rscript --vanilla ${PIPELINE}/SorTn-seq/SorTnSeq_insertion_counts.R \
	    ${PREFIX} samples.tsv beds
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
    Rscript --vanilla ${PIPELINE}/SorTn-seq/SorTnSeq_analysis.R \
	    ${PREFIX}
)
# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."
