#! /bin/bash

set -e

CONDA_PREFIX=$(dirname $(dirname $(type -p conda)))
. "${CONDA_PREFIX}/etc/profile.d/conda.sh"

PACKAGES=
PACKAGES+=" pip"

PACKAGES+=" FIXME"

set -x

conda env remove -y --name pipeline-FIXME
conda create -y --name pipeline-FIXME
conda activate pipeline-FIXME

conda install -y ${PACKAGES}

pip install FIXME
