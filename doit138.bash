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

echo 1>&2 "# Run SorTnSeq"

rm -rf ${SORTNSEQ}
mkdir -p ${SORTNSEQ}

set -x
cd ${SORTNSEQ}/
set +x

# Stage the data
cp --archive ../../local/annotation.gff fixme_genomic.gff
mkdir bam
cp --archive ../../test/xsample_metadata.xlsx .
cp --archive ../../test/xbam .
unpigz xbam/*.gz

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
# ('[genome.prefix]_feature- s_sortnseq.xlsx') that specifies
# intergenic regions as well as RefSeq features.
# 
# ------------------------------------------------------------------------

(
    set -x
    Rscript --vanilla ../../SorTn-seq/SorTnSeq_format_features.R \
	    fixme
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
    Rscript --vanilla ../../SorTn-seq/SorTnSeq_insertion_counts.R \
	    fixme ../../local/fixme.tsv ../beds
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
    Rscript --vanilla ../../SorTn-seq/SorTnSeq_analysis.R \
	    fixme
)
# ------------------------------------------------------------------------
# Done.
# ------------------------------------------------------------------------

echo 1>&2 "# Done."
