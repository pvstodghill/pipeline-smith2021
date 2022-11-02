#! /bin/bash

set -e

CONDA_PREFIX=$(dirname $(dirname $(type -p conda)))
. "${CONDA_PREFIX}/etc/profile.d/conda.sh"

PACKAGES=
#PACKAGES+=" pip"

PACKAGES+=" bedtools"
PACKAGES+=" bioconductor-edger=3.32.1"
PACKAGES+=" biotradis"
PACKAGES+=" fastqc"
PACKAGES+=" r-base"
PACKAGES+=" r-ggiraph"
PACKAGES+=" r-ggrepel"
PACKAGES+=" r-optparse"
PACKAGES+=" r-readxl"
PACKAGES+=" r-scales"
PACKAGES+=" r-tidyverse"
PACKAGES+=" r-writexl"
PACKAGES+=" trimmomatic"

if [ "$(type -p mamba)" ] ; then
    _conda=mamba
else
    _conda=conda
fi

set -x

conda env remove -y --name pipeline-smith2021
conda create -y --name pipeline-smith2021
conda activate pipeline-smith2021

$_conda install -y ${PACKAGES}

#pip install FIXME
